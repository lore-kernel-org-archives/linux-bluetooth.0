Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060320140334.49322.qmail@web15002.mail.cnb.yahoo.com>
From: yong Zhu <zhuyong0003@yahoo.com.cn>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-20695929-1142863414=:47618"
Subject: [Bluez-users] bluez utils compile error-"undefined reference to `daemon'"
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
Date: Mon, 20 Mar 2006 22:03:34 +0800 (CST)

--0-20695929-1142863414=:47618
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi, everyone I have one compile error in my cross-compile.
  I use the cmd "./configure --host=arm-elf --with-kernel=/home/zhuyong/uClinux-040408/linux-2.4.x/ --includedir=/home/zhuyong/uClinux-040408/linux-2.4.x/include/ --prefix=/". 
  Then the cmd "make", I have "PATH_MAX" compile error first. I try to fix it to define the macro "PATH_MAX". 
  But I got another compile error about undefined reference to `daemon' ". 
  I do not know why have the compile error. Please help me. 
   
  thanks 
  yong Zhu
   
  The "daemon" compile info as follows:
   "[root@localhost bluez-utils-2.25]# make
make  all-recursive
make[1]: Entering directory `/home/zhuyong/bluez-utils-2.25'
Making all in common
make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/common'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/common'
Making all in daemon
make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/daemon'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/daemon'
Making all in tools
make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/tools'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/tools'
Making all in rfcomm
make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/rfcomm'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/rfcomm'
Making all in hcid
make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/hcid'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/hcid'
Making all in sdpd
make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/sdpd'
source='main.c' object='main.o' libtool=no \
depfile='.deps/main.Po' tmpdepfile='.deps/main.TPo' \
depmode=gcc /bin/sh ../depcomp \
arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'main.c' || echo './'`main.c
/bin/sh ../libtool --mode=link arm-elf-gcc -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g   -o sdpd  main.o request.o service.o cstate.o servicedb.o -L//lib -lbluetooth
arm-elf-gcc -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o sdpd main.o request.o service.o cstate.o servicedb.o  -L//lib //lib/libbluetooth.a
sdpd.elf2flt: In function `main':
/home/zhuyong/bluez-utils-2.25/sdpd/main.c:409: undefined reference to `daemon'
collect2: ld returned 1 exit status
make[2]: *** [sdpd] Error 1
make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/sdpd'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/zhuyong/bluez-utils-2.25'
make: *** [all] Error 2
[root@localhost bluez-utils-2.25]#"
   
   
  the "PATH_MAX" compile error as follows: 
  "[root@localhost bluez-utils-2.25]# make
make  all-recursive
make[1]: Entering directory `/home/zhuyong/bluez-utils-2.25'
Making all in common
make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/common'
source='textfile.c' object='textfile.o' libtool=no \
depfile='.deps/textfile.Po' tmpdepfile='.deps/textfile.TPo' \
depmode=gcc /bin/sh ../depcomp \
arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I..     -elf2flt -D_FORTIFY_SOURCE=2 -g -c
`test -f 'textfile.c' || echo './'`textfile.c
rm -f libtextfile.a
arm-elf-ar cru libtextfile.a textfile.o
arm-elf-ranlib libtextfile.a
source='glib-ectomy.c' object='glib-ectomy.o' libtool=no \
depfile='.deps/glib-ectomy.Po' tmpdepfile='.deps/glib-ectomy.TPo' \
depmode=gcc /bin/sh ../depcomp \
arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I..     -elf2flt -D_FORTIFY_SOURCE=2 -g -c
`test -f 'glib-ectomy.c' || echo './'`glib-ectomy.c
rm -f libglib-ectomy.a
arm-elf-ar cru libglib-ectomy.a glib-ectomy.o
arm-elf-ranlib libglib-ectomy.a
source='test_textfile.c' object='test_textfile.o' libtool=no \
depfile='.deps/test_textfile.Po' tmpdepfile='.deps/test_textfile.TPo' \
depmode=gcc /bin/sh ../depcomp \
arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I..     -elf2flt -D_FORTIFY_SOURCE=2 -g -c
`test -f 'test_textfile.c' || echo './'`test_textfile.c
/bin/sh ../libtool --mode=link arm-elf-gcc  -elf2flt -D_FORTIFY_SOURCE=2 -g   -o test_textfile  test_textfile.o libtextfile.a
mkdir .libs
arm-elf-gcc -elf2flt -D_FORTIFY_SOURCE=2 -g -o test_textfile test_textfile.o  libtextfile.a
make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/common'
Making all in daemon
make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/daemon'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/daemon'
Making all in tools
make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/tools'
source='hcitool.c' object='hcitool.o' libtool=no \
depfile='.deps/hcitool.Po' tmpdepfile='.deps/hcitool.TPo' \
depmode=gcc /bin/sh ../depcomp \
arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I//include  -I//include
-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'hcitool.c' || echo './'`hcitool.c
source='oui.c' object='oui.o' libtool=no \
depfile='.deps/oui.Po' tmpdepfile='.deps/oui.TPo' \
depmode=gcc /bin/sh ../depcomp \
arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I//include  -I//include
-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'oui.c' || echo './'`oui.c
/bin/sh ../libtool --mode=link arm-elf-gcc -I//include  -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g   -o hcitool  hcitool.o oui.o -L//lib -lbluetooth ../common/libtextfile.a
mkdir .libs
arm-elf-gcc -I//include -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o hcitool hcitool.o oui.o  -L//lib //lib/libbluetooth.a ../common/libtextfile.a
source='l2ping.c' object='l2ping.o' libtool=no \
depfile='.deps/l2ping.Po' tmpdepfile='.deps/l2ping.TPo' \
depmode=gcc /bin/sh ../depcomp \
arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I//include  -I//include
-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'l2ping.c' || echo './'`l2ping.c
/bin/sh ../libtool --mode=link arm-elf-gcc -I//include  -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g   -o l2ping  l2ping.o -L//lib -lbluetooth
arm-elf-gcc -I//include -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o l2ping l2ping.o  -L//lib //lib/libbluetooth.a
source='sdptool.c' object='sdptool.o' libtool=no \
depfile='.deps/sdptool.Po' tmpdepfile='.deps/sdptool.TPo' \
depmode=gcc /bin/sh ../depcomp \
arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I//include  -I//include
-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'sdptool.c' || echo './'`sdptool.c
/bin/sh ../libtool --mode=link arm-elf-gcc -I//include  -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g   -o sdptool  sdptool.o -L//lib -lbluetooth
arm-elf-gcc -I//include -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o sdptool sdptool.o  -L//lib //lib/libbluetooth.a
source='ciptool.c' object='ciptool.o' libtool=no \
depfile='.deps/ciptool.Po' tmpdepfile='.deps/ciptool.TPo' \
depmode=gcc /bin/sh ../depcomp \
arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I//include  -I//include
-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'ciptool.c' || echo './'`ciptool.c
/bin/sh ../libtool --mode=link arm-elf-gcc -I//include  -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g   -o ciptool  ciptool.o -L//lib -lbluetooth
arm-elf-gcc -I//include -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o ciptool ciptool.o  -L//lib //lib/libbluetooth.a
source='hcisecfilter.c' object='hcisecfilter.o' libtool=no \
depfile='.deps/hcisecfilter.Po' tmpdepfile='.deps/hcisecfilter.TPo' \
depmode=gcc /bin/sh ../depcomp \
arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I//include  -I//include
-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'hcisecfilter.c' || echo './'`hcisecfilter.c
/bin/sh ../libtool --mode=link arm-elf-gcc -I//include  -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g   -o hcisecfilter  hcisecfilter.o
arm-elf-gcc -I//include -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o hcisecfilter hcisecfilter.o
source='ppporc.c' object='ppporc.o' libtool=no \
depfile='.deps/ppporc.Po' tmpdepfile='.deps/ppporc.TPo' \
depmode=gcc /bin/sh ../depcomp \
arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I//include  -I//include
-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'ppporc.c' || echo './'`ppporc.c
/bin/sh ../libtool --mode=link arm-elf-gcc -I//include  -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g   -o ppporc  ppporc.o -L//lib -lbluetooth
arm-elf-gcc -I//include -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o ppporc ppporc.o  -L//lib //lib/libbluetooth.a
source='hciattach.c' object='hciattach.o' libtool=no \
depfile='.deps/hciattach.Po' tmpdepfile='.deps/hciattach.TPo' \
depmode=gcc /bin/sh ../depcomp \
arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I//include  -I//include
-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'hciattach.c' || echo './'`hciattach.c
hciattach.c: In function `main':
hciattach.c:972: `PATH_MAX' undeclared (first use in this function)
hciattach.c:972: (Each undeclared identifier is reported only once
hciattach.c:972: for each function it appears in.)
make[2]: *** [hciattach.o] Error 1
make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/tools'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/zhuyong/bluez-utils-2.25'
make: *** [all] Error 2
[root@localhost bluez-utils-2.25]#
" 

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
--0-20695929-1142863414=:47618
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<div>Hi, everyone I have one compile error in my cross-compile.</div>  <div>I use the cmd "./configure --host=arm-elf --with-kernel=/home/zhuyong/uClinux-040408/linux-2.4.x/ --includedir=/home/zhuyong/uClinux-040408/linux-2.4.x/include/ --prefix=/". </div>  <div>Then the cmd "make", I have "PATH_MAX" compile error first. I try to fix it to define the macro "PATH_MAX". </div>  <div>But I got another compile error about undefined reference to `daemon' ". </div>  <div>I do not know why have the compile error. Please help me. </div>  <div>&nbsp;</div>  <div>thanks </div>  <div>yong Zhu</div>  <div>&nbsp;</div>  <div>The "daemon" compile info as follows:</div>  <div>&nbsp;"[root@localhost bluez-utils-2.25]# make<BR>make&nbsp; all-recursive<BR>make[1]: Entering directory `/home/zhuyong/bluez-utils-2.25'<BR>Making all in common<BR>make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/common'<BR>make[2]: Nothing to be done for `all'.<BR>make[2]: Leaving directory
 `/home/zhuyong/bluez-utils-2.25/common'<BR>Making all in daemon<BR>make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/daemon'<BR>make[2]: Nothing to be done for `all'.<BR>make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/daemon'<BR>Making all in tools<BR>make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/tools'<BR>make[2]: Nothing to be done for `all'.<BR>make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/tools'<BR>Making all in rfcomm<BR>make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/rfcomm'<BR>make[2]: Nothing to be done for `all'.<BR>make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/rfcomm'<BR>Making all in hcid<BR>make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/hcid'<BR>make[2]: Nothing to be done for `all'.<BR>make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/hcid'<BR>Making all in sdpd<BR>make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/sdpd'<BR>source='main.c' object='main.o' libt
 ool=no
 \<BR>depfile='.deps/main.Po' tmpdepfile='.deps/main.TPo' \<BR>depmode=gcc /bin/sh ../depcomp \<BR>arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'main.c' || echo './'`main.c<BR>/bin/sh ../libtool --mode=link arm-elf-gcc -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g&nbsp;&nbsp; -o sdpd&nbsp; main.o request.o service.o cstate.o servicedb.o -L//lib -lbluetooth<BR>arm-elf-gcc -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o sdpd main.o request.o service.o cstate.o servicedb.o&nbsp; -L//lib //lib/libbluetooth.a<BR>sdpd.elf2flt: In function `main':<BR>/home/zhuyong/bluez-utils-2.25/sdpd/main.c:409: undefined reference to `daemon'<BR>collect2: ld returned 1 exit status<BR>make[2]: *** [sdpd] Error 1<BR>make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/sdpd'<BR>make[1]: *** [all-recursive] Error 1<BR>make[1]: Leaving directory `/home/zhuyong/bluez-utils-2.25'<BR>make: *** [all] Error 2<BR>[root@localhost
 bluez-utils-2.25]#"</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>the "PATH_MAX" compile error as follows: </div>  <div>"[root@localhost bluez-utils-2.25]# make<BR>make&nbsp; all-recursive<BR>make[1]: Entering directory `/home/zhuyong/bluez-utils-2.25'<BR>Making all in common<BR>make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/common'<BR>source='textfile.c' object='textfile.o' libtool=no \<BR>depfile='.deps/textfile.Po' tmpdepfile='.deps/textfile.TPo' \<BR>depmode=gcc /bin/sh ../depcomp \<BR>arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp;&nbsp; -elf2flt -D_FORTIFY_SOURCE=2 -g -c<BR>`test -f 'textfile.c' || echo './'`textfile.c<BR>rm -f libtextfile.a<BR>arm-elf-ar cru libtextfile.a textfile.o<BR>arm-elf-ranlib libtextfile.a<BR>source='glib-ectomy.c' object='glib-ectomy.o' libtool=no \<BR>depfile='.deps/glib-ectomy.Po' tmpdepfile='.deps/glib-ectomy.TPo' \<BR>depmode=gcc /bin/sh ../depcomp \<BR>arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp;
 &nbsp;
 -elf2flt -D_FORTIFY_SOURCE=2 -g -c<BR>`test -f 'glib-ectomy.c' || echo './'`glib-ectomy.c<BR>rm -f libglib-ectomy.a<BR>arm-elf-ar cru libglib-ectomy.a glib-ectomy.o<BR>arm-elf-ranlib libglib-ectomy.a<BR>source='test_textfile.c' object='test_textfile.o' libtool=no \<BR>depfile='.deps/test_textfile.Po' tmpdepfile='.deps/test_textfile.TPo' \<BR>depmode=gcc /bin/sh ../depcomp \<BR>arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp;&nbsp; -elf2flt -D_FORTIFY_SOURCE=2 -g -c<BR>`test -f 'test_textfile.c' || echo './'`test_textfile.c<BR>/bin/sh ../libtool --mode=link arm-elf-gcc&nbsp; -elf2flt -D_FORTIFY_SOURCE=2 -g&nbsp;&nbsp; -o test_textfile&nbsp; test_textfile.o libtextfile.a<BR>mkdir .libs<BR>arm-elf-gcc -elf2flt -D_FORTIFY_SOURCE=2 -g -o test_textfile test_textfile.o&nbsp; libtextfile.a<BR>make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/common'<BR>Making all in daemon<BR>make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/daemon'<BR>make[2]: Nothing t
 o be
 done for `all'.<BR>make[2]: Leaving directory `/home/zhuyong/bluez-utils-2.25/daemon'<BR>Making all in tools<BR>make[2]: Entering directory `/home/zhuyong/bluez-utils-2.25/tools'<BR>source='hcitool.c' object='hcitool.o' libtool=no \<BR>depfile='.deps/hcitool.Po' tmpdepfile='.deps/hcitool.TPo' \<BR>depmode=gcc /bin/sh ../depcomp \<BR>arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I//include&nbsp; -I//include<BR>-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'hcitool.c' || echo './'`hcitool.c<BR>source='oui.c' object='oui.o' libtool=no \<BR>depfile='.deps/oui.Po' tmpdepfile='.deps/oui.TPo' \<BR>depmode=gcc /bin/sh ../depcomp \<BR>arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I//include&nbsp; -I//include<BR>-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'oui.c' || echo './'`oui.c<BR>/bin/sh ../libtool --mode=link arm-elf-gcc -I//include&nbsp; -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g&nbsp;&nbsp; -o hcitool&nbsp; hcitool.o oui.o -L//lib -lbluet
 ooth
 ../common/libtextfile.a<BR>mkdir .libs<BR>arm-elf-gcc -I//include -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o hcitool hcitool.o oui.o&nbsp; -L//lib //lib/libbluetooth.a ../common/libtextfile.a<BR>source='l2ping.c' object='l2ping.o' libtool=no \<BR>depfile='.deps/l2ping.Po' tmpdepfile='.deps/l2ping.TPo' \<BR>depmode=gcc /bin/sh ../depcomp \<BR>arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I//include&nbsp; -I//include<BR>-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'l2ping.c' || echo './'`l2ping.c<BR>/bin/sh ../libtool --mode=link arm-elf-gcc -I//include&nbsp; -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g&nbsp;&nbsp; -o l2ping&nbsp; l2ping.o -L//lib -lbluetooth<BR>arm-elf-gcc -I//include -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o l2ping l2ping.o&nbsp; -L//lib //lib/libbluetooth.a<BR>source='sdptool.c' object='sdptool.o' libtool=no \<BR>depfile='.deps/sdptool.Po' tmpdepfile='.deps/sdptool.TPo' \<BR>depmode=gcc /bin/sh ../depcomp \<BR>arm-elf-gcc -DHAVE_C
 ONFIG_H
 -I. -I. -I.. -I../common&nbsp;&nbsp; -I//include&nbsp; -I//include<BR>-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'sdptool.c' || echo './'`sdptool.c<BR>/bin/sh ../libtool --mode=link arm-elf-gcc -I//include&nbsp; -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g&nbsp;&nbsp; -o sdptool&nbsp; sdptool.o -L//lib -lbluetooth<BR>arm-elf-gcc -I//include -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o sdptool sdptool.o&nbsp; -L//lib //lib/libbluetooth.a<BR>source='ciptool.c' object='ciptool.o' libtool=no \<BR>depfile='.deps/ciptool.Po' tmpdepfile='.deps/ciptool.TPo' \<BR>depmode=gcc /bin/sh ../depcomp \<BR>arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I//include&nbsp; -I//include<BR>-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'ciptool.c' || echo './'`ciptool.c<BR>/bin/sh ../libtool --mode=link arm-elf-gcc -I//include&nbsp; -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g&nbsp;&nbsp; -o ciptool&nbsp; ciptool.o -L//lib -lbluetooth<BR>arm-elf-gcc -I//include -I//include -elf2fl
 t
 -D_FORTIFY_SOURCE=2 -g -o ciptool ciptool.o&nbsp; -L//lib //lib/libbluetooth.a<BR>source='hcisecfilter.c' object='hcisecfilter.o' libtool=no \<BR>depfile='.deps/hcisecfilter.Po' tmpdepfile='.deps/hcisecfilter.TPo' \<BR>depmode=gcc /bin/sh ../depcomp \<BR>arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I//include&nbsp; -I//include<BR>-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'hcisecfilter.c' || echo './'`hcisecfilter.c<BR>/bin/sh ../libtool --mode=link arm-elf-gcc -I//include&nbsp; -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g&nbsp;&nbsp; -o hcisecfilter&nbsp; hcisecfilter.o<BR>arm-elf-gcc -I//include -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o hcisecfilter hcisecfilter.o<BR>source='ppporc.c' object='ppporc.o' libtool=no \<BR>depfile='.deps/ppporc.Po' tmpdepfile='.deps/ppporc.TPo' \<BR>depmode=gcc /bin/sh ../depcomp \<BR>arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I//include&nbsp; -I//include<BR>-elf2flt -D_FORTIFY_SOURCE=2 -g -c `te
 st -f
 'ppporc.c' || echo './'`ppporc.c<BR>/bin/sh ../libtool --mode=link arm-elf-gcc -I//include&nbsp; -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g&nbsp;&nbsp; -o ppporc&nbsp; ppporc.o -L//lib -lbluetooth<BR>arm-elf-gcc -I//include -I//include -elf2flt -D_FORTIFY_SOURCE=2 -g -o ppporc ppporc.o&nbsp; -L//lib //lib/libbluetooth.a<BR>source='hciattach.c' object='hciattach.o' libtool=no \<BR>depfile='.deps/hciattach.Po' tmpdepfile='.deps/hciattach.TPo' \<BR>depmode=gcc /bin/sh ../depcomp \<BR>arm-elf-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I//include&nbsp; -I//include<BR>-elf2flt -D_FORTIFY_SOURCE=2 -g -c `test -f 'hciattach.c' || echo './'`hciattach.c<BR>hciattach.c: In function `main':<BR>hciattach.c:972: `PATH_MAX' undeclared (first use in this function)<BR>hciattach.c:972: (Each undeclared identifier is reported only once<BR>hciattach.c:972: for each function it appears in.)<BR>make[2]: *** [hciattach.o] Error 1<BR>make[2]: Leaving directory
 `/home/zhuyong/bluez-utils-2.25/tools'<BR>make[1]: *** [all-recursive] Error 1<BR>make[1]: Leaving directory `/home/zhuyong/bluez-utils-2.25'<BR>make: *** [all] Error 2<BR>[root@localhost bluez-utils-2.25]#<BR>" </div><p>__________________________________________________<br>∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?<br>http://cn.mail.yahoo.com
--0-20695929-1142863414=:47618--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
