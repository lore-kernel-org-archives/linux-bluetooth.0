Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: regression in sdp lib
Date: Fri, 21 Jun 2013 22:09:47 +0200
Message-ID: <1560638.biMD7yTzvv@athlon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

commit 'lib: Add range check for SDP_SVC_ATTR_RSP/SDP_SVC_SEARCH_ATTR_RSP'
1796f00e846561af broke sdp with Nokia BH217 headset.


As discussed on IRC, sending bluetoothd and monitor logs.

It looks like if response is fragmented size should be verified after all
fragments are received, not for each fragment in separate..

I'm not sure how this should be fixed correctly. Suggestions are welcome.

logs:

bluetoothd[19429]: src/device.c:connect_profiles() /org/bluez/hci0/dev_00_1E_DE_8C_61_7F (all), client :1.45
bluetoothd[19429]: gen_dataseq_pdu: 
bluetoothd[19429]: gen_dataseq_pdu: Seq length : 1
bluetoothd[19429]: gen_dataseq_pdu: Data Seq : 0x(nil)
bluetoothd[19429]: gen_dataseq_pdu: Copying : 5
bluetoothd[19429]: sdp_service_search_attr_async: Data seq added : 5
bluetoothd[19429]: sdp_service_search_attr_async: Max attr byte count : 65535
bluetoothd[19429]: gen_dataseq_pdu: 
bluetoothd[19429]: gen_dataseq_pdu: Seq length : 1
bluetoothd[19429]: gen_dataseq_pdu: Data Seq : 0x(nil)
bluetoothd[19429]: gen_dataseq_pdu: Copying : 7
bluetoothd[19429]: sdp_service_search_attr_async: Attr list length : 7
bluetoothd[19429]: sdp_read_rsp: Waiting for response
bluetoothd[19429]: sdp_process: Attrlist byte count : 53
bluetoothd[19429]: sdp_process: Cstate length : 2
bluetoothd[19429]: src/adapter.c:connected_callback() hci0 device 00:1E:DE:8C:61:7F connected eir_len 14
bluetoothd[19429]: sdp_read_rsp: Waiting for response
bluetoothd[19429]: sdp_process: Attrlist byte count : 54
bluetoothd[19429]: sdp_process: Cstate length : 2
bluetoothd[19429]: sdp_read_rsp: Waiting for response
bluetoothd[19429]: sdp_process: Attrlist byte count : 54
bluetoothd[19429]: sdp_process: Cstate length : 2
bluetoothd[19429]: sdp_read_rsp: Waiting for response
bluetoothd[19429]: sdp_process: Attrlist byte count : 1
bluetoothd[19429]: sdp_process: Protocol error: invalid AttrList size
bluetoothd[19429]: 00:1E:DE:8C:61:7F: error updating services: Protocol error (71)
bluetoothd[19429]: src/adapter.c:dev_disconnected() Device 00:1E:DE:8C:61:7F disconnected, reason 3
bluetoothd[19429]: src/adapter.c:adapter_remove_connection() 
bluetoothd[19429]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:1E:DE:8C:61:7F type 0 status 0xe
bluetoothd[19429]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[19429]: src/device.c:device_bonding_failed() status 14
bluetoothd[19429]: src/adapter.c:resume_discovery() 



< HCI Command: Create Connection (0x01|0x0005) plen 13                                                                     [hci0] 459.100789
        Address: 00:1E:DE:8C:61:7F (OUI 00-1E-DE)
        Packet type: 0xcc18
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                                                                                  [hci0] 459.103284
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                                                                               [hci0] 460.504285
        Status: Success (0x00)
        Handle: 12
        Address: 00:1E:DE:8C:61:7F (OUI 00-1E-DE)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2                                                         [hci0] 460.504433
        Handle: 12
