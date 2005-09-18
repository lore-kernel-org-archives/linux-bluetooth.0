Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <432D6F49.80304@cyph.ath.cx>
From: Ho Ming Shun <cyph@cyph.ath.cx>
MIME-Version: 1.0
To: Bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] BCM2035 over UART on the E680I
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
Date: Sun, 18 Sep 2005 21:44:41 +0800

Hi,

I'm part of a community of linux enthusiasts trying to hack the Motorola 
E680I phone. Its a based on an Intel PXA270  running MontaVista Linux on 
their 2.4.20 kernel. I've been trying to get BlueZ running on it.

The original Bluetooth stack implemented in the firmware is in one 
userspace-only app, which talks to ttyS1. So no way to extend 
functionality, which badly needs extending. The phone only publishes one 
service: Object Push. No way to browse or be browsed, no HID, nothing.

 From strace output, it seems to load some kind of firmware into the 
phone using a vendor-specific HCI command:

write(3, "\x01\x2e\xfc\x00", 4)         = 4
read(3, "\x04\x0e\x04\x01\x2e\xfc\x00", 8) = 7
read(3, "41", 8)                        = 2
write(3, ":03000000028EB0BD", 17)       = 17
read(3, ".", 8)                         = 1
write(3, ":0B1109008FE18DE2E4F5E375E30122C"..., 33) = 33
.
.
.

Then it programs the Bluetooth address in using another vendor-specific 
command (address is 00:12:8a:2d:3d:3e)

write(3, "\x01\x01\xfc\x06\x3e\x3d\x2d\x8a\x12\x00", 10) = 10
read(3, "\x04\x0e\x04\x01\x01\xfc\x00", 8) = 7

I've managed to duplicate this whole process, and get the hci_uart 
driver attached to ttyS1. By default when first initialised, the 
Bluetooth name is "Broadcom BCM2035".

However, the problem comes when BlueZ requests the Bluetooth address 
back from the chip: it will reply with 00:00:00:00:00:00. Seems like its 
not a problem unheard of: 
http://www.linuxquestions.org/questions/history/341892
l2ping and hcitool scan works despite BlueZ not knowing the correct 
local address.

Will this cause any problems BlueZ functionality or other applications?
Is this a sign that the chip is somehow configured wrongly?
Is this a common problem for this chip?
What are the known pitfalls and bugs (besides this one) for BCM2035?







-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
