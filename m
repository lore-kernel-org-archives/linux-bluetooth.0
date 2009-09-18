Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Sep 2009 12:46:46 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: BNEP problem, hardware dependent?
Message-ID: <20090918124646.6722c00f@strolchi.home.s3e.de>
In-Reply-To: <20090918120755.3ef94e40@strolchi.home.s3e.de>
References: <20090916181902.52bf7e99@strolchi.home.s3e.de>
	<2d5a2c100909161148h7d15ebf2g1fecc84e670480f7@mail.gmail.com>
	<20090918120755.3ef94e40@strolchi.home.s3e.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/7MMzr_Pre4hz7ly9g2CbNp6"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--MP_/7MMzr_Pre4hz7ly9g2CbNp6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 18 Sep 2009 12:07:55 +0200
Stefan Seyfried <stefan.seyfried@googlemail.com> wrote:

> Will do so, too, if I can make it fail again.

Was pretty easy ;), with an el-cheapo dongle:

strolchi:~ # hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:72:C3:4C:58 ACL MTU: 377:10 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:7145 acl:43 sco:0 events:179 errors:0
        TX bytes:1390 acl:35 sco:0 commands:108 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Broadcom BCM2035'
        Class: 0x4a010c
        Service Classes: Networking, Capturing, Telephony
        Device Class: Computer, Laptop
        HCI Ver: 1.2 (0x2) HCI Rev: 0xa LMP Ver: 1.2 (0x2) LMP Subver: 0x309
        Manufacturer: Broadcom Corporation (15)

I attached bluetoothd.log (bluetoothd -nd) and hcidump.log
(hcidump -XVt) because of their size.

JFTR: it works fine with the built-in adapter:

strolchi:~ # hciconfig -a
hci0:   Type: USB
        BD Address: 00:16:41:25:5F:C3 ACL MTU: 1017:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:2597 acl:19 sco:0 events:50 errors:0
        TX bytes:2016 acl:18 sco:0 commands:32 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'strolchi-builtin'
        Class: 0x4a010c
        Service Classes: Networking, Capturing, Telephony
        Device Class: Computer, Laptop
        HCI Ver: 2.0 (0x3) HCI Rev: 0x204a LMP Ver: 2.0 (0x3) LMP Subver: 0x4127
        Manufacturer: Broadcom Corporation (15)


The ACL MTU is bigger on the built in dongle, but I am quite sure that
I did not set anything, it's all plain plug-and-play.

lsusb shows the following for the two dongles:
Bus 002 Device 004: ID 0a5c:200a Broadcom Corp. Bluetooth dongle
Bus 004 Device 019: ID 03f0:171d Hewlett-Packard Wireless (Bluetooth + WLAN) Interface [Integrated Module]

The HP is the one that works.

Thanks,

	seife
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
--MP_/7MMzr_Pre4hz7ly9g2CbNp6
Content-Type: text/x-log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=hcidump.log

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
2009-09-18 12:35:13.427129 < HCI Command: Set Event Mask (0x03|0x0001) plen 8
    Mask: 0xffffffffff1f0000
2009-09-18 12:35:13.467678 > HCI Event: Command Complete (0x0e) plen 4
    Set Event Mask (0x03|0x0001) ncmd 1
    status 0x00
2009-09-18 12:35:13.467744 < HCI Command: Exit Periodic Inquiry Mode (0x01|0x0004) plen 0
2009-09-18 12:35:13.508679 > HCI Event: Command Complete (0x0e) plen 4
    Exit Periodic Inquiry Mode (0x01|0x0004) ncmd 1
    status 0x0c
    Error: Command Disallowed
2009-09-18 12:35:13.508763 < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
    enable 2
2009-09-18 12:35:13.548654 > HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    status 0x00
2009-09-18 12:35:13.548701 < HCI Command: Write Class of Device (0x03|0x0024) plen 3
    class 0x4a0000
2009-09-18 12:35:13.589652 > HCI Event: Command Complete (0x0e) plen 4
    Write Class of Device (0x03|0x0024) ncmd 1
    status 0x00
