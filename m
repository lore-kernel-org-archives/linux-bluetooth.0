Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "leiyu" <leiyu@kcoe.cn>
To: <bluez-users@lists.sourceforge.net>
Date: Sun, 3 Jun 2007 21:42:01 +0800
Message-ID: <EJENLMBEOLKAMCJFBFMDEECBCAAA.leiyu@kcoe.cn>
MIME-Version: 1.0
In-Reply-To: <EJENLMBEOLKAMCJFBFMDCEBNCAAA.leiyu@kcoe.cn>
Subject: [Bluez-users] the problem of cross-compile bluez
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
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Dear   All,
 
Marcel had suggested me  using 2.6 kernel for cross-compile bluez last time,  as I am a new user on Linux, it may spend too much time on making 2.6 kernel work, so I still use 2.4.18 kernel for the moment,  cross-compile bluez-libs-3.9 is Ok, but cross-compile bluez-utils-3.9 is fail, the problem has bothered me some weeks ,I do not know how to solve it and  really need your help, thanks very much 

I installed bluez-lib-3.9 in /bluez/lib
I installed dbus-0.62
I patched patch-2.4.18-mh15.gz  on kernel

the error message is listed as below

step 1 this is configure's parameter
 [root@localhost bluez-utils-3.9]# ./configure --host=arm-linux --prefix=/bluez/util  CC=/usr/local/arm/2.95.3/bin/arm-linux-gcc CPP=/usr/local/arm/2.95.3/bin/cpp AR=/usr/local/arm/2.95.3/bin/arm-linux-ar STRIP=/usr/local/arm/2.95.3/bin/arm-linux-strip RANLIB=/usr/local/arm/2.95.3/bin/arm-linux-ranlib LD=/usr/local/arm/2.95.3/bin/arm-linux-ld --includedir=/bluez/lib/include --libdir=/bluez/lib/lib --with-bluez-libs=/usr/local/arm/kernel/lib  --with-kernel=/usr/lcoal/arm/kernel 
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
......
config.status: config.h is unchanged
config.status: executing depfiles commands

step 2,  make 
[root@localhost bluez-utils-3.9]# make
make  all-recursive
make[1]: Entering directory `/blu/bluez-utils-3.9-arm'
Making all in eglib
make[2]: Entering directory `/blu/bluez-utils-3.9-arm/eglib'
source='gmain.c' object='gmain.lo' libtool=yes \
DEPDIR=.deps depmode=gcc /bin/sh ../depcomp \
....... 
/usr/local/arm/2.95.3/bin/arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2 -c textfile.c
source='logging.c' object='logging.o' libtool=no \
DEPDIR=.deps depmode=gcc /bin/sh ../depcomp \
/usr/local/arm/2.95.3/bin/arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2 -c logging.c
source='dbus-helper.c' object='dbus-helper.o' libtool=no \
DEPDIR=.deps depmode=gcc /bin/sh ../depcomp \
/usr/local/arm/2.95.3/bin/arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2 -c dbus-helper.c
source='sdp-xml.c' object='sdp-xml.o' libtool=no \
DEPDIR=.deps depmode=gcc /bin/sh ../depcomp \
/usr/local/arm/2.95.3/bin/arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2 -c sdp-xml.c
sdp-xml.c: In function `convert_raw_data_to_xml':
sdp-xml.c:111: warning: unknown conversion type character `j' in format
sdp-xml.c:111: warning: too many arguments for format
sdp-xml.c:156: warning: unknown conversion type character `j' in format
sdp-xml.c:156: warning: too many arguments for format
sdp-xml.c:239: parse error before `int'
sdp-xml.c:255: `num_chars_to_escape' undeclared (first use in this function)
sdp-xml.c:255: (Each undeclared identifier is reported only once
sdp-xml.c:255: for each function it appears in.)
sdp-xml.c:263: parse error before `char'
sdp-xml.c:267: `strBuf' undeclared (first use in this function)
make[2]: *** [sdp-xml.o] Error 1
make[2]: Leaving directory `/blu/bluez-utils-3.9-arm/common'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/blu/bluez-utils-3.9-arm'
make: *** [all] Error 2

Best regards,
Leiyu


 
 
   
 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
