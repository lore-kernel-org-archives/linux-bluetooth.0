Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606260404kc22d718u4561df45147624e@mail.gmail.com>
Date: Mon, 26 Jun 2006 16:34:23 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] bluez-utils do not cross compile
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0280030129=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0280030129==
Content-Type: multipart/alternative;
	boundary="----=_Part_44807_15740040.1151319863892"

------=_Part_44807_15740040.1151319863892
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am trying to cross compile bluez-libs-2.25 and bluez-utils-2.25 for ARM.
bluez-libs-2.25 cross-compile fine.
But when I cross compile bluez-utils, I get the following error while
configuring:


[root@localhost bluez-utils-2.25]#./configure --host=arm-linux
--libdir=/usr/local/arm/2.95.3/arm-linux/lib
--includedir=/usr/local/arm/2.95.3/arm-linux/include
--with-kernel=$KERNEL_PATH

configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
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
checking for arm-linux-gcc option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of arm-linux-gcc... gcc
checking whether arm-linux-gcc accepts -fPIE... no
checking for a BSD-compatible install... /usr/bin/install -c
checking for bison... bison -y
checking for flex... flex
checking for yywrap in -lfl... no
checking for yywrap in -ll... no
checking lex output file root... lex.yy
checking whether yytext is a pointer... no
checking build system type... i686-pc-linux-gnu
checking host system type... arm-unknown-linux-gnu
checking for a sed that does not truncate output... /bin/sed
checking for egrep... grep -E
checking for ld used by arm-linux-gcc... arm-linux-ld
checking if the linker (arm-linux-ld) is GNU ld... yes
checking for arm-linux-ld option to reload object files... -r
checking for BSD-compatible nm... arm-linux-nm
checking whether ln -s works... yes
checking how to recognise dependent libraries... pass_all
checking how to run the C preprocessor... arm-linux-gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking dlfcn.h usability... yes
checking dlfcn.h presence... yes
checking for dlfcn.h... yes
checking the maximum length of command line arguments... 32768
checking command to parse arm-linux-nm output from arm-linux-gcc object...
ok
checking for objdir... .libs
checking for arm-linux-ar... arm-linux-ar
checking for arm-linux-ranlib... arm-linux-ranlib
checking for arm-linux-strip... (cached) arm-linux-strip
checking if arm-linux-gcc supports -fno-rtti -fno-exceptions... yes
checking for arm-linux-gcc option to produce PIC... -fPIC
checking if arm-linux-gcc PIC flag -fPIC works... yes
checking if arm-linux-gcc static flag -static works... yes
checking if arm-linux-gcc supports -c -o file.o... yes
checking whether the arm-linux-gcc linker (arm-linux-ld) supports shared
libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
configure: creating libtool
checking bluetooth/bluetooth.h usability... yes
checking bluetooth/bluetooth.h presence... yes
checking for bluetooth/bluetooth.h... yes
checking for hci_open_dev in -lbluetooth... no
configure: error: Bluetooth library not found





=================

*Can you help me find out the reason fro the error: Bluetooth library not
found ???*
**
Any suggestions will be appreciated.
Thanks in advance.

Regards,
Mayank

