Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] multi rfcomm/sco connection
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <006901c4c32f$febee8a0$6f04a8c0@ZBOX>
References: <006901c4c32f$febee8a0$6f04a8c0@ZBOX>
Content-Type: text/plain
Message-Id: <1099658061.6919.13.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 05 Nov 2004 13:34:21 +0100

Hi Suriyan,

> I would like to known feasibility to add multi SCO connections support on
> BlueZ stack. I try lastest patched 2.6.9-mh3, I saw sco_num and acl_num were
> counted separately, is BlueZ stack going to support multi SCO connections?

this has nothing to do with it.

> I have application to uses Bluetooth Headset work as Wireless Microphone so
> that I would like support up to 3 channels for each dongle. Unfotunately,
> with lastest BlueZ stack my application can support only one Headset per
> dongle.

Please read and understand my responses. We support one SCO per ACL
link. Which means when you open three ACL links, you can also have three
SCO links, but of course there can be only one ACL link between two
Bluetooth devices.

> Anyone have going to add multi SCO connections support on BlueZ stack?
> Please let me known, I'd like to hear from you all. Any contact would be
> greatly appreciated.

As I said, I haven't seen any application that needs to connect more
than one SCO link to an ACL link. Your problem looks like a hardware
limit. Are you using SCO over HCI or over PCM? What kind of Bluetooth
dongle do you use (hciconfig -a)?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
