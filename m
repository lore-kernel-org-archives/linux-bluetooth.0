Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] AmbiCom BT2000E
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1102374899.3513.10.camel@charis.crosswire.org>
References: <1102374899.3513.10.camel@charis.crosswire.org>
Content-Type: text/plain
Message-Id: <1102406003.8447.12.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 07 Dec 2004 08:53:23 +0100

Hi Troy,

> Has anyone has success using and AmbiCom BT card with kernel
> 2.6.9?  I just upgraded to FC3 from FC1, which was a 2.4.x to 2.6.x
> kernel upgrade.  I used to use the bt950 driver with this card just
> fine.  Now I can't seem to get anything to work.
> 
> 
> card "AmbiCom BT2000E Bluetooth Card"
>   version "AmbiCom,Inc", "BT2000E"
>   bind "serial_cs" class "bluetooth"
> #  bind "btuart_cs"
> #  bind "bt950_cs"

use only 'bind "serial_cs"' and remove the 'class "bluetooth"' for now.

> Here is the output with the serial_cs driver:
> 
> Dec  6 16:14:23 charis cardmgr[4396]: socket 0: AmbiCom BT2000E
> Bluetooth Card
> Dec  6 16:14:23 charis kernel: ttyS1 at I/O 0x2f8 (irq = 11) is a
> 16C950/954
> Dec  6 16:14:28 charis cardmgr[4396]: executing: './bluetooth start
> ttyS1 2>&1'
> Dec  6 16:14:28 charis cardmgr[4396]: + Initialization timed out.

When you see this then you got a new serial port ttyS1 in your system
and you must attach this device to the hci_uart driver using hcittach.

The only problem is now, that the parameters are not always clear. I
assume that the BT2000E is the Ambicom card with the Ericsson chip
inside and so you should try "hciattach ttyS1 ericsson".

If this won't work then try 2.6.10-rc3 first before anything else.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
