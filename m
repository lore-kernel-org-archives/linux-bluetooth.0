Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 11 Feb 2009 10:16:21 -0700
Message-ID: <d89ddf300902110916r794a2d4bpab764a33b077ad91@mail.gmail.com>
Subject: logitech and repeated keys
From: Brad Midgley <bmidgley@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I've been following major releases with ubuntu. On the last release, I
found that the logitech mx5000 bluetooth keyboard I use has started
repeating keys. It's especially bad after it's been idle and also if I
start typing quickly. I'll disable key repeats in the keyboard control
panel but that's not entirely satisfactory either.

This wasn't happening before 8.10. I'm running 2.6.27-9-generic and bluez 4.12.

The dump when I typed a quick "hello" (it came out "heeeeeeeello")

> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x00 interval 0
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x02 interval 802
    Mode: Sniff
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 45 mode 0x00 interval 0
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 45 mode 0x02 interval 120
    Mode: Sniff
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 0b 00 00 00  00 00                    ..........
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 0b 08 00 00  00 00                    ..........
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 08 00 00 00  00 00                    ..........
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 0f 00 00 00  00 00                    ..........
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 0f 00 00 00  00 00                    ..........
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 12 00 00 00  00 00                    ..........
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x00 interval 0
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x02 interval 32
    Mode: Sniff
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x00 interval 0
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x02 interval 162
    Mode: Sniff
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x00 interval 0
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x02 interval 402
    Mode: Sniff


-- 
Brad Midgley
