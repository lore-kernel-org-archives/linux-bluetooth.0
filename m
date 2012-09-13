Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Sep 2012 08:50:24 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCHv4 07/17] Bluetooth: AMP: Remote AMP ctrl definitions
In-Reply-To: <1347437192-24694-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Message-ID: <alpine.DEB.2.02.1209130846560.19321@mathewm-linux>
References: <alpine.DEB.2.02.1209111121550.3754@mathewm-linux> <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1347437192-24694-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Wed, 12 Sep 2012, Andrei Emeltchenko wrote:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Create remote AMP controllers structure. It is used to keep information
> about discovered remote AMP controllers by A2MP protocol.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> include/net/bluetooth/a2mp.h |    3 ++
> include/net/bluetooth/pal.h  |   14 ++++++++
> net/bluetooth/a2mp.c         |    5 +++
> net/bluetooth/pal.c          |   81 ++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 103 insertions(+)
>
> diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
> index f9010c0..93967f1 100644
> --- a/include/net/bluetooth/a2mp.h
> +++ b/include/net/bluetooth/a2mp.h
> @@ -31,6 +31,9 @@ struct amp_mgr {
> 		READ_LOC_AMP_ASSOC,
> 	} state;
> 	unsigned long		flags;
> +
> +	struct list_head	amp_ctrls;
> +	struct mutex		amp_ctrls_lock;
> };
>
> struct a2mp_cmd {
> diff --git a/include/net/bluetooth/pal.h b/include/net/bluetooth/pal.h
> index a0f441b..918a4be 100644
> --- a/include/net/bluetooth/pal.h
> +++ b/include/net/bluetooth/pal.h
> @@ -20,6 +20,20 @@
> #include <net/bluetooth/a2mp.h>
> #include <net/bluetooth/amp.h>
>
> +struct amp_ctrl {
> +	struct list_head	list;
> +	struct kref		kref;
> +	__u8			id;
> +	__u16			assoc_len_so_far;
> +	__u16			assoc_rem_len;
> +	__u16			assoc_len;
> +	__u8			*assoc;
> +};

I think you have the necessary information here.  There should be no 
need to also track the remote device in the amp_ctrl struct because 
the amp_mgr that owns the list of controllers is only referring to one 
remote device, right?

> +
> +int amp_ctrl_put(struct amp_ctrl *ctrl);
> +struct amp_ctrl *amp_ctrl_add(struct amp_mgr *mgr);
> +struct amp_ctrl *amp_ctrl_lookup(struct amp_mgr *mgr, u8 id);
> +void amp_ctrl_list_flush(struct amp_mgr *mgr);
> struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
> 			     u8 remote_id);
>
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index 8f236db..36bf0f4 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -585,6 +585,7 @@ static void amp_mgr_destroy(struct kref *kref)
> 	list_del(&mgr->list);
> 	mutex_unlock(&amp_mgr_list_lock);
>
> +	amp_ctrl_list_flush(mgr);
> 	kfree(mgr);
> }
>
> @@ -623,6 +624,10 @@ static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
> 	list_add(&mgr->list, &amp_mgr_list);
> 	mutex_unlock(&amp_mgr_list_lock);
>
> +	/* Remote AMP ctrl list initialization */
> +	INIT_LIST_HEAD(&mgr->amp_ctrls);
> +	mutex_init(&mgr->amp_ctrls_lock);
> +
> 	kref_init(&mgr->kref);
>
> 	return mgr;
> diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
> index 3377ad1..7548644 100644
> --- a/net/bluetooth/pal.c
> +++ b/net/bluetooth/pal.c
> @@ -13,6 +13,87 @@
>
> #include <net/bluetooth/pal.h>
>
> +/* Remote AMP Controllers handling */
> +static void amp_ctrl_get(struct amp_ctrl *ctrl)
> +{
> +	BT_DBG("ctrl %p orig refcnt %d", ctrl,
> +	       atomic_read(&ctrl->kref.refcount));
> +
> +	kref_get(&ctrl->kref);
> +}
> +
> +static void amp_ctrl_destroy(struct kref *kref)
> +{
> +	struct amp_ctrl *ctrl = container_of(kref, struct amp_ctrl, kref);
> +
> +	BT_DBG("ctrl %p", ctrl);
> +
> +	if (ctrl->assoc)
> +		kfree(ctrl->assoc);
> +
> +	kfree(ctrl);
> +}
> +
> +int amp_ctrl_put(struct amp_ctrl *ctrl)
> +{
> +	BT_DBG("ctrl %p orig refcnt %d", ctrl,
> +	       atomic_read(&ctrl->kref.refcount));
> +
> +	return kref_put(&ctrl->kref, &amp_ctrl_destroy);
> +}
> +
> +struct amp_ctrl *amp_ctrl_add(struct amp_mgr *mgr)
> +{
> +	struct amp_ctrl *ctrl;
> +
> +	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return NULL;
> +
> +	mutex_lock(&mgr->amp_ctrls_lock);
> +	list_add(&ctrl->list, &mgr->amp_ctrls);
> +	mutex_unlock(&mgr->amp_ctrls_lock);
> +
> +	kref_init(&ctrl->kref);
> +
> +	BT_DBG("mgr %p ctrl %p", mgr, ctrl);
> +
> +	return ctrl;
> +}
> +
> +void amp_ctrl_list_flush(struct amp_mgr *mgr)
> +{
> +	struct amp_ctrl *ctrl, *n;
> +
> +	BT_DBG("mgr %p", mgr);
> +
> +	mutex_lock(&mgr->amp_ctrls_lock);
> +	list_for_each_entry_safe(ctrl, n, &mgr->amp_ctrls, list) {
> +		list_del(&ctrl->list);
> +		amp_ctrl_put(ctrl);
> +	}
> +	mutex_unlock(&mgr->amp_ctrls_lock);
> +}
> +
> +struct amp_ctrl *amp_ctrl_lookup(struct amp_mgr *mgr, u8 id)
> +{
> +	struct amp_ctrl *ctrl = NULL;
> +
> +	mutex_lock(&mgr->amp_ctrls_lock);
> +	list_for_each_entry(ctrl, &mgr->amp_ctrls, list) {
> +		if (ctrl->id == id)
> +			break;
> +	}
> +	mutex_unlock(&mgr->amp_ctrls_lock);
> +
> +	BT_DBG("mgr %p id %d ctrl %p", mgr, id, ctrl);
> +
> +	if (ctrl)
> +		amp_ctrl_get(ctrl);
> +
> +	return ctrl;
> +}
> +
> /* Physical Link interface */
> static u8 __next_handle(struct amp_mgr *mgr)
> {
> -- 
> 1.7.9.5


--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

