Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] error attaching device
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Cc: mail@apexo.de
In-Reply-To: <200501151854.40656.mail@apexo.de>
References: <200501151854.40656.mail@apexo.de>
Content-Type: text/plain
Message-Id: <1105865464.8080.10.camel@pegasus>
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
Date: Sun, 16 Jan 2005 09:51:03 +0100

Hi Christian,

> I'm using linux kernel 2.6.10 with the following debian bluez packages:
> bluez-bluefw            1.0-1
> bluez-hcidump           1.12-1
> bluez-pin               0.24-1
> bluez-utils             2.10-5
> 
> my problem now is:
> I have a Acer Bluetooth USB Dongle which works correctly when plugged into 
> either one of the primary USB ports as well as within the Microsoft Natural 
> Keyboad USB Hub but NOT in my newly acquired Acer USB 2.0 Hub which leaves 
> the following error messages in the syslog:
> 
> kernel: hci_usb_intr_rx_submit: hci0 intr rx submit failed urb c6586b74 err 
> -28

this is a problem in the USB subsystem or maybe it is buggy hardware.
However you should post this problem to the USB development mailing
list, because I have no idea what is wrong.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
