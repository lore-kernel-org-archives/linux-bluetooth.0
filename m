Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Jan 2008 15:01:50 -0500
From: Robert Moskowitz <rgm@htt-consult.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <478BBFAE.5080800@htt-consult.com>
In-Reply-To: <1200328736.6259.21.camel@McM>
References: <1200328736.6259.21.camel@McM>
MIME-Version: 1.0
Subject: [Bluez-users] Problems pairing a Treo 650
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

The System is Centos 5.1 (well really Trixbox 2.4.1 built on Centos 5)  
The bluz rpms are:

bluez-gnome-0.5-5.fc6.i386.rpm
bluez-hcidump-1.32-1.i386.rpm
bluez-libs-3.7-1.i386.rpm
bluez-utils-3.7-2.el5.centos.i386.rpm

But note this is all done in init 3.

I see the following in /messages:

Jan 14 00:12:28 sip2 kernel: hub 1-0:1.0: connect-debounce failed, port 
1 disabled
Jan 14 00:13:00 sip2 last message repeated 18 times
Jan 14 00:14:01 sip2 last message repeated 35 times
Jan 14 00:15:02 sip2 last message repeated 35 times
Jan 14 00:16:03 sip2 last message repeated 35 times
Jan 14 00:17:04 sip2 last message repeated 35 times
Jan 14 00:18:05 sip2 last message repeated 35 times
Jan 14 00:19:06 sip2 last message repeated 35 times
Jan 14 00:20:07 sip2 last message repeated 35 times
Jan 14 00:21:08 sip2 last message repeated 35 times
Jan 14 00:22:10 sip2 last message repeated 35 times
Jan 14 00:23:11 sip2 last message repeated 35 times
Jan 14 00:24:12 sip2 last message repeated 35 times
Jan 14 00:25:13 sip2 last message repeated 35 times
Jan 14 00:26:15 sip2 last message repeated 35 times
Jan 14 00:27:16 sip2 last message repeated 35 times
Jan 14 00:28:17 sip2 last message repeated 35 times
Jan 14 00:29:18 sip2 last message repeated 35 times
Jan 14 00:30:19 sip2 last message repeated 35 times
Jan 14 00:31:20 sip2 last message repeated 35 times
Jan 14 00:32:21 sip2 last message repeated 35 times
Jan 14 00:32:44 sip2 last message repeated 13 times
Jan 14 00:32:44 sip2 kernel: usb 1-1: new full speed USB device using 
uhci_hcd and address 2
Jan 14 00:32:44 sip2 kernel: usb 1-1: configuration #1 chosen from 1 choice
Jan 14 00:32:45 sip2 kernel: Bluetooth: HCI USB driver ver 2.9
Jan 14 00:32:45 sip2 hcid[1826]: HCI dev 0 registered
Jan 14 00:32:45 sip2 hcid[1826]: Register path:/org/bluez/hci0 fallback:0
Jan 14 00:32:45 sip2 kernel: usbcore: registered new driver hci_usb
Jan 14 00:32:45 sip2 hcid[1826]: HCI dev 0 up
Jan 14 00:32:45 sip2 hcid[1826]: Device hci0 has been added
Jan 14 00:32:45 sip2 hcid[1826]: Starting security manager 0
Jan 14 00:32:45 sip2 hcid[1826]: Device hci0 has been activated


a hciconfig -a gets:

hci0:   Type: USB
       BD Address: 00:0D:18:01:20:B9 ACL MTU: 192:8 SCO MTU: 64:8
       UP RUNNING PSCAN
       RX bytes:8862 acl:38 sco:0 events:393 errors:0
       TX bytes:2358 acl:38 sco:0 commands:154 errors:0
       Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80
       Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
       Link policy: RSWITCH HOLD SNIFF PARK
       Link mode: SLAVE ACCEPT
       Name: 'sip2'
       Class: 0x000100
       Service Classes: Unspecified
       Device Class: Computer, Uncategorized
       HCI Ver: 1.2 (0x2) HCI Rev: 0x512 LMP Ver: 1.2 (0x2) LMP Subver: 
0x512
       Manufacturer: Cambridge Silicon Radio (10)

CSR is considered good...

Then I try and pair my Treo 650.

I picked up the following to make the token discoverable:

dbus-send --system --type=method_call --print-reply --dest=org.bluez 
/org/bluez/hci0 org.bluez.Adapter.SetMode string:discoverable

ouch!

Now then, hcitool scan mostly fails.  But hcitool info 00:07:E0:24:5A:94

gets:

Requesting information ...
       BD Address:  00:07:E0:24:5A:94
       Device Name: RGM
       LMP Version: 1.1 (0x1) LMP Subversion: 0x700
       Manufacturer: Broadcom Corporation (15)
       Features: 0xbf 0xfe 0x0d 0x00 0x00 0x00 0x00 0x00
               <3-slot packets> <5-slot packets> <encryption> <slot offset>
               <timing accuracy> <role switch> <sniff mode> <RSSI>
               <channel quality> <SCO link> <HV2 packets> <HV3 packets>
               <u-law log> <A-law log> <CVSD> <power control>
               <transparent SCO>


After a bit of work, I can get the phone to prompt me for the PIN.  But 
hcitool con comes up empty.  I try hcitool cc 00:07:E0:24:5A:94  and the 
phone shows connecting, but hcitool con shows an empty list.

Of course when I get into Asterisk's CLI and try a mobile show device, 
it lists the Treo (I did put a section for it in the mobile.conf file) 
put shows NO for Available.

Can anyone help me get direction on getting my phone paired with my system?




-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