> HCI Event: Command Status (0x0f) plen 4                                                                                  [hci0] 460.507277
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11                                                                 [hci0] 460.559288
        Status: Success (0x00)
        Handle: 12
        Features: 0xbc 0xfe 0x8f 0xfe 0x1b 0xfe 0x79 0x87
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          u-law log synchronous data
          A-law log synchronous data
          CVSD synchronous data
          Paging parameter negotiation
          Power control
          Transparent synchronous data
          Broadcast Encryption
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          EV4 packets
          EV5 packets
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Enhanced Data Rate eSCO 3 Mbps mode
          3-slot Enhanced Data Rate eSCO packets
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3                                                          [hci0] 460.559342
        Handle: 12
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                                                                                  [hci0] 460.562276
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13                                                                  [hci0] 460.565279
        Status: Success (0x00)
        Handle: 12
        Page: 1/1
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10                                                                   [hci0] 460.565323
        Address: 00:1E:DE:8C:61:7F (OUI 00-1E-DE)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
< ACL Data TX: Handle 12 flags 0x00 dlen 10                                                                                [hci0] 460.565334
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> HCI Event: Command Status (0x0f) plen 4                                                                                  [hci0] 460.568276
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 12 flags 0x02 dlen 16                                                                                [hci0] 460.569278
      L2CAP: Information Response (0x0b) ident 1 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x00000200
          Unicast Connectionless Data Reception
< ACL Data TX: Handle 12 flags 0x00 dlen 12                                                                                [hci0] 460.569318
      L2CAP: Connection Request (0x02) ident 2 len 4
        PSM: 1 (0x0001)
        Source CID: 64
> ACL Data RX: Handle 12 flags 0x02 dlen 16                                                                                [hci0] 460.573279
      L2CAP: Connection Response (0x03) ident 2 len 8
        Destination CID: 66
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 12 flags 0x00 dlen 12                                                                                [hci0] 460.573315
      L2CAP: Configure Request (0x04) ident 3 len 4
        Destination CID: 66
        Flags: 0x0000
> ACL Data RX: Handle 12 flags 0x02 dlen 16                                                                                [hci0] 460.574284
      L2CAP: Configure Request (0x04) ident 2 len 8
        Destination CID: 64
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01)
          MTU: 64
< ACL Data TX: Handle 12 flags 0x00 dlen 18                                                                                [hci0] 460.574319
      L2CAP: Configure Response (0x05) ident 2 len 10
        Source CID: 66
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01)
          MTU: 64
> ACL Data RX: Handle 12 flags 0x02 dlen 14                                                                                [hci0] 460.578282
      L2CAP: Configure Response (0x05) ident 3 len 6
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
< ACL Data TX: Handle 12 flags 0x00 dlen 24                                                                                [hci0] 460.578742
      Channel: 66 len 20 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 0 len 15
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 0
> ACL Data RX: Handle 12 flags 0x02 dlen 67                                                                                [hci0] 460.583285
      Channel: 64 len 63 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 0 len 58
        Attribute bytes: 53
        Continuation state: 2
        00 35                                            .5              
< ACL Data TX: Handle 12 flags 0x00 dlen 26                                                                                [hci0] 460.583515
      Channel: 66 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 1 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 35                                            .5              
> HCI Event: Remote Name Req Complete (0x07) plen 255                                                                      [hci0] 460.587272
        Status: Success (0x00)
        Address: 00:1E:DE:8C:61:7F (OUI 00-1E-DE)
        Name: Nokia BH-217
@ Device Connected: 00:1E:DE:8C:61:7F (0) flags 0x0000
        0d 09 4e 6f 6b 69 61 20 42 48 2d 32 31 37        ..Nokia BH-217  
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 460.588275
        Num handles: 1
        Handle: 12
        Count: 2
> ACL Data RX: Handle 12 flags 0x02 dlen 68                                                                                [hci0] 460.588289
      Channel: 64 len 64 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 1 len 59
        Attribute bytes: 54
        Continuation state: 2
        00 6b                                            .k              
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 460.589279
        Num handles: 1
        Handle: 12
        Count: 2
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 460.590278
        Num handles: 1
        Handle: 12
        Count: 2
< ACL Data TX: Handle 12 flags 0x00 dlen 26                                                                                [hci0] 460.630741
      Channel: 66 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 2 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 6b                                            .k              
> ACL Data RX: Handle 12 flags 0x02 dlen 68                                                                                [hci0] 460.636281
      Channel: 64 len 64 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 2 len 59
        Attribute bytes: 54
        Continuation state: 2
        00 a1                                            ..              
