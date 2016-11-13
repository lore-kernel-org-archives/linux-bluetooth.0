Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Trump DD <wrxzzj@gmail.com>
Date: Sun, 13 Nov 2016 17:48:59 +0800
Message-ID: <CABuKQijYU5Ndst=ZKjPcy0MEOrmocAgNE_BDppgYNf_L0iBmBw@mail.gmail.com>
Subject: Why bluetoothd disconnect immediate follow connected event , what's
 wrong with my bluez ?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys
   I met a very strang issue about config Microsoft Designer Mouse
(Bluetooth LE)
I have paired and trust my devices already, and connected it success,
all works fine.
But after I reboot my computer,  when I click a mouse button, I see
'connected'  in bluetoothctl, immediate a 'disconnect' event follow.
what's wrong with my bluetooth.
below it's my log files

bluetoothctl log:
[NEW] Controller A4:34:D9:2B:2E:41 debian [default]
[NEW] Device C0:11:5B:C2:55:DF Designer Mouse
[CHG] Device C0:11:5B:C2:55:DF Connected: yes
[CHG] Device C0:11:5B:C2:55:DF Connected: no
[bluetooth]# info C0:11:5B:C2:55:DF
Device C0:11:5B:C2:55:DF
        Name: Designer Mouse
        Alias: Designer Mouse
        Appearance: 0x03c2
        Icon: input-mouse
        Paired: yes
        Trusted: yes
        Blocked: no
        Connected: no
        LegacyPairing: no
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
        UUID: Battery Service           (0000180f-0000-1000-8000-00805f9b34fb)
        UUID: Human Interface Device    (00001812-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v045Ep0805d0110
[bluetooth]#


bluetoothd log after I click mouse button:

bluetoothd[552]: src/adapter.c:connected_callback() hci0 device
C0:11:5B:C2:55:DF connected eir_len 27
bluetoothd[552]: src/adapter.c:disconnected_callback() reason = 2
bluetoothd[552]: src/adapter.c:dev_disconnected() Device
C0:11:5B:C2:55:DF disconnected, reason 2
bluetoothd[552]: src/adapter.c:adapter_remove_connection()
bluetoothd[552]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
C0:11:5B:C2:55:DF type 2 status 0xe
bluetoothd[552]: src/device.c:device_bonding_complete() bonding (nil)
status 0x0e
bluetoothd[552]: src/device.c:device_bonding_failed() status 14
bluetoothd[552]: src/adapter.c:resume_discovery()


btmon.log:

Bluetooth monitor ver 5.43
= Note: Linux version 4.8.7 (x86_64)                                   0.680553
= Note: Bluetooth subsystem version 2.21                               0.680558
= New Index: A4:34:D9:2B:2E:41 (Primary,USB,hci0)               [hci0] 0.680560
= Open Index: A4:34:D9:2B:2E:41                                 [hci0] 0.680562
= Index Info: A4:34:D9:2B:2E:41 (Intel Corp.)                   [hci0] 0.680564
> HCI Event: LE Meta Event (0x3e) plen 39                      [hci0] 15.114469
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: C0:11:5B:C2:55:DF (Static)
        Data length: 27
        Name (complete): Designer Mouse
        Appearance: Mouse (0x03c2)
        Flags: 0x04
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Human Interface Device (0x1812)
        RSSI: -44 dBm (0xd4)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0] 15.114560
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 15.117454
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25      [hci0] 15.117533
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: C0:11:5B:C2:55:DF (Static)
        Own address type: Random (0x01)
        Min connection interval: 7.50 msec (0x0006)
        Max connection interval: 7.50 msec (0x0006)
        Connection latency: 0x003c
        Supervision timeout: 3000 msec (0x012c)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 15.119462
      LE Create Connection (0x08|0x000d) ncmd 2
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                      [hci0] 15.152484
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 3585
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: C0:11:5B:C2:55:DF (Static)
        Connection interval: 7.50 msec (0x0006)
        Connection latency: 75.00 msec (0x003c)
        Supervision timeout: 3000 msec (0x012c)
        Master clock accuracy: 0x00
< HCI Command: LE Read Remote Used Fea.. (0x08|0x0016) plen 2  [hci0] 15.152731
        Handle: 3585
@ Device Connected: C0:11:5B:C2:55:DF (2) flags 0x0000
        0f 09 44 65 73 69 67 6e 65 72 20 4d 6f 75 73 65  ..Designer Mouse
        03 19 c2 03 02 01 04 03 03 12 18                 ...........
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 15.153245
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 12                      [hci0] 15.169486
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 3585
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 17.187533
        Handle: 3585
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 17.188560
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 17.466778
        Status: Success (0x00)
        Handle: 3585
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: C0:11:5B:C2:55:DF (2) reason 2
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0] 17.495493
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 17.496545
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0] 17.496602
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 17.497555
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 36                      [hci0] 17.559800
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 08:7C:BE:87:03:E4 (Quintic Corp.)
        Data length: 24
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Service Data (UUID 0xfe95): 7120830002e40387be7c08090510020016
        RSSI: -91 dBm (0xa5)
> HCI Event: LE Meta Event (0x3e) plen 35                      [hci0] 17.682920
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: 42:54:92:F8:E1:8E (Resolvable)
        Data length: 23
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: Apple, Inc. (76)
          Type: Unknown (12)
          Data: 00ee11265467e3c8de62466d97bc
        RSSI: -91 dBm (0xa5)
> HCI Event: LE Meta Event (0x3e) plen 36                      [hci0] 18.098143
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: F4:D0:9A:3C:D1:86 (OUI F4-D0-9A)
        Data length: 24
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: not assigned (4660)
          Data: 86d13c9ad0f40000
        Name (complete): bong3HR
        RSSI: -91 dBm (0xa5)
> HCI Event: LE Meta Event (0x3e) plen 36                      [hci0] 19.899089
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: F2:1F:37:29:8D:41 (OUI F2-1F-37)
        Data length: 24
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: not assigned (4660)
          Data: 418d29371ff20000
        Name (complete): bong3HR
        RSSI: -87 dBm (0xa9)
> HCI Event: LE Meta Event (0x3e) plen 43                      [hci0] 20.583438
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 88:0F:10:8E:43:68 (Huami Information Technology Co.,Ltd.)
        Data length: 31
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (partial): 1 entry
          Weight Scale (0x181d)
        Company: Anhui Huami Information Technology Co., Ltd. (343)
          Data: 880f108e4368
        Service Data (UUID 0x181d): a2e439b20801030a252b
        RSSI: -94 dBm (0xa2)
> HCI Event: LE Meta Event (0x3e) plen 43                      [hci0] 21.505731
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: F6:84:DE:B1:2B:E7 (Static)
        Data length: 31
        Flags: 0x04
          BR/EDR Not Supported
        128-bit Service UUIDs (partial): 1 entry
          Vendor specific (adabfb00-6e7d-4601-bda2-bffaa68956ba)
        Service Data (UUID 0x180a): 08048e210000
        RSSI: -86 dBm (0xaa)




-- 
Thanks
