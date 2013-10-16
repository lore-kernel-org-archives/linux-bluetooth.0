Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Remove not used struct sock
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381937991-12645-1-git-send-email-gustavo@padovan.org>
Date: Wed, 16 Oct 2013 18:14:22 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Message-Id: <121AE7E9-6B79-4132-8B59-DEDB1F6EBEE3@holtmann.org>
References: <1381937991-12645-1-git-send-email-gustavo@padovan.org>
To: Gustavo Padovan <gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> It is a leftover from the recent effort of remove sk usage from L2CAP
> core.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
> net/bluetooth/l2cap_core.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b77e178..2681880 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3714,7 +3714,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
> 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
> 	struct l2cap_conn_rsp rsp;
> 	struct l2cap_chan *chan = NULL, *pchan;
> -	struct sock *parent, *sk = NULL;
> +	struct sock *parent;
> 	int result, status = L2CAP_CS_NO_INFO;
> 
> 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
> @@ -3753,8 +3753,6 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
> 	if (!chan)
> 		goto response;
> 
> -	sk = chan->sk;
> -

can we already do that? I still do not like the chan->data != sk magic check.

Regards

Marcel

