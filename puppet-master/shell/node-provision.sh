  if [ ! -d "/data" ]; then
	  mkdir /data
  fi
  if [ ! -d "/opt/devops/code" ]; then
	  mkdir -p /opt/devops/code
  fi

  echo "updating locale"
  echo 'LANG="en_US.UTF-8"' > /etc/locale.conf
  mkdir -p /auto/ecs/bin
  # rsync -avz /home/vagrant/devops /data/.
  chown vagrant:vagrant -R /opt/devops/code


  echo "exit 0" > /auto/ecs/bin/install-dotfiles
  chmod +x /auto/ecs/bin/install-dotfiles
  echo "installing ntpdate"


  #ntpdate 0.centos.pool.ntp.org
# Install puppet agent

sudo yum -y install https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
sudo yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update -y

sudo yum install -y puppet-agent
#copy puppet agent configuration from the master
vi /etc/puppetlabs/puppet/puppet.conf
# Clean puppet agent certs
rm -rf /etc/puppetlabs/puppet/ssl/

systemctl start puppet
systemctl enable puppet


puppet agent -t


  curl -fsSL https://get.docker.com/ | sh

  systemctl start docker
  systemctl status docker
  systemctl enable docker
  usermod -aG docker vagrant
  docker info
  docker run hello-world

  echo "Centos provisioning is  completed................................................"
