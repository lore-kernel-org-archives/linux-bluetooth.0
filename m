Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Mon, 25 Jan 2016 16:23:24 +0100
Message-ID: <CAEZxfGMJZva2Rmfm4P8D+zTnY7RbvaaA-e3R3SxoLycuD9D==A@mail.gmail.com>
Subject: Two connect failed...
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I fail to understand what is happening here and I would appreciate your help.
I'm able to see my nearby device (NRF51822DK) with the "scan on" command.
However when calling "connect F1:6F:DE:EC:F1:D6" from bluetoothctl, I
get a "connect failed" error...
And from times to times, it magically works... meaning it gets a
connect failed but eventually create a connection with a single
"connect" command by the way.

Here's a btmon trace below.

Bluetooth monitor ver 5.35
= New Index: A4:17:31:78:A6:04 (BR/EDR,USB,hci0)
                                                     [hci0] 0.753884


< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
                                                    [hci0] 22.180529
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                                [hci0] 22.181008
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
                                                    [hci0] 22.181041
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                                [hci0] 22.182008
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 36                                                                                  [hci0] 22.264099
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: F1:6F:DE:EC:F1:D6 (Static)
        Data length: 24
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        Name (complete): Espruino NRF51822DK
        RSSI: -49 dBm (0xcf)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
                                                    [hci0] 22.264224
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                                [hci0] 22.265029
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
                                                    [hci0] 22.265139
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: F1:6F:DE:EC:F1:D6 (Static)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                                                  [hci0] 22.266017
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0
                                                    [hci0] 24.269467
> HCI Event: Command Complete (0x0e) plen 4                                                                                [hci0] 24.271009
      LE Create Connection Cancel (0x08|0x000e) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                                                                  [hci0] 24.272993
      LE Connection Complete (0x01)
        Status: Unknown Connection Identifier (0x02)
        Handle: 32
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: F1:6F:DE:EC:F1:D6 (Static)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ Connect Failed: F1:6F:DE:EC:F1:D6 (2) status 0x02
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
                                                    [hci0] 24.282482
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                                [hci0] 24.282992
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
                                                    [hci0] 24.283021
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                                [hci0] 24.283990
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 36                                                                                  [hci0] 26.283994
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: F1:6F:DE:EC:F1:D6 (Static)
        Data length: 24
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        Name (complete): Espruino NRF51822DK
        RSSI: -46 dBm (0xd2)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
                                                    [hci0] 26.284088
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                                [hci0] 26.284989
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
                                                    [hci0] 26.285068
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: F1:6F:DE:EC:F1:D6 (Static)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                                                  [hci0] 26.285982
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0
                                                    [hci0] 28.289490
> HCI Event: Command Complete (0x0e) plen 4                                                                                [hci0] 28.290991
      LE Create Connection Cancel (0x08|0x000e) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                                                                  [hci0] 28.292966
      LE Connection Complete (0x01)
        Status: Unknown Connection Identifier (0x02)
        Handle: 32
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: F1:6F:DE:EC:F1:D6 (Static)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ Connect Failed: F1:6F:DE:EC:F1:D6 (2) status 0x02
