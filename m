Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Leon Nicholls <lnicholls@google.com>
Date: Thu, 1 Oct 2015 23:33:42 -0700
Message-ID: <CAHmfHqTrHGpwyxaP6rsBNk5FamFxJMFBy547UY21vQLdLSDc4Q@mail.gmail.com>
Subject: Cannot write to BLE thermal printer
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a1138073670119c0521195986
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--001a1138073670119c0521195986
Content-Type: text/plain; charset=UTF-8

Hi
I'm trying to write a value to a BLE thermal printer using the Web
Bluetooth API on ChromeOS (using Bluez 5.33). I can connect to the
device and find the service and characteristic. But when I try and
write to the characteristic an error is thrown (although it looks like
it disconnects before the write happens). Please find attached
log.

Thanks
Leon

sudo btmon -w ~/Downloads/btmon.btsnoop
Bluetooth monitor ver 5.33
= New Index: 1C:3E:84:0D:F9:F8 (BR/EDR,USB,hci0)
                                                     [hci0] 0.004075
< HCI Command: LE Add Device To White List (0x08|0x0011) plen 7
                                                    [hci0] 15.209842
        Address type: Random (0x01)
        Address: 0F:04:E0:51:44:8B (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                                                                [hci0] 15.210823
      LE Add Device To White List (0x08|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
                                                    [hci0] 15.210856
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                                [hci0] 15.211822
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
                                                    [hci0] 15.211854
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                                [hci0] 15.212823
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 43                                                                                  [hci0] 15.528855
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: 0F:04:E0:51:44:8B (Non-Resolvable)
        Data length: 31
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (partial): 1 entry
          Unknown (0x18f0)
        128-bit Service UUIDs (partial): 1 entry
          e7810a71-73ae-499d-8c15-faa9aef0c3f2
        TX power: 4 dBm
        RSSI: -46 dBm (0xd2)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
                                                    [hci0] 15.528930
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                                [hci0] 15.529824
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
                                                    [hci0] 15.529878
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: 0F:04:E0:51:44:8B (Non-Resolvable)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                                                  [hci0] 15.530826
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                                                                  [hci0] 15.848909
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 32
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: 0F:04:E0:51:44:8B (Non-Resolvable)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
                                                    [hci0] 15.849297
        Handle: 32
@ Device Connected: 0F:04:E0:51:44:8B (2) flags 0x0000
        02 01 06 03 02 f0 18 11 06 f2 c3 f0 ae a9 fa 15  ................
        8c 9d 49 ae 73 71 0a 81 e7 02 0a 04 00 00 00     ..I.sq.........
> HCI Event: Command Status (0x0f) plen 4                                                                                  [hci0] 15.849836
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 32 flags 0x02 dlen 16                                                                                [hci0] 15.883695
      LE L2CAP: Connection Parameter Update Request (0x12) ident 180 len 8
        Min interval: 8
        Max interval: 16
        Slave latency: 0
        Timeout multiplier: 300
> HCI Event: LE Meta Event (0x3e) plen 12                                                                                  [hci0] 16.018827
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 32
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
< ACL Data TX: Handle 32 flags 0x00 dlen 10
                                                    [hci0] 16.018919
      LE L2CAP: Connection Parameter Update Response (0x13) ident 180 len 2
        Result: Connection Parameters accepted (0x0000)
< HCI Command: LE Connection Update (0x08|0x0013) plen 14
                                                    [hci0] 16.018938
        Handle: 32
        Min connection interval: 10.00 msec (0x0008)
        Max connection interval: 20.00 msec (0x0010)
        Connection latency: 0x0000
        Supervision timeout: 3000 msec (0x012c)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
< ACL Data TX: Handle 32 flags 0x00 dlen 7
                                                    [hci0] 16.019328
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> HCI Event: Command Status (0x0f) plen 4                                                                                  [hci0] 16.019819
      LE Connection Update (0x08|0x0013) ncmd 1
        Status: Success (0x00)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.086875
        Num handles: 1
        Handle: 32
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.087870
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 7                                                                                 [hci0] 16.153733
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 158
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.153997
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.221859
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 24                                                                                [hci0] 16.288359
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0006-0x0006
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0007-0x000b
        UUID: Battery Service (0x180f)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.288589
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000c-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.356857
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 24                                                                                [hci0] 16.423416
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x000c-0x000e
        UUID: Link Loss (0x1803)
        Handle range: 0x000f-0x0011
        UUID: Immediate Alert (0x1802)
        Handle range: 0x0012-0x001f
        UUID: Alert Notification Service (0x1811)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.423732
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0020-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.491921
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 24                                                                                [hci0] 16.558416
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0020-0x0022
        UUID: Tx Power (0x1804)
        Handle range: 0x0023-0x0029
        UUID: Unknown (0x18f0)
        Handle range: 0x002a-0x002e
        UUID: Device Information (0x180a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.558740
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x002f-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.626913
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 26                                                                                [hci0] 16.693364
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute group list: 1 entry
        Handle range: 0x002f-0x0032
        UUID: Unknown (e7810a71-73ae-499d-8c15-faa9aef0c3f2)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.693674
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0033-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: LE Meta Event (0x3e) plen 10                                                                                  [hci0] 16.693845
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 32
        Connection interval: 15.00 msec (0x000c)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 3000 msec (0x012c)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.708831
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 16.723276
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0033
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.723678
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Secondary Service (0x2801)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.738822
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 16.753289
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.753627
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0005
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.768858
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 16.783290
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.783618
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0007-0x000b
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.798828
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 16.813283
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0007
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.813608
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000c-0x000e
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.828840
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 16.843277
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000c
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.843625
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000f-0x0011
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.858824
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 16.873234
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000f
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.873476
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0012-0x001f
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.888906
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 16.903234
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0012
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.903486
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0020-0x0022
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.918864
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 16.933215
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0020
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.933401
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0023-0x0029
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.948918
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 16.963217
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0023
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.963549
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002a-0x002e
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 16.978834
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 16.993230
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x002a
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 16.993526
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002f-0x0032
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.008917
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 17.023196
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x002f
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.023593
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0005
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.038918
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.053196
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0002
        Value: 020300002a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.053464
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0003-0x0005
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.068910
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.083270
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0004
        Value: 020500012a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.083583
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0005-0x0005
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.098917
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 17.113205
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0005
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.113705
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0007-0x000b
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.128816
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.143220
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0008
        Value: 120900192a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.143457
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0009-0x000b
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.158818
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 17.173249
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0009
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 9
                                                    [hci0] 17.173568
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x000a-0x000b
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.188871
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 14                                                                                [hci0] 17.203411
      ATT: Find Information Response (0x05) len 9
        Format: UUID-16 (0x01)
        Handle: 0x000a
        UUID: Characteristic Format (0x2904)
        Handle: 0x000b
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.203778
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000c-0x000e
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.218824
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.233259
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x000d
        Value: 0a0e00062a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.233596
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000e-0x000e
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.248851
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 17.263285
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000e
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.263643
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000f-0x0011
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.293823
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.308362
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0010
        Value: 041100062a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.308668
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0011-0x0011
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.323911
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 17.338293
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0011
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.338649
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0012-0x001f
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.353829
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.368411
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0013
        Value: 021400472a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.369010
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0014-0x001f
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.398916
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.413355
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0015
        Value: 101600462a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.413754
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0016-0x001f
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.428879
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.443345
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0018
        Value: 021900482a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.443574
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0019-0x001f
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.458856
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.473356
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x001a
        Value: 101b00452a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.473660
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x001b-0x001f
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.488815
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.503338
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x001d
        Value: 181e00442a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.503642
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x001e-0x001f
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.518869
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 17.533201
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x001e
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 9
                                                    [hci0] 17.533732
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0017-0x0017
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.548839
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 10                                                                                [hci0] 17.563221
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0017
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 32 flags 0x00 dlen 9
                                                    [hci0] 17.563496
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x001c-0x001c
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.578816
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 10                                                                                [hci0] 17.593246
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x001c
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 32 flags 0x00 dlen 9
                                                    [hci0] 17.593596
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x001f-0x001f
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.608818
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 10                                                                                [hci0] 17.623286
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x001f
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.623640
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0020-0x0022
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.638840
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.653410
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0021
        Value: 022200072a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.653721
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0022-0x0022
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.668867
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 17.683241
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0022
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.683511
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0023-0x0029
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.698817
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.713365
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0024
        Value: 0c2500f12a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.713569
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0025-0x0029
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.728917
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.743317
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0027
        Value: 302800f02a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.743573
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0028-0x0029
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.758913
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 17.773195
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0028
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 9
                                                    [hci0] 17.773531
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0026-0x0026
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.788913
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 10                                                                                [hci0] 17.803317
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0026
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 32 flags 0x00 dlen 9
                                                    [hci0] 17.803739
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0029-0x0029
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.818913
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 10                                                                                [hci0] 17.833321
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0029
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.833757
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002a-0x002e
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.848912
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.863352
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x002b
        Value: 022c00232a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.863629
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002c-0x002e
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.878828
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 13                                                                                [hci0] 17.908312
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x002d
        Value: 022e00292a
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.908583
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002e-0x002e
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.923919
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 17.938187
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x002e
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.938450
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002f-0x0032
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 32 flags 0x02 dlen 27                                                                                [hci0] 17.968564
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 21
        Attribute data list: 1 entry
        Handle: 0x0030
        Value: 3a31009f9f00c158bd32b69e4c219cc9d6f8be
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.968805
        Num handles: 1
        Handle: 32
        Count: 1
< ACL Data TX: Handle 32 flags 0x00 dlen 11
                                                    [hci0] 17.968838
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0031-0x0032
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 17.983876
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                 [hci0] 17.998313
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0031
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 32 flags 0x00 dlen 9
                                                    [hci0] 17.998699
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0032-0x0032
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 18.013849
        Num handles: 1
        Handle: 32
        Count: 1
> ACL Data RX: Handle 32 flags 0x02 dlen 10                                                                                [hci0] 18.028315
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0032
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 32 flags 0x00 dlen 9
                                                    [hci0] 18.030692
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0003
        Offset: 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                     [hci0] 18.043803
        Num handles: 1
        Handle: 32
        Count: 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
                                                    [hci0] 50.049295
        Handle: 32
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                                                                                  [hci0] 50.050594
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Vendor (0xff) plen 7                                                                                          [hci0] 50.055689
        82 70 90 80 10 36 59                             .p...6Y
> HCI Event: Disconnect Complete (0x05) plen 4                                                                             [hci0] 50.056491
        Status: Success (0x00)
        Handle: 32
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 0F:04:E0:51:44:8B (2) reason 2l

--001a1138073670119c0521195986
Content-Type: application/octet-stream; name="btmon (2).btsnoop"
Content-Disposition: attachment; filename="btmon (2).btsnoop"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_if99ycrh0

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
BwAAAAcAAAADAAAAAADh/swcoiLuEwUBIAABAAAAABEAAAARAAAABQAAAAAA4f7MHKJbBiAgDQAJ
AAQACQcEAAIFAAEqAAAADwAAAA8AAAAEAAAAAADh/swcolw/IAALAAcABAAIBQAFAAMoAAAABwAA
AAcAAAADAAAAAADh/swcopglEwUBIAABAAAAAA0AAAANAAAABQAAAAAA4f7MHKLP9SAgCQAFAAQA
AQgFAAoAAAAPAAAADwAAAAQAAAAAAOH+zByi0ekgAAsABwAEAAgHAAsAAygAAAAHAAAABwAAAAMA
AAAAAOH+zByjDPATBQEgAAEAAAAAEQAAABEAAAAFAAAAAADh/swco0U0ICANAAkABAAJBwgAEgkA
GSoAAAAPAAAADwAAAAQAAAAAAOH+zByjRiEgAAsABwAEAAgJAAsAAygAAAAHAAAABwAAAAMAAAAA
AOH+zByjgiITBQEgAAEAAAAADQAAAA0AAAAFAAAAAADh/swco7qBICAJAAUABAABCAkACgAAAA0A
AAANAAAABAAAAAAA4f7MHKO7wCAACQAFAAQABAoACwAAAAAHAAAABwAAAAMAAAAAAOH+zByj94cT
BQEgAAEAAAAAEgAAABIAAAAFAAAAAADh/swcpDBTICAOAAoABAAFAQoABCkLAAIpAAAADwAAAA8A
AAAEAAAAAADh/swcpDHCIAALAAcABAAIDAAOAAMoAAAABwAAAAcAAAADAAAAAADh/swcpGyIEwUB
IAABAAAAABEAAAARAAAABQAAAAAA4f7MHKSk6yAgDQAJAAQACQcNAAoOAAYqAAAADwAAAA8AAAAE
AAAAAADh/swcpKY8IAALAAcABAAIDgAOAAMoAAAABwAAAAcAAAADAAAAAADh/swcpOHTEwUBIAAB
AAAAAA0AAAANAAAABQAAAAAA4f7MHKUaNSAgCQAFAAQAAQgOAAoAAAAPAAAADwAAAAQAAAAAAOH+
zBylG5sgAAsABwAEAAgPABEAAygAAAAHAAAABwAAAAMAAAAAAOH+zBylkX8TBQEgAAEAAAAAEQAA
ABEAAAAFAAAAAADh/swcpcpKICANAAkABAAJBxAABBEABioAAAAPAAAADwAAAAQAAAAAAOH+zByl
y3wgAAsABwAEAAgRABEAAygAAAAHAAAABwAAAAMAAAAAAOH+zBymBwcTBQEgAAEAAAAADQAAAA0A
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
IAAW
--001a1138073670119c0521195986--
