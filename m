Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3F7BF2EC.2080000@freemail.hu>
From: Lengyel Gabor <lgaga@freemail.hu>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] fujitsu-siemens pc card
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
Date: Thu, 02 Oct 2003 11:42:04 +0200

Hi!

I recently obtained a Fujitsu-Siemens Bluetooth PC Card and tried a lot 
but could not make it work. I tried with debian sid, kernel 2.4.22 (from 
kernel.org, not the debian one), on an Asus L3400Tp notebook.

Pcmcia support is in the kernel (not in a module), the pcmcia socket 
itself seems ok (though I can not test it with another card as I only 
have this one):

# cardctl ident
Socket 0:
   product info: "OXSEMI", "OXCB950", "Rev A"
   manfid: 0x0279, 0x0001
   function: 2 (serial)
Socket 1:
   no product info available

I applied this patch to my kernel: 
http://www.ussg.iu.edu/hypermail/linux/kernel/0203.0/0040.html
(Shouldn't 'cardctl ident' tell the real vendor and name for the 
bluetooth card, instead of the uart?)

I edited modules.conf according to the BlueZ Howto, now bluez modules 
load automatically on boot, rfcomm l2cap and bluez is loaded all right.

When I plug in the card, the following is written to /var/log/messages:

Oct  2 11:17:30 lgnote kernel: cs: cb_alloc(bus 2): vendor 0x1415, 
device 0x950b
Oct  2 11:17:30 lgnote kernel: PCI: Enabling device 02:00.0 (0000 -> 0003)
Oct  2 11:17:30 lgnote kernel: ttyS04 at port 0x4000 (irq = 9) is a 
16C950/954
Oct  2 11:17:30 lgnote pci.agent[577]: ... no modules for PCI slot 02:00.0

There was no /dev/ttyS04 (and no ttyS4 either), so i created one (major 
number 4, minor 68).

Then I tried hciattach:
# hciattach -n /dev/ttyS04 any
It seems to work OK, hci0 device is created, but hciconfig hci0 up does 
not work:
Can't init device hci0. Connection timed out(110).

I tried loading all the bluetooth modules (hci_uart, btuart_cs, ...) one 
by one and all of them together ( :) ), but the result is the same. I 
also tried hciattach with different device types (ericsson, digi, ...), 
some of them seems OK (but the problem with hciconfig still remains), 
with others it does not even start (for example with csr it says 
"Initialization timed out").

I have no further ideas, am I doing something wrong? Or is this card not 
supported at all? :(

Thank you all,
Gabor Lengyel (Lgaga)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
