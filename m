Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <28c817710605310752n2485f3fcu2c59786a24982522@mail.gmail.com>
Date: Wed, 31 May 2006 22:52:25 +0800
From: ifq <ifqqfi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] cross compile BlueZ lib error
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0704012811=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0704012811==
Content-Type: multipart/alternative;
	boundary="----=_Part_30140_20701792.1149087145274"

------=_Part_30140_20701792.1149087145274
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, all,

I want to cross compile bluez lib for arm.

And I have done as following:
#./configure --host=armv4l-linux --prefix=/root/bluedev/bluezport/libs
CC=/opt/host/armv4l/bin/armv4l-unknown-linux-gcc
CPP=/opt/host/armv4l/bin/armv4l-unknown-linux-cpp
AR=/opt/host/armv4l/bin/armv4l-unknown-linux-ar
STRIP=/opt/host/armv4l/bin/armv4l-unknown-linux-strip
RANLIB=/opt/host/armv4l/bin/armv4l-unknown-linux-ranlib
LD=/opt/host/armv4l/bin/armv4l-unknown-linux-ld
--includedir=/root/linux/include

"/root/linux/include"is my arm linux include directory.

then
#make

and i get an error as follow:
/bin/sh ../libtool --mode=compile
/opt/host/armv4l/bin/armv4l-unknown-linux-gcc -DHAVE_CONFIG_H -I. -I. -I..
-I../include    -Wall -O2 -D_FORTIFY_SOURCE=2 -c -o hci.lo `test -f 'hci.c'
|| echo './'`hci.c
 /opt/host/armv4l/bin/armv4l-unknown-linux-gcc -DHAVE_CONFIG_H -I. -I. -I..
-I../include -Wall -O2 -D_FORTIFY_SOURCE=2 -c hci.c -Wp,-MD,.deps/hci.TPlo
-o hci.o
hci.c: In function `hci_send_cmd':
hci.c:885: storage size of `iv' isn't known
hci.c:903: warning: implicit declaration of function `writev'
hci.c:885: warning: unused variable `iv'

according to "hci.c" the 'iv 'is a "struct iovec".and this struct defined in
the linux/include/linux/uio.h
I think this is a very simple error,but i'm new to linux.so,please help me
to fix it up:)

thanks very much!

if.q
Cheng DU .China

------=_Part_30140_20701792.1149087145274
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hello, all,</div>
<div>&nbsp;</div>
<div>I want to cross compile bluez lib for arm.</div>
<div>&nbsp;</div>
And I have done as following:<br>#./configure --host=armv4l-linux
--prefix=/root/bluedev/bluezport/libs
CC=/opt/host/armv4l/bin/armv4l-unknown-linux-gcc
CPP=/opt/host/armv4l/bin/armv4l-unknown-linux-cpp
AR=/opt/host/armv4l/bin/armv4l-unknown-linux-ar
STRIP=/opt/host/armv4l/bin/armv4l-unknown-linux-strip
RANLIB=/opt/host/armv4l/bin/armv4l-unknown-linux-ranlib<br>
  LD=/opt/host/armv4l/bin/armv4l-unknown-linux-ld<br>--includedir=/root/linux/include<a></a><br><br>
&quot;/root/linux/include&quot;is my arm linux include directory.<br><br>then<br>#make<br><br>and i get an error as follow:<br>/bin/sh ../libtool --mode=compile /opt/host/armv4l/bin/armv4l-unknown-linux-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../include&nbsp;&nbsp;&nbsp; -Wall -O2 -D_FORTIFY_SOURCE=2 -c -o 
hci.lo `test -f 'hci.c' || echo './'`hci.c<br>&nbsp;/opt/host/armv4l/bin/armv4l-unknown-linux-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2 -D_FORTIFY_SOURCE=2 -c hci.c -Wp,-MD,.deps/hci.TPlo -o hci.o<br>hci.c: In function `hci_send_cmd':
<br>hci.c:885: storage size of `iv' isn't known<br>hci.c:903: warning: implicit declaration of function `writev'<br>hci.c:885: warning: unused variable `iv'<br><br>according to &quot;hci.c&quot; the 'iv 'is a &quot;struct iovec&quot;.and this struct defined in the linux/include/linux/uio.h
<br>I think this is a very simple error,but i'm new to linux.so,please help me to fix it up:)<br><br>thanks very much!<br><br>if.q <br>Cheng DU .China<br><br><br>

------=_Part_30140_20701792.1149087145274--


--===============0704012811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0704012811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0704012811==--
