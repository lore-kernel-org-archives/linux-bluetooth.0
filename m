Return-Path: <cyrus@holtmann.org>
Message-ID: <4FB185FF.2060401@tu-ilmenau.de>
Date: Tue, 15 May 2012 00:23:59 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Can't connect Bluetooth Devices
References: <4F968FF7.7060303@tu-ilmenau.de> <4FA1BB1C.6060409@tu-ilmenau.de> <20120502225815.GE16030@joana> <4FA23B93.8090204@tu-ilmenau.de> <20120503094429.GA6226@x220> <4FA6C460.9010209@tu-ilmenau.de> <4FAA5D6C.9010708@tu-ilmenau.de> <4FAA7F06.6050805@tu-ilmenau.de>
In-Reply-To: <4FAA7F06.6050805@tu-ilmenau.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

> as I said, I have two gentoo-PCs with a Bluetooth3.0-Dongle at each PC.
> Now I tried to use the bluetooth-test-network to connect:
> But connection was refused and I don't know how to fix it. Down below 
> you find the
> # bluez-test-network
> # monitor-bluetooth
> and
> # hcidump -i hci0
> -messages of both PCs. On top of that, there are different error 
> messages at both PCs!
>
> Hope you can help me in this case.
>
> Regards,
> Steffen
>
>
> So here it is:
>
> PC1:
> bluetooth1 ~ # bluez-test-discovery
> [ 00:02:72:AE:58:73 ]
>     Name = bluetooth2-0
>     Paired = 1
>     LegacyPairing = 0
>     Alias = bluetooth2-0
>     UUIDs = 
> dbus.Array([dbus.String(u'00001116-0000-1000-8000-00805f9b34fb'), 
> dbus.String(u'00001103-0000-1000-8000-00805f9b34fb'), 
> dbus.String(u'0000110e-0000-1000-8000-00805f9b34fb'), 
> dbus.String(u'0000110c-0000-1000-8000-00805f9b34fb'), 
> dbus.String(u'0000110a-0000-1000-8000-00805f9b34fb'), 
> dbus.String(u'0000111f-0000-1000-8000-00805f9b34fb'), 
> dbus.String(u'00001112-0000-1000-8000-00805f9b34fb')], 
> signature=dbus.Signature('s'), variant_level=1)
>     Address = 00:02:72:AE:58:73
>     RSSI = -37
>     Class = 0x4a0100
>     Trusted = 1
>     Icon = computer
>
> ------------------------------------------------------------------------------------- 
>
>
> bluetooth1 ~ # bluez-test-network 00:02:72:AE:58:73 nap
> Traceback (most recent call last):
>   File "/usr/bin/bluez-test-network", line 45, in <module>
>     iface = network.Connect(service)
>   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 68, 
> in __call__
>     return self._proxy_method(*args, **keywords)
>   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 143, 
> in __call__
>     **keywords)
>   File "/usr/lib64/python2.7/site-packages/dbus/connection.py", line 
> 630, in call_blocking
>     message, timeout)
> dbus.exceptions.DBusException: org.bluez.Error.Failed: Connection 
> refused (111)
>
> ------------------------------------------------------------------------------------- 
>
>
> bluetooth1 ~ # monitor-bluetooth
> {Device.PropertyChanged} [/org/bluez/2821/hci0/dev_00_02_72_AE_58_73] 
> Connected = 1
> {Device.PropertyChanged} [/org/bluez/2821/hci0/dev_00_02_72_AE_58_73] 
> Connected = 0
>
> ------------------------------------------------------------------------------------- 
>
>
> bluetooth1 ~ # hcidump -i hci0
> HCI sniffer - Bluetooth packet analyzer ver 2.3
> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:02:72:AE:58:73 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: Role Change (0x12) plen 8
>     status 0x00 bdaddr 00:02:72:AE:58:73 role 0x01
>     Role: Slave
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 12 bdaddr 00:02:72:AE:58:73 type ACL encrypt 0x00
> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>     handle 12
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 12 slots 5
> > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> > HCI Event: Read Remote Supported Features (0x0b) plen 11
>     status 0x00 handle 12
>     Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x87
> < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
>     handle 12 page 1
> > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> > HCI Event: Read Remote Extended Features (0x23) plen 13
>     status 0x00 handle 12 page 1 max 1
>     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:02:72:AE:58:73 mode 2 clkoffset 0x0000
> > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> > HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x00 bdaddr 00:02:72:AE:58:73 name 'bluetooth2-0'
> < HCI Command: Authentication Requested (0x01|0x0011) plen 2
>     handle 12
> > HCI Event: Command Status (0x0f) plen 4
>     Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> > HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:02:72:AE:58:73
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>     bdaddr 00:02:72:AE:58:73 key C6A4D268E42E81CAD233A2C61FA7993A
> > HCI Event: Command Complete (0x0e) plen 10
>     Link Key Request Reply (0x01|0x000b) ncmd 1
>     status 0x00 bdaddr 00:02:72:AE:58:73
> > HCI Event: Auth Complete (0x06) plen 3
>     status 0x00 handle 12
> < HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
>     handle 12 encrypt 0x01
> > HCI Event: Command Status (0x0f) plen 4
>     Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> > HCI Event: Encrypt Change (0x08) plen 4
>     status 0x00 handle 12 encrypt 0x01
> < ACL data: handle 12 flags 0x00 dlen 10
>     L2CAP(s): Info req: type 2
> > ACL data: handle 12 flags 0x02 dlen 16
>     L2CAP(s): Info rsp: type 2 result 0
>       Extended feature mask 0x00b8
>         Enhanced Retransmission mode
>         Streaming mode
>         FCS Option
>         Fixed Channels
> < ACL data: handle 12 flags 0x00 dlen 10
>     L2CAP(s): Info req: type 3
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 2
> > ACL data: handle 12 flags 0x02 dlen 20
>     L2CAP(s): Info rsp: type 3 result 0
>       Fixed channel list 0x00000002
>         L2CAP Signalling Channel
> < ACL data: handle 12 flags 0x00 dlen 12
>     L2CAP(s): Connect req: psm 15 scid 0x0040
> > ACL data: handle 12 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
>       Connection pending - No futher information available
> > ACL data: handle 12 flags 0x02 dlen 10
>     L2CAP(s): Info req: type 2
> < ACL data: handle 12 flags 0x00 dlen 16
>     L2CAP(s): Info rsp: type 2 result 0
>       Extended feature mask 0x00b8
>         Enhanced Retransmission mode
>         Streaming mode
>         FCS Option
>         Fixed Channels
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 2
> > ACL data: handle 12 flags 0x02 dlen 10
>     L2CAP(s): Info req: type 3
> < ACL data: handle 12 flags 0x00 dlen 20
>     L2CAP(s): Info rsp: type 3 result 0
>       Fixed channel list 0x00000002
>         L2CAP Signalling Channel
> > ACL data: handle 12 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
>       Connection pending - Authorization pending
> > ACL data: handle 12 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
>       Connection refused - security block
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 1
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>     handle 12 reason 0x13
>     Reason: Remote User Terminated Connection
> > HCI Event: Command Status (0x0f) plen 4
>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 12 reason 0x16
>     Reason: Connection Terminated by Local Host
>
>
> ------------------------------------------------------------------------------------- 
>
> ------------------------------------------------------------------------------------- 
>
>
> PC2:
> bluetooth2 ~ # bluez-test-discovery
> [ 00:02:72:24:02:04 ]
>     Name = bluetooth1-0
>     Paired = 1
>     LegacyPairing = 0
>     Alias = bluetooth1-0
>     UUIDs = 
> dbus.Array([dbus.String(u'00001103-0000-1000-8000-00805f9b34fb'), 
> dbus.String(u'0000110e-0000-1000-8000-00805f9b34fb'), 
> dbus.String(u'0000110c-0000-1000-8000-00805f9b34fb'), 
> dbus.String(u'0000110a-0000-1000-8000-00805f9b34fb'), 
> dbus.String(u'0000111f-0000-1000-8000-00805f9b34fb'), 
> dbus.String(u'00001112-0000-1000-8000-00805f9b34fb')], 
> signature=dbus.Signature('s'), variant_level=1)
>     Address = 00:02:72:24:02:04
>     RSSI = -38
>     Class = 0x4a0100
>     Trusted = 1
>     Icon = computer
>
> ------------------------------------------------------------------------------------- 
>
>
> bluetooth2 ~ # bluez-test-network 00:02:72:24:02:04 nap
> Traceback (most recent call last):
>   File "/usr/bin/bluez-test-network", line 45, in <module>
>     iface = network.Connect(service)
>   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 68, 
> in __call__
>     return self._proxy_method(*args, **keywords)
>   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 143, 
> in __call__
>     **keywords)
>   File "/usr/lib64/python2.7/site-packages/dbus/connection.py", line 
> 630, in call_blocking
>     message, timeout)
> dbus.exceptions.DBusException: 
> org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with 
> signature "s" on interface "org.bluez.Network" doesn't exist
>
> ------------------------------------------------------------------------------------- 
>
>
> bluetooth2 ~ # monitor-bluetooth
>
> ------------------------------------------------------------------------------------- 
>
>
> bluetooth2 bluetooth # hcidump -i hci0
> HCI sniffer - Bluetooth packet analyzer ver 2.3
> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
>
> ------------------------------------------------------------------------------------- 
>
> ------------------------------------------------------------------------------------- 
>
>
> monitor and hcidump at bluetooth2 when bluetooth1 tries to connect:
>
> bluetooth2 ~ # monitor-bluetooth
> {Device.PropertyChanged} [/org/bluez/2937/hci0/dev_00_02_72_24_02_04] 
> Connected = 1
> {Device.PropertyChanged} [/org/bluez/2937/hci0/dev_00_02_72_24_02_04] 
> Connected = 0
>
> ------------------------------------------------------------------------------------- 
>
>
> bluetooth2 bluetooth # hcidump -i hci0
> HCI sniffer - Bluetooth packet analyzer ver 2.3
> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> > HCI Event: Connect Request (0x04) plen 10
>     bdaddr 00:02:72:24:02:04 class 0x4a0100 type ACL
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>     bdaddr 00:02:72:24:02:04 role 0x00
>     Role: Master
> > HCI Event: Command Status (0x0f) plen 4
>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> > HCI Event: Role Change (0x12) plen 8
>     status 0x00 bdaddr 00:02:72:24:02:04 role 0x00
>     Role: Master
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 12 bdaddr 00:02:72:24:02:04 type ACL encrypt 0x00
> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>     handle 12
> > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> > HCI Event: Read Remote Supported Features (0x0b) plen 11
>     status 0x00 handle 12
>     Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x87
> < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
>     handle 12 page 1
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 12 slots 5
> > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> > HCI Event: Read Remote Extended Features (0x23) plen 13
>     status 0x00 handle 12 page 1 max 1
>     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:02:72:24:02:04 mode 2 clkoffset 0x0000
> > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> > HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x00 bdaddr 00:02:72:24:02:04 name 'bluetooth1-0'
> > HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:02:72:24:02:04
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>     bdaddr 00:02:72:24:02:04 key C6A4D268E42E81CAD233A2C61FA7993A
> > HCI Event: Command Complete (0x0e) plen 10
>     Link Key Request Reply (0x01|0x000b) ncmd 1
>     status 0x00 bdaddr 00:02:72:24:02:04
> > HCI Event: Encrypt Change (0x08) plen 4
>     status 0x00 handle 12 encrypt 0x01
> > ACL data: handle 12 flags 0x02 dlen 10
>     L2CAP(s): Info req: type 2
> < ACL data: handle 12 flags 0x00 dlen 16
>     L2CAP(s): Info rsp: type 2 result 0
>       Extended feature mask 0x00b8
>         Enhanced Retransmission mode
>         Streaming mode
>         FCS Option
>         Fixed Channels
> > ACL data: handle 12 flags 0x02 dlen 10
>     L2CAP(s): Info req: type 3
> < ACL data: handle 12 flags 0x00 dlen 20
>     L2CAP(s): Info rsp: type 3 result 0
>       Fixed channel list 0x00000002
>         L2CAP Signalling Channel
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 2
> > ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 15 scid 0x0040
> < ACL data: handle 12 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
>       Connection pending - No futher information available
> < ACL data: handle 12 flags 0x00 dlen 10
>     L2CAP(s): Info req: type 2
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 2
> > ACL data: handle 12 flags 0x02 dlen 16
>     L2CAP(s): Info rsp: type 2 result 0
>       Extended feature mask 0x00b8
>         Enhanced Retransmission mode
>         Streaming mode
>         FCS Option
>         Fixed Channels
> < ACL data: handle 12 flags 0x00 dlen 10
>     L2CAP(s): Info req: type 3
> > ACL data: handle 12 flags 0x02 dlen 20
>     L2CAP(s): Info rsp: type 3 result 0
>       Fixed channel list 0x00000002
>         L2CAP Signalling Channel
> < ACL data: handle 12 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
>       Connection pending - Authorization pending
> < ACL data: handle 12 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
>       Connection refused - security block
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 2
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 1
> > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 12 reason 0x13
>     Reason: Remote User Terminated Connection
>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I dealed the last few days with this problem, but I didn't gained any 
new information =(
I really don't know how to fix this problem.
Why can't I create a connection between my two devices?
Please help me, I really don't know what to do.

Regards,
Steffen
