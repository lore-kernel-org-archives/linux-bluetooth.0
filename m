Return-Path: <cyrus@holtmann.org>
From: Adam Warski <adam@warski.org>
Content-Type: text/plain; charset=windows-1252
Subject: Passive scanning of iBeacons results in a "Data Buffer Overflow"
Message-Id: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org>
Date: Fri, 28 Feb 2014 13:41:55 +0100
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I知 trying to scan for Estimote iBeacons, using Bluez 5.15, a raspbian Linux with Kernel 3.10.26 (so on a Raspberry Pi), and a TP-LINK TL-WN725N dongle.

To test receiving of the advertisements, I知 using hcidump and hcitool lescan.

As I want to continuously receive the advertisements, I知 allowing duplicates (--duplicates). Also, I don稚 want to send scan responses, so I知 running a passive scan (--passive; running an active scan quickly results in a hardware error).

So the commands I知 running:
1st terminal: hcidump
2nd terminal: hcitool lescan --duplicates --passive

Receiving the advertisements works fine for some time (30 seconds-2 minutes), resulting in advertisement events printed by hcidump:

> HCI Event: LE Meta Event (0x3e) plen 42
    LE Advertising Report
      ADV_IND - Connectable undirected advertising (0)
      bdaddr FC:94:A8:6F:A8:10 (Random)
      Flags: 0x06
      Unknown type 0xff with 25 bytes data
      RSSI: -65

These events come at a rate of up to a couple per second. The RSSI values oscillate between -70 and -55 as the beacon is close.

But then I get:

> HCI Event: LE Meta Event (0x3e) plen 42
    LE Advertising Report
      ADV_IND - Connectable undirected advertising (0)
      bdaddr FC:94:A8:6F:A8:10 (Random)
      Flags: 0x06
      Unknown type 0xff with 25 bytes data
      RSSI: -4
> HCI Event: QoS Violation (0x1e) plen 2
    handle 1537
> HCI Event: Data Buffer Overflow (0x1a) plen 255
    type Unknown
> HCI Event: code 0xa8 plen 148
> HCI Event: code 0xf8 plen 70
> HCI Event: Physical Link Complete (0x40) plen 127
    status 0x30 phy handle 0xf5
    Error: Parameter out of Mandatory Range

The first weird thing is the abnormally large RSSI (sometimes even positive), but that may be the result of the buffer overflow, which comes next. Of course later no more packets are received, just a lot of: http://pastie.org/private/ckvvdt3plhxv84fbydyxg

I tried decreasing the scan痴 interval to 0x50 (keeping the window at 0x10), which results in fewer advertisements being received), but after some time I get the same buffer overflow.

Any ideas what can be wrong? Is it something in bluez? Something specific to the dongle?

Thanks,
Adam

-- 
Adam Warski

http://twitter.com/#!/adamwarski
http://www.softwaremill.com
http://www.warski.org

