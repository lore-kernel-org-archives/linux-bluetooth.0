Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tom Harada <tomharada@lnihealth.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: Privacy mode breaking BLE reconnects
Message-ID: <2cd3f83d-6057-c813-4eaf-50a39d4e85a7@lnihealth.com>
Date: Thu, 9 Jun 2016 12:46:23 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------67283264EC3185DEE11D1D9C"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--------------67283264EC3185DEE11D1D9C
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

I have a particular device that requires an IRK from BlueZ during 
pairing. To my limited understanding this is wrong since my Bluetooth 
adapter uses a public address by default, but I have to live with it in 
any case. I've found that turning on privacy mode using `btmgmt privacy 
on` allows BlueZ to pair with the device. However, it also prevents 
reconnecting to any already-paired BLE device, even if privacy mode was 
enabled when I paired with it.

This is the sequence of events:
1. Pair with a BLE device.
2. Power off the adapter, run `btmgmt privacy on`, and power the adapter 
back on.
3. Connect to the device. The connection fails with the status 
"Connection Failed to be Established" in the LE Read Remote Used 
Features HCI event.

It makes no difference whether privacy mode is already on when I turn it 
on. I can connect to the device after re-pairing it.

Since the privacy setting doesn't appear to persist across reboots, I 
don't have the option of not setting it. Is this behavior expected? Is 
there a different approach I should be taking with the strange device?

I'm using version 5.39 of bluetoothd and btmgmt with a 4.4.11 kernel. My 
hardware is the Raspberry Pi 3's BCM43438.

Thanks in advance for any input.

--------------67283264EC3185DEE11D1D9C
Content-Type: text/x-log; name="connect_failure.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="connect_failure.log"

Bluetooth monitor ver 5.23
= New Index: B8:27:EB:91:0B:31 (BR/EDR,UART,hci0)                                                              [hci0] 0.353457
* Unknown packet (code 8 len 0)                                                                                [hci0] 0.353460
* Unknown packet (code 10 len 8)                                                                               [hci0] 0.353461
        31 0b 91 eb 27 b8 0f 00                          1...'...        
> HCI Event: Inquiry Complete (0x01) plen 1                                                                    [hci0] 0.743440
        Status: Success (0x00)
@ Discovering: 0x00 (7)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7                                                     [hci0] 6.484866
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                    [hci0] 6.485865
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                         [hci0] 6.485929
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                    [hci0] 6.486642
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x01 (7)
> HCI Event: LE Meta Event (0x3e) plen 33                                                                      [hci0] 6.505004
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 00:60:19:20:1D:12 (Roche Diagnostics)
        Data length: 21
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Glucose (0x1808)
        TX power: 0 dBm
        Name (complete): Accu-Chek
        RSSI: -46 dBm (0xd2)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                        [hci0] 11.618286
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                   [hci0] 11.619654
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: Inquiry (0x01|0x0001) plen 5                                                                   [hci0] 11.619737
        Access code: 0x9e8b33 (General Inquiry)
        Length: 5.12s (0x04)
        Num responses: 0
@ Device Found: 00:60:19:20:1D:12 (1) rssi -46 flags 0x0000
        02 01 05 03 03 08 18 02 0a 00 0a 09 41 63 63 75  ............Accu
        2d 43 68 65 6b                                   -Chek           
> HCI Event: Command Status (0x0f) plen 4                                                                     [hci0] 11.621401
      Inquiry (0x01|0x0001) ncmd 1
        Status: Success (0x00)
> HCI Event: Inquiry Complete (0x01) plen 1                                                                   [hci0] 16.744733
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7                                                    [hci0] 16.744831
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
@ Discovering: 0x00 (7)
> HCI Event: Command Complete (0x0e) plen 4                                                                   [hci0] 16.745331
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                        [hci0] 16.745390
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                   [hci0] 16.747477
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 33                                                                     [hci0] 16.776836
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 00:60:19:20:1D:12 (Roche Diagnostics)
        Data length: 21
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Glucose (0x1808)
        TX power: 0 dBm
        Name (complete): Accu-Chek
        RSSI: -38 dBm (0xda)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                        [hci0] 16.776906
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                   [hci0] 16.778418
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25                                                     [hci0] 16.778474
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:60:19:20:1D:12 (Roche Diagnostics)
        Own address type: Random (0x01)
        Min connection interval: 20.00 msec (0x0010)
        Max connection interval: 40.00 msec (0x0020)
        Connection latency: 0x0000
        Supervision timeout: 1000 msec (0x0064)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                                     [hci0] 16.779545
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                                                     [hci0] 16.803606
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 64
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:60:19:20:1D:12 (Roche Diagnostics)
        Connection interval: 37.50 msec (0x001e)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 1000 msec (0x0064)
        Master clock accuracy: 0x00
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2                                              [hci0] 16.803920
        Handle: 64
> HCI Event: Command Status (0x0f) plen 4                                                                     [hci0] 16.804528
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
@ Device Connected: 00:60:19:20:1D:12 (1) flags 0x0000
        02 01 05 03 03 08 18 02 0a 00 0a 09 41 63 63 75  ............Accu
        2d 43 68 65 6b                                   -Chek           
> HCI Event: LE Meta Event (0x3e) plen 12                                                                     [hci0] 17.052965
      LE Read Remote Used Features (0x04)
        Status: Connection Failed to be Established (0x3e)
        Handle: 64
        Features: 0x1f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Connection Parameter Request Procedure
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Ping
> HCI Event: Disconnect Complete (0x05) plen 4                                                                [hci0] 17.053862
        Status: Success (0x00)
        Handle: 64
        Reason: Connection Failed to be Established (0x3e)
@ Device Disconnected: 00:60:19:20:1D:12 (1) reason 0
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7                                                    [hci0] 22.484299
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                   [hci0] 22.485422
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                        [hci0] 22.485517
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                   [hci0] 22.486037
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x01 (7)

--------------67283264EC3185DEE11D1D9C
Content-Type: text/x-log; name="connect_success.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="connect_success.log"

Bluetooth monitor ver 5.23
= New Index: B8:27:EB:91:0B:31 (BR/EDR,UART,hci0)                                                              [hci0] 0.108559
* Unknown packet (code 8 len 0)                                                                                [hci0] 0.108563
* Unknown packet (code 10 len 8)                                                                               [hci0] 0.108564
        31 0b 91 eb 27 b8 0f 00                          1...'...        
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7                                                     [hci0] 1.484629
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                    [hci0] 1.485103
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                         [hci0] 1.485133
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                    [hci0] 1.485602
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x01 (7)
> HCI Event: LE Meta Event (0x3e) plen 33                                                                      [hci0] 4.613281
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 00:60:19:20:1D:12 (Roche Diagnostics)
        Data length: 21
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Glucose (0x1808)
        TX power: 0 dBm
        Name (complete): Accu-Chek
        RSSI: -60 dBm (0xc4)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                         [hci0] 6.618295
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                    [hci0] 6.620688
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: Inquiry (0x01|0x0001) plen 5                                                                    [hci0] 6.620768
        Access code: 0x9e8b33 (General Inquiry)
        Length: 5.12s (0x04)
        Num responses: 0
@ Device Found: 00:60:19:20:1D:12 (1) rssi -60 flags 0x0000
        02 01 05 03 03 08 18 02 0a 00 0a 09 41 63 63 75  ............Accu
        2d 43 68 65 6b                                   -Chek           
> HCI Event: Command Status (0x0f) plen 4                                                                      [hci0] 6.622799
      Inquiry (0x01|0x0001) ncmd 1
        Status: Success (0x00)
> HCI Event: Extended Inquiry Result (0x2f) plen 255                                                           [hci0] 7.864743
        Num responses: 1
        Address: 2C:81:58:C3:F3:68 (Hon Hai Precision Ind. Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P0 (0x00)
        Class: 0x2a010c
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Laptop
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Audio (Speaker, Microphone, Headset)
        Clock offset: 0x6150
        RSSI: -85 dBm (0xab)
@ Device Found: 2C:81:58:C3:F3:68 (0) rssi -85 flags 0x0001
        04 0d 0c 01 2a                                   ....*           
> HCI Event: Extended Inquiry Result (0x2f) plen 255                                                          [hci0] 10.397855
        Num responses: 1
        Address: 2C:81:58:C3:F3:68 (Hon Hai Precision Ind. Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P0 (0x00)
        Class: 0x2a010c
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Laptop
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Audio (Speaker, Microphone, Headset)
        Clock offset: 0x6150
        RSSI: -88 dBm (0xa8)
        Name (complete): HUA-VAIO
        TX power: 0 dBm
@ Device Found: 2C:81:58:C3:F3:68 (0) rssi -88 flags 0x0000
        09 09 48 55 41 2d 56 41 49 4f 02 0a 00 04 0d 0c  ..HUA-VAIO......
        01 2a                                            .*              
> HCI Event: Inquiry Complete (0x01) plen 1                                                                   [hci0] 11.745767
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7                                                    [hci0] 11.745850
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                   [hci0] 11.746390
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                        [hci0] 11.746427
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                   [hci0] 11.747159
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x00 (7)
> HCI Event: LE Meta Event (0x3e) plen 33                                                                     [hci0] 11.760827
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 00:60:19:20:1D:12 (Roche Diagnostics)
        Data length: 21
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Glucose (0x1808)
        TX power: 0 dBm
        Name (complete): Accu-Chek
        RSSI: -46 dBm (0xd2)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                        [hci0] 11.760892
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                   [hci0] 11.763240
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25                                                     [hci0] 11.763288
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:60:19:20:1D:12 (Roche Diagnostics)
        Own address type: Random (0x01)
        Min connection interval: 20.00 msec (0x0010)
        Max connection interval: 40.00 msec (0x0020)
        Connection latency: 0x0000
        Supervision timeout: 1000 msec (0x0064)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                                     [hci0] 11.764107
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                                                     [hci0] 11.787744
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 64
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:60:19:20:1D:12 (Roche Diagnostics)
        Connection interval: 37.50 msec (0x001e)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 1000 msec (0x0064)
        Master clock accuracy: 0x00
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2                                              [hci0] 11.788046
        Handle: 64
> HCI Event: Command Status (0x0f) plen 4                                                                     [hci0] 11.788556
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
@ Device Connected: 00:60:19:20:1D:12 (1) flags 0x0000
        02 01 05 03 03 08 18 02 0a 00 0a 09 41 63 63 75  ............Accu
        2d 43 68 65 6b                                   -Chek           
> ACL Data RX: Handle 64 flags 0x02 dlen 16                                                                   [hci0] 11.853984
      LE L2CAP: Connection Parameter Update Request (0x12) ident 1 len 8
        Min interval: 16
        Max interval: 32
        Slave latency: 0
        Timeout multiplier: 100
> HCI Event: LE Meta Event (0x3e) plen 12                                                                     [hci0] 11.966630
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 64
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28                                                      [hci0] 11.966696
        Handle: 64
        Random number: 0x0000020100200400
        Encrypted diversifier: 0x0000
        Long term key: fc83d761a189c5f349f32610e6130962
< ACL Data TX: Handle 64 flags 0x00 dlen 10                                                                   [hci0] 11.966765
      LE L2CAP: Connection Parameter Update Response (0x13) ident 1 len 2
        Result: Connection Parameters accepted (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                                     [hci0] 11.967833
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Connection Update (0x08|0x0013) plen 14                                                     [hci0] 11.967886
        Handle: 64
        Min connection interval: 20.00 msec (0x0010)
        Max connection interval: 40.00 msec (0x0020)
        Connection latency: 0x0000
        Supervision timeout: 1000 msec (0x0064)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                                     [hci0] 11.968498
      LE Connection Update (0x08|0x0013) ncmd 1
        Status: Success (0x00)
@ New Conn Param: 00:60:19:20:1D:12 (1) hint 1 min 0x0010 max 0x0020 latency 0x0000 timeout 0x0064
> HCI Event: Encryption Change (0x08) plen 4                                                                  [hci0] 12.303940
        Status: Success (0x00)
        Handle: 64
        Encryption: Enabled with AES-CCM (0x01)
< ACL Data TX: Handle 64 flags 0x00 dlen 7                                                                    [hci0] 12.412654
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5                                                        [hci0] 12.416505
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 7                                                                    [hci0] 12.453913
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 23
< ACL Data TX: Handle 64 flags 0x00 dlen 11                                                                   [hci0] 12.454322
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 64 flags 0x02 dlen 24                                                                   [hci0] 12.529693
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute data list: 3 entries
        Handle: 0x0001
        Value: 05000018
        Handle: 0x0006
        Value: 13000818
        Handle: 0x0014
        Value: 20000a18
< ACL Data TX: Handle 64 flags 0x00 dlen 11                                                                   [hci0] 12.529983
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0021-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                        [hci0] 12.579153
        Num handles: 1
        Handle: 64
        Count: 2
> HCI Event: LE Meta Event (0x3e) plen 10                                                                     [hci0] 12.579451
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 64
        Connection interval: 37.50 msec (0x001e)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 1000 msec (0x0064)
> ACL Data RX: Handle 64 flags 0x02 dlen 26                                                                   [hci0] 12.654715
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute data list: 1 entry
        Handle: 0x0021
        Value: 240000000000000000100010000000000000
< ACL Data TX: Handle 64 flags 0x00 dlen 11                                                                   [hci0] 12.654966
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0025-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 64 flags 0x02 dlen 9                                                                    [hci0] 12.728973
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0025
        Error: Attribute Not Found (0x0a)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                        [hci0] 12.875254
        Num handles: 1
        Handle: 64
        Count: 1
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7                                                    [hci0] 17.483825
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                   [hci0] 17.484548
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                        [hci0] 17.484609
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                   [hci0] 17.485081
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x01 (7)
< HCI Command: Disconnect (0x01|0x0006) plen 3                                                                [hci0] 22.481674
        Handle: 64
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                                                                     [hci0] 22.482148
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                                                                [hci0] 22.517050
        Status: Success (0x00)
        Handle: 64
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 00:60:19:20:1D:12 (1) reason 2
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                        [hci0] 22.618279
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                   [hci0] 22.620449
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: Inquiry (0x01|0x0001) plen 5                                                                   [hci0] 22.620506
        Access code: 0x9e8b33 (General Inquiry)
        Length: 5.12s (0x04)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4                                                                     [hci0] 22.621724
      Inquiry (0x01|0x0001) ncmd 1
        Status: Success (0x00)
> HCI Event: Extended Inquiry Result (0x2f) plen 255                                                          [hci0] 23.252923
        Num responses: 1
        Address: 2C:81:58:C3:F3:68 (Hon Hai Precision Ind. Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P0 (0x00)
        Class: 0x2a010c
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Laptop
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Audio (Speaker, Microphone, Headset)
        Clock offset: 0x6151
        RSSI: -85 dBm (0xab)
        Name (complete): HUA-VAIO
        TX power: 0 dBm
@ Device Found: 2C:81:58:C3:F3:68 (0) rssi -85 flags 0x0000
        09 09 48 55 41 2d 56 41 49 4f 02 0a 00 04 0d 0c  ..HUA-VAIO......
        01 2a                                            .*              

--------------67283264EC3185DEE11D1D9C--
