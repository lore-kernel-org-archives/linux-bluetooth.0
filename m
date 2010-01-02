Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 3 Jan 2010 00:26:19 +0100
Message-ID: <c66253311001021526o7711bb9ayde9f47ea8a918f88@mail.gmail.com>
Subject: 3com pcmcia bluetooth card does'n work with bt3c_cs
From: =?ISO-8859-1?Q?Szigetv=E1ri_J=E1nos?= <jszigetvari@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I have a 3Com Bluetooth PC Card of type 3CRWB6096 (Ver. 2.0, Rev: AA).
I'm using kernel 2.6.30.9 on a Slackware 13.0-based system.
I have the following problems:
- when I insert the pc card, a hci device is created, but the
bluetooth MAC address is always all-zero.
- I can't bring the newly created interface up, using hciconfig,
because it results in a timeout.
- if I remove the card using pccardctl eject, and plug it in once
more, the kernel panics. (I can't currently attach any hard evidence,
as the log doesn't contain anything about this happening.)

Here are the outputs of some commands, that describe my system:

root@orion:~# uname -a
Linux orion 2.6.30.9-orion #4 Sat Jan 2 10:15:52 CET 2010 i686 Mobile
Pentium II GenuineIntel GNU/Linux

root@orion:~# hciconfig -a
hci0:	Type: PCCARD
	BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
	DOWN
	RX bytes:0 acl:0 sco:0 events:0 errors:0
	TX bytes:4 acl:0 sco:0 commands:1 errors:0

root@orion:~# hciconfig hci0 up
Can't init device hci0: Connection timed out (110)

root@orion:~# hciconfig hci0 features
hci0:	Type: PCCARD
	BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
	Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
		
root@orion:~# hciconfig hci0 commands
Can't read support commands on hci0: Connection timed out (110)
root@orion:~# hciconfig hci0 reset
Can't init device hci0: Connection timed out (110)

root@orion:~# pccardctl info 1
PRODID_1="3COM"
PRODID_2="3CRWB60-A"
PRODID_3="Bluetooth PC Card"
PRODID_4=""
MANFID=0101,0040
FUNCID=2

I have also added some additional debug messages to the kernel module
source, to better see, which code blocks are executed when the card is
inserted, and configured:

root@orion:/usr/src/linux/drivers/bluetooth# diff bt3c_cs.c.orig bt3c_cs.c
484a485
> printk(KERN_INFO "fwload 1\n");
494a496
> printk(KERN_INFO "fwload 2\n");
544a547
> printk(KERN_INFO "fwload 3\n");
565a569
> printk(KERN_INFO "open 1\n");
569a574
> printk(KERN_INFO "open 2\n");
573a579
> printk(KERN_INFO "open 3\n");
576a583
> printk(KERN_INFO "open 3\n");
584a592
> printk(KERN_INFO "open 4\n");
595a604
> printk(KERN_INFO "open 5\n");
598a608
> printk(KERN_INFO "open 6\n");
602a613
> printk(KERN_INFO "open 7\n");
604c615
<
---
> printk(KERN_INFO "open 8\n");
614a626
> printk(KERN_INFO "open 9\n");
617a630
> printk(KERN_INFO "open 10\n");
624a638
> printk(KERN_INFO "open 11\n");
632a647
> printk(KERN_INFO "close 1\n");
637a653
> printk(KERN_INFO "close 2\n");
642a659
> printk(KERN_INFO "close 3\n");
651a669
> printk(KERN_INFO "probe 1\n");
670a689
> printk(KERN_INFO "probe 2\n");
671a691
> printk(KERN_INFO "probe 3\n");
676a697
> printk(KERN_INFO "detach 1\n");
688a710
> printk(KERN_INFO "check_config 1\n");
700a723
> printk(KERN_INFO "check_config_np 2\n");
709a733
> printk(KERN_INFO "check_config_np 1\n");
720a745
> printk(KERN_INFO "check_config_np 2\n");
725a751
> printk(KERN_INFO "config 1\n");
735a762
> printk(KERN_INFO "config 2\n");
741a769
> printk(KERN_INFO "config 3\n");
746a775
> printk(KERN_INFO "config 4\n");
752a782
> printk(KERN_INFO "config 5\n");
758a789
> printk(KERN_INFO "config 6\n");
763a795
> printk(KERN_INFO "config 7\n");
784a817
> 	PCMCIA_DEVICE_MANF_CARD(0x0101, 0x0040),
800a834
> printk(KERN_INFO "init 1\n");
801a836
> printk(KERN_INFO "init 2\n");

After installing the modified module and inserting the card, I got the
following output:

root@orion:~# dmesg | tail -n 26
init 1
probe 1
probe 2
config 1
check_config 1
check_config_np 2
check_config 1
check_config_np 2
config 2
check_config_np 1
config 4
config 5
config 6
open 1
open 2
open 3
open 4
open 5
bt3c_cs 1.0: firmware: requesting BT3CPCC.bin
open 7
fwload 1
fwload 2
fwload 3
open 8
open 9
config 7
--EJECTING CARD--
pcmcia_socket pcmcia_socket1: pccard: card ejected from slot 1
detach 1
close 1
close 2
close 3

Sorry for the long letter, hopefully it will help to track down the problem.
If you know about this, or a similar problem, or if it is already
fixed in a more recent kernel release, please inform me.
Thanks!

Best regards,
Janos Szigetvari
