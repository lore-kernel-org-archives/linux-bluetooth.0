Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Ken M <wgold@flyingplastic.com>
Message-ID: <loom.20050728T195337-380@post.gmane.org>
References: <428EDFCA.5070702@gmail.com> <1116842776.30044.33.camel@pegasus>	 <4292938B.2090000@gmail.com> <1116924491.30044.131.camel@pegasus>	 <429553F1.7020604@gmail.com> <1117095364.12036.14.camel@pegasus>	 <429682D6.2020800@gmail.com> <1117177537.12036.90.camel@pegasus>	 <42980599.9040801@gmail.com> <1117287707.12036.138.camel@pegasus> <429E8F28.3010008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Early failures with Treo 650
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
Date: Thu, 28 Jul 2005 18:02:22 +0000 (UTC)

David Britton <davidpbritton <at> gmail.com> writes:

> 
> Marcel Holtmann wrote:
> > 
> > explain the speed increase to me. I don't understand it. The RESET quirk
> > should be enough, because the BCM92035 quirk is only for a very specific
> > dongle from Broadcom.
> > 
> > Check the dmesg output for added and removed USB while you are attaching
> > the dongle. You should see a mouse and a keyboard that will disappear
> > minutes later.
> 
> Well Marcel, as usual, you are correct on this one as well.  The speed
> drop is corallated to the mouse/keyboard add somehow.  Once the mouse
> and keyboard are removed:
> 
> Jun  1 23:37:02 localhost kernel: usb 3-2.2: USB disconnect, address 44
> Jun  1 23:37:02 localhost udev[16373]: removing device node
> '/dev/input/event3'
> Jun  1 23:37:02 localhost hal.hotplug[16386]: DEVPATH is not set
> Jun  1 23:37:02 localhost kernel: usb 3-2.3: USB disconnect, address 45
> Jun  1 23:37:02 localhost udev[16421]: removing device node
> '/dev/input/mouse2'
> Jun  1 23:37:02 localhost udev[16423]: removing device node
> '/dev/input/event4'
> 
> The speed for the hcitool scan returns to normal.  It is not related to
> the BCM92035 quirk at all.  FYI, the symptom is that before these
> removal messages, "hcitool scan" takes on average 3 seconds longer to
> perform a scan.  I did not test any other hci tools.  This must be
> related to some contention in the usb code somewhere?
> 
> Attached is the patch with just the reset quirk for the Kensington
> adapter.  I believe that you are correct in that this is all that is
> needed for this adapter to function.
> 

Hey guys, thanks for the great info!  

I've got the same adapter, and am seeing the exact same problem.  I've tried
both adding a "reset=1" to the modprobe, as well as adding HCI_RESET to the
hci_usb, neither seem to work for me.

As a matter of fact, the driver refuses the "reset" setting: 

Jul 28 14:16:05 FatboySlim kernel: hci_usb: Unknown parameter `reset'


I'm running FC3 (2.6.10-770) and the first patch Marcel sent didn't work as
"HCI_BCM92035" wasn't defined in my kernel tree.

The second patch that David wrote, setting the driver to "HCI_RESET" still gives
me a "Connection Timed Out" error when attempting any "hcitool scan|inq", yet my
Treo 650 sees it in discovery.

"hcitool dev" gives me:
Devices:
        hci0    00:01:52:F3:A4:55


"hciconfig -a" gives me:
[root@FatboySlim bluetooth]# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0C:55:F6:A0:53 ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN INQUIRY AUTH ENCRYPT
        RX bytes:101 acl:0 sco:0 events:13 errors:0
        TX bytes:304 acl:0 sco:0 commands:13 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'FatboySlim-0'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x6965
        Manufacturer: Broadcom Corporation (15)

What more can I do to help debug this?  I am pretty savvy with this stuff, but
I'm stumped..


Ken





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
