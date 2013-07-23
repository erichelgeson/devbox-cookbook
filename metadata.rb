name             'devbox'
maintainer       'Eric Helgeson'
maintainer_email 'erichelgeson@gmail.com'
license          'All rights reserved'
description      'Installs/Configures devbox'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apt'
depends 'ssh_known_hosts'

supports 'ubuntu', '>= 12.04'