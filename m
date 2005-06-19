Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050619213712.56900.qmail@web50708.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
Subject: Re: [Bluez-users] error on bluez-utils compile(fc4)
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1119216918.8954.3.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Sun, 19 Jun 2005 14:37:12 -0700 (PDT)


thanks, is it ok to leave the other parts of bluez as
released versions?



--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi John,
> 
> > Any ideas?  I am assuming it's something new with
> > dbus.
> > 
> > 
> > dbus.o(.text+0x75): In function
> > `hcid_dbus_request_pin':
> > dbus.c: undefined reference to
> > `dbus_message_append_iter_init'
> > dbus.o(.text+0x85):dbus.c: undefined reference to
> > `dbus_message_iter_append_boolean'
> > dbus.o(.text+0x91):dbus.c: undefined reference to
> > `dbus_message_iter_append_byte_array'
> > dbus.o(.text+0x2f1): In function
> > `reply_handler_function':
> > dbus.c: undefined reference to
> > `dbus_pending_call_get_reply'
> > dbus.o(.text+0x354):dbus.c: undefined reference to
> > `dbus_message_iter_get_string'
> > collect2: ld returned 1 exit status
> > make[2]: *** [hcid] Error 1
> > make[2]: Leaving directory
> > `/tmp/bluez-utils-2.17/hcid'
> > make[1]: *** [all-recursive] Error 1
> > make[1]: Leaving directory `/tmp/bluez-utils-2.17'
> > make: *** [all] Error 2
> 
> the CVS version should fix it.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux
> Migration Strategies
> from IBM. Find simple to follow Roadmaps,
> straightforward articles,
> informative Webcasts and more! Get everything you
> need to get up to
> speed, fast.
>
http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



		
__________________________________ 
Discover Yahoo! 
Get on-the-go sports scores, stock quotes, news and more. Check it out! 
http://discover.yahoo.com/mobile.html


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
