Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 16 Jul 2015 12:30:06 +0200
Message-ID: <CANzaTi6_OF9C6DjPeRqaoUBKqdJZSQ+0k0cJLodWS3o5LzTsbw@mail.gmail.com>
Subject: Advertising API, possible to set LE only?
From: dogan yazar <doganyazar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the Advertising API, org.bluez.LEAdvertisement1 has Type field
which can be "broadcast" or "peripheral".
When I set it to be peripheral, the outgoing advertisement packets has
the advertisement flags:
0x02 (BLE_GAP_ADV_FLAG_LE_GENERAL_DISC_MODE) and I guess that is why
when I try to connect the peripheral from my Android, I get a pairing
request back.

Is there a way to set BLE_GAP_ADV_FLAG_BR_EDR_NOT_SUPPORTED on the
flags as well to show I only support LE and so I can also skip the
pairing requests.
