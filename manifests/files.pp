class jenkins::files(
  $url,
  $email_address,
  $slaves,
  $views
) {
  file { "/var/lib/jenkins/config.xml":
    ensure => file,
    owner => jenkins,
    group => nogroup,
    mode => 0644,
    content => strip(template("jenkins/config.xml.erb")),
    notify => Class['jenkins::service']
  }

  file { "/var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml":
    ensure => file,
    owner => jenkins,
    group => nogroup,
    mode => "0644",
    content => strip(template("jenkins/jenkins.model.JenkinsLocationConfiguration.xml.erb")),
    notify => Class['jenkins::service']
  }

  file { "/var/lib/jenkins/jobs":
    ensure => directory,
    owner => jenkins,
    group => nogroup,
    recurse => true,
    purge => true,
    force => true
  }

  file { "/var/lib/jenkins/plugins":
    ensure => directory,
    owner => jenkins,
    group => nogroup
  }
  
  file { "/etc/default/jenkins":
    source => 'puppet:///modules/jenkins/jenkins_default',
    owner  => root,
    group  => root,
    mode   => '0644',
  }
}
