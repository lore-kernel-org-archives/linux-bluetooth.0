Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: "David Favro" <dfavro@users.sourceforge.net>
Content-Type: multipart/mixed; boundary=----------fp6Z55lNQPDO7D32sdjIht
MIME-Version: 1.0
Message-ID: <opsj5ahvnzdfsa41@dfavro-3>
Subject: [Bluez-users] Zoom 4312 PCMCIA Bluetooth freezes laptop
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
Date: Wed, 05 Jan 2005 14:45:21 -0500

------------fp6Z55lNQPDO7D32sdjIht
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello --

I recently acquired the Zoom model 4312 bluetooth PCMCIA adapter for my
eMachines M5312 laptop running Fedora Core 2 (I want to use it for my
bluetooth mouse).  The whole set-up works fine under Windows-XP, so
apparently there is no hardware incompatibility, but it hangs the
machine under Linux.

Prior to the malfunction, everything seems to be OK with the exception
of an error message when the PCMCIA card is initialized: "cs: warning:
no high memory space available!" and "cs: unable to map card memory!"
(full dmesg trace and much other system info included as an
attachment).  The card seems to initialize and flashes its L.E.D.  I
did no system configuration for the card beyond installing all of the
bluez packages from the FC2 repositories.  I don't know how to resolve
the memory-map problem or if it is relevant.

The problem is that when I do "hciattach ttyS16 bcsp" (per
http://sourceforge.net/mailarchive/message.php?msg_id=9958619), it
stays up long enough to display the next shell prompt, and then the
machine completely hangs.  The caps-lock L.E.D. starts _flashing_ (and
continues to do so indefinitely -- strange, I don't know what that
means) and the video display remains unchanged, but the machine is
completely unresponsive to all input: the keyboard, the touch-pad and
mouse-buttons, the connected ethernet interface... completely hung.
Network-connected ssh's go dead, the machine will give no visible
response to any keystrokes at all, the mouse-pointer will not move,
etc.  The only way to get it restarted is to hold down the power button
long enough that it turns off uncleanly.

I'm no expert on PCMCIA nor Bluetooth, so I am clueless as to how to
address this.  I don't know if this is the BT protocol driver or the
PCMCIA config that is causing the problem, but it is hard to deal with
due to the machine being so totally disabled.  I've retried many times
and it is repeatable very consistently.  Should I try a PCMCIA mailing
list?  Am I correct to do the hciattach command?  If I don't, the card
seems not to be noticed by hciconfig (see attached logs).

Any help or advice is greatly appreciated -- thanks very much in advance.

David Favro
Meta-Dynamic Solutions, LLC
dfavro@users.sourceforge.net
------------fp6Z55lNQPDO7D32sdjIht
Content-Disposition: attachment; filename=System-info.txt
Content-Type: text/plain; name=System-info.txt
Content-Transfer-Encoding: 8bit

~ # uname -a
Linux dfavro-3 2.6.9-1.11_FC2 #1 Sun Jan 2 15:49:30 EST 2005 i686 athlon i386 GNU/Linux


RELEVANT PORTION OF DMESG LOG:
==============================
Yenta: CardBus bridge found at 0000:00:0a.0 [161f:2029]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.0, mfunc 0x01001c00, devctl 0x64
Yenta: ISA IRQ mask 0x00f8, PCI irq 10
Socket status: 30000010
cs: warning: no high memory space available!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x378-0x37f 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
ttyS16 at I/O 0x100 (irq = 3) is a 16C950/954
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.4
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized


~ # hciconfig -a
~ #


~ # cat /var/lib/pcmcia/stab
Socket 0: Serial or Modem
0       serial  serial_cs       0       ttyS16  4       80


~ # dump_cis
Socket 0:
  dev_info
    NULL 0ns, 512b
  manfid 0x0279, 0x950b
  funcid serial_port [post]
  serial_interface
    uart 16550 [space/mark/odd/even] [5/6/7/8] [1/1.5/2]
  vers_1 7.1, "PCMCIA", "Bluetooth Card", "", ""
  config base 0x00f8 mask 0x000f last_index 0x04
  cftable_entry 0x01 [default]
    [rdybsy]
    Vcc Vnom 3300mV
    io 0x03f8-0x0407 [lines=8] [8bit] [range]
    irq mask 0xffff [level] [shared]
  cftable_entry 0x02
    io 0x0000-0x7fff [lines=15] [8bit]


~ # cardctl config
Socket 0:
  Vcc 3.3V  Vpp1 0.0V  Vpp2 0.0V
  interface type is "memory and I/O"
  irq 3 [exclusive] [level]
  speaker output is enabled
  function 0:
    config base 0x00f8
      option 0x42 status 0x08 pin 0x00 copy 0x00
    io 0x0100-0x010f [8bit]


~ # cardctl status
Socket 0:
  3.3V 16-bit PC Card
  function 0: [ready], [bat dead], [bat low]


~ # cardctl ident
Socket 0:
  product info: "PCMCIA", "Bluetooth Card", "", ""
  manfid: 0x0279, 0x950b
  function: 2 (serial)

------------fp6Z55lNQPDO7D32sdjIht--



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
