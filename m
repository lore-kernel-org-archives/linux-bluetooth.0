Return-Path: <hans@comerwell.xs4all.nl>
Date: Tue, 2 Nov 2004 22:40:45 +0100
From: Hans Bausewein <hans@comerwell.xs4all.nl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bluez users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Broadcom Corporation (Firmware 105.105.074) USB dongle
Message-ID: <20041102214045.GA20691@comerwell.xs4all.nl>
References: <20041030094327.GA8724@comerwell.xs4all.nl> <1099136877.6912.41.camel@pegasus> <20041030124433.GA9232@comerwell.xs4all.nl> <1099143692.10448.14.camel@pegasus> <20041030152320.GA9566@comerwell.xs4all.nl> <1099150958.16247.12.camel@pegasus> <20041030155712.GA9715@comerwell.xs4all.nl> <1099152611.16247.23.camel@pegasus> <20041030195917.GA10109@comerwell.xs4all.nl> <1099167789.6644.6.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099167789.6644.6.camel@notepaq>
List-ID: <bluez-users.lists.sourceforge.net>

On Sat, Oct 30, 2004 at 10:23:09PM +0200, Marcel Holtmann wrote:
> Hi Hans,
> 
> > > actually there must be a secret within the init sequence of the commands
> > > and you should try a clean 2.6.9 vanilla kernel with the -mh3 patch.    
> >  
> > same results
> > 
> > p2:~# hciconfig dev hci0 up
> > Can't init device hci0. Device or resource busy(16)
> > 
> > And then I plugged in the other MSI (CSR) dongle: still works fine.
> > 
> > > I think I will get this dongle working, but I need it at home for further
> > > testing and I stopped buying Bluetooth dongles by myself. If you believe
> > > it or not, I have enough of them ;)
> > 
> > I think about returning it to the shop and buying the Cambridge-based
> > dongle. Let me know if I can try anything. I'll have it until tuesday, at
> > least.
> > 
> > Would it help to turn on CONFIG_BT_HCIUSB_DEBUG and examine log ?
> 
> I don't think so, because this is some kind of init problem. You can try
> to set the quirk for your device 0a5c:2009 to HCI_BROKEN_ISOC only,
> because it seems that parts of it still work if you don't call reset.
> Btw do you compiled your kernel with the CONFIG_BT_HCIUSB_SCO option? If
> yes, then try without it.

Maybe I've missed something here, but I cannot see how this HCI_BROKEN_ISOC
bit can do anything if CONFIG_BT_HCIUSB_SCO is off, because it's only used
inside the CONFIG_BT_HCIUSB_SCO ifdef.

  #ifdef CONFIG_BT_HCIUSB_SCO
	if (!(id->driver_info & HCI_BROKEN_ISOC))
		isoc_iface = usb_ifnum_to_if(udev, isoc_ifnum);

 
> The other thing is to change the init sequence of HCI commands and
> actually for this I must have this dongle at home. Think about donating
> it to me instead of returning it.

I asked MyCom to send one to you. I hope my arguments were good enough.

regards,

Hans
