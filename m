Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 May 2012 15:45:38 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 17/17] Bluetooth: A2MP: Manage incoming connections
In-Reply-To: <1337351150-20526-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Message-ID: <alpine.DEB.2.02.1205211530290.2239@mathewm-linux>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1337351150-20526-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Fri, 18 May 2012, Andrei Emeltchenko wrote:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Handle incoming A2MP connection by creating AMP manager and
> processing A2MP messages.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> include/net/bluetooth/a2mp.h |    4 ++++
> net/bluetooth/a2mp.c         |   12 ++++++++++++
> net/bluetooth/l2cap_core.c   |   14 ++++++++++----
> 3 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
> index 980c266..b4f74c6 100644
> --- a/include/net/bluetooth/a2mp.h
> +++ b/include/net/bluetooth/a2mp.h
> @@ -15,6 +15,8 @@
> #ifndef __A2MP_H
> #define __A2MP_H
>
> +#include <net/bluetooth/l2cap.h>
> +
> #define A2MP_FEAT_EXT	0x8000
>
> struct amp_mgr {
> @@ -119,5 +121,7 @@ struct a2mp_physlink_rsp {
>
> void amp_mgr_get(struct amp_mgr *mgr);
> int amp_mgr_put(struct amp_mgr *mgr);
> +struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
> +				       struct sk_buff *skb);
>
> #endif /* __A2MP_H */
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index 86b2078..dda297d 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -544,3 +544,15 @@ static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
>
> 	return mgr;
> }
> +
> +struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
> +				       struct sk_buff *skb)
> +{
> +	struct amp_mgr *mgr;
> +
> +	mgr = amp_mgr_create(conn);
> +
> +	BT_DBG("mgr: %p chan %p", mgr, mgr->a2mp_chan);
> +
> +	return mgr->a2mp_chan;
> +}
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b5c4229..8c9250e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -56,6 +56,7 @@
> #include <net/bluetooth/hci_core.h>
> #include <net/bluetooth/l2cap.h>
> #include <net/bluetooth/smp.h>
> +#include <net/bluetooth/a2mp.h>
>
> bool disable_ertm;
>
> @@ -4652,10 +4653,15 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>
> 	chan = l2cap_get_chan_by_scid(conn, cid);
> 	if (!chan) {
> -		BT_DBG("unknown cid 0x%4.4x", cid);
> -		/* Drop packet and return */
> -		kfree_skb(skb);
> -		return 0;
> +		if (cid == L2CAP_CID_A2MP) {
> +			chan = a2mp_channel_create(conn, skb);

This allocates a new AMP manager for each incoming command, doesn't 
it?  I'd expect the manager to be created once when it is first 
needed, then remain active until the ACL is closed.

> +			l2cap_chan_lock(chan);
> +		} else {
> +			BT_DBG("unknown cid 0x%4.4x", cid);
> +			/* Drop packet and return */
> +			kfree_skb(skb);
> +			return 0;
> +		}
> 	}
>
> 	BT_DBG("chan %p, len %d", chan, skb->len);
> -- 
> 1.7.9.5

How do you plan to create an AMP manager if you don't get an A2MP 
command from the remote device first?

Regards,

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

