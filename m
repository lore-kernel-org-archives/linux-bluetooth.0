Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 14 Apr 2010 11:10:48 +0300
Message-ID: <k2i2d5a2c101004140110s5834b2e6u86290c6466baa723@mail.gmail.com>
Subject: detecting dead link
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

It seems that most of the chips take a lot of time to detect that a
link in dead, due to out of range or power off (no hci disconnect),
the most common problem regarding this is when we try to connect SCO:

2010-03-31 18:40:19.975128 < HCI Command: Setup Synchronous Connection
(0x01|0x0028) plen 17
    handle 11 voice setting 0x0060
2010-03-31 18:40:19.981780 > HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
2010-03-31 18:40:33.318023 < ACL data: handle 11 flags 0x02 dlen 22
    L2CAP(d): cid 0x0073 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 32 2c 33 0d  i....+CIEV: 2,3.
      0010: 0a 3e                                             .>
2010-03-31 18:40:33.318145 < HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
    handle 11
2010-03-31 18:40:33.324615 > HCI Event: Command Status (0x0f) plen 4
    Exit Sniff Mode (0x02|0x0004) status 0x00 ncmd 1
2010-03-31 18:40:51.207885 < ACL data: handle 11 flags 0x02 dlen 22
    L2CAP(d): cid 0x0073 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 32 2c 32 0d  i....+CIEV: 2,2.
      0010: 0a 3e                                             .>
2010-03-31 18:40:54.965362 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 11 slots 5
2010-03-31 18:40:54.966094 > HCI Event: Synchronous Connect Complete (0x2c)
plen 17
    status 0x08 handle 0 bdaddr 00:1E:DC:B3:40:9D type eSCO
    Error: Connection Timeout
2010-03-31 18:40:54.968353 > HCI Event: Number of Completed Packets (0x13) plen
5
    handle 11 packets 2
2010-03-31 18:40:54.968658 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x08
    Reason: Connection Timeout

It took 35 sec to timeout where connections attempt normally only take
5 sec due to page timeout (configurable in main.conf), it is probably
due to being in sniff mode but even after exiting it takes another 20
sec to timeout (probably lmp timeout).

So I was wondering why this timeout is not derived from page timeout,
to me it seems quite obvious that if the connection doesn't complete
within page timeout there is something wrong since that is supposed to
be much faster on an active link, also if that assumption is correct
what would be the impact to have such a logic that takes page timeout
as timeout for any connection attempt in active/dead links dropping
them if the timeout is reached, of course this has to take into
account the user authorization framework/defer setup so it only
timeout if there is no activity in the link.

-- 
Luiz Augusto von Dentz
Computer Engineer
