Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <006901c4c32f$febee8a0$6f04a8c0@ZBOX>
From: "Suriyan" <suriyan@netgadgets.co.th>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=windows-874
Subject: [Bluez-devel] Re: Re: multi rfcomm/sco connection
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
Date: Fri, 5 Nov 2004 19:07:17 +0700

> Hi,
>
> > > actually I don"t see why you need more than one SCO link in a
connection
> > > between two devices. However take a look at the kernel source code of
> > > Linux 2.6.x and especially at net/bluetooth/hci_conn.c
> >
> > I explain you a bit more my situation...
> >
> > I need to be able with a single usb-bt-dongle to play/capture audio for
> > several bt-handsfree, I tried with one and there are no problems, but if
I
> > try to connect another one then I get something like "sco channel busy".
> >
> > I studied the net/bluetooth directory but I cannot find any good way to
> > achieve what I need! :)
> >
> > Am I wrong in something or is this feature really missing?
>
> as I said, between two devices BlueZ supports only one ACL link and one
> SCO link. These links a bi-directional so you can play and capture audio
> data at the same time. The limit to one SCO link is only a per ACL link
> limitation. If you open a second ACL to another device you can also have
> a second SCO link bound to that connection.
>
> Regards
>
> Marcel

Hi,

I would like to known feasibility to add multi SCO connections support on
BlueZ stack. I try lastest patched 2.6.9-mh3, I saw sco_num and acl_num were
counted separately, is BlueZ stack going to support multi SCO connections?

I have application to uses Bluetooth Headset work as Wireless Microphone so
that I would like support up to 3 channels for each dongle. Unfotunately,
with lastest BlueZ stack my application can support only one Headset per
dongle.

Anyone have going to add multi SCO connections support on BlueZ stack?
Please let me known, I'd like to hear from you all. Any contact would be
greatly appreciated.

Regards,
Suriyan.




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
