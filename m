Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Hans Bausewein <hans@comerwell.xs4all.nl>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Broadcom Corporation (Firmware 105.105.074) USB dongle
Message-ID: <20041030204753.GA10315@comerwell.xs4all.nl>
References: <20041030094327.GA8724@comerwell.xs4all.nl> <1099136877.6912.41.camel@pegasus> <20041030124433.GA9232@comerwell.xs4all.nl> <1099143692.10448.14.camel@pegasus> <20041030152320.GA9566@comerwell.xs4all.nl> <1099150958.16247.12.camel@pegasus> <20041030155712.GA9715@comerwell.xs4all.nl> <1099152611.16247.23.camel@pegasus> <20041030195917.GA10109@comerwell.xs4all.nl> <1099167789.6644.6.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099167789.6644.6.camel@notepaq>
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
Date: Sat, 30 Oct 2004 22:47:54 +0200

On Sat, Oct 30, 2004 at 10:23:09PM +0200, Marcel Holtmann wrote:
> 
> I don't think so, because this is some kind of init problem. You can try
> to set the quirk for your device 0a5c:2009 to HCI_BROKEN_ISOC only,
> because it seems that parts of it still work if you don't call reset.

Did this, but with same result. I only compiled 'hci_usb.c' and replaced the
'hci_usb.ko' since it's only a piece of implementation that changed. Must be
OK, I guess.

> Btw do you compiled your kernel with the CONFIG_BT_HCIUSB_SCO option? If
> yes, then try without it.

OK, maybe this is the problem. The Debian default was with
CONFIG_BT_HCIUSB_SCO=y, so I kept that.

Now I have to recompile everything, I guess.
It's compiling on the 2.8 GHz P4 machine at my work, now.

> The other thing is to change the init sequence of HCI commands and
> actually for this I must have this dongle at home. Think about donating
> it to me instead of returning it.

Maybe I'll buy another one for you, if I think it will work. 


Hans


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
