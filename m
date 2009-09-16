Return-Path: <cyrus@holtmann.org>
Message-ID: <4AB128CC.6090807@charter.net>
Date: Wed, 16 Sep 2009 14:05:00 -0400
From: Peter Hurley <phurley@charter.net>
MIME-Version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Odd eSCO behavior with BCM2045-based receiver
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While attempting to setup a Motorola S9 headset with a BCM2045-based USB 
dongle (Dell-branded Logitech device), I've observed some strange eSCO 
behavior.  I'm running 64-bit 2.6.31 kernel with bluez 4.52.

Behavior # 1:  when attempting a SCO connection, frequently the 
connection is rejected with Reserved Slot Violation status return from 
the Synchronous Connect Complete event.  The SCO connection occasionally 
succeeds as an eSCO connection in CVSD mode. I've been experimenting 
with this for a while. (After some more observation, it may be that the 
successful path is preceded by a mode change to sniff mode) Any ideas?

Behavior # 2:  The bt receiver's LM crashes when the eSCO connection is 
disconnected (here's the hcidump):

2009-09-15 18:35:41.675877 > SCO data: handle 6 flags 0x00 dlen 48
    0000: 29 00 4f 00 46 00 0a 00  00 00 0b 00 1f 00 10 00  ).O.F...........
    0010: e8 ff ee ff eb ff bf ff  da ff 1e 00 fd ff f1 ff  ................
    0020: 00 00 ee ff 2b 00 26 00  c8 ff bf ff e4 ff 0b 00  ....+.&.........
2009-09-15 18:35:41.676957 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 6 reason 0x13
    Reason: Remote User Terminated Connection
2009-09-15 18:35:41.681877 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2009-09-15 18:35:41.685875 > SCO data: handle 6 flags 0x00 dlen 48
    0000: 38 00 2d 00 ef ff fd ff  01 00 05 00 29 00 29 00  8.-.........).).
    0010: cd ff b1 ff ce ff c9 ff  f9 ff 09 00 dd ff 15 00  ................
    0020: 02 00 0c 00 49 00 15 00  fc ff e6 ff f7 ff 34 00  ....I.........4.
2009-09-15 18:35:41.685876 > SCO data: handle 6 flags 0x00 dlen 48
    0000: 20 00 17 00 27 00 fe ff  e5 ff eb ff 0c 00 23 00   ...'.........#.
    0010: e7 ff a4 ff c8 ff f6 ff  f7 ff fa ff 0e 00 06 00  ................
    0020: 10 00 46 00 29 00 d5 ff  c4 ff ec ff f4 ff 11 00  ..F.)...........
2009-09-15 18:35:41.685876 > SCO data: handle 6 flags 0x00 dlen 48
    0000: 3b 00 20 00 09 00 14 00  ec ff c5 ff f1 ff 26 00  ;. ...........&.
    0010: 1e 00 03 00 cf ff b5 ff  f5 ff 0d 00 fb ff 0b 00  ................
    0020: e2 ff d6 ff 16 00 1d 00  06 00 0f 00 2f 00 40 00  ............/.@.
2009-09-15 18:35:41.695877 > SCO data: handle 6 flags 0x00 dlen 48
    0000: 1a 00 eb ff eb ff f0 ff  bf ff c3 ff 07 00 07 00  ................
    0010: f9 ff 09 00 06 00 0c 00  16 00 fe ff ea ff 10 00  ................
    0020: 21 00 01 00 e3 ff ce ff  d8 ff f3 ff f4 ff 0f 00  !...............
2009-09-15 18:36:11.758191 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x22
    Reason: LMP Response Timeout
2009-09-15 18:36:11.908200 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x22
    Reason: LMP Response Timeout

After this, *all connections with every device* are terminated (note 
that in the above sequence handle 11 was disconnected as well) and 
cannot be restarted without unplugging the dongle ('hcitool reset' 
operates but is ineffective) and restarting the daemon.  Again, I'd 
welcome any suggestions for further experimentation.  I do not have a 
sniffer.

Thanks,
Peter Hurley



