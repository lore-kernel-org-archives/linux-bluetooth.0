Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40E33BF2.7010705@mip.sdu.dk>
From: Peter Favrholdt <pfavr@mip.sdu.dk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] snd-bt-sco
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 01 Jul 2004 00:17:22 +0200

Hi bluez developers,

I'm not sure if this is the right forum. I'm probably in-between alsa-user, 
bluez-user, kernel-user? But here goes anyway:-)

I just tried getting the Logitech HS01 bluetooth headset working on kernel 
2.6.6 (debian unstable), using the ALSA driver from 
http://www.dcs.gla.ac.uk/~jp/snd-bt-sco/

Anyone had success with getting a headset working?

I know this driver is a hack, but it would be cool to have skype working using 
a headset under linux.

BR

Peter

--- cut: long and windy story about my adventures ---

I think I managed to patch my kernel-source-2.6.6 successfully. After 
modprobing the modules dmesg says:

Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.2
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: SCO (Voice Link) ver 0.3
Bluetooth: SCO socket layer initialized
Bluetooth: HCI USB driver ver 2.5
usbcore: registered new driver hci_usb
snd-bt-sco revision ??$
snd-bt-sco: snd-bt-scod thread starting

so far so good.

After a while I got this additional message:

hci_acldata_packet: hci0 ACL packet for unknown connection handle 1

here is a summary of what I did:

modprobe hci_usb
modprobe sco
invoke-rc.d bluez-utils restart

Here I turned on the headset in this special "reset/pairing mode" (don't know 
the right name for it - but you hold down the button for 10 seconds).

hcitool scan
Scanning ...
         00:0D:44:00:76:07       Logitech HS01

hcitool cc 00:0D:44:00:76:07 (I think I had to enter pin here)

hciconfig hci0 voice 0x0040

modprobe snd-bt-sco
sdptool search --bdaddr 00:0D:44:00:76:07 0x1108
snd-bt-sco-2004-03-14/btsco-0.2/btsco 00:0D:44:00:76:07 1
Error: control open (hw:0): No such file or directory
Error: Can't find device. Bail

So that was end of the game.


At this time hcitool con says:
Connections:
         > ACL 00:0D:44:00:76:07 handle 1 state 1 lm SLAVE

But I've also had it say:
         < ACL 00:0D:44:00:76:07 handle 1 state 1 lm MASTER

Using strace I get this:

strace btsco-0.2/btsco 00:0D:44:00:76:07 1

futex(0x400fbffc, FUTEX_WAKE, 2147483647) = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or directory)
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC0", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC0", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC0", O_RDWR)      = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC0", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC0", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC0", O_RDWR)      = -1 ENOENT (No such file or directory)
write(2, "Error: ", 7Error: )                  = 7
write(2, "control open (hw:0): No such fil"..., 46control open (hw:0): No such 
file or directory) = 46
write(2, "\n", 1
)                       = 1
write(2, "Error: ", 7Error: )                  = 7
write(2, "Can\'t find device. Bail", 23Can't find device. Bail) = 23
write(2, "\n", 1
)                       = 1
exit_group(1)                           = ?

This could be caused by missing device files in /dev/ maybe?

I have ALSA compiled statically into the kernel, here is what dmesg says:
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 
2004 UTC).
ALSA device list:
   #0: C-Media PCI CMI8738 (model 37) at 0xc400, irq 10


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
