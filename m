Return-Path: <cyrus@holtmann.org>
Message-id: <760B2557394A4432BAFD74479AD7711B@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1342682644-24964-1-git-send-email-jaganath.k@samsung.com>
 <20120719075239.GC26057@aemeltch-MOBL1>
In-reply-to: <20120719075239.GC26057@aemeltch-MOBL1>
Subject: Re: [PATCH] Bluetooth: Fix socket not getting freed if l2cap channel
 create fails
Date: Thu, 19 Jul 2012 16:50:16 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

--------------------------------------------------
From: "Andrei Emeltchenko" <andrei.emeltchenko.news@gmail.com>
Sent: Thursday, July 19, 2012 1:22 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Fix socket not getting freed if l2cap 
channel create fails

> Hi Jaganath,
>
> On Thu, Jul 19, 2012 at 12:54:04PM +0530, Jaganath Kanakkassery wrote:
>> If l2cap_chan_create() fails then it will return from l2cap_sock_kill
>> since zapped flag of sk is reset.
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>> ---
>>  net/bluetooth/l2cap_sock.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index 79350d1..419857d 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -1174,7 +1174,7 @@ static struct sock *l2cap_sock_alloc(struct net 
>> *net, struct socket *sock, int p
>>
>>  chan = l2cap_chan_create();
>>  if (!chan) {
>> - l2cap_sock_kill(sk);
>> + sk_free(sk);
>
> Could you consider using sock_put which will call sk_free,
> maybe we need to add also sock_orphan?

Ok, Actually I used sk_free since there is not refcount increase at this 
point
and also I found the same code in rfcomm_sock_alloc().
So should I fix it in RFCOMM also?

Thanks,
Jaganath 

