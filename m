Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 3 Jan 2010 15:14:19 +0100
Message-ID: <c66253311001030614k6a81313ajc05dc33f0bb3410d@mail.gmail.com>
Subject: IBM Bluetooth pc card problems
From: =?ISO-8859-1?Q?Szigetv=E1ri_J=E1nos?= <jszigetvari@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I did the following steps on a Slackware 13.0-based OS, with the
following kernel:

root@orion:~# uname -a
Linux orion 2.6.30.9-orion #5 Sat Jan 2 19:49:47 CET 2010 i686 Mobile
Pentium II GenuineIntel GNU/Linux

I have a TDK-made IBM branded Bluetooth PC Card.

root@orion:~# pccardctl info 1
PRODID_1="IBM"
PRODID_2="Bluetooth PC Card II"
PRODID_3=""
PRODID_4=""
MANFID=0105,4254
FUNCID=254

It by default contains a bad CIS, identifying itself with an "unknown" FUNCID.
I found the following thread that talks about this:
http://osdir.com/ml/linux.pcmcia.devel/2003-04/msg00001.html
As it is suggested in the thread I modified the CIS from this:

dev_info
  NULL 0ns, 512b
manfid 0x0105, 0x4254
funcid unknown [post]
vers_1 7.1, "IBM", "Bluetooth PC Card II", "", ""
config base 0x00f8 mask 0x000f last_index 0x04
cftable_entry 0x03 [default]
  [rdybsy]
  Vcc Vnom 5V
  io 0x01e0-0x01ef [lines=8] [8bit] [range]
  irq mask 0xffff [level] [shared]
cftable_entry 0x04
  io 0x0000-0x7fff [lines=15] [8bit]

To this:

dev_info
  NULL 0ns, 512b
manfid 0x0105, 0x4254
funcid serial_port [post]
vers_1 7.1, "IBM", "Bluetooth PC Card II", "", ""
config base 0x00f8 mask 0x000f last_index 0x03
cftable_entry 0x03 [default]
  [rdybsy]
  Vcc Vnom 5V
  io 0x01e0-0x01ef [lines=8] [8bit] [range]
  irq mask 0xffff [level] [shared]

I also had to add a line to serial_cs.c to make the kernel load the
modified version of the CIS:

root@orion:~# grep "IBM Bluetooth" /usr/src/linux/drivers/serial/serial_cs.c
        PCMCIA_DEVICE_CIS_MANF_CARD(0x0105, 0x4254, "cis/IBMBT.cis"),
 /* IBM Bluetooth PC Card II */

After recompiling the module, the modified CIS is loaded when the card
is inserted:

pcmcia_socket pcmcia_socket1: pccard: PCMCIA card inserted into slot 1
pcmcia 1.0: pcmcia: registering new device pcmcia1.0
pcmcia 1.0: firmware: requesting cis/IBMBT.cis
ttyS1: detected caps 00000700 should be 00000100
1.0: ttyS1 at I/O 0x1e0 (irq = 3) is a 16C950/954
1.0: ttyS2 at I/O 0x1e8 (irq = 3) is a 8250

The card itself is an Oxford Semicondutor 16950-based card, so it is a
bit surprising, to see the kernel detect a second serial UART.

Nevertheless after running hciattach a new hci device is created, but
it can't be used for anything:

root@orion:~# hciattach -p ttyS1 any
2597
root@orion:~# hciconfig -a
hci0:   Type: UART
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN INIT RUNNING
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:4 acl:0 sco:0 commands:1 errors:0

After some research I found out that I should use the "tdk" UART
identifier instead of any.
But that doesn't help either:

root@orion:~# hciattach -p ttyS1 tdk
BCSP initialization timed out.

Currently I can't go any further than this.
If anyone used this kind of Bluetooth card, or know about this, or a
similar problem, or if it is already fixed in a more recent kernel
release, please inform me.
Thanks!

Kind regards,
Janos Szigetvari
