Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Simon Schubert <2@0x2c.org>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Schubert <2@0x2c.org>
Subject: [PATCH BlueZ 0/1] input/hog: set notify bit for paired peripherals
Date: Wed, 25 Jul 2018 16:07:27 -0400
Message-Id: <20180725200728.11835-1-2@0x2c.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

My Microsoft Bluetooth Mobile Mouse 3600 only works on the first
connection after starting bluetoothd, or on the first connection when
pairing as a new device.  The mouse pointer/buttons will not work when
switching the mouse off and on again without restarting bluetoothd.

I've tracked this down to the mouse forgetting the CCC (notify bit)
state across disconnects.

For now, the solution I could come up with is to run the same CCC read
& set notify bit procedure that happens on the first connection to a
device.


btmon logs before and after patch

For the already paired and trusted mouse, this is a btmon log of
unpatched hog-lib when switching the mouse on and off (note the lack
of notify data on handle 0x0016):

Bluetooth monitor ver 5.49
= Note: Linux version 4.17.8-1-ARCH (x86_64)                           0.082300
= Note: Bluetooth subsystem version 2.22                               0.082302
= New Index: 00:28:F8:25:AA:34 (Primary,USB,hci0)               [hci0] 0.082303
= Open Index: 00:28:F8:25:AA:34                                 [hci0] 0.082304
= Index Info: 00:28:F8:25:AA:34 (Intel Corp.)                   [hci0] 0.082305
@ MGMT Open: bluetoothd (privileged) version 1.14             {0x0001} 0.082306
@ MGMT Open: btmon (privileged) version 1.14                  {0x0002} 0.082323
> HCI Event: LE Meta Event (0x3e) plen 12                    #1 [hci0] 4.307405
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable directed - ADV_DIRECT_IND (0x01)
        Address type: Random (0x01)
        Address: E1:F3:0C:DC:CD:85 (Static)
        Data length: 0
        RSSI: -45 dBm (0xd3)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2       #2 [hci0] 4.307482
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                  #3 [hci0] 4.312398
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25    #4 [hci0] 4.312502
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: E1:F3:0C:DC:CD:85 (Static)
        Own address type: Public (0x00)
        Min connection interval: 7.50 msec (0x0006)
        Max connection interval: 7.50 msec (0x0006)
        Connection latency: 60 (0x003c)
        Supervision timeout: 3000 msec (0x012c)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                    #5 [hci0] 4.313386
      LE Create Connection (0x08|0x000d) ncmd 2
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                    #6 [hci0] 4.320542
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 3585
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: E1:F3:0C:DC:CD:85 (Static)
        Connection interval: 7.50 msec (0x0006)
        Connection latency: 60 (0x003c)
        Supervision timeout: 3000 msec (0x012c)
        Master clock accuracy: 0x00
@ MGMT Event: Device Connected (0x000b) plen 13        {0x0002} [hci0] 4.320632
        LE Address: E1:F3:0C:DC:CD:85 (Static)
        Flags: 0x00000000
        Data length: 0
@ MGMT Event: Device Connected (0x000b) plen 13        {0x0001} [hci0] 4.320632
        LE Address: E1:F3:0C:DC:CD:85 (Static)
        Flags: 0x00000000
        Data length: 0
< HCI Command: LE Read Remote Used F.. (0x08|0x0016) plen 2  #7 [hci0] 4.320801
        Handle: 3585
> HCI Event: Command Status (0x0f) plen 4                    #8 [hci0] 4.321409
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 12                    #9 [hci0] 4.330401
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 3585
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28    #10 [hci0] 4.330607
        Handle: 3585
        Random number: 0x5434e71113742647
        Encrypted diversifier: 0x6f4c
        Long term key: ca7a1e3cacd797c1edcad7efe07d692d
> HCI Event: Command Status (0x0f) plen 4                   #11 [hci0] 4.331387
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Encryption Change (0x08) plen 4                #12 [hci0] 4.404539
        Status: Success (0x00)
        Handle: 3585
        Encryption: Enabled with AES-CCM (0x01)
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #13 [hci0] 4.404739
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5      #14 [hci0] 4.412444
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 7                #15 [hci0] 4.419288
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 23
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #16 [hci0] 4.419595
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003
> HCI Event: Number of Completed Packets (0x13) plen 5      #17 [hci0] 4.427451
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 23               #18 [hci0] 4.434579
      ATT: Read Response (0x0b) len 18
        Value: 426c7565746f6f74684d6f75736533363030
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #19 [hci0] 4.434904
      ATT: Read Request (0x0a) len 2
        Handle: 0x0005
