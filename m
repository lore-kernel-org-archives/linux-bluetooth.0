Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Sundstrom <sunkan@zappa.cx>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3FA8D9AC.4080907@zappa.cx>
References: <3FA8D9AC.4080907@zappa.cx>
Content-Type: text/plain
Message-Id: <1068031366.10389.175.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 05 Nov 2003 12:22:46 +0100

Hi Andreas,

> I have a Toshiba Laptop with a Bluetooth USB device integrated in it.
> I can use the BT device without problems in 2.4.22, but with 2.6.0-test9 
> it doesn't work for most of the time.

from the devices output I see that this device is based on a Silicon
Wave chip and it seems that I don't have this device in my list. So what
kind of model do you have and what is the output of "hciconfig -a".

> USB seems to be working just fine so that shouldn't be it.
> 
> The problem is that most of the time a "hcitool inq/scan" just returns
> "Inquiring ..." immediatly, without any delay like it didn't do anything.
> 
> If I remove the modules and reload them over and over again it usually 
> works after a while and when it works it stays working until I decide to 
> reboot.

What are your kernel config settings for the HCI USB driver. I prefer
you try it with these.

	CONFIG_BT_HCIUSB=m
	# CONFIG_BT_USB_SCO is not set
	# CONFIG_BT_USB_ZERO_PACKET is not set

> I've tried to enable some debugging in hci_usb.c but I don't understand
> what to make out of it.. not much that seems wrong to me..

Include a "#define HCI_USB_DEBUG" after the last include directive.

> I get one error when loading the hci_usb module though:
> hub 4-0:1.0: new USB device on port 1, assigned address 2
> hci_usb: probe of 4-1:1.1 failed with error -5
> 
> Don't know if it's related, the device seems fine and this showes up
> even when the device happen to work.

This is a question for the USB guys. Do you have another USB Bluetooth
dongle to test with your notebook?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
