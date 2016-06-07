
#!/bin/bash
curl http://yum.oracle.com/public-yum-ol7.repo -o /etc/yum.repos.d/public-yum-ol7.repo
rpm --import http://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol7
yum -y update yum
yum clean all
rpm -e --nodeps centos-release centos-logos
yum -y install oraclelinux-release oracle-logos
yum -y upgrade
rpm -qa --qf '%{NAME}:%{VENDOR}\n' |  grep  CentOS >> centospacks
cat centospacks | awk -F":" '{print $1}' >> centospacks2
yum -y reinstall --enablerepo=ol7_optional_latest `cat centospacks2`
yum -y update --enablerepo=ol7_optional_latest `cat centospacks2`
rm -f centospacks
rm -f centospacks2

