Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAEJBhJk2rd-4T1mc_GQ6UWB91vU_wTSPDQ6nt3+46j5KOsCoQ@mail.gmail.com>
References: <CAG=hFhL+OiRiwXLU5_9Yc03v8vOYhkfakp26871LU_AZdB2fmQ@mail.gmail.com>
 <CABBYNZK7t6jRaT1rDoiY=foi+5g74pTYE6KbShYx=8sv+_PW9A@mail.gmail.com>
 <CAG=hFhLGo_0kmWR0oMUP7DMEFD+5QqA5+p5AwfGhPK=-ofmT=Q@mail.gmail.com>
 <CAHFy41-2omfTux6-3VPcv0nHBZEdDu0r0ap2UTrc2z=3c_dtCg@mail.gmail.com>
 <CABBYNZ+B0sMpfg5chgz4nBgF0K9sTdWhxjkM2M9CboqiiBjuOQ@mail.gmail.com>
 <CAG=hFhJXr5xutpKq9Vwt4DcUui8d8Zdojt-4ccbUnnCmYGk_yg@mail.gmail.com> <CAAEJBhJk2rd-4T1mc_GQ6UWB91vU_wTSPDQ6nt3+46j5KOsCoQ@mail.gmail.com>
From: Naveen Kaje <nckaje@gmail.com>
Date: Fri, 16 Sep 2016 11:53:19 -0600
Message-ID: <CAG=hFhLazmAHOf9GbuOAaZMeTAnHhBRn02FrMkPdFU7h_ZLRQw@mail.gmail.com>
Subject: Re: Issue: Bluez: Bluetooth Mouse Disconnects Soon After Pairing
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,
Thanks for the feedback.

Here are the btmon logs when the device pairs successfully with the
SMP Kernel change. The behaviour is similar with Bluez 5.23, that
comes default with Debian Jessie.

Around 52 seconds mark in the logs, soon after
SMP: Pairing Random (0x04) len 16,
LE Start Encryption (0x08|0x0019) plen 28
is seen.

and then around 55 seconds,
SMP: Encryption Information
SMP: Master Identification
SMP: Identity Address Information
SMP: Signing Information

messages are seen.

Logs below: Software Baseline: Kernel 5.41, Bluez 5.42
FYI: BTMon Logs with the issue is included in my original message
http://marc.info/?l=linux-bluetooth&m=147356320523622&w=2

**************** Begin BTMon Logs ****************************
Bluez Version 5.41
root@Deb-Jessie:~# btmon
Bluetooth monitor ver 5.41
= New Index: 44:1C:A8:6C:8F:5E (Primary,UART,hci0)              [hci0] 0.513794
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      [hci0] 46.048934
        Address: 27:5A:29:B2:21:56 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 46.056068
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 46.056082
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0] 46.056152
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 46.060881
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0] 46.060960
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 46.065508
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x01 (7)
> HCI Event: LE Meta Event (0x3e) plen 35                      [hci0] 46.133086
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: 74:9A:AA:38:11:48 (Resolvable)
        Data length: 23
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: Apple, Inc. (76)
          Type: Unknown (12)
          Data: 00f9b4952a77038efd49b600f8a8
        RSSI: -86 dBm (0xaa)
> HCI Event: LE Meta Event (0x3e) plen 12                      [hci0] 46.133100
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Random (0x01)
        Address: 74:9A:AA:38:11:48 (Resolvable)
        Data length: 0
        RSSI: -83 dBm (0xad)
@ Device Found: 74:9A:AA:38:11:48 (2) rssi -83 flags 0x0000
        02 01 06 13 ff 4c 00 0c 0e 00 f9 b4 95 2a 77 03  .....L.......*w.
        8e fd 49 b6 00 f8 a8                             ..I....
> HCI Event: LE Meta Event (0x3e) plen 39                      [hci0] 46.144510
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: F5:95:EC:75:0F:D3 (Static)
        Data length: 27
        Name (complete): Designer Mouse
        Appearance: Mouse (0x03c2)
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Human Interface Device (0x1812)
        RSSI: -45 dBm (0xd3)
