Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <402DAAA7.8070408@yahoo.com>
From: "Todd E. Johnson" <tejohnson@yahoo.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] 2.6.2 errors with DBT-120 (B2)
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
Date: Fri, 13 Feb 2004 23:57:11 -0500

Hi all,

Using the 2.6.2 kernel on Slackware 9.1 and a D-Link DBT-120 (B2), I 
receive the following error:

hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb de96e614 err -90
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb de96e614 err -90

This occurs upon launching hcid during boot.  I am also using the KDE 
Bluetooth framework.
This configuration was working fine with 2.4.22...

I know the USB driver architecture has changed quite a bit w/ 2.6.  Are 
there any current outstanding issues with using this device in 2.6?

Thanks in advance!

        Regards,

        Todd E. Johnson


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
