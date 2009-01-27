Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B9402F9A-9F2F-4C2B-8F54-24DD213A167A@holtmann.org>
References: <35c90d960901261529i699411a7jddb81b8d9bef74f8@mail.gmail.com>
	 <B9402F9A-9F2F-4C2B-8F54-24DD213A167A@holtmann.org>
Date: Mon, 26 Jan 2009 17:38:05 -0800
Message-ID: <35c90d960901261738t510f7db9v9067c4d70999159f@mail.gmail.com>
Subject: Re: duplicate L2CAP connection requests - before and after L2CAP
	information response
From: Nick Pelly <npelly@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 26, 2009 at 5:17 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nick,
>
>> We've noticed In some situations Bluez will send duplicate L2CAP
>> connection requests.
>> - Both are due to the same userspace connect() call, and have the same
>> PSM and SCID, but different identifier. So the remote stack cannot
>> send duplicate response because of different identifiers.
>> - The first occurs before receiving L2CAP info response, and the
>> second after due to the l2cap_information_rsp() -> l2cap_conn_start()
>> code path.
>>
>> We are able to reproduce this consistently with basically any A2DP PTS
>> test case. It only happens when the test case is started when already
>> paired. This causes the PTS test case to fail because the tester
>> rejects the second L2CAP request (resource unavailable).
>>
>> We are using 2.6.27. I looked at l2cap.c in bluetooth-testing.git and
>> believe it will have the same issue.
>>
>> Question: to fix, which connection request should be removed?
>
> can you write a small test case for this or use l2test to reproduce it. If
> so, then I might be able to fix this quickly. I have currently no clue why
> this happens and funny part of that is that we did pass all the BITE test
> cases ;)

I can reproduce this with

l2test -n ADDRESS

The two devices need to be paired first. Here was the hcidump I got
from this repro. This time it was the remote features response that
triggered the duplicate l2cap connection request. I assume it is the
same l2cap_conn_start() path after the feature response that triggers
the duplicate.

I can also repro this connecting to many A2DP headsets, but most
remote stacks seem to be tolerant of our mistake and let it go. I
guess PTS comes in handy sometimes :)



2009-01-26 17:31:31.416976 < HCI Command: Create Connection
(0x01|0x0005) plen 13
    bdaddr 00:21:BA:83:52:E6 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2009-01-26 17:31:31.437178 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2009-01-26 17:31:32.014754 > HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:21:BA:83:52:E6 role 0x01
    Role: Slave
2009-01-26 17:31:32.051863 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:21:BA:83:52:E6 type ACL encrypt 0x00
2009-01-26 17:31:32.052107 < HCI Command: Read Remote Supported
Features (0x01|0x001b) plen 2
    handle 1
2009-01-26 17:31:32.052199 < ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2009-01-26 17:31:32.053786 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2009-01-26 17:31:32.064620 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
2009-01-26 17:31:32.065840 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 1 packets 1
2009-01-26 17:31:32.066451 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
2009-01-26 17:31:32.066573 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 10 scid 0x0040
2009-01-26 17:31:32.074477 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
    status 0x00 handle 1
    Features: 0xff 0xff 0x2d 0xfe 0x9b 0xf9 0x00 0x80
2009-01-26 17:31:32.074599 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 10 scid 0x0040
