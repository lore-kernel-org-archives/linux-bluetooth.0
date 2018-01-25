Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: David Wiberg <dwiberg@gmail.com>
Date: Thu, 25 Jan 2018 18:08:27 +0100
Message-ID: <CACXFvW2fOcYsJA1xV2QctbRUGCv0aLQ=PUbZ7icSq_KPjvaawg@mail.gmail.com>
Subject: Potential ATT_MTU problem when changing device
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

I'm running a BlueZ based GATT server where I encounter issues when I
switch clients. From looking at logs it seems like the issue is
related to ATT_MTU value. The scenario looks like this:
1a. Client A connects and sends an Exchange MTU Request which
increases ATT_MTU from the default.
1b. Client A reads/writes some data.
1c. Client A disconnects.
2a. Client B connects.
2b. Client B performs a service discovery.
2c. Service discovery reaches a point where BlueZ sends an attribute
list of length 8 (frame length 67 bytes)
3. Communication seem to stop.

I have taken a log of this (see below). The bluetoothd version used
while taking the log is 5.41. I have tried running 5.48 manually but
didn't notice any difference with regards to this.

While trying to understand the issue I noticed that BlueZ 5.42
Changelog mentioned "Fix issue with setting correct ATT default MTU
value" which tracks back to a mailing list post
(https://marc.info/?l=linux-bluetooth&m=147346392907270&w=4) which
seem similar to my scenario. The main difference I have seen is that
Client B doesn't perform the Exchange MTU procedure.

Does the above analysis seem correct or is there something else which
I might have missed?

I'm a Bluetooth/BlueZ beginner so any pointers are appreciated.

Bonus question: How can I enable the DBG prints for all modules when
running bluetoothd? It seems like I only get output from some of the
modules (e.g. adapter.c and device.c) but not from others (e.g.
nothing related to attributes).

Best regards
David

> HCI Event: LE Meta Event (0x3e) plen 19                #91 [hci0] 64.236586
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 68
        Role: Slave (0x01)
        Peer address type: Random (0x01)
        Peer address: 65:53:B3:01:FD:CD (Resolvable)
        Connection interval: 30.00 msec (0x0018)
        Connection latency: 0 (0x0000)
        Supervision timeout: 720 msec (0x0048)
        Master clock accuracy: 0x01
< ACL Data TX: Handle 68 flags 0x00 dlen 16              #92 [hci0] 64.237218
      LE L2CAP: Connection Parameter Update Request (0x12) ident 1 len 8
        Min interval: 40
        Max interval: 56
        Slave latency: 0
        Timeout multiplier: 72
@ Device Connected: 65:53:B3:01:FD:CD (2) flags 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5   #93 [hci0] 64.295626
        Num handles: 1
        Handle: 68
        Count: 1
> ACL Data RX: Handle 68 flags 0x02 dlen 10              #94 [hci0] 64.354593
      LE L2CAP: Connection Parameter Update Response (0x13) ident 1 len 2
        Result: Connection Parameters accepted (0x0000)
> ACL Data RX: Handle 68 flags 0x02 dlen 11              #95 [hci0] 64.354626
      Channel: 58 len 7 [PSM 0 mode 0] {chan 0}
        09 05 02 00 00 00 00                             .......
> ACL Data RX: Handle 68 flags 0x02 dlen 7               #96 [hci0] 64.355618
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 185
< ACL Data TX: Handle 68 flags 0x00 dlen 7               #97 [hci0] 64.358074
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 512
> HCI Event: Number of Completed Packets (0x13) plen 5   #98 [hci0] 64.415589
        Num handles: 1
        Handle: 68
        Count: 1
> ACL Data RX: Handle 68 flags 0x02 dlen 9               #99 [hci0] 64.474611
      ATT: Write Request (0x12) len 4
        Handle: 0x0019
          Data: 0100
< ACL Data TX: Handle 68 flags 0x00 dlen 5              #100 [hci0] 64.476344
      ATT: Write Response (0x13) len 0
> HCI Event: LE Meta Event (0x3e) plen 10               #101 [hci0] 64.503634
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 68
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0 (0x0000)
        Supervision timeout: 720 msec (0x0048)
> HCI Event: Number of Completed Packets (0x13) plen 5  #102 [hci0] 64.621620
        Num handles: 1
        Handle: 68
        Count: 1
> ACL Data RX: Handle 68 flags 0x02 dlen 11             #103 [hci0] 64.621680
      ATT: Write Request (0x12) len 6
        Handle: 0x0015
          Data: 01000000
< ACL Data TX: Handle 68 flags 0x00 dlen 5              #104 [hci0] 64.623772
      ATT: Write Response (0x13) len 0
> HCI Event: Number of Completed Packets (0x13) plen 5  #105 [hci0] 64.757590
        Num handles: 1
        Handle: 68
        Count: 1

--- Removed attribute read/writes to shorten log ---

> HCI Event: Disconnect Complete (0x05) plen 4          #126 [hci0] 71.049061
        Status: Success (0x00)
        Handle: 68
        Reason: Remote User Terminated Connection (0x13)
@ Device Disconnected: 65:53:B3:01:FD:CD (2) reason 3
< HCI Command: LE Set Advertise.. (0x08|0x000a) plen 1  #127 [hci0] 71.119671
        Advertising: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4             #128 [hci0] 71.121102
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set Advertis.. (0x08|0x0006) plen 15  #129 [hci0] 71.131389
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Type: Connectable undirected - ADV_IND (0x00)
        Own address type: Public (0x00)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect
Request from Any (0x00)
> HCI Event: Command Complete (0x0e) plen 4             #130 [hci0] 71.134074
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertis.. (0x08|0x0008) plen 32  #131 [hci0] 71.137597
        Length: 24
        Flags: 0x04
          BR/EDR Not Supported
        Name (complete): Test
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0x0021)
        Company: not assigned (4660)
          Data: 416c6f
