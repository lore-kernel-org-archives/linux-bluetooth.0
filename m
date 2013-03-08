Return-Path: <cyrus@holtmann.org>
From: "Huang, Christina" <christina.huang@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: one question on BLE device authentication error
Date: Fri, 8 Mar 2013 07:54:32 +0000
Message-ID: <A286798B34C0C9419EDBB5F44D457E14137231@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

I'm trying to use bluez 5.2 release to connect with my LE device, which is one proximity alert device. It always reports "PIN or Key Missing" and then disconnect immediately.
Btmon logs and function calls is shown below:
Bluetooth monitor ver 5.3
= New Index: 00:1A:7D:DA:71:05 (BR/EDR,USB,hci0)                [hci0] 0.777425
> HCI Event: LE Meta Event (0x3e) plen 26                       [hci0] 1.866952
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 80:CF:41:6D:0A:66 (OUI 80-CF-41)
        Data length: 14
        Name (complete): Lenovo S880i
        RSSI: -75 dBm
@ Device Found: 80:CF:41:6D:0A:66 (1) rssi -75 flags 0x0000
        0d 09 4c 65 6e 6f 76 6f 20 53 38 38 30 69        ..Lenovo S880i
> HCI Event: LE Meta Event (0x3e) plen 19                       [hci0] 2.454951
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 00:17:EA:91:8C:78 (OUI 00-17-EA)
        Data length: 7
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Link Loss (0x1803)
        RSSI: -69 dBm
@ Device Found: 00:17:EA:91:8C:78 (1) rssi -69 flags 0x0000
        02 01 06 03 03 03 18                             .......
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2          [hci0] 2.455206
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: LE Meta Event (0x3e) plen 30                       [hci0] 2.456922
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Public (0x00)
        Address: 00:17:EA:91:8C:78 (OUI 00-17-EA)
        Data length: 18
        Name (complete): UJuicer Alert
        TX power: -6 dBm
        RSSI: -69 dBm
@ Device Found: 00:17:EA:91:8C:78 (1) rssi -69 flags 0x0000
        0e 09 55 4a 75 69 63 65 72 20 41 6c 65 72 74 02  ..UJuicer Alert.
        0a fa                                            ..
> HCI Event: Command Complete (0x0e) plen 4                     [hci0] 2.461946
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x00 (6)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25       [hci0] 2.499924
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Address: 00:17:EA:91:8C:78 (OUI 00-17-EA)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
       Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                       [hci0] 2.503950
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                       [hci0] 5.723917
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 71
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Address: 00:17:EA:91:8C:78 (OUI 00-17-EA)
        Connection interval: 70.00 msec (0x0038)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28        [hci0] 5.724000
        Handle: 71
        Random number: 8c126b665d2de279
        Encryption diversifier: 0x3f55
        Long term key: dcd74a1a07f653c0e27f65888debcbe5
@ Device Connected: 00:17:EA:91:8C:78 (1) flags 0x0000
> HCI Event: Command Status (0x0f) plen 4                       [hci0] 5.733922
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 71 flags 0x02 dlen 6                      [hci0] 5.835521
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding - MITM (0x05)
> HCI Event: Encryption Change (0x08) plen 4                    [hci0] 6.115911
        Status: PIN or Key Missing (0x06)
        Handle: 71
        Encryption: Disabled (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                  [hci0] 6.115942
        Handle: 71
        Reason: Authentication Failure (0x05)
> HCI Event: Command Status (0x0f) plen 4                       [hci0] 6.117913
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                  [hci0] 6.186914
        Status: Success (0x00)
        Handle: 71
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 00:17:EA:91:8C:78 (1) reason 2

Some called function log:
received_data
event = 0x1, index = 0x0, length = 0x4
stop_passive_scanning_complete
device_connect_le
after bt_io_connect
received_data
event = 0x13, index = 0x0, length = 0x2
discovering_callback
received_data
event = 0xb, index = 0x0, length = 0xd
connected_callback
adapter_get_device
adapter_find_device
adapter_add_connection
device_add_connection
device_set_temporary
after adapter_add_connection
received_data
event = 0xc, index = 0x0, length = 0x8
dev_disconnected
adapter_find_device
bonding_complete
adapter_find_device
device_bonding_complete 
att_connect_cb
att_error_cb


Thanks.

