Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Broadcom Corporation (Firmware 105.105.074) USB
	dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Hans Bausewein <hans@comerwell.xs4all.nl>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041102214045.GA20691@comerwell.xs4all.nl>
References: <20041030094327.GA8724@comerwell.xs4all.nl>
	 <1099136877.6912.41.camel@pegasus>
	 <20041030124433.GA9232@comerwell.xs4all.nl>
	 <1099143692.10448.14.camel@pegasus>
	 <20041030152320.GA9566@comerwell.xs4all.nl>
	 <1099150958.16247.12.camel@pegasus>
	 <20041030155712.GA9715@comerwell.xs4all.nl>
	 <1099152611.16247.23.camel@pegasus>
	 <20041030195917.GA10109@comerwell.xs4all.nl>
	 <1099167789.6644.6.camel@notepaq>
	 <20041102214045.GA20691@comerwell.xs4all.nl>
Content-Type: text/plain
Message-Id: <1099432696.7125.8.camel@pegasus>
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
Date: Tue, 02 Nov 2004 22:58:16 +0100

Hi Hans,

> > > Would it help to turn on CONFIG_BT_HCIUSB_DEBUG and examine log ?
> > 
> > I don't think so, because this is some kind of init problem. You can try
> > to set the quirk for your device 0a5c:2009 to HCI_BROKEN_ISOC only,
> > because it seems that parts of it still work if you don't call reset.
> > Btw do you compiled your kernel with the CONFIG_BT_HCIUSB_SCO option? If
> > yes, then try without it.
> 
> Maybe I've missed something here, but I cannot see how this HCI_BROKEN_ISOC
> bit can do anything if CONFIG_BT_HCIUSB_SCO is off, because it's only used
> inside the CONFIG_BT_HCIUSB_SCO ifdef.
> 
>   #ifdef CONFIG_BT_HCIUSB_SCO
> 	if (!(id->driver_info & HCI_BROKEN_ISOC))
> 		isoc_iface = usb_ifnum_to_if(udev, isoc_ifnum);

you are right. If CONFIG_BT_HCIUSB_SCO is disabled then the value of
HCI_BROKEN_ISOC doesn't matters.
 
> > The other thing is to change the init sequence of HCI commands and
> > actually for this I must have this dongle at home. Think about donating
> > it to me instead of returning it.
> 
> I asked MyCom to send one to you. I hope my arguments were good enough.

I don't expect to get one from them. Some companies have some stupid
rules for test hardware for open source developers. And actually I think
this is a Broadcom problem, because they are not very helpful when it
comes to Linux support. On the other hand you get CSR and these guys
helped out in so many ways. Go and buy a CSR based dongle, because this
is better spent money and you will have less trouble.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