> HCI Event: Number of Completed Packets (0x13) plen 5      #20 [hci0] 4.442595
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 7                #21 [hci0] 4.449289
      ATT: Read Response (0x0b) len 2
        Value: c203
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #22 [hci0] 4.449513
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5      #23 [hci0] 4.457413
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 12               #24 [hci0] 4.464450
      ATT: Read Response (0x0b) len 7
        Value: 025e0416090001
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #25 [hci0] 4.464686
      ATT: Read Request (0x0a) len 2
        Handle: 0x0010
> HCI Event: Number of Completed Packets (0x13) plen 5      #26 [hci0] 4.472454
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 6                #27 [hci0] 4.479219
      ATT: Read Response (0x0b) len 1
        Value: 64
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #28 [hci0] 4.479458
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5      #29 [hci0] 4.487449
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 12               #30 [hci0] 4.494295
      ATT: Read Response (0x0b) len 7
        Value: 025e0416090001
< ACL Data TX: Handle 3585 flags 0x00 dlen 11               #31 [hci0] 4.494588
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5      #32 [hci0] 4.502592
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 24               #33 [hci0] 4.509431
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0007
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0008-0x0008
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0009-0x000d
        UUID: Device Information (0x180a)
< ACL Data TX: Handle 3585 flags 0x00 dlen 9                #34 [hci0] 4.509695
      ATT: Write Request (0x12) len 4
        Handle: 0x0011
          Data: 0100
> HCI Event: Number of Completed Packets (0x13) plen 5      #35 [hci0] 4.517440
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 5                #36 [hci0] 4.524394
      ATT: Write Response (0x13) len 0
< ACL Data TX: Handle 3585 flags 0x00 dlen 11               #37 [hci0] 4.524717
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000e-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5      #38 [hci0] 4.532413
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 18               #39 [hci0] 4.539364
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x000e-0x0011
        UUID: Battery Service (0x180f)
        Handle range: 0x0012-0xffff
        UUID: Human Interface Device (0x1812)
> ACL Data RX: Handle 3585 flags 0x02 dlen 8                #40 [hci0] 7.289940
      ATT: Handle Value Notification (0x1b) len 3
        Handle: 0x0010
          Data: 64
> HCI Event: Disconnect Complete (0x05) plen 4             #41 [hci0] 21.166456
        Status: Success (0x00)
        Handle: 3585
        Reason: Remote User Terminated Connection (0x13)
@ MGMT Event: Device Disconnected (0x000c) plen 8     {0x0002} [hci0] 21.166522
        LE Address: E1:F3:0C:DC:CD:85 (Static)
        Reason: Connection terminated by remote host (0x03)
@ MGMT Event: Device Disconnected (0x000c) plen 8     {0x0001} [hci0] 21.166522
        LE Address: E1:F3:0C:DC:CD:85 (Static)
        Reason: Connection terminated by remote host (0x03)
< HCI Command: LE Set Scan Paramet.. (0x08|0x000b) plen 7  #42 [hci0] 21.182661
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                #43 [hci0] 21.183445
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2     #44 [hci0] 21.183500
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                #45 [hci0] 21.184449
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 40                  #46 [hci0] 21.389478
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Public (0x00)
        Address: 30:FD:38:B3:DE:78 (Google, Inc.)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 02466c59327977336e414d6700000164d2bda061
        RSSI: -80 dBm (0xb0)
