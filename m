Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <434C6E2E.9070105@imap.cc>
From: Alex Viskovatoff <viskovatoff+list@imap.cc>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Logitech diNovo hub not recognized
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
Date: Tue, 11 Oct 2005 22:00:14 -0400

Hello,

I am having trouble getting the hub from my Logitech diNovo Cordless 
Desktop Keyboard & Mouse recognized by the Bluetooth system. (The system 
is able to communicate flawlessly with a Palm Tungsten E2, over a D-Link 
DBT-120 USB Bluetooth dongle.) I have looked at earlier posts on this 
list dealing with this device, but all previous posters were able to get 
this hub recognized as a Bluetooth device, as far as I have been able to 
tell. The keyboard and mouse work fine in HID mode.

I am running a Fedora-modified 2.6.13 kernel. My understanding is that 
recent kernels should have sufficient Bluetooth support, so that a Bluez 
patch is not necessary. (Anyway, I tried patch-2.6.13-mh1, and the 
resulting kernel didn't work any better.) I am using the current Fedora 
Core 4 version of bluez-utils, bluez-utils-2.15-7.

Here is what the system log shows when the device is insterted:

Oct 11 21:20:03 georg kernel: usb 2-4.2: new low speed USB device using 
ohci_hcd and address 39
Oct 11 21:20:03 georg kernel: input: USB HID v1.10 Keyboard [Logitech 
USB Receiver] on usb-0000:00:02.0-4.2
Oct 11 21:20:03 georg hal.hotplug[32675]: DEVPATH is not set (subsystem 
input)
Oct 11 21:20:03 georg kernel: input,hiddev96: USB HID v1.10 Mouse 
[Logitech USB Receiver] on usb-0000:00:02.0-4.2
Oct 11 21:20:04 georg hal.hotplug[32706]: DEVPATH is not set (subsystem 
input)

(From what I was able to find from Google searches, the DEVPATH issue 
shouldn't be significant.)

Here are what some commands return:

   # /usr/sbin/hid2hci
   No devices in HCI mode found
   # /usr/sbin/hid2hci -1
   No devices in HID mode found
   # /usr/sbin/hciconfig -a
   [blank]
   #

Inserting the D-Link DBT-120, while keeping the Logitech device plugged 
in, produces:

Oct 11 21:34:58 georg kernel: usb 2-6: new full speed USB device using 
ohci_hcd and address 40
Oct 11 21:34:58 georg hcid[11501]: HCI dev 0 registered
Oct 11 21:34:58 georg hcid[11501]: HCI dev 0 up
Oct 11 21:34:58 georg hcid[11501]: Starting security manager 0


# /usr/sbin/hciconfig -a
hci0:   Type: USB
         BD Address: 00:13:46:4D:6F:14 ACL MTU: 192:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
         RX bytes:101 acl:0 sco:0 events:13 errors:0
         TX bytes:296 acl:0 sco:0 commands:12 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'georg-0'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP 
Subver: 0x20d
         Manufacturer: Cambridge Silicon Radio (10)

#


I am at a loss as to what could be wrong, especially since I read a post 
for I believe the same device saying that it is supported by bluez.

Many thanks in advance for any help,

Alex


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
