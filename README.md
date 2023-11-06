<h1 align="center">Deploy a NEW flask application<h1> 


# Deployment 5
October 13, 2023

By: Andrew Mullen

## Purpose:

Demonstrate the ability to deploy a new flask application to an EC2 instance.

## Steps:

### 1. Create a VPC with Terraform, and the VPC must have only the components listed: 1 VPC, 2 AZs, 2 Public Subnets, 2 EC2s, 1 Route Table, Security Group Ports: 8080, 8000, 22
   - This process is to give us practice using Terraform to create our AWS infrastructure using resource blocks.  Here is the link to the main.tf file: Click [HERE](https://github.com/andmulLABS01/Deployment_5AM/blob/main/main.tf)
   - Also we will utilize Git to continue gaining experience in the day-to-day operations of a DevOps engineer.
   - We must update several files and merge them into the main branch.
	  - Create a new repository on GitHub
	  - Use git commands to clone the Kura Deployment 5 repository to a local instance and push it to the new repository.
	  - Branch, update and merge Jenkinsfilev1, Jenkinsfilev2, setup.sh, and setup2.sh into main branch.

### 2. For the first instance follow the below instructions: Jenkins Server
   - The below instructions create public and private keys that will allow us to SSH into the second instance
   - Create the Jenkins user that we need for our Jenkinsfiles
   - Install required packages

```
- Install Jenkins
- Create a Jenkins user password and log into the Jenkins user (Review Deployment 3 on how to do this)
- Create a public and private key on this instance with ssh-keygen
- Copy the public key contents and paste it into the second instance authorized_keys
- IMPORTANT: Test the ssh connection
- Exit the jenkins user
- Now, in the ubuntu user, install the following: {sudo apt install -y software-properties-common, sudo add-apt-repository -y ppa:deadsnakes/ppa, sudo apt install -y python3.7, sudo apt install -y python3.7-venv}
```

###	3. On the second instance, install the following: Webserver
   - Install required packages

```
- Install the following: {sudo apt install -y software-properties-common, sudo add-apt-repository -y ppa:deadsnakes/ppa, sudo apt install -y python3.7, sudo apt install -y python3.7-venv}
```

### 4. In the Jenkinsfilev1 and Jenkinsfilev2, create a command that will ssh into the second instance and download and run the required script for that step in the Jenkinsfile
- This is the step where we will need to utilize Git commands and make changes to the files mentioned above. 
		  
#### 4a. Clone the Kura repository to our local instance and push it to a new repository
	- Clone the Kura Deployment 5 repository to the local instance
		- Clone using `git clone` command and the URL of the repository
			- This will copy the files to the local instance 
		- Enter the following to gain access to the GitHub repository
			- `git config --global user.name username`
			- `git config --global user.email email@address`
		- Next, you will push the files from the local instance to the new repository (Done from the local instance via the command line)
			- `git push`
			- enter GitHub username
			- enter personal token (GitHub requires this as it is more secure)
			
#### 4b. Branch, update, and merge Jenkinsfile into the main branch
	- Create a new branch in your repository
		- `git branch newbranchName`
	- Switch to the new branch and modify the Jenkinsfilev1, Jenkinsfilev2, setup.sh, and setup2.sh
		- `git switch newbranchName`
		- Update Jenkinsfilev1 Deploy stage with ssh and curl command
		- Update Jenkinsfilev2 Deploy stage with ssh and curl command
		- Update setup.sh with the correct git clone url and cd command
		- Update setup2.sh with the correct git clone url and cd command
	- After modifing the Jenkinsfilev1, Jenkinsfilev2, setup.sh, and setup2.sh commit the changes
		- `git add "filename"`
		- `git commit -m "message"`
	- Merge the changes into the main branch
		- `git switch main`
		- `git merge second main`
	- Push the updates to your repository
		- `git push`
		
### 5. Create a Jenkins multibranch pipeline and run the Jenkinsfilev1
- Jenkins is the main tool used in this deployment for pulling the program from the GitHub repository, and then building and testing the files to be deployed to the second EC2 instance.
- Creating a multibranch pipeline gives the ability to implement different Jenkinsfiles for different branches of the same project.
- A Jenkinsfile is used by Jenkins to list out the steps to be taken in the deployment pipeline.

- Steps in the Jenkinsfilev1 are as follows:
  - Build
    - The environment is built to see if the application can run.
  - Test
    - Unit test is performed to test specific functions in the application
  - Deploy
    - SSH into the second instance and runs the setup.sh script 	


### 6. Check the application on the second instance!!
- Here is the screenshot of the application. Click [HERE](https://github.com/andmulLABS01/Deployment_5AM/blob/main/Deployment_5a.PNG)
	
### 7. Now make a change to the HTML and then run the Jenkinsfilev2	
	- Steps in the Jenkinsfilev2 are as follows:
	  - Clean
		- SSH into the second instance and runs the pkill.sh script
	  - Deploy
		- SSH into the second instance and run the setup2.sh script 
		
#### 7a. Make the change to the HTML file using Git commands
	- Switch to the new branch and cd into the HTML directory, modify the file
		- `git switch newbranchName`
		- Update HTML file
	- After modifying the file commit the changes
		- `git add "filename"`
		- `git commit -m "message"`
	- Merge the changes into the main branch
		- `git switch main`
		- `git merge second main`
	- Push the updates to your repository
		- `git push`
#### 7b. View the application after the change
- Click [HERE](https://github.com/andmulLABS01/Deployment_5AM/blob/main/Deployment_5b.PNG)

### 8. How did you decide to run the Jenkinsfilev2? 

- I changed the file path in Jenkins configuration section from Jenkinsfilev1 to Jenkinsfilev2.

### 9. Should you place both instances in the public subnet? Or should you place them in a private subnet? Explain why?

- Well it depends.  Since both instances need to be accessed via the internet it is best to put them on the public subnet with the correct security group settings to secure them. 
However, we could place parts of the second instance, application and database tiers, into the private subnet to enhance security and limit access.


## System Diagram:

To view the diagram of the system design/deployment pipeline, click [HERE](https://github.com/andmulLABS01/Deployment_5AM/blob/main/Deployment_5.drawio.png)

## Issues/Troubleshooting:

Trouble with security group association with subnets

Resolution Steps:
- Assocated the security group to the wrong resource block.
- Associated the security group to the EC2 instance block and fixed the issue.


Created a second route table but didn't need to create it.

Resolution Steps:
- Learned that there is a resource block 'resource "aws_default_route_table" ' that modifies the default route table.
- I will use this next time instead of going through the AWS console to delete and reassociate the subnets to the route table and to the internet gateway.



## Conclusion:

As stated in previous documentation this deployment was improved by automating the setup of infrastructure by using Terraform.  However, additional improvements can be made to the Terraform code by can be improved by setting up variables and modules.  These will allow the Terraform code to be more flexible, less information would need to be hard-coded, and the code would be shorter to improve efficiency.  We can also utilize ChatGPT to assist with error messages and check our Terraform code for errors before deployment. Utilizing prompts such as:
- You are a Terraform expert
- Check the main.tf, or other Terraform file, for errors
- Please explain the error, including the method to fix the error, and provide a link to documentation. AWS instance
