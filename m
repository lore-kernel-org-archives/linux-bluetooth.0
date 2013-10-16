Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 14:14:53 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH] Bluetooth: Remove not used struct sock
Message-ID: <20131016171453.GA2107@joana>
References: <1381937991-12645-1-git-send-email-gustavo@padovan.org>
 <121AE7E9-6B79-4132-8B59-DEDB1F6EBEE3@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <121AE7E9-6B79-4132-8B59-DEDB1F6EBEE3@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-10-16 Marcel Holtmann <marcel@holtmann.org>:

> Hi Gustavo,
> 
> > It is a leftover from the recent effort of remove sk usage from L2CAP
> > core.
> > 
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > ---
> > net/bluetooth/l2cap_core.c | 4 +---
> > 1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index b77e178..2681880 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -3714,7 +3714,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
> > 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
> > 	struct l2cap_conn_rsp rsp;
> > 	struct l2cap_chan *chan = NULL, *pchan;
> > -	struct sock *parent, *sk = NULL;
> > +	struct sock *parent;
> > 	int result, status = L2CAP_CS_NO_INFO;
> > 
> > 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
> > @@ -3753,8 +3753,6 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
> > 	if (!chan)
> > 		goto response;
> > 
> > -	sk = chan->sk;
> > -
> 
> can we already do that? I still do not like the chan->data != sk magic check.

Yes, this is just a dead assignment. It is totally safe to remove it.

	Gustavo
