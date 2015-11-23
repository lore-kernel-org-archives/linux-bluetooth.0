Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Mon, 23 Nov 2015 15:43:11 +0100
Message-ID: <CAEZxfGPTxwUZzU+3XSV-uiN+DMz+hyOKiiZfgF+oD6pp=-XiOA@mail.gmail.com>
Subject: Unknown Connection Identifier
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone!

Would you know why I get a "Status: Unknown Connection Identifier
(0x02)" error while trying to connect to a BLE device, causing a
"Connect failed" message. However sometimes, as you can read below, it
is still able to connect to it.

Bluetooth monitor ver 5.35
...
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
[hci0] 15:36:33.367332
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4                            [hci0] 15:36:33.368113
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
[hci0] 15:36:33.368139
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                            [hci0] 15:36:33.369111
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 43                              [hci0] 15:36:37.636180
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
        Data length: 31
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: Anhui Huami Information Technology Co., Ltd. (343)
          Data: 0093590469cb1080738d253d87117136f902880f109deb42
        RSSI: -60 dBm (0xc4)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
[hci0] 15:36:37.636249
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                            [hci0] 15:36:37.637121
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
[hci0] 15:36:37.637198
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                              [hci0] 15:36:37.638083
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0
[hci0] 15:36:39.643232
> HCI Event: Command Complete (0x0e) plen 4                            [hci0] 15:36:39.644088
      LE Create Connection Cancel (0x08|0x000e) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                              [hci0] 15:36:39.646071
      LE Connection Complete (0x01)
        Status: Unknown Connection Identifier (0x02)
        Handle: 32
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ Connect Failed: 88:0F:10:9D:EB:42 (1) status 0x02
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
[hci0] 15:36:39.663306
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4                            [hci0] 15:36:39.664082
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
[hci0] 15:36:39.664181
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                            [hci0] 15:36:39.665078
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 43                              [hci0] 15:36:40.647148
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
        Data length: 31
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: Anhui Huami Information Technology Co., Ltd. (343)
          Data: 0093590469cb1080738d253d87117136f902880f109deb42
        RSSI: -61 dBm (0xc3)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
[hci0] 15:36:40.647275
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                            [hci0] 15:36:40.648077
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
[hci0] 15:36:40.648195
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                              [hci0] 15:36:40.649074
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                              [hci0] 15:36:42.154146
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 32
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
[hci0] 15:36:42.154539
        Handle: 32
@ Device Connected: 88:0F:10:9D:EB:42 (1) flags 0x0000
