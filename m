Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Dec 2014 12:53:38 +0100
From: Veseli Veseljko <veseljko75@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: ShanWan Sixaxis PS3 controller
Message-ID: <20141219115338.GA19036@ubuntu.localnet>
References: <20141216172421.GA12748@ubuntu.localnet>
 <20141217133613.GA18280@ubuntu.localnet>
 <1432274.34ricBdst7@uw000953>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
In-Reply-To: <1432274.34ricBdst7@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thursday, 2014-12-18, at 12:24:59 +0100, Szymon Janc wrote:
> Typically DS3 should be handled like this:
> 
> 1. make sure you don't have sixad/qtsixa installed as it was reported
> that it conflicted with sixpair plugin (udev rules)

I've uninstalled sixad and qtsixa.

> 2. make sure you have sixaxis plugin installed - this plugin depends
> on udev so it is not builin into bluetoothd but loaded on start from
> /usr/lib/bluetooth/plugins

Yes, plugin "sixaxis.so" is installed in
"/usr/lib/i386-linux-gnu/bluetooth/plugins/".

> 3. plug it into USB (don't press PS button yet) you should see
> something like "sixaxis: compatible device connected: ...." in
> bluetoothd logs

Yes, I got it in the logs:

---begin---
bluetoothd[24934]: sixaxis: compatible device connected: PLAYSTATION(R)3
  Controller (054C:0268)
bluetoothd[24934]: sixaxis: setting up new device
----end----

> 4. unplug it
> 5. press PS button
> 
> Device should now connect and you should be asked (in bluetoothctl or
> UI) to authorize connection. After that you should be able to
> reconnect without need of pluging it with USB first.

I did as you said, but I haven't been asked to authorize connection.

I attached logs from bluetoothd run with "-d" and hcidump of what has
happened when I pressed PS button.

> This was mostly tested with genuine controllers. There were reports
> that some of clone devices doesn't behave exactly the same ie. use
> different pid/vid or don't report correct BT address over USB. Making
> them work would probably require some extra work, but I don't have any
> of those clone devices.

I could order one of those clone controllers for you if you provide me
your delivery address.

Best regards,

Veseljko

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="syslog.txt"

kernel: [89396.404095] usb 2-2: new full-speed USB device number 6 using uhci_hcd
kernel: [89396.589056] usb 2-2: New USB device found, idVendor=054c, idProduct=0268
kernel: [89396.589065] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
kernel: [89396.589069] usb 2-2: Product: PLAYSTATION(R)3 Controller
kernel: [89396.589073] usb 2-2: Manufacturer: ShanWan    
kernel: [89396.629190] sony 0003:054C:0268.0005: Fixing up Sony Sixaxis report descriptor
kernel: [89396.669211] input: ShanWan     PLAYSTATION(R)3 Controller as /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0/0003:054C:0268.0005/input/input19
kernel: [89396.675612] sony 0003:054C:0268.0005: input,hiddev0,hidraw0: USB HID v1.10 Joystick [ShanWan     PLAYSTATION(R)3 Controller] on usb-0000:00:1d.0-2/input0
bluetoothd[24934]: sixaxis: compatible device connected: PLAYSTATION(R)3 Controller (054C:0268)
bluetoothd[24934]: plugins/sixaxis.c:setup_device() remote 00:16:FE:xx:xx:xx old_master 00:20:E0:xx:xx:xx new_master 00:20:E0:xx:xx:xx
bluetoothd[24934]: src/device.c:device_create() dst 00:16:FE:xx:xx:xx
bluetoothd[24934]: src/device.c:device_new() address 00:16:FE:xx:xx:xx
bluetoothd[24934]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_00_16_FE_xx_xx_xx
bluetoothd[24934]: sixaxis: setting up new device
bluetoothd[24934]: src/device.c:btd_device_device_set_name() /org/bluez/hci0/dev_00_16_FE_xx_xx_xx PLAYSTATION(R)3 Controller
bluetoothd[24934]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[24934]: plugins/sixaxis.c:get_leds_data() number 1
bluetoothd[24934]: src/device.c:btd_device_set_trusted() trusted 1
kernel: [89456.744176] usb 2-2: USB disconnect, device number 6
bluetoothd[24934]: src/adapter.c:connected_callback() hci0 device 00:16:FE:xx:xx:xx connected eir_len 5
bluetoothd[24934]: src/device.c:device_set_class() /org/bluez/hci0/dev_00_16_FE_xx_xx_xx 0x001F00
bluetoothd[24934]: profiles/input/server.c:connect_event_cb() Incoming connection from 00:16:FE:xx:xx:xx on PSM 17
bluetoothd[24934]: profiles/input/device.c:input_device_set_channel() idev (nil) psm 17
bluetoothd[24934]: profiles/input/server.c:confirm_event_cb() 
bluetoothd[24934]: 00:16:FE:xx:xx:xx: error updating services: Connection timed out (110)
bluetoothd[24934]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_00_16_FE_xx_xx_xx err -110
bluetoothd[24934]: profiles/input/server.c:sixaxis_sdp_cb() err -110 (Connection timed out)
bluetoothd[24934]: HUP or ERR on socket: Connection timed out (110)
bluetoothd[24934]: src/adapter.c:dev_disconnected() Device 00:16:FE:xx:xx:xx disconnected, reason 2
bluetoothd[24934]: src/adapter.c:adapter_remove_connection() 
bluetoothd[24934]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[24934]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:16:FE:xx:xx:xx type 0 status 0xe
bluetoothd[24934]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[24934]: src/device.c:device_bonding_failed() status 14
bluetoothd[24934]: src/adapter.c:resume_discovery() 
bluetoothd[24934]: src/adapter.c:connected_callback() hci0 device 00:16:FE:xx:xx:xx connected eir_len 5
bluetoothd[24934]: profiles/input/server.c:connect_event_cb() Incoming connection from 00:16:FE:xx:xx:xx on PSM 17
bluetoothd[24934]: profiles/input/device.c:input_device_set_channel() idev (nil) psm 17
bluetoothd[24934]: profiles/input/server.c:sixaxis_sdp_cb() err 0 (Success)
bluetoothd[24934]: profiles/input/device.c:input_device_set_channel() idev (nil) psm 17
bluetoothd[24934]: profiles/input/server.c:confirm_event_cb() 
bluetoothd[24934]: profiles/input/server.c:connect_event_cb() Incoming connection from 00:16:FE:xx:xx:xx on PSM 19
bluetoothd[24934]: profiles/input/device.c:input_device_set_channel() idev (nil) psm 19
bluetoothd[24934]: profiles/input/server.c:sixaxis_sdp_cb() err 0 (Success)
bluetoothd[24934]: profiles/input/device.c:input_device_set_channel() idev (nil) psm 19
bluetoothd[24934]: 00:16:FE:xx:xx:xx: error updating services: Connection timed out (110)
bluetoothd[24934]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_00_16_FE_xx_xx_xx err -110
bluetoothd[24934]: src/adapter.c:dev_disconnected() Device 00:16:FE:xx:xx:xx disconnected, reason 2
bluetoothd[24934]: src/adapter.c:adapter_remove_connection() 
bluetoothd[24934]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[24934]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:16:FE:xx:xx:xx type 0 status 0xe
bluetoothd[24934]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[24934]: src/device.c:device_bonding_failed() status 14
bluetoothd[24934]: src/adapter.c:resume_discovery() 

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hcidump.txt"

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:16:FE:xx:xx:xx class 0x001f00 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:16:FE:xx:xx:xx role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:16:FE:xx:xx:xx role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:16:FE:xx:xx:xx type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 41
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:16:FE:xx:xx:xx mode 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 41 ptype 0x0018
    Packet type: DM1 DH1 
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x20ee
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 41
    Features: 0xfc 0x07 0x82 0x7a 0x08 0x18 0x00 0x80
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:FE:xx:xx:xx mode 2 clkoffset 0x0000
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x20ee result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 2
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:16:FE:xx:xx:xx name 'PLAYSTATION(R)3Conteroller-VINS'
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x20ee result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x20ee flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x20ee flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x20ee scid 0x0040
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x20ef
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x20ef result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x20ef result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x20ef flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
> ACL data: handle 41 flags 0x01 dlen 16
> ACL data: handle 41 flags 0x01 dlen 4
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 24
      QoS 0x02 (Guaranteed) 
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x20ef flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x20ef scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host

--EeQfGwPcQSOJBaQU--
