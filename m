Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.2 errors with DBT-120 (B2)
From: Marcel Holtmann <marcel@holtmann.org>
To: "Todd E. Johnson" <tejohnson@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <402DAAA7.8070408@yahoo.com>
References: <402DAAA7.8070408@yahoo.com>
Content-Type: text/plain
Message-Id: <1076749321.18588.156.camel@pegasus>
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
Date: Sat, 14 Feb 2004 10:02:01 +0100

Hi Todd,

> Using the 2.6.2 kernel on Slackware 9.1 and a D-Link DBT-120 (B2), I 
> receive the following error:
> 
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb de96e614 err -90
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb de96e614 err -90
> 
> This occurs upon launching hcid during boot.  I am also using the KDE 
> Bluetooth framework.
> This configuration was working fine with 2.4.22...
> 
> I know the USB driver architecture has changed quite a bit w/ 2.6.  Are 
> there any current outstanding issues with using this device in 2.6?

the outstanding issue is the SCO audio support of the HCI USB driver and
for now I can only advice you to disable it.

BTW please send me the output of "hciconfig -a" for your dongle.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