2009-09-18 12:35:13.589705 < HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:24:EF:D1:B3:23 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
2009-09-18 12:35:13.639632 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2009-09-18 12:35:13.639689 < HCI Command: Read Scan Enable (0x03|0x0019) plen 0
2009-09-18 12:35:13.678629 > HCI Event: Command Complete (0x0e) plen 5
    Read Scan Enable (0x03|0x0019) ncmd 1
    status 0x00 enable 2
2009-09-18 12:35:13.722101 < HCI Command: Write Class of Device (0x03|0x0024) plen 3
    class 0x4a010c
2009-09-18 12:35:13.761609 > HCI Event: Command Complete (0x0e) plen 4
    Write Class of Device (0x03|0x0024) ncmd 1
    status 0x00
2009-09-18 12:35:16.743861 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:24:EF:D1:B3:23 type ACL encrypt 0x00
2009-09-18 12:35:16.743932 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 6
2009-09-18 12:35:16.783839 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2009-09-18 12:35:16.800560 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:24:EF:D1:B3:23 mode 2 clkoffset 0x0000
2009-09-18 12:35:16.839837 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2009-09-18 12:35:16.845827 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5
2009-09-18 12:35:16.851823 > HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 6
    Features: 0xbf 0xec 0x8d 0xfe 0x98 0x29 0x00 0x00
2009-09-18 12:35:16.851876 < ACL data: handle 6 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2009-09-18 12:35:16.888810 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:24:EF:D1:B3:23 name 'seife C510'
2009-09-18 12:35:16.890814 > ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
2009-09-18 12:35:16.890864 < ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040
2009-09-18 12:35:16.898812 > ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
2009-09-18 12:35:16.902811 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 2
2009-09-18 12:35:17.066773 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:24:EF:D1:B3:23
2009-09-18 12:35:17.067296 < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:24:EF:D1:B3:23 key 5CC0FCC321442D4F946146D5F7B8EF6C
2009-09-18 12:35:17.071766 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:24:EF:D1:B3:23
2009-09-18 12:35:17.157756 > HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 6 encrypt 0x01
2009-09-18 12:35:17.158745 > ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0054 scid 0x0040 result 0 status 0
      Connection successful
2009-09-18 12:35:17.158794 < ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0054 flags 0x00 clen 4
      MTU 1691 
2009-09-18 12:35:17.160743 > ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1691 
2009-09-18 12:35:17.160787 < ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0054 flags 0x00 result 0 clen 4
      MTU 1691 
2009-09-18 12:35:17.166744 > ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 1691 
2009-09-18 12:35:17.166991 < ACL data: handle 6 flags 0x02 dlen 11
    L2CAP(d): cid 0x0054 len 7 [psm 15]
      BNEP: Control(0x01|0)
        Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)
2009-09-18 12:35:17.179746 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 3
2009-09-18 12:35:17.184740 > HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 6 encrypt 0x00
2009-09-18 12:35:17.260728 > HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 6 encrypt 0x01
2009-09-18 12:35:17.263719 > ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Setup Rsp(0x02) res 0x0004
2009-09-18 12:35:17.264739 > ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0054
2009-09-18 12:35:17.264793 < ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0054
2009-09-18 12:35:17.274723 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
2009-09-18 12:35:19.261009 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 6 reason 0x13
    Reason: Remote User Terminated Connection
2009-09-18 12:35:19.265209 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2009-09-18 12:35:19.344202 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x16
    Reason: Connection Terminated by Local Host

--MP_/7MMzr_Pre4hz7ly9g2CbNp6
Content-Type: text/x-log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=bluetoothd.log