------=_Part_44807_15740040.1151319863892
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I am trying to cross compile bluez-libs-2.25 and bluez-utils-2.25 for ARM.</div>
<div>bluez-libs-2.25 cross-compile fine.</div>
<div>But when I cross compile bluez-utils, I get the following error while configuring:</div>
<div>&nbsp;</div>
<blockquote dir="ltr" style="MARGIN-RIGHT: 0px">
<div>[root@localhost bluez-utils-2.25]#./configure --host=arm-linux --libdir=/usr/local/arm/2.95.3/arm-linux/lib --includedir=/usr/local/arm/2.95.3/arm-linux/include --with-kernel=$KERNEL_PATH</div>
<div><br>configure: WARNING: If you wanted to set the --build type, don't use --host.<br>&nbsp;&nbsp;&nbsp; If a cross compiler is detected then cross compile mode will be used.<br>checking for a BSD-compatible install... /usr/bin/install -c
<br>checking whether build environment is sane... yes<br>checking for gawk... gawk<br>checking whether make sets $(MAKE)... yes<br>checking for arm-linux-strip... arm-linux-strip<br>checking whether to enable maintainer-specific portions of Makefiles... no
<br>checking for arm-linux-gcc... arm-linux-gcc<br>checking for C compiler default output file name... a.out<br>checking whether the C compiler works... yes<br>checking whether we are cross compiling... yes<br>checking for suffix of executables... 
<br>checking for suffix of object files... o<br>checking whether we are using the GNU C compiler... yes<br>checking whether arm-linux-gcc accepts -g... yes<br>checking for arm-linux-gcc option to accept ANSI C... none needed
<br>checking for style of include used by make... GNU<br>checking dependency style of arm-linux-gcc... gcc<br>checking whether arm-linux-gcc accepts -fPIE... no<br>checking for a BSD-compatible install... /usr/bin/install -c
<br>checking for bison... bison -y<br>checking for flex... flex<br>checking for yywrap in -lfl... no<br>checking for yywrap in -ll... no<br>checking lex output file root... lex.yy<br>checking whether yytext is a pointer... no
<br>checking build system type... i686-pc-linux-gnu<br>checking host system type... arm-unknown-linux-gnu<br>checking for a sed that does not truncate output... /bin/sed<br>checking for egrep... grep -E<br>checking for ld used by arm-linux-gcc... arm-linux-ld
<br>checking if the linker (arm-linux-ld) is GNU ld... yes<br>checking for arm-linux-ld option to reload object files... -r<br>checking for BSD-compatible nm... arm-linux-nm<br>checking whether ln -s works... yes<br>checking how to recognise dependent libraries... pass_all
<br>checking how to run the C preprocessor... arm-linux-gcc -E<br>checking for ANSI C header files... yes<br>checking for sys/types.h... yes<br>checking for sys/stat.h... yes<br>checking for stdlib.h... yes<br>checking for 
string.h... yes<br>checking for memory.h... yes<br>checking for strings.h... yes<br>checking for inttypes.h... yes<br>checking for stdint.h... yes<br>checking for unistd.h... yes<br>checking dlfcn.h usability... yes<br>checking 
dlfcn.h presence... yes<br>checking for dlfcn.h... yes<br>checking the maximum length of command line arguments... 32768<br>checking command to parse arm-linux-nm output from arm-linux-gcc object... ok<br>checking for objdir... .libs
<br>checking for arm-linux-ar... arm-linux-ar<br>checking for arm-linux-ranlib... arm-linux-ranlib<br>checking for arm-linux-strip... (cached) arm-linux-strip<br>checking if arm-linux-gcc supports -fno-rtti -fno-exceptions... yes
<br>checking for arm-linux-gcc option to produce PIC... -fPIC<br>checking if arm-linux-gcc PIC flag -fPIC works... yes<br>checking if arm-linux-gcc static flag -static works... yes<br>checking if arm-linux-gcc supports -c -o 
file.o... yes<br>checking whether the arm-linux-gcc linker (arm-linux-ld) supports shared libraries... yes<br>checking whether -lc should be explicitly linked in... no<br>checking dynamic linker characteristics... GNU/Linux 
ld.so<br>checking how to hardcode library paths into programs... immediate<br>checking whether stripping libraries is possible... yes<br>checking if libtool supports shared libraries... yes<br>checking whether to build shared libraries... yes
<br>checking whether to build static libraries... no<br>configure: creating libtool<br>checking bluetooth/bluetooth.h usability... yes<br>checking bluetooth/bluetooth.h presence... yes<br>checking for bluetooth/bluetooth.h... yes
<br>checking for hci_open_dev in -lbluetooth... no<br>configure: error: Bluetooth library not found<br>&nbsp;</div></blockquote>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>=================</div>
<div>&nbsp;</div>
<div><strong>Can you help me find out the reason fro the error: Bluetooth library not found ???</strong></div>
<div><strong></strong>&nbsp;</div>
<div>Any suggestions will be appreciated.</div>
<div>Thanks in advance.</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div>

------=_Part_44807_15740040.1151319863892--


--===============0280030129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0280030129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0280030129==--
