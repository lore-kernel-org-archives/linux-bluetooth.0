Return-Path: <cyrus@holtmann.org>
Message-ID: <5270F19A.4030408@ahsoftware.de>
Date: Wed, 30 Oct 2013 12:46:34 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Tim Tisdall <tim.tisdall@flemingcollege.ca>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: l2cap sockets not properly multiplexed on ARM
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local> <5270EC62.6070705@ahsoftware.de>
In-Reply-To: <5270EC62.6070705@ahsoftware.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 30.10.2013 12:24, schrieb Alexander Holler:
> Am 29.10.2013 21:44, schrieb Tim Tisdall:
>
>> L2CAP sockets
>> -------------
>>
>> socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)
>> bind(bdaddr, 0)  // bind to bluetooth address and PSM 0 (Python
>> doesn't support LE directly,
>>                   // but this is enough for binding to the right device
>
> That looks wrong. Try to bind to ATT_CID (4).
>

And don't forget to check the return code of bind (as well as of 
setsockopt and other calls).

Regards,

Alexander Holler

