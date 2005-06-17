Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050617025850.59350.qmail@web50708.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1118908231.3826.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] upgrade to fc4 kills bluez-utils
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
Date: Thu, 16 Jun 2005 19:58:50 -0700 (PDT)

and so I tried to recompile and i get this, despite
recompiling/installing bluez-libs

 -L/usr/lib -ldbus-1 /usr/lib/libbluetooth.so
dbus.o(.text+0x75): In function
`hcid_dbus_request_pin':
dbus.c: undefined reference to
`dbus_message_append_iter_init'
dbus.o(.text+0x85):dbus.c: undefined reference to
`dbus_message_iter_append_boolean'
dbus.o(.text+0x91):dbus.c: undefined reference to
`dbus_message_iter_append_byte_array'
dbus.o(.text+0x2f1): In function
`reply_handler_function':
dbus.c: undefined reference to
`dbus_pending_call_get_reply'
dbus.o(.text+0x354):dbus.c: undefined reference to
`dbus_message_iter_get_string'
collect2: ld returned 1 exit status
make[2]: *** [hcid] Error 1
make[2]: Leaving directory
`/tmp/bluez-utils-2.17/hcid'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/tmp/bluez-utils-2.17'
make: *** [all] Error 2


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
