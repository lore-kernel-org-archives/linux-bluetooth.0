Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <d1f423d3050304053873e95ba1@mail.gmail.com>
From: Anderson Rodrigues <rodrigues.anderson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Crosscompiling Bluez - Tutorial
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 4 Mar 2005 08:38:26 -0500

Hi folks,


I made a short tutorial of how compiling Bluez to ARM plataform using
the Scratchbox Crosscompiling environment. Maybe someone can think it
is usefull. Any sugestiong will be welcome.


Cheers,


BEGIN OF TUTORIAL
+--------------------------------------------------------------------------=
-----------+

Authors: Anderson Rodrigues (ext-anderson.rodrigues@indt.org.br)
Eduardo Valentin (ebv@dcc.ufam.edu.br)
Date: 28/01/2005
Revision: 1.0
By: Raoni Novellino (raoni.novellino@indt.org.br)

1. Objective

This short tutorial aims to show how to configure and install Bluez
bluetooth stack and tools on Innovator 1510, it includes a bluetooth device
emulator that allows the execution of tests.

2. Dependencies

a) Kernel source linux-2.6.10.tar.bz2 from www.kernel.org
b) patch-2.6.10-omap1.gz from www.muru.com
c) patch-2.6.10-mh2.gz http://www.bluez.org/patches.html
d) bluez-libs-2.14.tar.gz from http://www.bluez.org/download.html
e) bluez-utils-2.14.tar.gz from http:/www.bluez.org/download.html
f) bluez-hciemu-1.1.tar.gz from http://www.bluez.org/download.html
g) glib-2.6.0.tar.bz2 from http://www.gtk.org

3. Preparing the Kernel Image

OBS: We are assuming that you have scratchbox fully installed and right
configured to allow kernel compilation and the following commands are all
executed inside the scratchbox environment (excepted when indicated).
See section A for more details.

a) Unpack linux-2.6.10.tar.bz2 inside your home directory in scratchbox
b) Apply the patch-2.6.10-omap1.gz to the source (patch -p1 <
patch-2.6.10-omap1)
c) Apply the patch-2.6.10-mh2.gz to the source (patch -p1 <
patch-2.6.10-mh2)
d) Execute commands:
make omap_1510_innovator_defconfig
make menuconfig
d) Make sure that the following options are selected:

<*> Networking support --->
<*> Bluetooth subsystem support --->
<*> L2CAP protocol support
Bluetooth device drivers --->
<*> HCI VHCI (Virtual HCI device) driver (Utilizado para realizar testes)

e) Compile the kernel image using the following comand:
make uImage
f) Compile and install he kernel modules:
fakeroot make modules
fakeroot make modules_install
g) Copy the necessaries files to your target filesystem directory:

OBS: These commands must be executed outside the scratchbox as root user.

# cp -a
/scratchbox/users/<your_user_name>/home/<your_user_name>/linux-2.6.10/arch/=
arm/boot/uImage
/<your_tftp_boot_directory>

# cp -a
/scratchbox/users/<your_user_name>/targets/<your_target_name>/lib/modules/2=
.6.10-mh2-omap1/<your_nfs_file_system_directory>/lib/modules

4. Compiling and installing the bluez-tools

a) Unpack the bluez-libs-2.14 source into your home directory in scratchbox
b) Create a directory called usr into your home directory in scratchbox
c) Configure the compilation as follows:
cd bluez-libs-2.14
/configure --prefix=3D/home/<your_user_name>/usr
d) Compile and install:
make
make install
e) Unpack the bluez-utils-2.14 source into your home directory in
scratchbox and enter into bluez-utils-2.14 directory
f) Edit the file tools/Makefile.in and change the following line:
CFLAGS =3D @CFLAGS@
to
CFLAGS =3D @CFLAGS@ -L/home/<your_user_name>/usr/lib
g) Configure the compilation as follows:
cd bluez-utils-2.14
./configure --prefix=3D/home/<your_user_name>/usr --enable-test
h) Compile and install:
make
make install
i) Copy the necessaries files to your target filesystem directory:

OBS: These command must be executed outside the scratchbox as root user.

cp -a /scratchbox/users/<your_user_name>/home/<your_user_name>/usr/*
/<your_nfs_file_system_directory>/usr/

5. Compiling and installing Bluez HCIEmu

a) Extract glib-2.6.0 into the scratchbox environment
b) In order to configure the glib compilation execute the following
commands:
> ./configure --prefix=3D/usr/local --with-threads=3Dnone
> make
> make install

c) Extract bluez-hciemu-1.1.tar.gz inside the scratchbox environment;
d) In order to configure the compilation execute the following command:
> ./configure --prefix=3D/home/<your_user_name>/usr/ --disable-glibtest
e) Edit the Makefile and change the CFLAG variable to:
-Wall -O2 -I/usr/local/include/glib-2.0
-I/usr/local/lib/glib-2.0/include -L/usr/local/lib -l glib-2.0
f) Compile:
> make
g) Copy the hciemu directory to your <your_nfs_file_system_directory>
OBS: this command must be executed outside of the scratchbox environment
# cp -r
/scratchbox/users/<your_user_name>/home/<your_user_name>/bluez-hciemu-1.1
/<your_nfs_file_system_directory>/usr/local

6. Testing bluetooth

a) Execute the following commands at the omapinnovator prompt:
# mknod /dev/vhci c 10 250
'Creates the HCI interfaces
# ./hciemu localhost:10
# ./hciemu localhost:11
'Activates the HCI interfaces
# hciconfig hci0 up '
# hciconfig hci1 up
'Show the available HCI interfaces
# hciconfig

You can also send a virtual ping to these virtual devices using the
following command:
# l2ping <BD Address>

A. Compiling U-boot-1.1.1

a) Download U-boot-1.1.1 from:
http://sourceforge.net/project/showfiles.php?group_id=3D65938

b) Unpack U-boot inside the scratchbox environment

c) Get into the U-boot directory
> cd u-boot-1.1.1

d) Configure Make:
> make omap1510inn_config

c) Compile U-boot
> make all (you will have some errors. Don=B4t mind)
> make all (Now the file we want has been generated)

d) Verify if there is a file named "mkimage"
> ls tools/

e ) Copy this file to your scratchbox \usr\bin directory:
> cp tools/mkimage /usr/bin

OBS: All commands must be executed inside the scratchbox environment.
+--------------------------------------------------------END OF
TUTORIAL--------------------------------------------

--=20
Anderson Clayton B. Rodrigues
Eng. de Software
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
