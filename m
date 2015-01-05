Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Keeping hci interface powered
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <m361cklxwo.fsf@carbon.jhcloos.org>
Date: Mon, 5 Jan 2015 13:47:52 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C5CDA647-8415-44F3-9F89-0D596D76498F@holtmann.org>
References: <m3oaqfl79f.fsf@carbon.jhcloos.org> <D043D131-E9F8-43C1-8671-0EACAE810420@holtmann.org> <m361cklxwo.fsf@carbon.jhcloos.org>
To: James Cloos <cloos@jhcloos.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

> MH> it should not do that at all. Once a controller is powered that should stay until you tell it otherwise.
> 
> Since I wrote, I powerred it back on and is has remained up, but still
> refuses to reconnect to the keyboard w/o an explicit connect command in
> bluetoothctl.
> 
> MH> You can also check with btmon what happens when the keyboard
> MH> disconnects. If the controller goes away it will tell you as well.
> 
> I ran btmon until the keyboard disconnected; the last few events were:
> 
> ,----
> | > HCI Event: Mode Change (0x14) plen 6                                       [hci0] 4313.775232
> |         Status: Remote User Terminated Connection (0x13)
> |         Handle: 256
> |         Mode: Active (0x00)
> |         Interval: 0.000 msec (0x0000)
> | > HCI Event: Disconnect Complete (0x05) plen 4                               [hci0] 4313.777078
> |         Status: Success (0x00)
> |         Handle: 256
> |         Reason: Remote User Terminated Connection (0x13)
> | @ Device Disconnected: 90:7F:xx:xx:xx:xx (0) reason 3
> | < HCI Command: Write Scan Enable (0x03|0x001a) plen 1                        [hci0] 4313.788169
> |         Scan enable: Page Scan (0x02)
> | > HCI Event: Command Complete (0x0e) plen 4                                  [hci0] 4313.790072
> |       Write Scan Enable (0x03|0x001a) ncmd 2
> |         Status: Success (0x00)
> `----

this looks like a recent kernel since it cleanly handles the page scan. However Page Scan enabled means that you are again connectable. So once the keyboard disconnects, the kernel will accept new connections.

> Today I ran hcidump and hit a key on the keyboard; that showed:
> 
> ,----
> | > HCI Event: Connect Request (0x04) plen 10
> |     bdaddr 90:7F:xx:xx:xx:xx class 0x000540 type ACL
> | < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> |     bdaddr 90:7F:xx:xx:xx:xx role 0x00
> |     Role: Master
> | > HCI Event: Command Status (0x0f) plen 4
> |     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> | > HCI Event: Role Change (0x12) plen 8
> |     status 0x00 bdaddr 90:7F:xx:xx:xx:xx role 0x00
> |     Role: Master
> | > HCI Event: Connect Complete (0x03) plen 11
> |     status 0x00 handle 256 bdaddr 90:7F:xx:xx:xx:xx type ACL encrypt 0x00
> | < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> |     handle 256
> | > HCI Event: Command Status (0x0f) plen 4
> |     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> | < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
> |     enable 0
> | > HCI Event: Max Slots Change (0x1b) plen 3
> |     handle 256 slots 5
> | > HCI Event: Command Complete (0x0e) plen 4
> |     Write Scan Enable (0x03|0x001a) ncmd 2
> |     status 0x00
> | > HCI Event: Read Remote Supported Features (0x0b) plen 11
> |     status 0x00 handle 256
> |     Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
> | < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
> |     handle 256 page 1
> | > HCI Event: Command Status (0x0f) plen 4
> |     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> | > HCI Event: Read Remote Extended Features (0x23) plen 13
> |     status 0x00 handle 256 page 1 max 0
> |     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> | < HCI Command: Remote Name Request (0x01|0x0019) plen 10
> |     bdaddr 90:7F:xx:xx:xx:xx mode 2 clkoffset 0x0000
> | < ACL data: handle 256 flags 0x00 dlen 10
> |     L2CAP(s): Info req: type 2
> | > ACL data: handle 256 flags 0x02 dlen 12
> |     L2CAP(s): Connect req: psm 17 scid 0x0045
> | > HCI Event: Command Status (0x0f) plen 4
> |     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> | < ACL data: handle 256 flags 0x00 dlen 16
> |     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0045 result 3 status 0
> |       Connection refused - security block
> | > ACL data: handle 256 flags 0x02 dlen 16
> |     L2CAP(s): Info rsp: type 2 result 0
> |       Extended feature mask 0x0280
> |         Fixed Channels
> |         Unicast Connectless Data Reception
> | > HCI Event: Number of Completed Packets (0x13) plen 5
> |     handle 256 packets 1
> | < ACL data: handle 256 flags 0x00 dlen 10
> |     L2CAP(s): Info req: type 3
> | > HCI Event: Number of Completed Packets (0x13) plen 5
> |     handle 256 packets 1
> | > HCI Event: Command Complete (0x0e) plen 4
> |     Set AFH Host Channel Classification (0x03|0x003f) ncmd 2
> |     status 0x00
> | > HCI Event: Remote Name Req Complete (0x07) plen 255
> |     status 0x13 bdaddr 90:7F:xx:xx:xx:xx name ''
> |     Error: Remote User Terminated Connection
> | > HCI Event: Disconn Complete (0x05) plen 4
> |     status 0x00 handle 256 reason 0x13
> |     Reason: Remote User Terminated Connection
> | < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
> |     enable 2
> | > HCI Event: Command Complete (0x0e) plen 4
> |     Write Scan Enable (0x03|0x001a) ncmd 2
> |     status 0x00
> | > HCI Event: Connect Request (0x04) plen 10
> |     bdaddr 90:7F:xx:xx:xx:xx class 0x000540 type ACL
> | < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> |     bdaddr 90:7F:xx:xx:xx:xx role 0x00
> |     Role: Master
> | > HCI Event: Command Status (0x0f) plen 4
> |     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> | > HCI Event: Role Change (0x12) plen 8
> |     status 0x00 bdaddr 90:7F:xx:xx:xx:xx role 0x00
> |     Role: Master
> | > HCI Event: Connect Complete (0x03) plen 11
> |     status 0x00 handle 256 bdaddr 90:7F:xx:xx:xx:xx type ACL encrypt 0x00
> | < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> |     handle 256
> | > HCI Event: Command Status (0x0f) plen 4
> |     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> | < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
> |     enable 0
> | > HCI Event: Max Slots Change (0x1b) plen 3
> |     handle 256 slots 5
> | > HCI Event: Command Complete (0x0e) plen 4
> |     Write Scan Enable (0x03|0x001a) ncmd 2
> |     status 0x00
> | > HCI Event: Read Remote Supported Features (0x0b) plen 11
> |     status 0x00 handle 256
> |     Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
> | < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
> |     handle 256 page 1
> | > HCI Event: Command Status (0x0f) plen 4
> |     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> | > HCI Event: Read Remote Extended Features (0x23) plen 13
> |     status 0x00 handle 256 page 1 max 0
> |     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> | < HCI Command: Remote Name Request (0x01|0x0019) plen 10
> |     bdaddr 90:7F:xx:xx:xx:xx mode 2 clkoffset 0x0000
> | < ACL data: handle 256 flags 0x00 dlen 10
> |     L2CAP(s): Info req: type 2
> | > HCI Event: Command Status (0x0f) plen 4
> |     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> | > ACL data: handle 256 flags 0x02 dlen 12
> |     L2CAP(s): Connect req: psm 17 scid 0x0040
> | > HCI Event: Number of Completed Packets (0x13) plen 5
> |     handle 256 packets 1
> | < ACL data: handle 256 flags 0x00 dlen 16
> |     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 3 status 0
> |       Connection refused - security block
> | > ACL data: handle 256 flags 0x02 dlen 16
> |     L2CAP(s): Info rsp: type 2 result 0
> |       Extended feature mask 0x0280
> |         Fixed Channels
> |         Unicast Connectless Data Reception
> | < ACL data: handle 256 flags 0x00 dlen 10
> |     L2CAP(s): Info req: type 3
> | > HCI Event: Number of Completed Packets (0x13) plen 5
> |     handle 256 packets 1
> | > HCI Event: Number of Completed Packets (0x13) plen 5
> |     handle 256 packets 1
> | > HCI Event: Command Complete (0x0e) plen 4
> |     Set AFH Host Channel Classification (0x03|0x003f) ncmd 2
> |     status 0x00
> | > HCI Event: Remote Name Req Complete (0x07) plen 255
> |     status 0x13 bdaddr 90:7F:xx:xx:xx:xx name ''
> |     Error: Remote User Terminated Connection
> | > HCI Event: Disconn Complete (0x05) plen 4
> |     status 0x00 handle 256 reason 0x13
> |     Reason: Remote User Terminated Connection
> | < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
> |     enable 2
> | > HCI Event: Command Complete (0x0e) plen 4
> |     Write Scan Enable (0x03|0x001a) ncmd 2
> |     status 0x00
> `----
> 
> As you can see, there are a couple of Connection refused - security
> block errors.  Is there a permission issue which I miss?

