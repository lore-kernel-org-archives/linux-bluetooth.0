Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Sep 2012 08:02:58 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCHv4 02/17] Bluetooth: A2MP: Create amp_mgr global list
In-Reply-To: <1347437192-24694-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Message-ID: <alpine.DEB.2.02.1209130802210.19321@mathewm-linux>
References: <alpine.DEB.2.02.1209111121550.3754@mathewm-linux> <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1347437192-24694-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Wed, 12 Sep 2012, Andrei Emeltchenko wrote:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Create amp_mgr_list global list which will be used by different
> hci devices to find amp_mgr.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> include/net/bluetooth/a2mp.h |    8 ++++++++
> net/bluetooth/a2mp.c         |   29 +++++++++++++++++++++++++++++
> 2 files changed, 37 insertions(+)
>
> diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
> index 6a76e0a..e56d656 100644
> --- a/include/net/bluetooth/a2mp.h
> +++ b/include/net/bluetooth/a2mp.h
> @@ -20,11 +20,15 @@
> #define A2MP_FEAT_EXT	0x8000
>
> struct amp_mgr {
> +	struct list_head	list;
> 	struct l2cap_conn	*l2cap_conn;
> 	struct l2cap_chan	*a2mp_chan;
> 	struct kref		kref;
> 	__u8			ident;
> 	__u8			handle;
> +	enum {
> +		READ_LOC_AMP_INFO,
> +	} state;
> 	unsigned long		flags;
> };
>
> @@ -118,9 +122,13 @@ struct a2mp_physlink_rsp {
> #define A2MP_STATUS_PHYS_LINK_EXISTS		0x05
> #define A2MP_STATUS_SECURITY_VIOLATION		0x06
>
> +extern struct list_head amp_mgr_list;
> +extern struct mutex amp_mgr_list_lock;
> +
> void amp_mgr_get(struct amp_mgr *mgr);
> int amp_mgr_put(struct amp_mgr *mgr);
> struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
> 				       struct sk_buff *skb);
> +struct amp_mgr *amp_mgr_lookup_by_state(u8 state);
>
> #endif /* __A2MP_H */
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index 0760d1f..6b7a4b4 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -17,6 +17,10 @@
> #include <net/bluetooth/l2cap.h>
> #include <net/bluetooth/a2mp.h>
>
> +/* Global AMP Manager list */
> +LIST_HEAD(amp_mgr_list);
> +DEFINE_MUTEX(amp_mgr_list_lock);
> +
> /* A2MP build & send command helper functions */
> static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
> {
> @@ -516,6 +520,10 @@ static void amp_mgr_destroy(struct kref *kref)
>
> 	BT_DBG("mgr %p", mgr);
>
> +	mutex_lock(&amp_mgr_list_lock);
> +	list_del(&mgr->list);
> +	mutex_unlock(&amp_mgr_list_lock);
> +
> 	kfree(mgr);
> }
>
> @@ -550,6 +558,10 @@ static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
>
> 	conn->hcon->amp_mgr = mgr;
>
> +	mutex_lock(&amp_mgr_list_lock);
> +	list_add(&mgr->list, &amp_mgr_list);
> +	mutex_unlock(&amp_mgr_list_lock);
> +
> 	kref_init(&mgr->kref);

Should the reference count be initialized before adding to the list?

>
> 	return mgr;
> @@ -570,3 +582,20 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
>
> 	return mgr->a2mp_chan;
> }
> +
> +struct amp_mgr *amp_mgr_lookup_by_state(u8 state)
> +{
> +	struct amp_mgr *mgr;
> +
> +	mutex_lock(&amp_mgr_list_lock);
> +	list_for_each_entry(mgr, &amp_mgr_list, list) {
> +		if (mgr->state == state) {
> +			amp_mgr_get(mgr);
> +			mutex_unlock(&amp_mgr_list_lock);
> +			return mgr;
> +		}
> +	}
> +	mutex_unlock(&amp_mgr_list_lock);
> +
> +	return NULL;
> +}
> -- 
> 1.7.9.5

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation



