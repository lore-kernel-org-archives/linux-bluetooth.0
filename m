Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Timo Veith <tv@rz-zw.fh-kl.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503202301.49376.tv@rz-zw.fh-kl.de>
Subject: [Bluez-devel] Problem with BlueLogic WingKey Keyboard
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 20 Mar 2005 23:01:49 +0100

Hi bluez-devel readers,

I bought the nice BlueLogic WingKey Keyboard. Unfortunately I wasn't able to 
get it working yet. On http://www.holtmann.org/linux/bluetooth/hid.html you 
wrote that it should work with linux.

At least I can type some characters. But when I start to type the keyoard 
randomly begins to produce characters after some time. Like so:

ddddddddddddddddddd

Then I have to press backspace on my normal keyboard (which is still 
connected) to stop that behaviour. It's not always a "d", it depends on what I 
typed before. Also sometimes some characters get mixed.

The trackball and the mouse buttons aren't working at all. This keyboard was 
so expensive and it would be a great pity if I couldn't use it now. :(

Here are some infos about my system: I am using Gentoo Linux with kernel 
2.6.11-gentoo-r4, bluez-libs and bluez-utils 2.15. The bluetooth daemon is 
started and when I plug in the usb dongle the log says:

Mar 20 19:42:02 tristan usb 3-1: new full speed USB device using uhci_hcd and 
address 2
Mar 20 19:42:03 tristan Bluetooth: HCI USB driver ver 2.8
Mar 20 19:42:03 tristan hcid[7523]: HCI dev 0 registered
Mar 20 19:42:03 tristan usbcore: registered new driver hci_usb
Mar 20 19:42:03 tristan hcid[7523]: HCI dev 0 up
Mar 20 19:42:03 tristan hcid[7523]: Starting security manager 0


And when I push the power button of the keyboard I get:

Mar 20 19:42:21 tristan hidd[7529]: New HID device 00:02:72:49:3C:2D 
(Bluelogic Technologies Inc. Bluetooth Keyboard)


So far, everything seems to be good, but if I press some keys the upper 
mentioned behaviour takes place and I see the following kind of messages in 
the log file:

Mar 20 19:42:43 tristan hidp_input_report: Unknown key (scancode 0xbe) 
pressed.
Mar 20 19:42:43 tristan hidp_input_report: Unknown key (scancode 0xbe) 
released.
Mar 20 19:42:43 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:42:43 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:42:44 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:42:44 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:42:52 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:42:53 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:42:53 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:42:53 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:42:53 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:42:53 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:42:53 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:42:54 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:43:01 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:43:01 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:43:04 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:43:05 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:43:05 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:43:06 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:43:06 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:43:06 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:43:07 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:43:07 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:43:07 tristan hidp_input_report: Unknown key (scancode 0xcd) 
pressed.
Mar 20 19:43:07 tristan hidp_input_report: Unknown key (scancode 0xcd) 
released.
Mar 20 19:43:08 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:43:08 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:43:09 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:43:10 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:43:12 tristan hidp_input_report: Unknown key (scancode 0xff) 
pressed.
Mar 20 19:43:12 tristan hidp_input_report: Unknown key (scancode 0xff) 
released.
Mar 20 19:43:15 tristan hidp_input_report: Unknown key (scancode 0xae) 
pressed.
Mar 20 19:43:15 tristan hidp_input_report: Unknown key (scancode 0xae) 
released.

It would be really nice get some help here, because I am completly lost. 
Please tell me if I can provide more info. Thanks in advance and kind 
regards,

Timo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
