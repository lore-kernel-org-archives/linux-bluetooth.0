Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Message-id: <4FBDD609.8060702@samsung.com>
Date: Thu, 24 May 2012 15:32:41 +0900
From: Minho Ban <mhban@samsung.com>
To: Chanyeol Park <chanyeol.park@samsung.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix null pointer dereference in l2cap_chan_send
References: <4FB9932B.9070101@samsung.com> <4FBB8828.303@samsung.com>
In-reply-to: <4FBB8828.303@samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/22/2012 09:35 PM, Chanyeol Park wrote:
> Hi
> On 2012년 05월 21일 09:58, Minho Ban wrote:
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index 3bb1611..98d4541 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -727,10 +727,12 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
>>       if (msg->msg_flags&  MSG_OOB)
>>           return -EOPNOTSUPP;
>>
>> -    if (sk->sk_state != BT_CONNECTED)
>> +    l2cap_chan_lock(chan);
>> +    if (sk->sk_state != BT_CONNECTED || !chan->conn) {
>> +        l2cap_chan_unlock(chan);
>>           return -ENOTCONN;
>> +    }
>>
>> -    l2cap_chan_lock(chan);
>>       err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
>>       l2cap_chan_unlock(chan);
>>   
> Beside !chan->conn condition,I think it makes sense that sk_state check should be moved after l2cap_chan_lock()
> because sk_state could be changed due to l2cap_conn_del().
> 

Thanks, chan->conn condition is not necessary, move sk->sk_state != BT_CONNECTED behind chan_lock is enough.
I'll amend this patch.

Regards
Minho Ban
