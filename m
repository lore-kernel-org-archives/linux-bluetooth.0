Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4028818C.1070109@utia.cas.cz>
From: Rudolf Matousek <matousek@utia.cas.cz>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] i-Tec Bluetooth USB dongle
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
Date: Tue, 10 Feb 2004 08:00:28 +0100

Hi,

I've recently purchased i-Tec USB dongle. Before the purchase, I checked 
that the dongle is supported by linux Bluez.

Unfortunatelly, the dongle I purchased has different chipset from the 
dongle announced as functional. The chipset is Broadcom with Vendor Id: 
0a5c and Product Id: 200a.

The USB view detects three peripherals after dongle insertion:

  1) Wireless Transceiver for Bluetooth (marked red)
  2) usbkbd
  3) mouse

The detail of the usbview data of the transceiver is attached at the end 
of this email. I tried to use bluefw with the broadcom 2033 firmware. 
Unfortunatelly, I was not able to force the hotplug support to execute 
the bluefw script. I probably somehow missed the meaning of the 
bluefw.usermap file. I inserted one more line with flags 0x0000, and 
vendor and product Ids according to the usbview. With no success.

I also noticed that a file modules.usbmap (in /lib/modules/<kernel no> 
directory) also contains vendor and product IDs to load suitable driver.
It seems that all required modules are loaded correctly.

NOW, my questions: Is there a chance to force this i-Tec donge to work 
with Bluez? Do I need a new firmware binaries from Broadcom? Why the 
hotplug support does not execute bluefw?

Any help is welcome! Cheers,


Ruda Matousek

--

Wireless Transceiver for Bluetooth
Manufacturer: Broadcom
Serial Number: 2035B0CD4060
Speed: 12Mb/s (full)
USB Version:  1.10
Device Class: e0(unk. )
Device Subclass: 01
Device Protocol: 01
Maximum Default Endpoint Size: 64
Number of Configurations: 1
Vendor Id: 0a5c
Product Id: 200a
Revision Number:  1.00

Config Number: 1
	Number of Interfaces: 3
	Attributes: e0
	MaxPower Needed:   0mA

	Interface Number: 0
		Name: hci_usb
		Alternate Number: 0
		Class: e0(unk. )
		Sub Class: 1
		Protocol: 1
		Number of Endpoints: 3

			Endpoint Address: 81
			Direction: in
			Attribute: 3
			Type: Int.
			Max Packet Size: 16
			Interval: 1ms

			Endpoint Address: 82
			Direction: in
			Attribute: 2
			Type: Bulk
			Max Packet Size: 64
			Interval: 0ms

			Endpoint Address: 02
			Direction: out
			Attribute: 2
			Type: Bulk
			Max Packet Size: 64
			Interval: 0ms

	Interface Number: 1
		Name: hci_usb
		Alternate Number: 0
		Class: e0(unk. )
		Sub Class: 1
		Protocol: 1
		Number of Endpoints: 2

			Endpoint Address: 83
			Direction: in
			Attribute: 1
			Type: Isoc
			Max Packet Size: 0
			Interval: 1ms

			Endpoint Address: 03
			Direction: out
			Attribute: 1
			Type: Isoc
			Max Packet Size: 0
			Interval: 1ms

	Interface Number: 1
		Name: hci_usb
		Alternate Number: 1
		Class: e0(unk. )
		Sub Class: 1
		Protocol: 1
		Number of Endpoints: 2

			Endpoint Address: 83
			Direction: in
			Attribute: 1
			Type: Isoc
			Max Packet Size: 9
			Interval: 1ms

			Endpoint Address: 03
			Direction: out
			Attribute: 1
			Type: Isoc
			Max Packet Size: 9
			Interval: 1ms

	Interface Number: 1
		Name: hci_usb
		Alternate Number: 2
		Class: e0(unk. )
		Sub Class: 1
		Protocol: 1
		Number of Endpoints: 2

			Endpoint Address: 83
			Direction: in
			Attribute: 1
			Type: Isoc
			Max Packet Size: 17
			Interval: 1ms

			Endpoint Address: 03
			Direction: out
			Attribute: 1
			Type: Isoc
			Max Packet Size: 17
			Interval: 1ms

	Interface Number: 1
		Name: hci_usb
		Alternate Number: 3
		Class: e0(unk. )
		Sub Class: 1
		Protocol: 1
		Number of Endpoints: 2

			Endpoint Address: 83
			Direction: in
			Attribute: 1
			Type: Isoc
			Max Packet Size: 32
			Interval: 1ms

			Endpoint Address: 03
			Direction: out
			Attribute: 1
			Type: Isoc
			Max Packet Size: 32
			Interval: 1ms

	Interface Number: 1
		Name: hci_usb
		Alternate Number: 4
		Class: e0(unk. )
		Sub Class: 1
		Protocol: 1
		Number of Endpoints: 2

			Endpoint Address: 83
			Direction: in
			Attribute: 1
			Type: Isoc
			Max Packet Size: 64
			Interval: 1ms

			Endpoint Address: 03
			Direction: out
			Attribute: 1
			Type: Isoc
			Max Packet Size: 64
			Interval: 1ms

	Interface Number: 1
		Name: hci_usb
		Alternate Number: 5
		Class: e0(unk. )
		Sub Class: 1
		Protocol: 1
		Number of Endpoints: 2

			Endpoint Address: 83
			Direction: in
			Attribute: 1
			Type: Isoc
			Max Packet Size: 64
			Interval: 1ms

			Endpoint Address: 03
			Direction: out
			Attribute: 1
			Type: Isoc
			Max Packet Size: 64
			Interval: 1ms

	Interface Number: 2
		Name: (none)
		Alternate Number: 0
		Class: ff(vend.)
		Sub Class: 0
		Protocol: 0
		Number of Endpoints: 2

			Endpoint Address: 84
			Direction: in
			Attribute: 2
			Type: Bulk
			Max Packet Size: 32
			Interval: 0ms

			Endpoint Address: 04
			Direction: out
			Attribute: 2
			Type: Bulk
			Max Packet Size: 32
			Interval: 0ms


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
