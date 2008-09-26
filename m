Return-Path: <cyrus@holtmann.org>
Message-ID: <6306c640809260237p117a46e9t9d14e54eb25a1faa@mail.gmail.com>
Date: Fri, 26 Sep 2008 15:07:55 +0530
From: "Ram kumar" <ramkumar.research@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Bluez-Utils: Flex and ENOKEY error
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-users-bounces@lists.sourceforge.net

hi,
      I have successfully cross compiled bluez-libs for my AT91SAM9260
which has arm926ej-s processor core.

VERSION:Bluez-utils-3.36 and 3.34
                Linux-2.6.25

But when i compile Bluez-utils i am facing lot of errors.Inside the
bluez-utils i have read the README file.

It says Bluez-utils needs BISON,FLEX,USBLIBRARY and GCC.

Do i have to cross compile BISON,FLEX for the Bluez-utils to cross compile????

When i configure the bluez-utils without cross compiling bison and flex.

[root@localhost bluez-utils-3.36]# ./configure --host=arm-linux
--prefix=/opt/atmel/devkit-4.1.2-uclibc3/
--libdir=/opt/atmel/devkit-4.1.2-uclibc3/lib
--includedir=/opt/atmel/devkit-4.1.2-uclibc3/include
--with-kernel=/testing3/buildroot/project_build_arm/airbox/linux-2.6.24

it configures well.

But when i type make it gives the error.....

storage.c: In function 'encrypt_link':
storage.c:286: error: 'ENOKEY' undeclared (first use in this function)
storage.c:286: error: (Each undeclared identifier is reported only once
storage.c:286: error: for each function it appears in.)
make[2]: *** [storage.lo] Error 1
make[2]: Leaving directory `/bttesting/bluez-utils-3.36/input'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/bttesting/bluez-utils-3.36'
make: *** [all] Error 2

so i disabled the input option by supplying the key --disable-input.

[root@localhost bluez-utils-3.36]# ./configure --host=arm-linux
--prefix=/opt/atmel/devkit-4.1.2-uclibc3/
--libdir=/opt/atmel/devkit-4.1.2-uclibc3/lib
--includedir=/opt/atmel/devkit-4.1.2-uclibc3/include
--with-kernel=/testing3/buildroot/project_build_arm/airbox/linux-2.6.24
--disable-input.

Then the cross-compiling succeeds.But When i transfer the tools like
hciconfig,hciattach,,,etc to the target and try to execute it says

Segmentation fault.

Hence i thought i should cross compile BISON and FLEX.So i have cross
compiled BISON and FLEX using buildroot.

Again Bluez-libs has compiled properly.

But Bluez-utils failed in the configure step.

[root@localhost bluez-utils-3.36]# ./configure --host=arm-linux
--prefix=/opt/atmel/devkit-4.1.2-uclibc3/
--libdir=/opt/atmel/devkit-4.1.2-uclibc3/lib
--includedir=/opt/atmel/devkit-4.1.2-uclibc3/include
--with-kernel=/testing3/buildroot/project_build_arm/airbox/linux-2.6.24

it says.....

configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for arm-linux-strip... arm-linux-strip
checking whether to enable maintainer-specific portions of Makefiles... no
checking for arm-linux-gcc... arm-linux-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether arm-linux-gcc accepts -g... yes
checking for arm-linux-gcc option to accept ISO C89... none needed
checking for style of include used by make... GNU
checking dependency style of arm-linux-gcc... gcc3
checking whether arm-linux-gcc accepts -fPIE... yes
checking for a BSD-compatible install... /usr/bin/install -c
checking for bison... bison -y
checking for flex... flex
checking lex output file root... configure: error: cannot find output
from flex; giving up

i don't know why it is failing with lex and flex??? .Is there any
patch i should apply to cross compile ?????

Please guide me to solve this error.

Any "How to document" on cross compiling bluez-utils for arm will be
helpful to me...

NOTE: I have exported the CC and other environment variables by using a script.
# source btscript

This is the script file.

#! /bin/bash
export GCC=arm-linux-gcc
export CC=arm-linux-gcc
export CXX=arm-linux-gcc
export LD=arm-linux-ld
export NM=arm-linux-nm
export RANLIB=arm-linux-ranlib
export AS=arm-linux-as
export PKG_CONFIG_SYSROOT=/opt/atmel/devkit-4.1.2-uclibc3
export PATH=/opt/atmel/devkit-4.1.2-uclibc3/bin:${PATH

Regards,
Ram

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