> HCI Event: LE Meta Event (0x3e) plen 12                      [hci0] 46.144526
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Random (0x01)
        Address: F5:95:EC:75:0F:D3 (Static)
        Data length: 0
        RSSI: -45 dBm (0xd3)
@ Device Found: F5:95:EC:75:0F:D3 (2) rssi -45 flags 0x0000
        0f 09 44 65 73 69 67 6e 65 72 20 4d 6f 75 73 65  ..Designer Mouse
        03 19 c2 03 02 01 05 03 03 12 18                 ...........
> HCI Event: LE Meta Event (0x3e) plen 23                      [hci0] 46.532010
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: 5E:57:57:96:E8:82 (Resolvable)
        Data length: 11
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Unknown (16)
          Data: 0b00
        RSSI: -68 dBm (0xbc)
> HCI Event: LE Meta Event (0x3e) plen 12                      [hci0] 46.532025
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Random (0x01)
        Address: 5E:57:57:96:E8:82 (Resolvable)
        Data length: 0
        RSSI: -68 dBm (0xbc)
@ Device Found: 5E:57:57:96:E8:82 (2) rssi -68 flags 0x0000
        02 01 1a 07 ff 4c 00 10 02 0b 00                 .....L.....
> HCI Event: LE Meta Event (0x3e) plen 27                      [hci0] 48.054711
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 6C:94:F8:DA:38:93 (OUI 6C-94-F8)
        Data length: 15
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 0312c0a80137
        RSSI: -82 dBm (0xae)
> HCI Event: LE Meta Event (0x3e) plen 19                      [hci0] 48.102354
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: FE:7D:EE:A0:1B:05 (Static)
        Data length: 7
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Tile, Inc. (0xfeed)
        RSSI: -78 dBm (0xb2)
@ Device Found: 6C:94:F8:DA:38:93 (1) rssi -82 flags 0x0000
        02 01 1a 0b ff 4c 00 09 06 03 12 c0 a8 01 37     .....L........7
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0] 51.188339
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 51.194672
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: Inquiry (0x01|0x0001) plen 5                    [hci0] 51.194766
        Access code: 0x9e8b33 (General Inquiry)
        Length: 5.12s (0x04)
        Num responses: 0
