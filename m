Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Simon Huggins <huggie@earth.li>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040513202052.GJ14471@paranoidfreak.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] D-Link DBT 120 B4 + 2.6.6 / 2.6.6-mh1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 13 May 2004 21:20:52 +0100

Hi,

I've just got a D-link DBT 120 which on the box has a revision of B4
(not quite sure where to find this when the module is loaded).

I compiled up 2.6.6 and got the module loaded and everything and it all
looked fine but it won't see my phone in hcidump.

So I looked on the site and noticed it said:
	This patch brings the long awaited kernel HID support for the
	Human Interface Device Protocol and fixes some serious bugs in
	the USB based Bluetooth drivers.

So I tried it with the -mh1 patch to 2.6.6 and didn't get any further.

I have a Nokia 6310i and I was expecting to see it in hcitool scan but I
just get:
huggie@thin:~$ hcitool scan
Scanning ...
in spite of the phone having Bluetooth turned on and having a name.

I tried running hcidump too and it shows me stuff like:
> HCI Event: Inquiry Complete(0x01) plen 1
> HCI Event: Command Status(0x0f) plen 4
when I run the above scan.

Oh I tried "hcitool inq" as well but didn't get that working either.

hciconfig -a shows:
hci0:   Type: USB
        BD Address: 00:0F:3D:0D:73:5C ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH 
        RX bytes:465 acl:0 sco:0 events:32 errors:0
        TX bytes:622 acl:0 sco:0 commands:27 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'thin-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)


There are two lights on the dongle and one of them PWR and LNK and the
LNK one flashes regularly but both are green and on when I plug in (the
driver gets loaded automatically).

I'm running Debian unstable at first with the unstable packages and now
with the ones from:
deb http://bluez.sourceforge.net/download/debian/ ./

Anything you can tell me which is relevant would be useful.  Don't
assume I've done something obvious because although I've tried looking
at the docs I don't seem to have got very far.

Since this is CSR I take it I don't need to load firmware?

Messages when it's detected (in 2.6.6-mh1) are:
Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.2
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
ohci_hcd 0000:00:0c.0: GetStatus roothub.portstatus [1] = 0x00010101 CSC
PPS CCS
hub 1-0:1.0: port 1, status 101, change 1, 12 Mb/s
hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
ohci_hcd 0000:00:0c.0: GetStatus roothub.portstatus [1] = 0x00100103
PRSC PPS PE
S CCS
usb 1-1: new full speed USB device using address 2
usb 1-1: skipped 1 class/vendor specific interface descriptors
usb 1-1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: hotplug
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
usb 1-1:1.0: hotplug
usb 1-1: adding 1-1:1.1 (config #1, interface 1)
usb 1-1:1.1: hotplug
usb 1-1: adding 1-1:1.2 (config #1, interface 2)
usb 1-1:1.2: hotplug
Bluetooth: HCI USB driver ver 2.5
hci_usb 1-1:1.0: usb_probe_interface
hci_usb 1-1:1.0: usb_probe_interface - got id
hci_usb 1-1:1.2: usb_probe_interface
hci_usb 1-1:1.2: usb_probe_interface - got id
usbcore: registered new driver hci_usb


Simon.

-- 
UK based domain, email and web hosting ***/          If a tree fell on a /*
http://www.blackcatnetworks.co.uk/     **/     florist, would he make a /**
sales@blackcatnetworks.co.uk           */                       sound? /***
Black Cat Networks                     /                              /****


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