< ACL Data TX: Handle 12 flags 0x00 dlen 26                                                                                [hci0] 460.636586
      Channel: 66 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 3 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 a1                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 460.640280
        Num handles: 1
        Handle: 12
        Count: 2
> ACL Data RX: Handle 12 flags 0x02 dlen 13                                                                                [hci0] 460.641280
      Channel: 64 len 9 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 3 len 4
        Attribute bytes: 1
        Continuation state: 0
        Combined attribute bytes: 162
          Attribute list: [len 74] {position 0}
            Attribute: Service Record Handle (0x0000) [len 2]
              0x00010000
            Attribute: Service Class ID List (0x0001) [len 2]
              UUID (3) with 2 bytes [0 extra bits] len 3
                Headset (0x1108)
              UUID (3) with 2 bytes [0 extra bits] len 3
                Generic Audio (0x1203)
            Attribute: Protocol Descriptor List (0x0004) [len 2]
              Sequence (6) with 3 bytes [8 extra bits] len 5
                UUID (3) with 2 bytes [0 extra bits] len 3
                  L2CAP (0x0100)
              Sequence (6) with 5 bytes [8 extra bits] len 7
                UUID (3) with 2 bytes [0 extra bits] len 3
                  RFCOMM (0x0003)
                Unsigned Integer (1) with 1 byte [0 extra bits] len 2
                  0x01
            Attribute: Browse Group List (0x0005) [len 2]
              UUID (3) with 2 bytes [0 extra bits] len 3
                Public Browse Root (0x1002)
            Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
              Sequence (6) with 6 bytes [8 extra bits] len 8
                UUID (3) with 2 bytes [0 extra bits] len 3
                  Headset (0x1108)
                Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                  0x0100
            Attribute: Unknown (0x0100) [len 2]
              HSP service [len 12]
          Attribute list: [len 80] {position 1}
            Attribute: Service Record Handle (0x0000) [len 2]
              0x00010001
            Attribute: Service Class ID List (0x0001) [len 2]
              UUID (3) with 2 bytes [0 extra bits] len 3
                Handsfree (0x111e)
              UUID (3) with 2 bytes [0 extra bits] len 3
                Generic Audio (0x1203)
            Attribute: Protocol Descriptor List (0x0004) [len 2]
              Sequence (6) with 3 bytes [8 extra bits] len 5
                UUID (3) with 2 bytes [0 extra bits] len 3
                  L2CAP (0x0100)
              Sequence (6) with 5 bytes [8 extra bits] len 7
                UUID (3) with 2 bytes [0 extra bits] len 3
                  RFCOMM (0x0003)
                Unsigned Integer (1) with 1 byte [0 extra bits] len 2
                  0x02
            Attribute: Browse Group List (0x0005) [len 2]
              UUID (3) with 2 bytes [0 extra bits] len 3
                Public Browse Root (0x1002)
            Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
              Sequence (6) with 6 bytes [8 extra bits] len 8
                UUID (3) with 2 bytes [0 extra bits] len 3
                  Handsfree (0x111e)
                Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                  0x0105
            Attribute: Unknown (0x0100) [len 2]
              HFP service [len 12]
            Attribute: Unknown (0x0311) [len 2]
              0x001d
< ACL Data TX: Handle 12 flags 0x00 dlen 12                                                                                [hci0] 462.993870
      L2CAP: Disconnection Request (0x06) ident 4 len 4
        Destination CID: 66
        Source CID: 64
> ACL Data RX: Handle 12 flags 0x02 dlen 12                                                                                [hci0] 463.000278
      L2CAP: Disconnection Response (0x07) ident 4 len 4
        Destination CID: 66
        Source CID: 64
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 463.138281
        Num handles: 1
        Handle: 12
        Count: 1
> HCI Event: Disconnect Complete (0x05) plen 4                                                                             [hci0] 464.777286
        Status: Success (0x00)
        Handle: 12
        Reason: Remote User Terminated Connection (0x13)
@ Device Disconnected: 00:1E:DE:8C:61:7F (0) reason 3



-- 
Szymon K. Janc
szymon.janc@gmail.com
