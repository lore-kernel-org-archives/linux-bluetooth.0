Return-Path: <cyrus@holtmann.org>
Message-id: <4FBAE9FE.9030807@samsung.com>
Date: Tue, 22 May 2012 10:21:02 +0900
From: Minho Ban <mhban@samsung.com>
MIME-version: 1.0
To: Gustavo Padovan <gustavo@padovan.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix null pointer dereference in l2cap_chan_send
References: <4FB9932B.9070101@samsung.com> <20120521161707.GD16942@joana>
In-reply-to: <20120521161707.GD16942@joana>
Content-type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/22/2012 01:17 AM, Gustavo Padovan wrote:
> Hi Minho,
> 
> * Minho Ban <mhban@samsung.com> [2012-05-21 09:58:19 +0900]:
> 
>> If l2cap_chan_send is called will null conn it will cause kernel Oops.
>> This patch checks if conn is valid before entering l2cap_chan_send.
> 
> chan->conn should be always valid, and if not we have a bug somewhere else in
> the code and not in l2cap_chan_send(). It could be a locking problem maybe.
> Also check if you can reproduce this with latest bluetooth-next.
> 
> 	Gustavo
> 

Thanks for comment. I'm using bluetooth-next backporting to kernel 3.0
I wonder how do we guarantee chan->conn is valid if other thread release chan->lock
just after exit l2cap_chan_del.
It seem l2cap_chan_del is well protected with various mutex (eg, sk, conn, chan) but
that may not enough to prevent lock waiters from accessing object.

Regards,
Minho Ban
