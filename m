Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] dbus error
From: Marcel Holtmann <marcel@holtmann.org>
To: buzz231@ntlworld.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040827111948.JZAD7047.mta01-svc.ntlworld.com@[10.137.100.68]>
References: <20040827111948.JZAD7047.mta01-svc.ntlworld.com@[10.137.100.68]>
Content-Type: text/plain
Message-Id: <1093606492.2581.103.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 27 Aug 2004 13:34:52 +0200

Hi Sharon,

> Please can you help with following errors, i'm using fedora core 1 with
> kernel  linux-2.4.22-1.2115, im trying to install bluez, new to linux so i
> not got clue what to do next
> 
> [root@localhost src]# cd bluez-utils-2.9
> root@localhost bluez-utils-2.9]# ./configure
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> checking for gawk... gawk
> checking whether make sets $(MAKE)... yes
> checking whether to enable maintainer-specific portions of Makefiles... no
> checking for gcc... gcc
> checking for C compiler default output file name... a.out
> checking whether the C compiler works... yes
> checking whether we are cross compiling... no
> checking for suffix of executables...
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for gcc option to accept ANSI C... none needed
> checking for style of include used by make... GNU
> checking dependency style of gcc... none
> checking for a BSD-compatible install... /usr/bin/install -c
> checking for bison... bison -y
> checking for flex... flex
> checking for yywrap in -lfl... yes
> checking lex output file root... lex.yy
> checking whether yytext is a pointer... yes
> checking how to run the C preprocessor... gcc -E
> checking for egrep... grep -E
> checking for ANSI C header files... yes
> checking for sys/types.h... yes
> checking for sys/stat.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for memory.h... yes
> checking for strings.h... yes
> checking for inttypes.h... yes
> checking for stdint.h... yes
> checking for unistd.h... yes
> checking bluetooth/bluetooth.h usability... yes
> checking bluetooth/bluetooth.h presence... yes
> checking for bluetooth/bluetooth.h... yes
> checking for hci_open_dev in -lbluetooth... yes
> checking for sdp_connect in -lsdp... yes
> checking usb.h usability... yes
> checking usb.h presence... yes
> checking for usb.h... yes
> checking for usb_open in -lusb... yes
> checking dbus/dbus.h usability... yes
> checking dbus/dbus.h presence... yes
> checking for dbus/dbus.h... yes
> checking for dbus_error_init in -ldbus-1... yes
> configure: creating ./config.status
> config.status: creating Makefile
> config.status: creating hcid/Makefile
> config.status: creating tools/Makefile
> config.status: creating rfcomm/Makefile
> config.status: creating sdpd/Makefile
> config.status: creating dund/Makefile
> config.status: creating pand/Makefile
> config.status: creating hidd/Makefile
> config.status: creating cups/Makefile
> config.status: creating test/Makefile
> config.status: creating scripts/Makefile
> config.status: creating pcmcia/Makefile
> config.status: creating extra/Makefile
> config.status: creating config.h
> config.status: config.h is unchanged
> config.status: executing depfiles commands
> [root@localhost bluez-utils-2.9]# make all
> make all-recursive
> make[1]: Entering directory `/usr/src/bluez-utils-2.9'
> Making all in hcid
> make[2]: Entering directory `/usr/src/bluez-utils-2.9/hcid'
> gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include -DDBUS_API_SUBJECT_TO_CHANGE
> -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -DENABLE_DBUS -DDBUS_API
> _SUB
> JECT_TO_CHANGE -Wall -g -O2 -c `test -f 'dbus.c' || echo './'`dbus.c
> dbus.c:66: error: syntax error before '*' token
> dbus.c: In function `reply_handler_function':
> dbus.c:68: error: `user_data' undeclared (first use in this function)
> dbus.c:68: error: (Each undeclared identifier is reported only once
> dbus.c:68: error: for each function it appears in.)
> dbus.c:76: warning: implicit declaration of function
> `dbus_pending_call_get_repl
> y'dbus.c:76: error: `call' undeclared
> (first use in this function)dbus.c:76: warning: assignment makes pointer
> from
> integer without a castdbus.c:78: warning: implicit declaration of function
> `dbus_message_is_error'dbus.c: In function `hcid_dbus_request_pin':
> dbus.c:114: error: `DBusPendingCall' undeclared (first use in this function)
> dbus.c:114: error: `pending' undeclared (first use in this function)
> dbus.c:117: warning: implicit declaration of function
> `dbus_message_new_method_c
> all'dbus.c:118: warning: assignment
> makes pointer from integer without a castdbus.c:140: warning: implicit
> declaration of function `dbus_pending_call_set_not
> ify'make[2]: *** [dbus.o] Error 1make[2]: Leaving directory
> `/usr/src/bluez-utils-2.9/hcid'make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/usr/src/bluez-utils-2.9'
> make: *** [all] Error 2
> [root@localhost bluez-utils-2.9]#

update the D-Bus library or configure with --disable-dbus.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