bluetoothd[28364]: Bluetooth daemon 4.51
bluetoothd[28364]: Enabling debug information
bluetoothd[28364]: parsing main.conf
bluetoothd[28364]: discovto=0
bluetoothd[28364]: pairto=0
bluetoothd[28364]: pageto=8192
bluetoothd[28364]: name=%h-%d
bluetoothd[28364]: class=0x000100
bluetoothd[28364]: discov_interval=0
bluetoothd[28364]: Key file does not have key 'DeviceID'
bluetoothd[28364]: Starting SDP server
bluetoothd[28364]: Loading builtin plugins
bluetoothd[28364]: Loading audio plugin
bluetoothd[28364]: Loading input plugin
bluetoothd[28364]: Loading serial plugin
bluetoothd[28364]: Loading network plugin
bluetoothd[28364]: Loading service plugin
bluetoothd[28364]: Loading hciops plugin
bluetoothd[28364]: Loading hal plugin
bluetoothd[28364]: Loading storage plugin
bluetoothd[28364]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[28364]: Can't load plugin /usr/lib/bluetooth/plugins/netlink.so: /usr/lib/bluetooth/plugins/netlink.so: undefined symbol: debug
bluetoothd[28364]: register_interface: path /org/bluez/28364/any
bluetoothd[28364]: Registered interface org.bluez.Service on path /org/bluez/28364/any
bluetoothd[28364]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
bluetoothd[28364]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[28364]: bridge pan0 created
bluetoothd[28364]: Parsing /etc/bluetooth/input.conf failed: No such file or directory
bluetoothd[28364]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[28364]: Unix socket created: 9
bluetoothd[28364]: Telephony plugin initialized
bluetoothd[28364]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[28364]: HCI dev 0 registered
bluetoothd[28364]: child 28369 forked
bluetoothd[28369]: Can't set link policy on hci0: Operation not supported (95)
bluetoothd[28364]: btd_adapter_ref(0xb80740d0): ref=1
bluetoothd[28364]: HCI dev 0 up
bluetoothd[28364]: Starting security manager 0
bluetoothd[28364]: Stopping Inquiry at adapter startup
bluetoothd[28364]: register_interface: path /org/bluez/28364/hci0
bluetoothd[28364]: Registered interface org.bluez.Service on path /org/bluez/28364/hci0
bluetoothd[28364]: network_server_probe: path /org/bluez/28364/hci0
bluetoothd[28364]: btd_adapter_ref(0xb80740d0): ref=2
bluetoothd[28364]: Adding record with handle 0x10000
bluetoothd[28364]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[28364]: register_server_record: got record id 0x10000
bluetoothd[28364]: Registered interface org.bluez.NetworkPeer on path /org/bluez/28364/hci0
bluetoothd[28364]: network_server_probe: path /org/bluez/28364/hci0
bluetoothd[28364]: Adding record with handle 0x10001
bluetoothd[28364]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[28364]: register_server_record: got record id 0x10001
bluetoothd[28364]: Registered interface org.bluez.NetworkHub on path /org/bluez/28364/hci0
bluetoothd[28364]: network_server_probe: path /org/bluez/28364/hci0
bluetoothd[28364]: Adding record with handle 0x10002
bluetoothd[28364]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[28364]: register_server_record: got record id 0x10002
bluetoothd[28364]: Registered interface org.bluez.NetworkRouter on path /org/bluez/28364/hci0
bluetoothd[28364]: proxy_probe: path /org/bluez/28364/hci0
bluetoothd[28364]: btd_adapter_ref(0xb80740d0): ref=3
bluetoothd[28364]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/28364/hci0
bluetoothd[28364]: Parsing /etc/bluetooth/serial.conf failed: No such file or directory
bluetoothd[28364]: btd_adapter_ref(0xb80740d0): ref=4
bluetoothd[28364]: headset_server_probe: path /org/bluez/28364/hci0
bluetoothd[28364]: btd_adapter_ref(0xb80740d0): ref=5
bluetoothd[28364]: audio_adapter_ref(0xb806cf90): ref=1
bluetoothd[28364]: Adding record with handle 0x10003
bluetoothd[28364]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[28364]: Adding record with handle 0x10004
bluetoothd[28364]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[28364]: a2dp_server_probe: path /org/bluez/28364/hci0
bluetoothd[28364]: audio_adapter_ref(0xb806cf90): ref=2
bluetoothd[28364]: SEP 0xb806e198 registered: type:0 codec:0 seid:1
bluetoothd[28364]: Adding record with handle 0x10005
bluetoothd[28364]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[28364]: avrcp_server_probe: path /org/bluez/28364/hci0
bluetoothd[28364]: audio_adapter_ref(0xb806cf90): ref=3
bluetoothd[28364]: Adding record with handle 0x10006
bluetoothd[28364]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[28364]: Adding record with handle 0x10007
bluetoothd[28364]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[28364]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[28364]: Creating device /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[28364]: btd_device_ref(0xb806f830): ref=1
bluetoothd[28364]: Probe drivers for /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[28364]: network_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[28364]: btd_device_ref(0xb806f830): ref=2
bluetoothd[28364]: Registered interface org.bluez.Network on path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[28364]: network_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[28364]: serial_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23: 00000002-0000-1000-8000-0002ee000002
bluetoothd[28364]: Registered interface org.bluez.Serial on path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[28364]: serial_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23: 00001101-0000-1000-8000-00805f9b34fb
bluetoothd[28364]: serial_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23: 00001103-0000-1000-8000-00805f9b34fb
bluetoothd[28364]: serial_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23: 00001104-0000-1000-8000-00805f9b34fb
bluetoothd[28364]: serial_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23: 00001105-0000-1000-8000-00805f9b34fb
bluetoothd[28364]: serial_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23: 00001106-0000-1000-8000-00805f9b34fb
bluetoothd[28364]: serial_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23: 00001112-0000-1000-8000-00805f9b34fb
bluetoothd[28364]: serial_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23: 0000111f-0000-1000-8000-00805f9b34fb
bluetoothd[28364]: serial_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23: 0000112f-0000-1000-8000-00805f9b34fb
bluetoothd[28364]: serial_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23: 8e771401-0000-1000-8000-00805f9b34fb
bluetoothd[28364]: hid_device_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[28364]: btd_device_ref(0xb806f830): ref=3
bluetoothd[28364]: Registered interface org.bluez.Input on path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[28364]: headset_probe: path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[28364]: probe failed with driver input-headset for device /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[28364]: adapter_get_device(00:24:EF:D1:B3:23)
bluetoothd[28364]: btd_device_ref(0xb806f830): ref=4
bluetoothd[28364]: Registered interface org.bluez.Audio on path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[28364]: audio handle_uuid: server not enabled for 00001112-0000-1000-8000-00805f9b34fb (0x1112)
bluetoothd[28364]: audio handle_uuid: server not enabled for 0000111f-0000-1000-8000-00805f9b34fb (0x111f)
bluetoothd[28364]: audio handle_uuid: server not enabled for 0000110a-0000-1000-8000-00805f9b34fb (0x110a)
bluetoothd[28364]: Found AV Target
bluetoothd[28364]: Registered interface org.bluez.Control on path /org/bluez/28364/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[28364]: Found AV Remote
bluetoothd[28364]: Adapter /org/bluez/28364/hci0 has been enabled
bluetoothd[28364]: Entering main loop
bluetoothd[28364]: child 28369 exited
bluetoothd[28364]: RFKILL event idx 1 type 1 op 0 soft 0 hard 0
bluetoothd[28364]: RFKILL event idx 12 type 2 op 0 soft 0 hard 0
bluetoothd[28364]: Computer is classified as laptop
bluetoothd[28364]: Setting 0x00010c for major/minor device class
bluetoothd[28364]: RFKILL event idx 21 type 2 op 0 soft 0 hard 0
bluetoothd[28364]: Agent registered for hci0 at :1.2719:/org/bluez/agent/hci0
bluetoothd[28364]: Inquiry Failed with status 0x0c
bluetoothd[28364]: adapter_get_device(00:24:EF:D1:B3:23)
bluetoothd[28364]: link_key_request (sba=00:02:72:C3:4C:58, dba=00:24:EF:D1:B3:23)
bluetoothd[28364]: kernel auth requirements = 0x00
bluetoothd[28364]: stored link key type = 0x00
bluetoothd[28364]: bnep failed

--MP_/7MMzr_Pre4hz7ly9g2CbNp6--
