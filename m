Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 2/2] Bluetooth: Switch ATT channels to use L2CAP_CHAN_FIXED_CID
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390483368-21321-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 23 Jan 2014 16:52:38 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <3B627A69-3B09-46FB-9580-15FB93844E29@holtmann.org>
References: <1390483368-21321-1-git-send-email-johan.hedberg@gmail.com> <1390483368-21321-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> ATT channels are not connection oriented so having them use
> L2CAP_CHAN_CONN_ORIENTED is quite confusing. Instead, use the new
> L2CAP_CHAN_FIXED_CID type and ensure that the MTU and CID values get
> properly set.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 21 +++++++++------------
> net/bluetooth/l2cap_sock.c |  6 ++++++
> 2 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 84714541b48c..c5c47667bfe0 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -498,18 +498,10 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> 
> 	switch (chan->chan_type) {
> 	case L2CAP_CHAN_CONN_ORIENTED:
> -		if (conn->hcon->type == LE_LINK) {
> -			if (chan->dcid == L2CAP_CID_ATT) {
> -				chan->omtu = L2CAP_DEFAULT_MTU;
> -				chan->scid = L2CAP_CID_ATT;
> -			} else {
> -				chan->scid = l2cap_alloc_cid(conn);
> -			}
> -		} else {
> -			/* Alloc CID for connection-oriented socket */
> -			chan->scid = l2cap_alloc_cid(conn);
> +		/* Alloc CID for connection-oriented socket */
> +		chan->scid = l2cap_alloc_cid(conn);
> +		if (conn->hcon->type == ACL_LINK)
> 			chan->omtu = L2CAP_DEFAULT_MTU;
> -		}
> 		break;
> 
> 	case L2CAP_CHAN_CONN_LESS:
> @@ -7025,7 +7017,12 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> 		goto done;
> 	}
> 
> -	if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED && !(psm || cid)) {
> +	if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED && !psm) {
> +		err = -EINVAL;
> +		goto done;
> +	}
> +
> +	if (chan->chan_type == L2CAP_CHAN_FIXED_CID && !cid) {
> 		err = -EINVAL;
> 		goto done;
> 	}
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 4aa6704f0b33..45064d130308 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -101,6 +101,12 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
> 	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
> 		return -EINVAL;
> 
> +	if (la.l2_cid) {
> +		/* Update type from the default CONN_ORIENTED */

I think that I understand your comment intention here, but we might want to make it less cryptic and actually spell out that this changed the channel type to overwrite the default.

> +		chan->chan_type = L2CAP_CHAN_FIXED_CID;
> +		chan->omtu = L2CAP_DEFAULT_MTU;
> +	}
> +
> 	if (bdaddr_type_is_le(la.l2_bdaddr_type)) {
> 		if (!enable_lecoc && la.l2_psm)
> 			return -EINVAL;

Regards

Marcel

