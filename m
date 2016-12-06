Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: dominique bavay <dominique.bavay@gmail.com>
Date: Tue, 6 Dec 2016 21:55:10 +0100
Message-ID: <CALF8x-bs228_nkGkwUyRtbeeL8QXRQYnABDx5h2p+3xdi7zFbQ@mail.gmail.com>
Subject: bt arduino module issue
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

I hope i am using correctly that mail list :)
I am looking for solution for 1 week and did not find anything :/ and
i do not know where to ask :) !
here is my problem,
I have an issue with a serial port module over bluetooth (HC-06 /
linvor) for arduino Rpi etc.. . it worked correctly with bluez 4 (i do
not the version) . I am using debian 8, kernel 3.16.0-14-amd64 and
bluez 5.43
I can pair/trust the module, but the connection is not possible with
the gui. when using bluetoothctl and try to connect i get:

Attempting to connect to 00:12:03:10:71:96
[CHG] Device 00:12:03:10:71:96 Connected: yes
[CHG] Device 00:12:03:10:71:96 ServicesResolved: yes
Failed to connect: org.bluez.Error.NotAvailable
[CHG] Device 00:12:03:10:71:96 ServicesResolved: no
[CHG] Device 00:12:03:10:71:96 Connected: no

in the same time i used btmon and here it told me:
< ACL Data TX: Handle 46 flags 0x00 dlen 12

                                                  [hci0] 2668.614925
      L2CAP: Disconnection Request (0x06) ident 4 len 4
        Destination CID: 67
        Source CID: 64
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                                          [hci0] 2668.627630
        Num handles: 1
        Handle: 46
        Count: 1
> ACL Data RX: Handle 46 flags 0x02 dlen 12                                                                                                                                                     [hci0] 2668.691614
      L2CAP: Disconnection Response (0x07) ident 4 len 4
        Destination CID: 67
        Source CID: 64
< HCI Command: Read RSSI (0x05|0x0005) plen 2

                                                  [hci0] 2669.370862
        Handle: 46
> HCI Event: Command Complete (0x0e) plen 7                                                                                                                                                     [hci0] 2669.373677
      Read RSSI (0x05|0x0005) ncmd 1
        Status: Success (0x00)
        Handle: 46
        RSSI: 0 dBm (0x00)
< HCI Command: Read Link Quality (0x05|0x0003) plen 2

                                                  [hci0] 2669.373782
        Handle: 46
> HCI Event: Command Complete (0x0e) plen 7                                                                                                                                                     [hci0] 2669.375744
      Read Link Quality (0x05|0x0003) ncmd 1
        Status: Success (0x00)
        Handle: 46
        Link quality: 0xff
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3

                                                  [hci0] 2669.375926
        Handle: 46
        Type: Current Transmit Power Level (0x00)
> HCI Event: Command Complete (0x0e) plen 7                                                                                                                                                     [hci0] 2669.379749
      Read Transmit Power Level (0x03|0x002d) ncmd 1
        Status: Success (0x00)
        Handle: 46
        TX power: -1 dBm
< HCI Command: Read RSSI (0x05|0x0005) plen 2

                                                  [hci0] 2670.372415
        Handle: 46
> HCI Event: Command Complete (0x0e) plen 7                                                                                                                                                     [hci0] 2670.374710
      Read RSSI (0x05|0x0005) ncmd 1
        Status: Success (0x00)
        Handle: 46
        RSSI: 0 dBm (0x00)
< HCI Command: Read Link Quality (0x05|0x0003) plen 2

                                                  [hci0] 2670.374814
        Handle: 46
> HCI Event: Command Complete (0x0e) plen 7                                                                                                                                                     [hci0] 2670.376789
      Read Link Quality (0x05|0x0003) ncmd 1
        Status: Success (0x00)
        Handle: 46
        Link quality: 0xff
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3

                                                  [hci0] 2670.376977
        Handle: 46
        Type: Current Transmit Power Level (0x00)
> HCI Event: Command Complete (0x0e) plen 7                                                                                                                                                     [hci0] 2670.379784
      Read Transmit Power Level (0x03|0x002d) ncmd 1
        Status: Success (0x00)
        Handle: 46
        TX power: -1 dBm
< HCI Command: Disconnect (0x01|0x0006) plen 3

                                                  [hci0] 2670.692650
        Handle: 46
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                                                                                                                                                       [hci0] 2670.698800
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                                                                                                                                                  [hci0] 2670.778725
        Status: Success (0x00)
        Handle: 46
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 00:12:03:10:71:96 (0) reason 2

i did not find  interesting log in the /var/log/ files
does anyone have an idea to get more logs ?
Thanks a lot,
Dominique,
ps: please apologize for my english :p
