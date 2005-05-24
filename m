Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4292938B.2090000@gmail.com>
From: David Britton <davidpbritton@gmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Early failures with Treo 650
References: <428EDFCA.5070702@gmail.com> <1116842776.30044.33.camel@pegasus>
In-Reply-To: <1116842776.30044.33.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------050306030902090804060900"
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
Date: Mon, 23 May 2005 21:38:03 -0500

This is a multi-part message in MIME format.
--------------050306030902090804060900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
> 
> 
> show us "hciconfig -a" and run "hcidump -X -V" as root while you are
> scanning. 

Thanks for the reply Marcel,

I have confirmed that this device does work on windows (a friends
machine)... for a while I was wondering.

Now on to the infomation requested:


hcitool/hciconfig output:
-------------------------

red:/home/dpb# hcitool scan
Scanning ...
Inquiry failed: Connection timed out
red:/home/dpb#
hciconfig -a:
red:/home/dpb# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0C:55:F8:5A:2B ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN INQUIRY AUTH
        RX bytes:101 acl:0 sco:0 events:13 errors:0
        TX bytes:304 acl:0 sco:0 commands:13 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'red (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver:
0x6965
        Manufacturer: Broadcom Corporation (15)

red:/home/dpb#



hcidump -X -V output:
---------------------

red:/home/dpb# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
  0000: 33 8b 9e 08 64                                    3...d
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00
    0000: 72 65 64 20 28 30 29 00  00 00 00 00 00 00 00 00  red (0).........
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    00f0: 00 00 00 00 00 00 00 00                           ........
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
> HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00
    0000: 00 01 00                                          ...
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    0000: 02 00 00 02 0f 00 65 69                           ......ei



I ran the hcitool scan first, then the hciconfig -a, and both output
through the dumper.  If I try to run more hcitool scan commands, I don't
get any output from those commands back in the dumper (probably still
stuck on the first one?) until I unplug the device and plug it back in, etc.



>
> Also a "hcitool info" on the Treo would be nice.
>


I think I get similar results when running the hcitool info.  However,
when I run the hcitool info (got the device number off the windows
install), the treo screen comes on (lights up) and it plays the
"bluetooth connection sound".  Nothing else, but at least that happens. :)


hcitool info output:
--------------------
red:/home/dpb# hcitool info 00:07:e0:05:0a:11
Requesting information ...
Can't create connection: Connection timed out
red:/home/dpb#

hcidump from info request:
--------------------------
red:/home/dpb# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 11 0a 05 e0 07 00 18 cc  02 00 00 00 01           .............

< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 11 0a 05 e0 07 00 18 cc  02 00 00 00 01           .............



Not sure if it is helpful, but I also attached the syslog output during
all these things.




I appreciate your help.

-- 
David Britton <davidpbritton@gmail.com>

--------------050306030902090804060900
Content-Type: text/plain;
 name="db"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="db"

May 23 21:29:04 localhost kernel: usb 3-2: new full speed USB device using address 30
May 23 21:29:04 localhost kernel: hub 3-2:1.0: USB hub found
May 23 21:29:04 localhost kernel: hub 3-2:1.0: 3 ports detected
May 23 21:29:05 localhost usb.agent[15650]:      usbcore: already loaded
May 23 21:29:05 localhost kernel: usb 3-2.1: new full speed USB device using address 31
May 23 21:29:05 localhost hcid[15344]: HCI dev 0 registered
May 23 21:29:05 localhost hcid[15344]: HCI dev 0 up
May 23 21:29:05 localhost hcid[15344]: Starting security manager 0
May 23 21:29:06 localhost usb.agent[15805]:      hci_usb: already loaded
May 23 21:29:06 localhost usb.agent[15823]:      hci_usb: already loaded
May 23 21:29:06 localhost usb.agent[15799]:      hci_usb: already loaded
May 23 21:29:07 localhost usb.agent[15782]:      hci_usb: already loaded
May 23 21:29:07 localhost kernel: usb 3-2.2: new full speed USB device using address 32
May 23 21:29:07 localhost hal.hotplug[15966]: DEVPATH is not set
May 23 21:29:07 localhost kernel: input: USB HID v1.11 Keyboard [0a5c:3502] on usb-0000:00:10.2-2.2
May 23 21:29:07 localhost udev[15963]: configured rule in '/etc/udev/rules.d/udev.rules[113]' applied, 'event4' becomes 'input/%k'
May 23 21:29:07 localhost udev[15963]: creating device node '/dev/input/event4'
May 23 21:29:07 localhost input.agent[15950]:      evdev: already loaded
May 23 21:29:07 localhost input.agent[15967]:      evdev: already loaded
May 23 21:29:07 localhost input.agent[15967]:      joydev: already loaded
May 23 21:29:07 localhost usb.agent[16031]:      usbhid: already loaded
May 23 21:29:07 localhost kernel: usb 3-2.3: new full speed USB device using address 33
May 23 21:29:08 localhost hal.hotplug[16120]: DEVPATH is not set
May 23 21:29:08 localhost kernel: input: USB HID v1.11 Mouse [0a5c:3503] on usb-0000:00:10.2-2.3
May 23 21:29:08 localhost udev[16109]: configured rule in '/etc/udev/rules.d/udev.rules[113]' applied, 'event5' becomes 'input/%k'
May 23 21:29:08 localhost udev[16109]: creating device node '/dev/input/event5'
May 23 21:29:08 localhost udev[16113]: configured rule in '/etc/udev/rules.d/udev.rules[111]' applied, 'mouse2' becomes 'input/%k'
May 23 21:29:08 localhost udev[16113]: creating device node '/dev/input/mouse2'
May 23 21:29:08 localhost udev[16117]: configured rule in '/etc/udev/rules.d/udev.rules[115]' applied, 'ts2' becomes 'input/%k'
May 23 21:29:08 localhost udev[16117]: creating device node '/dev/input/ts2'
May 23 21:29:08 localhost input.agent[16121]:      evdev: already loaded
May 23 21:29:08 localhost input.agent[16121]:      joydev: already loaded
May 23 21:29:08 localhost input.agent[16121]:      mousedev: already loaded
May 23 21:29:08 localhost input.agent[16121]:      tsdev: already loaded
May 23 21:29:08 localhost input.agent[16196]:      evdev: already loaded
May 23 21:29:08 localhost input.agent[16224]:      evdev: already loaded
May 23 21:29:08 localhost input.agent[16253]:      evdev: already loaded
May 23 21:29:08 localhost usb.agent[16283]:      usbhid: already loaded
May 23 21:29:12 localhost dund[15351]: Accept failed. Interrupted system call(4)
May 23 21:29:12 localhost pand[15353]: Accept failed. Interrupted system call(4)
May 23 21:29:12 localhost hcid[15344]: Exit.
May 23 21:29:12 localhost sdpd[15347]: terminating...   
May 23 21:29:12 localhost pand[15353]: Service record unregistration failed.
May 23 21:29:13 localhost hcid[16333]: Bluetooth HCI daemon
May 23 21:29:13 localhost hcid[16333]: Starting security manager 0
May 23 21:29:13 localhost sdpd[16337]: Bluetooth SDP daemon 
May 23 21:29:13 localhost dund[16339]: Bluetooth DUN daemon version 2.15
May 23 21:29:13 localhost pand[16341]: Bluetooth PAN daemon version 2.15
May 23 21:31:15 localhost kernel: hci_cmd_task: hci0 command tx timeout

--------------050306030902090804060900--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
