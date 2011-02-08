Return-Path: <cyrus@holtmann.org>
Message-ID: <4D517EE1.8040408@codeaurora.org>
Date: Tue, 08 Feb 2011 09:35:29 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Frequent SM test failure at UPF
References: <4D508DC2.60003@codeaurora.org> <4D509ABA.1010909@codeaurora.org> <20110208135849.GA31237@piper>
In-Reply-To: <20110208135849.GA31237@piper>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On 2/8/2011 5:58 AM, Vinicius Costa Gomes wrote:
> Hi Brian,
>
> On 17:22 Mon 07 Feb, Brian Gix wrote:
>> On 2/7/2011 4:26 PM, Brian Gix wrote:
>>>
>>> Testing of Shorter than 16 octet keys.
>>>
>>> In smp_cmd_pairing_random() when the STK is generated, it needs to be
>>> truncated to the MIN of conn->preq[4] and conn->pres[4].
>>>
>>> This Min value may need to be saved for later as well, because it needs
>>> to also limit the LTK key exchange.
>>>
>>> This failure showed up with the PTS tool, and at least one other device
>>> during the days testing. I have mocked up a fix, but have not had a
>>> chance to test it yet.
>>>
>>>
>
> First, thanks for the reports. This particular issue should be fixed soon.
>

When testing this morning, I successfully negotiated and paired with a 
device, where we both said that we could accept and produce all keys 
(key mask 0x07).  We were the responder, and sent all keys (0x06 through 
0x0A) then we received all keys from remote device (0x06 through 0x0A). 
  The apparent problem was that we sent the all of our keys a second 
time.  This caused no problems, but was noticable on the hcidump trace:

 > ACL data: handle 10 flags 0x02 dlen 11
     L2CAP(d): cid 0x0006 len 7 [psm 0]
       0000: 01 03 00 00 10 07 07                              .......
< ACL data: handle 10 flags 0x00 dlen 11
     0000: 07 00 06 00 02 03 00 00  10 07 07                 ...........
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 10 packets 1
 > ACL data: handle 10 flags 0x02 dlen 21
     L2CAP(d): cid 0x0006 len 17 [psm 0]
       0000: 03 de 36 99 3f ed 4a 13  78 2c 3e dd 6f 3c 0f 2f 
..6.?.J.x,>.o<./
       0010: 6e                                                n
< ACL data: handle 10 flags 0x00 dlen 21
     0000: 11 00 06 00 03 df 4b f0  b0 f1 8e 1c 5e b6 f9 9c 
......K.....^...
     0010: c4 65 c3 9e 3d                                    .e..=
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 10 packets 1
 > ACL data: handle 10 flags 0x02 dlen 21
     L2CAP(d): cid 0x0006 len 17 [psm 0]
       0000: 04 91 91 91 91 91 91 91  91 91 91 91 91 91 91 91 
................
       0010: 91                                                .
< ACL data: handle 10 flags 0x00 dlen 21
     0000: 11 00 06 00 04 56 54 2b  45 81 16 6a d4 58 5c 73 
.....VT+E..j.X\s
     0010: 77 08 43 e5 6f                                    w.C.o
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 10 packets 1
 > HCI Event: LE Meta Event (0x3e) plen 13
     LE Long Term Key Request
     0000: 0a 00 00 00 00 00 00 00  00 00 00 00              ............
< HCI Command: LE Long Term Key Request Reply (0x08|0x001a) plen 18
   0000: 0a 00 16 51 6d 0c c3 59  fc 71 e2 e1 64 59 a7 81  ...Qm..Y.q..dY..
   0010: c1 72                                             .r
 > HCI Event: Command Complete (0x0e) plen 6
     LE Long Term Key Request Reply (0x08|0x001a) ncmd 1
     0000: 00 0a 00                                          ...
 > HCI Event: Encrypt Change (0x08) plen 4
     status 0x00 handle 10 encrypt 0x01
< ACL data: handle 10 flags 0x00 dlen 21
     0000: 11 00 06 00 06 01 01 01  01 01 01 01 01 01 01 01 
................
     0010: 01 01 01 01 01                                    .....
< ACL data: handle 10 flags 0x00 dlen 15
     0000: 0b 00 06 00 07 02 02 02  02 02 02 02 02 02 02     ...............
< ACL data: handle 10 flags 0x00 dlen 21
     0000: 11 00 06 00 08 04 04 04  04 04 04 04 04 04 04 04 
................
     0010: 04 04 04 04 04                                    .....
< ACL data: handle 10 flags 0x00 dlen 12
     0000: 08 00 06 00 09 00 53 53  53 53 53 53              ......SSSSSS
< ACL data: handle 10 flags 0x00 dlen 21
     0000: 11 00 06 00 0a 05 05 05  05 05 05 05 05 05 05 05 
................
     0010: 05 05 05 05 05                                    .....
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 10 packets 4
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 10 packets 1
 > ACL data: handle 10 flags 0x02 dlen 21
     L2CAP(d): cid 0x0006 len 17 [psm 0]
       0000: 06 87 87 87 87 87 87 87  87 87 87 87 87 87 87 87 
................
       0010: 87                                                .
 > ACL data: handle 10 flags 0x02 dlen 15
     L2CAP(d): cid 0x0006 len 11 [psm 0]
       0000: 07 33 22 91 91 91 91 91  91 91 91                 .3"........
 > ACL data: handle 10 flags 0x02 dlen 21
     L2CAP(d): cid 0x0006 len 17 [psm 0]
       0000: 08 98 98 98 98 98 98 98  98 98 98 98 98 98 98 98 
................
       0010: 98                                                .
 > ACL data: handle 10 flags 0x02 dlen 12
     L2CAP(d): cid 0x0006 len 8 [psm 0]
       0000: 09 00 45 98 76 98 34 67                           ..E.v.4g
 > ACL data: handle 10 flags 0x02 dlen 21
     L2CAP(d): cid 0x0006 len 17 [psm 0]
       0000: 0a 99 99 99 99 99 99 99  99 99 99 99 99 99 99 99 
................
       0010: 99                                                .
< ACL data: handle 10 flags 0x00 dlen 21
     0000: 11 00 06 00 06 01 01 01  01 01 01 01 01 01 01 01 
................
     0010: 01 01 01 01 01                                    .....
< ACL data: handle 10 flags 0x00 dlen 15
     0000: 0b 00 06 00 07 02 02 02  02 02 02 02 02 02 02     ...............
< ACL data: handle 10 flags 0x00 dlen 21
     0000: 11 00 06 00 08 04 04 04  04 04 04 04 04 04 04 04 
................
     0010: 04 04 04 04 04                                    .....
< ACL data: handle 10 flags 0x00 dlen 12
     0000: 08 00 06 00 09 00 53 53  53 53 53 53              ......SSSSSS
< ACL data: handle 10 flags 0x00 dlen 21
     0000: 11 00 06 00 0a 05 05 05  05 05 05 05 05 05 05 05 
................
     0010: 05 05 05 05 05                                    .....
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 10 packets 3
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 10 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 10 packets 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 10 reason 0x13
     Reason: Remote User Terminated Connection






-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
