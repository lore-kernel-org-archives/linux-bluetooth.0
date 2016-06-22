Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Wed, 22 Jun 2016 13:10:09 +0200
Message-ID: <CAEZxfGNdtXFznY_D-HLnkFBtQsHaqGbn65ZhmcKkgoh9em5L3g@mail.gmail.com>
Subject: Caching device name in different connectable state
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a bluetooth beacon device that advertises a name depending on
its configuration (connectable or not).
Sadly, in Bluez, the first time it sees it while advertising its name,
it caches it which is nice for future discovery.
Except it doesn't because I don't want to see this name while it
advertises in non-connectable state as it is "not" the same device
anymore (sort of).
I guess what I'm asking is if we can make Device name aware of the
connectable state and only use it if it matches state when it was
cached.

See some btmon trace of what it looks like in both configurations:

> HCI Event: LE Meta Event (0x3e) plen 42                                                                     [hci0] 5.600723
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: D0:65:68:C3:6E:88 (Static)
        Data length: 30
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfeaa)
        Service Data (UUID 0xfeaa): 10de0263662e706879736963616c2d77656208
        RSSI: -80 dBm (0xb0)
@ Device Found: D0:65:68:C3:6E:88 (2) rssi -80 flags 0x0004
        02 01 06 03 03 aa fe 16 16 aa fe 10 de 02 63 66  ..............cf

        2e 70 68 79 73 69 63 61 6c 2d 77 65 62 08 .physical-web.



> HCI Event: LE Meta Event (0x3e) plen 37                                                                   [hci0] 114.202975
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: D0:65:68:C3:6E:88 (Static)
        Data length: 25
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        128-bit Service UUIDs (complete): 1 entry
          a3c87500-8ed3-4bdf-8a39-a01bebede295
        Appearance: Tag (0x0200)
        RSSI: -63 dBm (0xc1)
> HCI Event: LE Meta Event (0x3e) plen 38                                                                   [hci0] 114.205892
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Random (0x01)
        Address: D0:65:68:C3:6E:88 (Static)
        Data length: 26
        Name (complete): Eddystone Config:beta
        TX power: -18 dBm
        RSSI: -61 dBm (0xc3)
@ Device Found: D0:65:68:C3:6E:88 (2) rssi -61 flags 0x0000
        02 01 06 11 07 95 e2 ed eb 1b a0 39 8a df 4b d3  ...........9..K.
        8e 00 75 c8 a3 03 19 00 02 16 09 45 64 64 79 73  ..u........Eddys
        74 6f 6e 65 20 43 6f 6e 66 69 67 3a 62 65 74 61  tone Config:beta
        02 0a ee ...