> HCI Event: LE Meta Event (0x3e) plen 40                  #47 [hci0] 21.511487
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 57:79:AE:EF:8D:FC (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -68 dBm (0xbc)
> HCI Event: LE Meta Event (0x3e) plen 27                  #48 [hci0] 21.574478
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: B8:78:2E:47:B4:F3 (Apple, Inc.)
        Data length: 15
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 0300c0a80102
        RSSI: -95 dBm (0xa1)
> HCI Event: LE Meta Event (0x3e) plen 27                  #49 [hci0] 21.616614
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 3D:90:6E:0B:65:4C (Non-Resolvable)
        Data length: 15
        Flags: 0x1b
          LE Limited Discoverable Mode
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 030f0a000083
        RSSI: -95 dBm (0xa1)
> HCI Event: LE Meta Event (0x3e) plen 26                  #50 [hci0] 21.727470
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 08:66:98:9D:EF:F3 (Apple, Inc.)
        Data length: 14
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Unknown (16)
          Data: 011033e269
        RSSI: -87 dBm (0xa9)
> HCI Event: LE Meta Event (0x3e) plen 40                  #51 [hci0] 21.942578
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 62:54:CF:2B:06:CA (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -87 dBm (0xa9)
> HCI Event: LE Meta Event (0x3e) plen 40                  #52 [hci0] 23.013633
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 5B:2C:57:46:EB:21 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -94 dBm (0xa2)
> HCI Event: LE Meta Event (0x3e) plen 27                  #53 [hci0] 23.052634
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 18:F1:F4:A4:3F:AF (Non-Resolvable)
        Data length: 15
        Flags: 0x1b
          LE Limited Discoverable Mode
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 0395c0a80002
        RSSI: -91 dBm (0xa5)
> HCI Event: LE Meta Event (0x3e) plen 26                  #54 [hci0] 25.493582
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: 5F:43:B8:1B:8F:52 (Resolvable)
        Data length: 14
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Unknown (16)
          Data: 0b1089aa65
        RSSI: -98 dBm (0x9e)
> HCI Event: LE Meta Event (0x3e) plen 23                  #55 [hci0] 26.083613
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: D0:D2:B0:9D:38:E3 (Apple, Inc.)
        Data length: 11
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Unknown (16)
          Data: 0100
        RSSI: -95 dBm (0xa1)

For the already paired and trusted mouse, this is a btmon log of
patched hog-lib when switching the mouse on and off:

Bluetooth monitor ver 5.49
= Note: Linux version 4.17.8-1-ARCH (x86_64)                           0.235878
= Note: Bluetooth subsystem version 2.22                               0.235880
= New Index: 00:28:F8:25:AA:34 (Primary,USB,hci0)               [hci0] 0.235881
= Open Index: 00:28:F8:25:AA:34                                 [hci0] 0.235882
= Index Info: 00:28:F8:25:AA:34 (Intel Corp.)                   [hci0] 0.235882
@ MGMT Open: bluetoothd (privileged) version 1.14             {0x0001} 0.235883
@ MGMT Open: btmon (privileged) version 1.14                  {0x0002} 0.235978
> HCI Event: LE Meta Event (0x3e) plen 12                    #1 [hci0] 3.106945
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable directed - ADV_DIRECT_IND (0x01)
        Address type: Random (0x01)
        Address: E1:F3:0C:DC:CD:85 (Static)
        Data length: 0
        RSSI: -31 dBm (0xe1)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2       #2 [hci0] 3.107067
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                  #3 [hci0] 3.110986
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25    #4 [hci0] 3.111094
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: E1:F3:0C:DC:CD:85 (Static)
        Own address type: Public (0x00)
        Min connection interval: 7.50 msec (0x0006)
        Max connection interval: 7.50 msec (0x0006)
        Connection latency: 60 (0x003c)
        Supervision timeout: 3000 msec (0x012c)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                    #5 [hci0] 3.112906
      LE Create Connection (0x08|0x000d) ncmd 2
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                    #6 [hci0] 3.114940
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 3585
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: E1:F3:0C:DC:CD:85 (Static)
        Connection interval: 7.50 msec (0x0006)
        Connection latency: 60 (0x003c)
        Supervision timeout: 3000 msec (0x012c)
        Master clock accuracy: 0x00
@ MGMT Event: Device Connected (0x000b) plen 13        {0x0002} [hci0] 3.115022
        LE Address: E1:F3:0C:DC:CD:85 (Static)
        Flags: 0x00000000
        Data length: 0
@ MGMT Event: Device Connected (0x000b) plen 13        {0x0001} [hci0] 3.115022
        LE Address: E1:F3:0C:DC:CD:85 (Static)
        Flags: 0x00000000
        Data length: 0
< HCI Command: LE Read Remote Used F.. (0x08|0x0016) plen 2  #7 [hci0] 3.115181
        Handle: 3585
> HCI Event: Command Status (0x0f) plen 4                    #8 [hci0] 3.115813
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 12                    #9 [hci0] 3.127804
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 3585
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28    #10 [hci0] 3.128065
        Handle: 3585
        Random number: 0x5434e71113742647
        Encrypted diversifier: 0x6f4c
        Long term key: ca7a1e3cacd797c1edcad7efe07d692d
> HCI Event: Command Status (0x0f) plen 4                   #11 [hci0] 3.128798
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Encryption Change (0x08) plen 4                #12 [hci0] 3.201934
        Status: Success (0x00)
        Handle: 3585
        Encryption: Enabled with AES-CCM (0x01)
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #13 [hci0] 3.202174
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5      #14 [hci0] 3.209805
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 7                #15 [hci0] 3.216823
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 23
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #16 [hci0] 3.217098
      ATT: Read Request (0x0a) len 2
        Handle: 0x0010
> HCI Event: Number of Completed Packets (0x13) plen 5      #17 [hci0] 3.224842
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 6                #18 [hci0] 3.231933
      ATT: Read Response (0x0b) len 1
        Value: 64
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #19 [hci0] 3.232320
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5      #20 [hci0] 3.239841
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 12               #21 [hci0] 3.246885
      ATT: Read Response (0x0b) len 7
        Value: 025e0416090001
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #22 [hci0] 3.247143
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003
> HCI Event: Number of Completed Packets (0x13) plen 5      #23 [hci0] 3.254811
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 23               #24 [hci0] 3.262141
      ATT: Read Response (0x0b) len 18
        Value: 426c7565746f6f74684d6f75736533363030
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #25 [hci0] 3.262478
      ATT: Read Request (0x0a) len 2
        Handle: 0x0005
> HCI Event: Number of Completed Packets (0x13) plen 5      #26 [hci0] 3.269846
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 7                #27 [hci0] 3.276949
      ATT: Read Response (0x0b) len 2
        Value: c203
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #28 [hci0] 3.277228
      ATT: Read Request (0x0a) len 2
        Handle: 0x0017
> HCI Event: Number of Completed Packets (0x13) plen 5      #29 [hci0] 3.284936
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 7                #30 [hci0] 3.291859
      ATT: Read Response (0x0b) len 2
        Value: 0000
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #31 [hci0] 3.292071
      ATT: Read Request (0x0a) len 2
        Handle: 0x001b
> HCI Event: Number of Completed Packets (0x13) plen 5      #32 [hci0] 3.299935
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 7                #33 [hci0] 3.306845
      ATT: Read Response (0x0b) len 2
        Value: 0000
< ACL Data TX: Handle 3585 flags 0x00 dlen 7                #34 [hci0] 3.307123
      ATT: Read Request (0x0a) len 2
        Handle: 0x001f
> HCI Event: Number of Completed Packets (0x13) plen 5      #35 [hci0] 3.314855
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 7                #36 [hci0] 3.321935
      ATT: Read Response (0x0b) len 2
        Value: 0000
< ACL Data TX: Handle 3585 flags 0x00 dlen 11               #37 [hci0] 3.322200
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5      #38 [hci0] 3.329810
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 24               #39 [hci0] 3.336982
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0007
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0008-0x0008
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0009-0x000d
        UUID: Device Information (0x180a)
< ACL Data TX: Handle 3585 flags 0x00 dlen 9                #40 [hci0] 3.337217
      ATT: Write Request (0x12) len 4
        Handle: 0x0011
          Data: 0100
> HCI Event: Number of Completed Packets (0x13) plen 5      #41 [hci0] 3.344954
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 5                #42 [hci0] 3.351938
      ATT: Write Response (0x13) len 0
< ACL Data TX: Handle 3585 flags 0x00 dlen 9                #43 [hci0] 3.352243
      ATT: Write Request (0x12) len 4
        Handle: 0x0017
          Data: 0100
> HCI Event: Number of Completed Packets (0x13) plen 5      #44 [hci0] 3.359800
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 5                #45 [hci0] 3.366696
      ATT: Write Response (0x13) len 0
< ACL Data TX: Handle 3585 flags 0x00 dlen 9                #46 [hci0] 3.367127
      ATT: Write Request (0x12) len 4
        Handle: 0x001b
          Data: 0100
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #47 [hci0] 3.367587
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 001000000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #48 [hci0] 3.374524
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5      #49 [hci0] 3.374792
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 5                #50 [hci0] 3.381701
      ATT: Write Response (0x13) len 0
< ACL Data TX: Handle 3585 flags 0x00 dlen 9                #51 [hci0] 3.381918
      ATT: Write Request (0x12) len 4
        Handle: 0x001f
          Data: 0100
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #52 [hci0] 3.382846
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5      #53 [hci0] 3.389840
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 5                #54 [hci0] 3.396810
      ATT: Write Response (0x13) len 0
< ACL Data TX: Handle 3585 flags 0x00 dlen 11               #55 [hci0] 3.397069
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000e-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5      #56 [hci0] 3.404803
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 18               #57 [hci0] 3.411936
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x000e-0x0011
        UUID: Battery Service (0x180f)
        Handle range: 0x0012-0xffff
        UUID: Human Interface Device (0x1812)
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #58 [hci0] 3.434395
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000ffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #59 [hci0] 3.539439
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #60 [hci0] 3.546878
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000060000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #61 [hci0] 3.554510
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #62 [hci0] 3.577108
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000feff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #63 [hci0] 3.584546
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000feff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #64 [hci0] 3.592066
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000ffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #65 [hci0] 3.636933
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00feff000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #66 [hci0] 3.644581
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00fbff030000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #67 [hci0] 3.652060
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00ffff010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #68 [hci0] 3.711936
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000ffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #69 [hci0] 3.981934
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000ffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #70 [hci0] 4.034620
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #71 [hci0] 4.042037
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #72 [hci0] 4.386934
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000feff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #73 [hci0] 4.394964
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000eeff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #74 [hci0] 4.402039
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000ffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #75 [hci0] 4.522069
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000ffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #76 [hci0] 4.529433
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000ffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #77 [hci0] 4.536898
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000ffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #78 [hci0] 4.566902
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #79 [hci0] 5.557009
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00ffff000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #80 [hci0] 5.564959
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f2ff080000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #81 [hci0] 5.572041
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00eeff0a0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #82 [hci0] 5.579461
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f3ff090000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #83 [hci0] 5.587093
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f2ff0a0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #84 [hci0] 5.601828
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f3ff090000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #85 [hci0] 5.602625
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00faff040000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #86 [hci0] 5.609396
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f2ff0c0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #87 [hci0] 5.616932
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f4ff0a0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #88 [hci0] 5.624432
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f4ff0d0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #89 [hci0] 5.631931
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f4ff0d0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #90 [hci0] 5.639409
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f6ff100000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #91 [hci0] 5.647101
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f8ff0f0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #92 [hci0] 5.654600
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f7ff0e0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #93 [hci0] 5.662064
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f9ff0f0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #94 [hci0] 5.669440
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00fbff0e0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #95 [hci0] 5.677104
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00fcff0d0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #96 [hci0] 5.684537
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00feff0b0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #97 [hci0] 5.691931
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00feff0b0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #98 [hci0] 5.699404
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00feff0a0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16               #99 [hci0] 5.707055
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 0000000a0000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #100 [hci0] 5.714622
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000090000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #101 [hci0] 5.721930
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000200080000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #102 [hci0] 5.729441
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000300080000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #103 [hci0] 5.737109
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000200070000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #104 [hci0] 5.744564
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000200060000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #105 [hci0] 5.751936
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000300040000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #106 [hci0] 5.759445
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000200030000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #107 [hci0] 5.767823
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000200020000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #108 [hci0] 5.789437
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #109 [hci0] 5.797050
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #110 [hci0] 5.804466
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000300000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #111 [hci0] 5.811938
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000500000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #112 [hci0] 5.819437
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000600ffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #113 [hci0] 5.827050
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000b00fcff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #114 [hci0] 5.834592
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000c00fbff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #115 [hci0] 5.842110
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000f00faff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #116 [hci0] 5.849426
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 001000f8ff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #117 [hci0] 5.856939
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 001200f8ff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #118 [hci0] 5.864426
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 001200f7ff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #119 [hci0] 5.872042
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 001200f6ff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #120 [hci0] 5.879437
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 001100f6ff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #121 [hci0] 5.886935
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000f00f6ff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #122 [hci0] 5.894614
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000d00f7ff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #123 [hci0] 5.902113
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000c00f7ff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #124 [hci0] 5.909400
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000900f8ff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #125 [hci0] 5.916934
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000700f6ff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #126 [hci0] 5.924436
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000300f9ff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #127 [hci0] 5.932059
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100f9ff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #128 [hci0] 5.939438
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100fbff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #129 [hci0] 5.947102
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000faff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #130 [hci0] 5.954409
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00fffffbff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #131 [hci0] 5.961938
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00fffffbff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #132 [hci0] 5.969933
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00fcfffaff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #133 [hci0] 5.976990
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00fcfffcff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #134 [hci0] 5.984548
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00faffffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #135 [hci0] 5.991942
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f8ffffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #136 [hci0] 5.999404
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f8ff000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #137 [hci0] 6.007109
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00f8ffffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #138 [hci0] 6.014619
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00faffffff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #139 [hci0] 6.021931
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00faff000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #140 [hci0] 6.029434
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00fcff000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #141 [hci0] 6.037101
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00feff000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #142 [hci0] 6.044410
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00ffff000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 8               #143 [hci0] 6.045163
      ATT: Handle Value Notification (0x1b) len 3
        Handle: 0x0010
          Data: 64
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #144 [hci0] 6.052066
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 00ffff000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #145 [hci0] 6.067065
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #146 [hci0] 6.089399
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #147 [hci0] 6.134567
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #148 [hci0] 6.141898
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #149 [hci0] 6.149435
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #150 [hci0] 6.157103
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100020000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #151 [hci0] 6.164613
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #152 [hci0] 6.172404
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100010000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #153 [hci0] 6.179409
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100000000000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #154 [hci0] 6.187049
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100fdff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #155 [hci0] 6.194588
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000feff00000000
> ACL Data RX: Handle 3585 flags 0x02 dlen 16              #156 [hci0] 7.499393
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000000000000000000
> HCI Event: Disconnect Complete (0x05) plen 4             #157 [hci0] 7.514938
        Status: Success (0x00)
        Handle: 3585
        Reason: Remote User Terminated Connection (0x13)
@ MGMT Event: Device Disconnected (0x000c) plen 8      {0x0002} [hci0] 7.515020
        LE Address: E1:F3:0C:DC:CD:85 (Static)
        Reason: Connection terminated by remote host (0x03)
@ MGMT Event: Device Disconnected (0x000c) plen 8      {0x0001} [hci0] 7.515020
        LE Address: E1:F3:0C:DC:CD:85 (Static)
        Reason: Connection terminated by remote host (0x03)
< HCI Command: LE Set Scan Paramet.. (0x08|0x000b) plen 7  #158 [hci0] 7.542679
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                #159 [hci0] 7.543806
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2     #160 [hci0] 7.543861
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                #161 [hci0] 7.544810
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 26                  #162 [hci0] 7.679838
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 08:66:98:9D:EF:F3 (Apple, Inc.)
        Data length: 14
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Unknown (16)
          Data: 011033e269
        RSSI: -88 dBm (0xa8)
> HCI Event: LE Meta Event (0x3e) plen 27                  #163 [hci0] 7.684951
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 18:F1:F4:A4:3F:AF (Non-Resolvable)
        Data length: 15
        Flags: 0x1b
          LE Limited Discoverable Mode
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 0395c0a80002
        RSSI: -88 dBm (0xa8)
> HCI Event: LE Meta Event (0x3e) plen 40                  #164 [hci0] 7.786954
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 57:79:AE:EF:8D:FC (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -77 dBm (0xb3)
> HCI Event: LE Meta Event (0x3e) plen 40                  #165 [hci0] 7.792944
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Public (0x00)
        Address: 30:FD:38:B3:DE:78 (Google, Inc.)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 02466c59327977336e414d6700000164d2bda061
        RSSI: -83 dBm (0xad)
> HCI Event: LE Meta Event (0x3e) plen 40                  #166 [hci0] 8.832945
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 51:49:C5:53:C3:25 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -85 dBm (0xab)
> HCI Event: LE Meta Event (0x3e) plen 27                  #167 [hci0] 9.285967
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: B8:78:2E:47:B4:F3 (Apple, Inc.)
        Data length: 15
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 0300c0a80102
        RSSI: -88 dBm (0xa8)



Simon Schubert (1):
  input/hog-lib: set notify bit on every connection

 profiles/input/hog-lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--
2.18.0
