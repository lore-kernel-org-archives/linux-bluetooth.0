Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3FA8E805.1050909@zappa.cx>
From: Andreas Sundstrom <sunkan@zappa.cx>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
References: <3FA8D9AC.4080907@zappa.cx> <1068031366.10389.175.camel@pegasus>
In-Reply-To: <1068031366.10389.175.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 05 Nov 2003 13:07:33 +0100

First, thanks for taking your time to look at my problem, I appreciate it!

Here goes...

Marcel Holtmann wrote:
> Hi Andreas,
...
> from the devices output I see that this device is based on a Silicon
> Wave chip and it seems that I don't have this device in my list. So what
> kind of model do you have and what is the output of "hciconfig -a".
hci0:   Type: USB
         BD Address: 00:03:7A:08:13:91 ACL MTU: 60:20  SCO MTU: 64:0
         UP RUNNING PSCAN ISCAN
         RX bytes:63 acl:0 sco:0 events:7 errors:0
         TX bytes:28 acl:0 sco:0 commands:7 errors:0
         Features: 0xff 0x02 0x04 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
         Link policy:
         Link mode: SLAVE ACCEPT
         Name: ''
         Class: 0x000000
         Service Classes: Unspecified
         Device Class: Miscellaneous,
         HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 
0x514
         Manufacturer: Silicon Wave (11)

> What are your kernel config settings for the HCI USB driver. I prefer
> you try it with these.
> 
> 	CONFIG_BT_HCIUSB=m
> 	# CONFIG_BT_USB_SCO is not set
> 	# CONFIG_BT_USB_ZERO_PACKET is not set
Right now I have CONFIG_BT_HCIUSB=y beacause I checked if that would 
make things better, it did not.
SCO,Zeropacket is off

>>I've tried to enable some debugging in hci_usb.c but I don't understand
>>what to make out of it.. not much that seems wrong to me..
> 
> 
> Include a "#define HCI_USB_DEBUG" after the last include directive.
That's what I did.. I meant that the output I got from it didn't say 
much to mee.. I'll attach it in the end of the mail so you can check it.

>>I get one error when loading the hci_usb module though:
>>hub 4-0:1.0: new USB device on port 1, assigned address 2
>>hci_usb: probe of 4-1:1.1 failed with error -5
>>
>>Don't know if it's related, the device seems fine and this showes up
>>even when the device happen to work.
> 
> 
> This is a question for the USB guys. Do you have another USB Bluetooth
> dongle to test with your notebook?
I inserted a MS Wireless Transceiver for Bluetooth and it gave the same 
error.. but seems to work alright. Havn't done much testing yet though.

> 
> Regards
> 
> Marcel
> 
Here's the output from a "bad" session:

This is what I'v run:

//inserts the device into the USB hub
# echo blue_on:1 > /proc/acpi/toshiba/bluetooth

# hciconfig
hci0:   Type: USB
         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
         DOWN
         RX bytes:0 acl:0 sco:0 events:0 errors:0
         TX bytes:0 acl:0 sco:0 commands:0 errors:0

# hciconfig hic0 up

//No delay and no detected devices
# hcitool inq
Inquiring ...


