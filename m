Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Message-id: <4FBC3FD6.6050704@samsung.com>
Date: Wed, 23 May 2012 10:39:34 +0900
From: Minho Ban <mhban@samsung.com>
To: Chanyeol Park <chanyeol.park@samsung.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] Bluetooth: prevent double l2cap_chan_destroy
References: <4FB992C8.8090105@samsung.com> <20120521162137.GE16942@joana>
 <4FBAFEF5.2000207@samsung.com> <4FBB8544.3040408@samsung.com>
In-reply-to: <4FBB8544.3040408@samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/22/2012 09:23 PM, Chanyeol Park wrote:
> Hi
> 
> On 2012년 05월 22일 11:50, Minho Ban wrote:
>> @@ -1343,10 +1343,10 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
>>                  l2cap_chan_lock(chan);
>>
>>                  l2cap_chan_del(chan, err);
>> +               chan->ops->close(chan->data);
>>
>>                  l2cap_chan_unlock(chan);
>>
>> -               chan->ops->close(chan->data);
>>                  l2cap_chan_put(chan);
>>          }
> I think this patch does not make sense Because inside chan->ops->close() "chan" could be freed in the l2cap_chan_destroy().
> 

I agree, thanks for pointing out.