> HCI Event: Command Complete (0x0e) plen 4             #132 [hci0] 71.139030
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Res.. (0x08|0x0009) plen 32  #133 [hci0] 71.142651
        Length: 21
        Name (complete): Test
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0x0021)
        Company: not assigned (4660)
          Data: 416c6f
> HCI Event: Command Complete (0x0e) plen 4             #134 [hci0] 71.144036
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertise.. (0x08|0x000a) plen 1  #135 [hci0] 71.147908
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4             #136 [hci0] 71.149048
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19               #137 [hci0] 81.950054
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 67
        Role: Slave (0x01)
        Peer address type: Random (0x01)
        Peer address: 61:3E:20:FF:B9:06 (Resolvable)
        Connection interval: 48.75 msec (0x0027)
        Connection latency: 0 (0x0000)
        Supervision timeout: 20000 msec (0x07d0)
        Master clock accuracy: 0x05
< ACL Data TX: Handle 67 flags 0x00 dlen 16             #138 [hci0] 81.950691
      LE L2CAP: Connection Parameter Update Request (0x12) ident 1 len 8
        Min interval: 40
        Max interval: 56
        Slave latency: 0
        Timeout multiplier: 2000
@ Device Connected: 61:3E:20:FF:B9:06 (2) flags 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5  #139 [hci0] 82.021113
        Num handles: 1
        Handle: 67
        Count: 1
> ACL Data RX: Handle 67 flags 0x02 dlen 10             #140 [hci0] 82.117028
      LE L2CAP: Connection Parameter Update Response (0x13) ident 1 len 2
        Result: Connection Parameters accepted (0x0000)
> ACL Data RX: Handle 67 flags 0x02 dlen 11             #141 [hci0] 82.118034
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 67 flags 0x00 dlen 24             #142 [hci0] 82.121124
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0012
        UUID: Unknown (0x0021)
        Handle range: 0x0013-0x001d
        UUID: Unknown (0x0031)
        Handle range: 0x001e-0x0028
        UUID: Unknown (0x0041)
> HCI Event: Number of Completed Packets (0x13) plen 5  #143 [hci0] 82.214067
        Num handles: 1
        Handle: 67
        Count: 1
> ACL Data RX: Handle 67 flags 0x02 dlen 11             #144 [hci0] 82.214125
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0029-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 67 flags 0x00 dlen 9              #145 [hci0] 82.216360
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0029
        Error: Attribute Not Found (0x0a)
> HCI Event: Number of Completed Packets (0x13) plen 5  #146 [hci0] 82.312064
        Num handles: 1
        Handle: 67
        Count: 1
> ACL Data RX: Handle 67 flags 0x02 dlen 11             #147 [hci0] 82.312126
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0012
        Attribute type: Include (0x2802)
< ACL Data TX: Handle 67 flags 0x00 dlen 9              #148 [hci0] 82.314294
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
> HCI Event: Number of Completed Packets (0x13) plen 5  #149 [hci0] 82.409066
        Num handles: 1
        Handle: 67
        Count: 1
> ACL Data RX: Handle 67 flags 0x02 dlen 11             #150 [hci0] 82.409126
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0012
        Attribute type: Characteristic (0x2803)
< ACL Data TX: Handle 67 flags 0x00 dlen 62             #151 [hci0] 82.411378
      ATT: Read By Type Response (0x09) len 57
        Attribute data length: 7
        Attribute data list: 8 entries
        Handle: 0x0002
        Value: 0a03002200
        Handle: 0x0004
        Value: 1a05002300
        Handle: 0x0007
        Value: 020800002a
        Handle: 0x0009
        Value: 020a002700
        Handle: 0x000b
        Value: 020c002800
        Handle: 0x000d
        Value: 0a0e002a00
        Handle: 0x000f
        Value: 021000282a
        Handle: 0x0011
        Value: 021200272a
> HCI Event: LE Meta Event (0x3e) plen 10               #152 [hci0] 82.458061
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 67
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0 (0x0000)
        Supervision timeout: 20000 msec (0x07d0)
> HCI Event: Number of Completed Packets (0x13) plen 5  #153 [hci0] 82.546065
        Num handles: 1
        Handle: 67
        Count: 1
> HCI Event: Disconnect Complete (0x05) plen 4         #154 [hci0] 123.181063
        Status: Success (0x00)
        Handle: 67
        Reason: Remote User Terminated Connection (0x13)
@ Device Disconnected: 61:3E:20:FF:B9:06 (2) reason 3