Here's the dmesg output:
hub 4-0:1.0: new USB device on port 1, assigned address 2
hci_usb_probe: udev d8436c00 ifnum -1069408960
hci_usb_probe: udev d8436c00 ifnum -1069408960
hci_usb: probe of 4-1:1.1 failed with error -5
hci_usb_open: hci0
hci_usb_intr_rx_submit: hci0
hci_usb_bulk_rx_submit: hci0 urb d947f694
hci_usb_send_frame: hci0 type 1 len 3
hci_usb_tx_process: hci0
hci_usb_send_ctrl: hci0 skb da07f880 len 3
__tx_submit: hci0 urb d8fd3c14 type 1
hci_usb_tx_complete: hci0 urb d8fd3c14 status 0 flags 0
hci_usb_tx_process: hci0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 14 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 14
__recv_frame: new packet len 14
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_send_frame: hci0 type 1 len 3
hci_usb_tx_process: hci0
hci_usb_send_ctrl: hci0 skb d843bb80 len 3
__tx_submit: hci0 urb d8fd3c14 type 1
hci_usb_tx_complete: hci0 urb d8fd3c14 status 0 flags 0
hci_usb_tx_process: hci0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 13 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 13
__recv_frame: new packet len 13
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_send_frame: hci0 type 1 len 3
hci_usb_tx_process: hci0
hci_usb_send_ctrl: hci0 skb da07f980 len 3
__tx_submit: hci0 urb d8fd3c14 type 1
hci_usb_tx_complete: hci0 urb d8fd3c14 status 0 flags 0
hci_usb_tx_process: hci0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 12 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 12
__recv_frame: new packet len 12
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_send_frame: hci0 type 1 len 5
hci_usb_tx_process: hci0
hci_usb_send_ctrl: hci0 skb dd748980 len 5
__tx_submit: hci0 urb d8fd3c14 type 1
hci_usb_tx_complete: hci0 urb d8fd3c14 status 0 flags 0
hci_usb_tx_process: hci0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 6 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 6
__recv_frame: new packet len 6
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_send_frame: hci0 type 1 len 5
hci_usb_tx_process: hci0
hci_usb_send_ctrl: hci0 skb d843bc80 len 5
__tx_submit: hci0 urb d8fd3c14 type 1
hci_usb_tx_complete: hci0 urb d8fd3c14 status 0 flags 0
hci_usb_tx_process: hci0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 6 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 6
__recv_frame: new packet len 6
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_send_frame: hci0 type 1 len 5
hci_usb_tx_process: hci0
hci_usb_send_ctrl: hci0 skb d843ba80 len 5
__tx_submit: hci0 urb d8fd3c14 type 1
hci_usb_tx_complete: hci0 urb d8fd3c14 status 0 flags 0
hci_usb_tx_process: hci0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 6 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 6
__recv_frame: new packet len 6
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_send_frame: hci0 type 1 len 4
hci_usb_tx_process: hci0
hci_usb_send_ctrl: hci0 skb da07f680 len 4
__tx_submit: hci0 urb d8fd3c14 type 1
hci_usb_tx_complete: hci0 urb d8fd3c14 status 0 flags 0
hci_usb_tx_process: hci0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 6 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 6
__recv_frame: new packet len 6
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_send_frame: hci0 type 1 len 3
hci_usb_tx_process: hci0
hci_usb_send_ctrl: hci0 skb de339380 len 3
__tx_submit: hci0 urb d8fd3c14 type 1
hci_usb_tx_complete: hci0 urb d8fd3c14 status 0 flags 0
hci_usb_tx_process: hci0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
__recv_frame: new packet len 254
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 16 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 16
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 14 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 14
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_send_frame: hci0 type 1 len 3
hci_usb_tx_process: hci0
hci_usb_send_ctrl: hci0 skb d51d8080 len 3
__tx_submit: hci0 urb d8fd3c14 type 1
hci_usb_tx_complete: hci0 urb d8fd3c14 status 0 flags 0
hci_usb_tx_process: hci0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 9 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 9
__recv_frame: new packet len 9
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0
hci_usb_send_frame: hci0 type 1 len 3
hci_usb_tx_process: hci0
hci_usb_send_ctrl: hci0 skb de339a80 len 3
__tx_submit: hci0 urb d8fd3c14 type 1
hci_usb_tx_complete: hci0 urb d8fd3c14 status 0 flags 0
hci_usb_tx_process: hci0
hci_usb_rx_complete: hci0 urb d947f614 type 4 status 0 count 14 flags 0
__recv_frame: hci0 type 4 data da088dc0 count 14
__recv_frame: new packet len 14
hci_usb_rx_complete: hci0 urb d947f614 type 4 resubmit status 0

Hope you can make something out of it.

/Andreas



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
