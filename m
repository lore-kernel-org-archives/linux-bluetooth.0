Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Steve Benton <steve.benton@gmail.com>
Date: Fri, 21 Apr 2017 09:56:36 -0500
Message-ID: <CANQDEJHPrMtbv1+Xs2zOEpUhD0YD0c2nQbK3cX0fZA_-EG+FgQ@mail.gmail.com>
Subject: BlueZ 5 Unknown Connection Identifier
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have a Raspberry Pi 3 running the latest Raspbian, and I have
upgraded bluez from 5.23. to 5.43. I am attempting to connect to BLE
devices that advertise at 2 second interval. I wrote some code based
on gatttool and attempted to connect to these devices. I run into the
le connect request being cancelled after 2 seconds. From my research I
ran across this from about 15 months ago in the archives,

https://www.spinics.net/lists/linux-bluetooth/msg65434.html

However after following the threads, I did not see if a resolution was found.

I have ran tests with my code, the gatttool utility and well as using
bluetoothctl. I see the same type of activity in btmon that is listed
below:


< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
                 [hci0] 21:45:51.917070
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                             [hci0] 21:45:51.917819
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
                 [hci0] 21:45:51.917876
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                             [hci0] 21:45:51.918357
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 27                                               [hci0] 21:45:52.597503
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: D3:67:2D:D1:46:46 (Static)
        Data length: 15
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: FedEx Services (321)
          Data: 070a111080d28004
        RSSI: -63 dBm (0xc1)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
                 [hci0] 21:45:52.597611
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                             [hci0] 21:45:52.599626
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
                 [hci0] 21:45:52.599701
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: D3:67:2D:D1:46:46 (Static)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                               [hci0] 21:45:52.600508
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0
                 [hci0] 21:45:54.597597
> HCI Event: Command Complete (0x0e) plen 4                                             [hci0] 21:45:54.684146
      LE Create Connection Cancel (0x08|0x000e) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                               [hci0] 21:45:54.684361
      LE Connection Complete (0x01)
        Status: Unknown Connection Identifier (0x02)
        Handle: 64
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: D3:67:2D:D1:46:46 (Static)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ Connect Failed: D3:67:2D:D1:46:46 (2) status 0x02


Has there been a resolution to this? Is there a way to change the
connect timeout?

One thing to note is if I use hcitool to connect, I am able to connect
most all of the time. I know this is not the L2CAP layer, but I can
see that I am able to connect.

Thanks
