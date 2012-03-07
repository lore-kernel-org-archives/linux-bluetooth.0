Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Mar 2012 12:35:22 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ido Yariv <ido@wizery.com>
Cc: linux-bluetooth@vger.kernel.org, Arik Nemtsov <arik@wizery.com>
Subject: Re: [RFC] Bluetooth: Search global l2cap channels by src/dst
 addresses
Message-ID: <20120307103520.GF3647@aemeltch-MOBL1>
References: <1330971024-11010-1-git-send-email-ido@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330971024-11010-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ido,

On Mon, Mar 05, 2012 at 08:10:24PM +0200, Ido Yariv wrote:
> The cid or psm and the source address might not be enough to uniquely
> identify a global channel, especially when the source address is our
> own.
> 
> For instance, when trying to communicate with two LE devices in master
> mode, data received from the both devices is sent to the same socket.
> 
> Fix this by taking the destination address into account when choosing
> the socket.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>
> Signed-off-by: Arik Nemtsov <arik@wizery.com>
> ---
> Note: Only the change done to l2cap_global_chan_by_scid was tested.
> 
>  net/bluetooth/l2cap_core.c |   48 +++++++++++++++++++++++++++++++++-----------
>  1 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 0b1aabf..6491503 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -831,10 +831,12 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>  	mutex_unlock(&conn->chan_lock);
>  }
>  
> -/* Find socket with cid and source bdaddr.
> +/* Find socket with cid and source/destination bdaddrs.
>   * Returns closest match, locked.
>   */
> -static struct l2cap_chan *l2cap_global_chan_by_scid(int state, __le16 cid, bdaddr_t *src)
> +static struct l2cap_chan *l2cap_global_chan_by_scid(int state, __le16 cid,
> +						    bdaddr_t *src,
> +						    bdaddr_t *dst)
>  {
>  	struct l2cap_chan *c, *c1 = NULL;
>  
> @@ -847,14 +849,24 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, __le16 cid, bdadd
>  			continue;
>  
>  		if (c->scid == cid) {
> +			int src_match, dst_match;
> +			int src_any, dst_any;
> +
> +			src_match = !bacmp(&bt_sk(sk)->src, src);
> +			dst_match = !bacmp(&bt_sk(sk)->dst, dst);
> +			src_any = !bacmp(&bt_sk(sk)->src, BDADDR_ANY);
> +			dst_any = !bacmp(&bt_sk(sk)->dst, BDADDR_ANY);

This may be not efficient to use extensive memcmp operations every time
before they can be actually used.

> +
>  			/* Exact match. */
> -			if (!bacmp(&bt_sk(sk)->src, src)) {
> +			if (src_match && dst_match) {
>  				read_unlock(&chan_list_lock);
>  				return c;
>  			}

at least src_any and dst_any may be put here. Maybe you could improve it
even more.

>  
>  			/* Closest match */
> -			if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY))
> +			if ((src_match && dst_any) ||
> +			    (src_any && dst_match) ||
> +			    (src_any && dst_any))
>  				c1 = c;
>  		}
>  	}
> @@ -873,7 +885,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
>  
>  	/* Check if we have socket listening on cid */
>  	pchan = l2cap_global_chan_by_scid(BT_LISTEN, L2CAP_CID_LE_DATA,
> -							conn->src);
> +					     conn->src, conn->dst);
>  	if (!pchan)
>  		return;
>  
> @@ -1101,10 +1113,12 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
>  
>  /* ---- Socket interface ---- */
>  
> -/* Find socket with psm and source bdaddr.
> +/* Find socket with psm and source/destination bdaddrs.
>   * Returns closest match.
>   */
> -static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm, bdaddr_t *src)
> +static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
> +						   bdaddr_t *src,
> +						   bdaddr_t *dst)
>  {
>  	struct l2cap_chan *c, *c1 = NULL;
>  
> @@ -1117,14 +1131,24 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm, bdaddr
>  			continue;
>  
>  		if (c->psm == psm) {
> +			int src_match, dst_match;
> +			int src_any, dst_any;
> +
> +			src_match = !bacmp(&bt_sk(sk)->src, src);
> +			dst_match = !bacmp(&bt_sk(sk)->dst, dst);
> +			src_any = !bacmp(&bt_sk(sk)->src, BDADDR_ANY);
> +			dst_any = !bacmp(&bt_sk(sk)->dst, BDADDR_ANY);

Same here.

Best regards 
Andrei Emeltchenko 

> +
>  			/* Exact match. */
> -			if (!bacmp(&bt_sk(sk)->src, src)) {
> +			if (src_match && dst_match) {
>  				read_unlock(&chan_list_lock);
>  				return c;
>  			}
>  
>  			/* Closest match */
> -			if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY))
> +			if ((src_match && dst_any) ||
> +			    (src_any && dst_match) ||
> +			    (src_any && dst_any))
>  				c1 = c;
>  		}

Best regards 
Andrei Emeltchenko 
