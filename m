Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42384F8F.8030402@amplex.dk>
From: Stephan Henningsen <sth@amplex.dk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Trouble compiling BlueZ-utils in buildroot environment
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 16 Mar 2005 16:23:59 +0100

Hello World,

I'm trying to include bluez-libs and blues-utils buildroot 
environment.  I did this by making two seperate packages named 
bluez-libs and bluez-utils, and a set of buildroot style 
configuration files: bluez-libs.mk + Config.in and bluez-utils.mk + 
Config.in.  And the bluez-libs seems to cross-compile and install 
fine into build_arm/root of the buildroot environment.

But when I try to install bluez-tools, I get the error below while
bluez-tools' configure is working.  Apoligizes of line breaks 
introduced by my mail client.  Also note, that I did not include the 
entire screen log.

Did I compile bluez-libs in a wrong way?  I have compiled it and 
bluez-tools successfully before normally, ie. without buildroot.

I can include the entire log together with buildroot scripts if needed.



sth@speedball:~/au/buildroot$ make bluez-utils
(cd /home/sth/au/buildroot/build_arm/bluez-utils-2.15; \

PATH=/home/sth/au/buildroot/build_arm/staging_dir/bin:/bin:/sbin:/usr/bi
n:/usr/sbin
AR=/home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc
-ar
AS=/home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-as
LD=/
home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-ld
NM=/home/sth
/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-nm
CC=/home/sth/au/buil
droot/build_arm/staging_dir/bin/arm-linux-uclibc-gcc
GCC=/home/sth/au/buildroot/
build_arm/staging_dir/bin/arm-linux-uclibc-gcc
CXX=/home/sth/au/buildroot/build_
arm/staging_dir/bin/arm-linux-uclibc-g++
RANLIB=/home/sth/au/buildroot/build_arm
/staging_dir/bin/arm-linux-uclibc-ranlib \
         CFLAGS="-Os -pipe " \
         ./configure \
         --target=arm-linux \
         --host=arm-linux \
         --build=i386-pc-linux-gnu \
         --prefix=/usr \
         --exec-prefix=/usr \
         --bindir=/usr/bin \
         --sbindir=/usr/sbin \
         --libexecdir=/usr/lib \
         --sysconfdir=/etc \
         --datadir=/usr/share \
         --localstatedir=/var \
         --mandir=/usr/man \
         --infodir=/usr/info \
         --with-bluez=/usr \
);
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
...
... (lots of checking going on)
...
checking for unistd.h... yes
checking bluetooth/bluetooth.h usability... yes
checking bluetooth/bluetooth.h presence... yes
checking for bluetooth/bluetooth.h... yes
checking for hci_open_dev in -lbluetooth... no
configure: error: Bluetooth library not found
make: *** 
[/home/sth/au/buildroot/build_arm/bluez-utils-2.15/.configured] Error 1
sth@speedball:~/au/buildroot$


-- 
Stephan Henningsen


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
