Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44F34B52.3090609@prodigy7.de>
Date: Mon, 28 Aug 2006 22:00:18 +0200
From: Manuel Bernhardt <mailinglist@prodigy7.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <44F1A585.8050408@prodigy7.de>
In-Reply-To: <44F1A585.8050408@prodigy7.de>
Subject: Re: [Bluez-users] Can't use capi/cmtp with bfusb
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

really no one where have an idea? If other information are needed, say 
it and you get it. It would be very nice if i would get bfusb working 
with cmtp on my nas because i could use my nas as an voice box for ex.
I hope, i'dnt overrun the mailinglist with the detailed description in 
my first mail.

Manuel Bernhardt

Manuel Bernhardt schrieb:
> Hi,
>
> i try to get my BlueFritz! USB-Stick get working on my Kurobox (An NAS 
> based on an PPC-CPU) but i've the problem, that i can't use the capi 
> device after loading all modules (See messages at the end of this mail).
>
> Here some infos what I do:
>
> 1. I plug the stick on the Kurobox and the kernel does recognize the stick:
>
> usb 2-1: new full speed USB device using ohci_hcd and address 2
> usb 2-1: configuration #1 chosen from 1 choice
> Bluetooth: Core ver 2.10
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: HCI USB driver ver 2.9
> usbcore: registered new driver hci_usb
>
> Loaded modules are now:
>
> hci_usb                19260  0
> bluetooth              66476  1 hci_usb
>
> 2. Next I load the bfusb driver with _modprobe bfusb_
>
> Syslog output:
> Bluetooth: BlueFRITZ! USB driver ver 1.1
> usbcore: registered new driver bfusb
>
> Modules loaded now:
>
> bfusb                  14244  0
> firmware_class         12224  1 bfusb
> hci_usb                19260  0
> bluetooth              66476  2 bfusb,hci_usb
>
> 3. Now i execute /etc/init.d/bluez-utils start
>
> Output:
> Starting bluez-utils: hcid sdpd rfcomm.
>
> Syslog output:
> Bluetooth: L2CAP ver 2.8
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM ver 1.8
>
> Loaded modules:
> rfcomm                 48572  0
> l2cap                  27140  5 rfcomm
> bfusb                  14244  0
> firmware_class         12224  1 bfusb
> hci_usb                19260  2
> bluetooth              66476  8 rfcomm,l2cap,bfusb,hci_usb
>
> 4. When i enter hciconfig, i see the bluez interface - it's up:
>
> hci0:   Type: USB
>     BD Address: 00:04:0E:89:DA:BA ACL MTU: 120:20 SCO MTU: 0:0
>     UP RUNNING PSCAN ISCAN
>     RX bytes:101 acl:0 sco:0 events:13 errors:0
>     TX bytes:300 acl:0 sco:0 commands:13 errors:0
>
> Additionally i execute hciconfig hci0 lp because holtmann writes in his 
> how-to (http://www.holtmann.org/linux/bluetooth/isdn.html), that this 
> could be necessary:
>
> hci0:   Type: USB
>     BD Address: 00:04:0E:89:DA:BA ACL MTU: 120:20 SCO MTU: 0:0
>     Link policy: RSWITCH HOLD SNIFF PARK
>
> 5. I execute now _modprobe cmtp_
>
> Syslog output:
> CAPI Subsystem Rev 1.1.2.8
> Bluetooth: CMTP (CAPI Emulation) ver 1.0
>
> Loaded modules:
> cmtp                   24320  0
> kernelcapi             50548  1 cmtp
> rfcomm                 48572  0
> l2cap                  27140  6 cmtp,rfcomm
> bfusb                  14244  0
> firmware_class         12224  1 bfusb
> hci_usb                19260  2
> bluetooth              66476  9 cmtp,rfcomm,l2cap,bfusb,hci_usb
>
> 7. Next I do an _modprobe capi_ because.
>
> Syslog output:
> capifs: Rev 1.1.2.3
> capi20: Rev 1.1.2.7: started up with major 68 (middleware+capifs)
>
> Modules:
> Module                  Size  Used by
> capi                   21928  0
> capifs                  6888  2 capi
> cmtp                   24320  0
> kernelcapi             50548  2 capi,cmtp
> rfcomm                 48572  0
> l2cap                  27140  6 cmtp,rfcomm
> bfusb                  14244  0
> firmware_class         12224  1 bfusb
> hci_usb                19260  2
> bluetooth              66476  9 cmtp,rfcomm,l2cap,bfusb,hci_usb
>
> 8. Yet I do an ciptool search:
>
> Searching ...
>     Checking service for 00:04:0E:85:C2:21
>     Connecting to device 00:04:0E:85:C2:21
>
> Syslog output:
> Bluetooth: Found 1 CAPI controller(s) on device 00:04:0E:85:C2:21
> kcapi: Controller 1: 00:04:0E:85:C2:21 attached
> kcapi: card 1 "00:04:0E:85:C2:21" ready.
>
> Now .... when i enter now an capiinfo, i should get an full info about 
> available capi features, right?
>
> I get this here:
>
> Number of Controllers : 1
> Controller 1:
> Manufacturer: AVM Berlin
> CAPI Version: 2.0
> Manufacturer Version: 3.101-04  (49.20)
> Serial Number: 0000000
> BChannels: 512
> Global Options: 0x31000000
> B1 protocols support: 0x0f0000c0
> 56 kbit/s bit-transparent operation
> Modem with all negotiations
> B2 protocols support: 0x0b0b0000
> B3 protocols support: 0x0f000080
> Modem
>
> 0100
> 0200
> 31000000
> 0f0000c0
> 0b0b0000
> 0f000080
> 00000000 00000000 00000000 00000000 00000000 00000000
> 01000001 00020000 00000000 00000000 00000000
> FAC REQ - Illegal command or subcommand or message length less than 12 
> bytes (0x1102)
>
> Other capi applications doesn't also work so i think, the connection 
> isn't established right. What I do wrong?
>
> Here some further details:
> Linux lansrv01 2.6.17.8-mh5_kurobox_hg #2 Sat Aug 19 01:49:26 CEST 2006 
> ppc GNU/Linux
> - Kernel includes patch from http://www.bluez.org/patches.html
>
> I hope i give enough details so someone can help me, solving this problem.
>
> Kind regards
> Manuel Bernhardt
>
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