@ Device Found: FE:7D:EE:A0:1B:05 (2) rssi -78 flags 0x0000
        02 01 06 03 03 ed fe                             .......
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 51.199560
      Inquiry (0x01|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Inquiry Cancel (0x01|0x0002) plen 0             [hci0] 51.499269
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 51.506928
      Inquiry Cancel (0x01|0x0002) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x00 (7)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25      [hci0] 51.520384
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: F5:95:EC:75:0F:D3 (Static)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 51.527099
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                      [hci0] 51.539824
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 2
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: F5:95:EC:75:0F:D3 (Static)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 51.540129
      SMP: Pairing Request (0x01) len 6
        IO capability: KeyboardDisplay (0x04)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, Legacy, No Keypresses (0x05)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey IdKey Sign (0x07)
@ Device Connected: F5:95:EC:75:0F:D3 (2) flags 0x0000
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 51.544335
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 51.584603
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 11                     [hci0] 51.652973
      SMP: Pairing Response (0x02) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, Legacy, No
Keypresses (0x01)
        Max encryption key size: 16
        Initiator key distribution: Sign (0x04)
        Responder key distribution: EncKey IdKey (0x03)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 51.652988
        Num handles: 1
        Handle: 2
        Count: 1
< ACL Data TX: Handle 2 flags 0x00 dlen 21                     [hci0] 51.653107
      SMP: Pairing Confirm (0x03) len 16
        Confim value: e9c9ebe86a8fe83383a9a94af6db8f92
> ACL Data RX: Handle 2 flags 0x02 dlen 7                      [hci0] 51.720076
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 23
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 51.720091
        Num handles: 1
        Handle: 2
        Count: 1
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 51.720552
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 2 flags 0x02 dlen 21                     [hci0] 51.788846
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 073fac8c702d72ea5815e0bd08866a3c
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 51.788863
        Num handles: 1
        Handle: 2
        Count: 1
< ACL Data TX: Handle 2 flags 0x00 dlen 21                     [hci0] 51.788941
      SMP: Pairing Random (0x04) len 16
        Random value: a71f0097199364b27fa4753ebc53914f
> ACL Data RX: Handle 2 flags 0x02 dlen 24                     [hci0] 51.924277
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0007
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0008-0x0008
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0009-0x000d
        UUID: Device Information (0x180a)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 51.924292
        Num handles: 1
        Handle: 2
        Count: 1
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 51.924585
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000e-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 2 flags 0x02 dlen 21                     [hci0] 51.991434
      SMP: Pairing Random (0x04) len 16
        Random value: 578bb89781435b0e1bb2365d303da298
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 51.991449
        Num handles: 1
        Handle: 2
        Count: 1
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28       [hci0] 51.991561
        Handle: 2
        Random number: 0x0000000000000000
        Encrypted diversifier: 0x0000
        Long term key: 5644a3d4171b5b4d6034d00523c717d9
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 51.998086
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 2 flags 0x02 dlen 18                     [hci0] 52.057685
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x000e-0x0011
        UUID: Battery Service (0x180f)
        Handle range: 0x0012-0xffff
        UUID: Human Interface Device (0x1812)
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 52.059192
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Secondary Service (0x2801)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 52.124016
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 9                      [hci0] 52.191891
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 52.192185
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0007
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 52.259140
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 9                      [hci0] 52.326948
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 52.327248
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0009-0x000d
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 52.394109
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 9                      [hci0] 52.461847
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0009
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 52.462156
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000e-0x0011
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 52.528989
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 9                      [hci0] 52.664309
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000e
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 52.664624
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0012-0xffff
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 52.731535
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 9                      [hci0] 52.799486
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0012
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 52.799778
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0007
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 52.866517
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 27                     [hci0] 53.003647
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0002
        Value: 0a0300002a
        Handle: 0x0004
        Value: 020500012a
        Handle: 0x0006
        Value: 020700042a
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 53.003946
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0007-0x0007
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 53.068895
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 9                      [hci0] 53.137081
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0007
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 53.137406
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0009-0x000d
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 53.271534
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 20                     [hci0] 53.340441
      ATT: Read By Type Response (0x09) len 15
        Attribute data length: 7
        Attribute data list: 2 entries
        Handle: 0x000a
        Value: 020b00292a
        Handle: 0x000c
        Value: 020d00502a
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 53.340827
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000d-0x000d
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 53.406386
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 9                      [hci0] 53.474571
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000d
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 53.475052
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000e-0x0011
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 53.541618
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 13                     [hci0] 53.609804
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x000f
        Value: 121000192a
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 53.610123
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0x0011
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 53.676514
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 9                      [hci0] 53.744308
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 53.744682
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0011-0x0011
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 53.811426
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 10                     [hci0] 53.879469
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0011
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 53.879868
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0012-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 53.946373
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 27                     [hci0] 54.016157
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0013
        Value: 0614004e2a
        Handle: 0x0015
        Value: 1a16004d2a
        Handle: 0x0019
        Value: 1a1a004d2a
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 54.016510
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x001a-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 54.148984
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 27                     [hci0] 54.218646
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x001d
        Value: 0a1e004d2a
        Handle: 0x0020
        Value: 0a21004d2a
        Handle: 0x0023
        Value: 0224004b2a
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 54.218967
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0024-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 54.284131
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 27                     [hci0] 54.353514
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0025
        Value: 1a2600332a
        Handle: 0x0028
        Value: 0229004a2a
        Handle: 0x002a
        Value: 042b004c2a
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 54.353873
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002b-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 54.418911
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 9                      [hci0] 54.487154
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x002b
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 54.487600
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0017-0x0018
> ACL Data RX: Handle 2 flags 0x02 dlen 14                     [hci0] 54.623519
      ATT: Find Information Response (0x05) len 9
        Format: UUID-16 (0x01)
        Handle: 0x0017
        UUID: Client Characteristic Configuration (0x2902)
        Handle: 0x0018
        UUID: Report Reference (0x2908)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 54.623535
        Num handles: 1
        Handle: 2
        Count: 1
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 54.623854
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x001b-0x001c
> ACL Data RX: Handle 2 flags 0x02 dlen 21                     [hci0] 55.096893
      SMP: Encryption Information (0x06) len 16
        Long term key: a2a54ddd7818217ffba02c6523b74e97
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 55.096907
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 14                     [hci0] 55.162555
      ATT: Find Information Response (0x05) len 9
        Format: UUID-16 (0x01)
        Handle: 0x001b
        UUID: Client Characteristic Configuration (0x2902)
        Handle: 0x001c
        UUID: Report Reference (0x2908)
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 55.162902
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x001f-0x001f
> ACL Data RX: Handle 2 flags 0x02 dlen 15                     [hci0] 55.230975
      SMP: Master Identification (0x07) len 10
        EDIV: 0x9c1b
        Rand: 0xfe0ee7ed7698af66
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 55.230990
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 10                     [hci0] 55.297075
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x001f
        UUID: Report Reference (0x2908)
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 55.297414
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0022-0x0022
> ACL Data RX: Handle 2 flags 0x02 dlen 21                     [hci0] 55.366399
      SMP: Identity Information (0x08) len 16
        Identity resolving key: ea7102bac3d692626259c72b1613a1ca
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 55.366414
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 10                     [hci0] 55.432031
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0022
        UUID: Report Reference (0x2908)
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 55.432387
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0027-0x0027
> ACL Data RX: Handle 2 flags 0x02 dlen 12                     [hci0] 55.500706
      SMP: Identity Address Information (0x09) len 7
        Address type: Random (0x01)
        Address: F5:95:EC:75:0F:D3 (Static)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 55.500721
        Num handles: 1
        Handle: 2
        Count: 1
< ACL Data TX: Handle 2 flags 0x00 dlen 21                     [hci0] 55.500874
      SMP: Signing Information (0x0a) len 16
        Signature key: 76fcf28ce210691a008604b7cf7e3def
@ New IRK: F5:95:EC:75:0F:D3 (2) 00:00:00:00:00:00
@ New CSRK: F5:95:EC:75:0F:D3 (2) Local Unauthenticated (0)
@ New Long Term Key: F5:95:EC:75:0F:D3 (2) Master (Unauthenticated) 0x00
> ACL Data RX: Handle 2 flags 0x02 dlen 10                     [hci0] 55.568053
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0027
        UUID: Client Characteristic Configuration (0x2902)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 55.568068
        Num handles: 1
        Handle: 2
        Count: 1
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 55.568416
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x002c-0xffff
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 55.634151
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 9                      [hci0] 55.702101
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x002c
        Error: Attribute Not Found (0x0a)
@ Device Added: F5:95:EC:75:0F:D3 (2) 2
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 55.721800
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 55.768866
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 19                     [hci0] 55.837793
      ATT: Read Response (0x0b) len 14
        Value: 44657369676e6572204d6f757365
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 55.838123
      ATT: Read Request (0x0a) len 2
        Handle: 0x0005
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 55.903921
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 7                      [hci0] 55.971907
      ATT: Read Response (0x0b) len 2
        Value: c203
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 55.972214
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 56.038913
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 12                     [hci0] 56.107330
      ATT: Read Response (0x0b) len 7
        Value: 025e0405081001
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 56.107674
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0012-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 56.173897
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 27                     [hci0] 56.243648
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0013
        Value: 0614004e2a
        Handle: 0x0015
        Value: 1a16004d2a
        Handle: 0x0019
        Value: 1a1a004d2a
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 56.243991
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x001a-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 56.376515
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 27                     [hci0] 56.446035
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x001d
        Value: 0a1e004d2a
        Handle: 0x0020
        Value: 0a21004d2a
        Handle: 0x0023
        Value: 0224004b2a
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 56.446643
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0024-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 56.511473
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 27                     [hci0] 56.581195
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0025
        Value: 1a2600332a
        Handle: 0x0028
        Value: 0229004a2a
        Handle: 0x002a
        Value: 042b004c2a
< ACL Data TX: Handle 2 flags 0x00 dlen 11                     [hci0] 56.581822
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002b-0xffff
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 56.648464
      LE L2CAP: Connection Parameter Update Request (0x12) ident 2 len 8
        Min interval: 6
        Max interval: 6
        Slave latency: 60
        Timeout multiplier: 300
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 56.648480
        Num handles: 1
        Handle: 2
        Count: 1
< ACL Data TX: Handle 2 flags 0x00 dlen 10                     [hci0] 56.648571
      LE L2CAP: Connection Parameter Update Response (0x13) ident 2 len 2
        Result: Connection Parameters accepted (0x0000)
< HCI Command: LE Connection Update (0x08|0x0013) plen 14      [hci0] 56.648584
        Handle: 2
        Min connection interval: 7.50 msec (0x0006)
        Max connection interval: 7.50 msec (0x0006)
        Connection latency: 0x003c
        Supervision timeout: 3000 msec (0x012c)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
@ New Conn Param: F5:95:EC:75:0F:D3 (2) hint 1 min 0x0006 max 0x0006
latency 0x003c timeout 0x012c
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 56.655302
      LE Connection Update (0x08|0x0013) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 2 flags 0x02 dlen 9                      [hci0] 56.714560
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x002b
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 56.714908
      ATT: Read Request (0x0a) len 2
        Handle: 0x0016
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 56.782040
        Num handles: 1
        Handle: 2
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 56.849127
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 5                      [hci0] 56.916579
      ATT: Read Response (0x0b) len 0
        Value:
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 56.916870
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0017-0x0018
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 56.983895
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 14                     [hci0] 57.053457
      ATT: Find Information Response (0x05) len 9
        Format: UUID-16 (0x01)
        Handle: 0x0017
        UUID: Client Characteristic Configuration (0x2902)
        Handle: 0x0018
        UUID: Report Reference (0x2908)
> HCI Event: LE Meta Event (0x3e) plen 10                      [hci0] 57.053472
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 2
        Connection interval: 7.50 msec (0x0006)
        Connection latency: 75.00 msec (0x003c)
        Supervision timeout: 3000 msec (0x012c)
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 57.053786
      ATT: Read Request (0x0a) len 2
        Handle: 0x001a
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.127745
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020000000000000000
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.143330
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 002300ecff00000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.143345
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.152839
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000300feff00000000
> ACL Data RX: Handle 2 flags 0x02 dlen 5                      [hci0] 57.152854
      ATT: Read Response (0x0b) len 0
        Value:
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.152856
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000300feff00000000
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 57.153203
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x001b-0x001c
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.157611
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000300fdff00000000
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.165798
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000300feff00000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.165812
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 14                     [hci0] 57.174122
      ATT: Find Information Response (0x05) len 9
        Format: UUID-16 (0x01)
        Handle: 0x001b
        UUID: Client Characteristic Configuration (0x2902)
        Handle: 0x001c
        UUID: Report Reference (0x2908)
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.174136
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000400fdff00000000
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 57.174442
      ATT: Read Request (0x0a) len 2
        Handle: 0x001e
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.179976
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000400fdff00000000
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.188337
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000400feff00000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.188350
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 24                     [hci0] 57.197848
      ATT: Read Response (0x0b) len 19
        Value: 221f0104000000000000000000000000000000
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.197862
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000200fdff00000000
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 57.198132
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x001f-0x001f
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.202516
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000200ffff00000000
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.210966
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100ffff00000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.210981
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 10                     [hci0] 57.218745
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x001f
        UUID: Report Reference (0x2908)
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.218759
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100000000000000
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 57.219156
      ATT: Read Request (0x0a) len 2
        Handle: 0x0021
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.278585
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020000000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.278600
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 5                      [hci0] 57.284153
      ATT: Read Response (0x0b) len 0
        Value:
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 57.284427
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0022-0x0022
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.291402
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 10                     [hci0] 57.299702
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0022
        UUID: Report Reference (0x2908)
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 57.299977
      ATT: Read Request (0x0a) len 2
        Handle: 0x0024
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.306491
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 27                     [hci0] 57.316061
      ATT: Read Response (0x0b) len 22
        Value: 05010902a10105010902a102851a0901a10005091901
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 57.316434
      ATT: Read Request (0x0a) len 2
        Handle: 0x0014
> ACL Data RX: Handle 2 flags 0x02 dlen 6                      [hci0] 57.615841
      ATT: Read Response (0x0b) len 1
        Value: 01
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.615857
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020100000000000000
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 57.616273
      ATT: Read Request (0x0a) len 2
        Handle: 0x0029
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.622619
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020100000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.628970
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 9                      [hci0] 57.636869
      ATT: Read Response (0x0b) len 4
        Value: 01010003
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 57.637119
      ATT: Read Request (0x0a) len 2
        Handle: 0x0018
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.643925
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 7                      [hci0] 57.651805
      ATT: Read Response (0x0b) len 2
        Value: 1a01
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 57.652244
      ATT: Read Request (0x0a) len 2
        Handle: 0x001c
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.658852
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 7                      [hci0] 57.666751
      ATT: Read Response (0x0b) len 2
        Value: 2701
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 57.667006
      ATT: Read Request (0x0a) len 2
        Handle: 0x001f
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.675908
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020100000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.675924
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 7                      [hci0] 57.683577
      ATT: Read Response (0x0b) len 2
        Value: 2203
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.683593
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020100000000000000
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 57.684037
      ATT: Read Request (0x0a) len 2
        Handle: 0x0022
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.690032
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020200000000000000
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.698302
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020400000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.698317
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 7                      [hci0] 57.706128
      ATT: Read Response (0x0b) len 2
        Value: 2403
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.706145
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020700000000000000
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 57.706549
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0024
        Offset: 0x0016
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.712646
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020900000000000000
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.720912
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020800000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.720930
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 27                     [hci0] 57.730450
      ATT: Read Blob Response (0x0d) len 22
        29 05 95 05 75 01 15 00 25 01 81 02 75 03 95 01  )...u...%...u...
        81 01 05 01 09 30                                .....0
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.730466
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020800000000000000
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 57.730892
      ATT: Read Request (0x0a) len 2
        Handle: 0x0017
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.735069
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020900000000000000
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.743303
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020500000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.743320
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 7                      [hci0] 57.751077
      ATT: Read Response (0x0b) len 2
        Value: 0100
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.751093
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020400000000000000
< ACL Data TX: Handle 2 flags 0x00 dlen 7                      [hci0] 57.751558
      ATT: Read Request (0x0a) len 2
        Handle: 0x001b
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.757730
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020200000000000000
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.766046
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020100000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.766063
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 7                      [hci0] 57.773753
      ATT: Read Response (0x0b) len 2
        Value: 0100
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.773769
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020100000000000000
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 57.774198
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0024
        Offset: 0x002c
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.938420
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 020000000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.938437
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 27                     [hci0] 57.947874
      ATT: Read Blob Response (0x0d) len 22
        09 31 95 02 75 10 16 01 80 26 ff 7f 81 06 a1 02  .1..u....&......
        85 1a 09 38 35 00                                ...85.
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.947890
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 02ffff000000000000
< ACL Data TX: Handle 2 flags 0x00 dlen 9                      [hci0] 57.948362
      ATT: Write Request (0x12) len 4
        Handle: 0x0017
          Data: 0100
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.962573
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 02ffff000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 57.962592
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.962593
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 02ffff000000000000
> ACL Data RX: Handle 2 flags 0x02 dlen 5                      [hci0] 57.968509
      ATT: Write Response (0x13) len 0
> ACL Data RX: Handle 2 flags 0x02 dlen 16                     [hci0] 57.968524
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 02ffff000000000000
******************** End *************************************


Thanks,
Naveen

On Fri, Sep 16, 2016 at 4:02 AM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> Hi Naveen,
>
> On 15 September 2016 at 20:58, Naveen Kaje <nckaje@gmail.com> wrote:
> > Hi,
> > Thanks for all the input so far. I found out that the disconnection is
> > coming from Bluetooth SMP in Kernel. After host transmits
> > SMP_CMD_PAIRING_RANDOM,
> > the HID device sends:
> >
> > SMP_CMD_ENCRYPT_INFO
> > SMP_CMD_MASTER_IDENT
> > SMP_CMD_IDENT_ADDR_INFO
> > SMP_CMD_IDENT_INFO
>
> Could you get btmon traces from pairing so that we don't need to speculate?
> In general slave should distribute keys only after master enabled encryption.
>
> There is also a small chance of race between encryption event and ACL data
> on USB transport... I've seen this few times on UPFs but have no idea on
> how this could be solved without enhancing HCI specification
>