So it is clearly that the actual connection attempt from the keyboard arrives and is allowed to continue by the lower layers. However when opening the L2CAP channels from the HID control and interrupt endpoints, it refuses to let you connect.

Can you check /sys/kernel/debug/bluetooth/hci0/link_keys that you indeed have the keys available.

However I have the fear that your keyboard is violating the Bluetooth spec. Please check /sys/kernel/debug/bluetooth/hci0/features or btmgmt info. I assume your local controller supports Secure Simple Pairing (every 2.1 or later controller does) and your keyboard does as well.

What this means is that the initiator device (in this case your keyboard) has to enable encryption. And BlueZ refuses the L2CAP connection if the ACL link is not encrypted (as mandated by the spec).

Can you run a hcitool info <bdaddr> against your keyboard and see who is the chip/module manufacturer on that keyboard.

> For reference:
> 
> ,----
> | :; bluetoothctl 
> | [NEW] Controller 80:86:xx:xx:xx:xx BlueZ 5.27 [default]
> | [NEW] Device 90:7F:xx:xx:xx:xx ThinkPad Compact Bluetooth Keyboard with TrackPoint
> | [bluetooth]# show
> | Controller 80:86:xx:xx:xx:xx
> | 	Name: BlueZ 5.27
> | 	Alias: BlueZ 5.27
> | 	Class: 0x000104
> | 	Powered: yes
> | 	Discoverable: no
> | 	Pairable: yes
> | 	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> | 	UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
> | 	UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
> | 	UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> | 	UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> | 	Modalias: usb:v1D6Bp0246d051B
> | 	Discovering: no
> | [bluetooth]# info 90:7F:xx:xx:xx:xx
> | Device 90:7F:xx:xx:xx:xx
> | 	Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
> | 	Alias: ThinkPad Compact Bluetooth Keyboard with TrackPoint
> | 	Class: 0x000540
> | 	Icon: input-keyboard
> | 	Paired: yes
> | 	Trusted: yes
> | 	Blocked: no
> | 	Connected: no
> | 	LegacyPairing: no
> | 	UUID: Service Discovery Serve.. (00001000-0000-1000-8000-00805f9b34fb)
> | 	UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
> | 	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> | 	Modalias: usb:v17EFp6048d0309
> `----

The LegacyPairing: no is not a 100% indication, but I assume your keyboard is actually a Bluetooth 2.1 keyboard with Secure Simple Pairing.

Do you have an exact model number or link? We might have to buy one of these keyboards.

Regards

Marcel

