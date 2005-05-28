Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42980599.9040801@gmail.com>
From: David Britton <davidpbritton@gmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Early failures with Treo 650
References: <428EDFCA.5070702@gmail.com> <1116842776.30044.33.camel@pegasus>	 <4292938B.2090000@gmail.com> <1116924491.30044.131.camel@pegasus>	 <429553F1.7020604@gmail.com> <1117095364.12036.14.camel@pegasus>	 <429682D6.2020800@gmail.com> <1117177537.12036.90.camel@pegasus>
In-Reply-To: <1117177537.12036.90.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------010500060005060005070900"
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
Date: Sat, 28 May 2005 00:46:01 -0500

This is a multi-part message in MIME format.
--------------010500060005060005070900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
> 
> 
> So loading with "modprobe hci_usb reset=1" and without the patch doesn't
> make it work? Don't using "reset=1" and applying the patch does also not
> work? Only when you do both things the dongle is working. This is odd,
> because one of my previous Broadcom based dongles like this only needed
> the BCM92035 quirk to switch from HID into HCI mode. Please test all
> possibilities so I can add the correct quirk to the kernel.

OK -- here are the results:

1) Stock 2.6.11 hci_usb module:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a) modprobe hci_usb
	=> FAIL timeout on the scan (original behavior)
b) modprobe hci_usb reset=1
	=> PASS This works, can scan, and info my device


2) hci_usb module with given patch applied:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a) modprobe hci_usb
	=> FAIL timeout on the scan (seems to be the same as 1a)
b) modprobe hci_usb reset=1
	=> PASS This works, can scan, and info my device.  Also, there is a
significant increase in response when I do more "hcitool scan" commands
after the first one, I have no idea why this is or if it is important?


3) hci_usb module with attached patch applied:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a) modprobe hci_usb
	=> PASS since we do the bitwise or of HCI_RESET added to BCM92035 quirk
in the module, no need to specify reset at the command line of modprobe,
so this works just as 2b worked (just as you said it would).  Speed
increase on multiple "hcitool scan" commands is also present as in 2b.


If you need anything else tested, let me know.

-- 
David Britton <davidpbritton@gmail.com>

--------------010500060005060005070900
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- hci_usb.c	2005-05-28 00:38:58.000000000 -0500
+++ hci_usb.c.patch	2005-05-28 00:38:47.000000000 -0500
@@ -107,6 +107,9 @@
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = HCI_BCM92035 },
 
+	/* Kensington Bluetooth USB adapter */
+	{ USB_DEVICE(0x047d, 0x105d), .driver_info = HCI_RESET | HCI_BCM92035 },
+
 	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
 	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_RESET },
 

--------------010500060005060005070900--


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
