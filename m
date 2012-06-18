Return-Path: <cyrus@holtmann.org>
Message-ID: <1340030149.22602.1.camel@sirocco.config>
Subject: Re: Broken bluez master
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 18 Jun 2012 16:35:49 +0200
In-Reply-To: <CABBYNZ+AkCc_1+dvi6HEKVA_5hhvVUB0wydbGgDdiKS5Yr+3Ag@mail.gmail.com>
References: <1339886587.20079.2.camel@sirocco.config>
	 <CABBYNZ+AkCc_1+dvi6HEKVA_5hhvVUB0wydbGgDdiKS5Yr+3Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Em Mon, 2012-06-18 às 11:30 +0300, Luiz Augusto von Dentz escreveu:

kernel-3.4.0-1.fc17.x86_64
bluez master

bluetoothd log:
# Pressing BD Remote once
bluetoothd[22655]: input/server.c:connect_event_cb() Incoming connection from 00:19:C1:55:51:A9 on PSM 17
bluetoothd[22655]: input: authorization for 04:0C:CE:D6:09:B7 failed: Transport endpoint is not connected (-107)
bluetoothd[22655]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[22655]: plugins/mgmtops.c:mgmt_event() Received 43 bytes from management socket
bluetoothd[22655]: plugins/mgmtops.c:mgmt_device_connected() hci0 device 00:19:C1:55:51:A9 connected eir_len 24
bluetoothd[22655]: src/adapter.c:adapter_get_device() 00:19:C1:55:51:A9
bluetoothd[22655]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[22655]: plugins/mgmtops.c:mgmt_event() Received 13 bytes from management socket
bluetoothd[22655]: plugins/mgmtops.c:mgmt_device_disconnected() hci0 device 00:19:C1:55:51:A9 disconnected
bluetoothd[22655]: src/event.c:btd_event_disconn_complete() 
bluetoothd[22655]: src/adapter.c:adapter_remove_connection() 

# Second button press
bluetoothd[22655]: input/server.c:connect_event_cb() Incoming connection from 00:19:C1:55:51:A9 on PSM 17
bluetoothd[22655]: Refusing input device connect: Operation already in progress (114)
bluetoothd[22655]: input: authorization for 04:0C:CE:D6:09:B7 failed: Transport endpoint is not connected (-107)

(bluetoothd:22655): GLib-WARNING **: Invalid file descriptor.

bluetoothd[22655]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[22655]: plugins/mgmtops.c:mgmt_event() Received 43 bytes from management socket
bluetoothd[22655]: plugins/mgmtops.c:mgmt_device_connected() hci0 device 00:19:C1:55:51:A9 connected eir_len 24
bluetoothd[22655]: src/adapter.c:adapter_get_device() 00:19:C1:55:51:A9
bluetoothd[22655]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[22655]: plugins/mgmtops.c:mgmt_event() Received 13 bytes from management socket
bluetoothd[22655]: plugins/mgmtops.c:mgmt_device_disconnected() hci0 device 00:19:C1:55:51:A9 disconnected
bluetoothd[22655]: src/event.c:btd_event_disconn_complete() 
bluetoothd[22655]: src/adapter.c:adapter_remove_connection() 

And hcidump -X of the same:
HCI sniffer - Bluetooth packet analyzer ver 2.2
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
# First button press
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:19:C1:55:51:A9 class 0x00250c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:19:C1:55:51:A9 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:19:C1:55:51:A9 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 00:19:C1:55:51:A9 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:19:C1:55:51:A9 mode 2 clkoffset 0x0000
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0052
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0052 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 12 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0004
        Bi-directional QoS
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0052 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0052 flags 0x00 clen 0
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 185 
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0052 flags 0x00 result 0 clen 4
      MTU 185 
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 185 
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0053
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0053 result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0052 scid 0x0040
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0053 result 3 status 0
      Connection refused - security block
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0052 scid 0x0040
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:19:C1:55:51:A9 name 'BD Remote Control'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x13
    Reason: Remote User Terminated Connection

# 2nd button press
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:19:C1:55:51:A9 class 0x00250c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:19:C1:55:51:A9 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:19:C1:55:51:A9 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 11 bdaddr 00:19:C1:55:51:A9 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 11
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0054
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0054 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 11 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 11
    Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:19:C1:55:51:A9 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0004
        Bi-directional QoS
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0054 result 0 status 0
      Connection successful
< ACL data: handle 11 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0054 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 185 
< ACL data: handle 11 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0054 flags 0x00 result 0 clen 4
      MTU 185 
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 185 
< ACL data: handle 11 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0054 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0055
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0055 result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0055 result 3 status 0
      Connection refused - security block
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0054 scid 0x0040
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:19:C1:55:51:A9 name 'BD Remote Control'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x13
    Reason: Remote User Terminated Connection


