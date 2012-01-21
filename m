Return-Path: <cyrus@holtmann.org>
Message-ID: <1327164094.1955.50.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Use non locking get_chan and explicit lock
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 21 Jan 2012 17:41:34 +0100
In-Reply-To: <1327060226-16211-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1327060226-16211-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> For receiving ACL packets use __l2cap_get_chan_by_scid which is not
> locking sk and explicitly lock sk after checking that it is exist.
> Code looks nicer since now it is surrounded by lock/release.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d16ad49..53dbfd3 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4243,7 +4243,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>  	u16 tx_seq;
>  	int len;
>  
> -	chan = l2cap_get_chan_by_scid(conn, cid);
> +	chan = __l2cap_get_chan_by_scid(conn, cid);
>  	if (!chan) {
>  		if (cid == L2CAP_CID_A2MP) {
>  			chan = a2mp_channel_create(conn, skb);
> @@ -4255,6 +4255,8 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>  	}
>  
>  	sk = chan->sk;
> +	if (sk)
> +		lock_sock(sk);

this is the part I clearly do not like. This is pretty nasty conditional
locking. We need to figure out something better.

Regards

Marcel


