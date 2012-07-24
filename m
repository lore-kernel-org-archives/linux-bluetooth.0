Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 16:44:17 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 01/20] Bluetooth: General HCI callback implementation
Message-ID: <20120724194417.GA20029@joana>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343136121-22476-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-07-24 16:21:42 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add general HCI callback implementation. Can be used for executing
> HCI commands from A2MP protocol.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   21 +++++++++
>  net/bluetooth/hci_core.c         |   88 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 41d9439..479e4d1 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -124,6 +124,17 @@ struct le_scan_params {
>  
>  #define HCI_MAX_SHORT_NAME_LENGTH	10
>  
> +struct hci_dev;
> +
> +struct hci_cb_cmd {
> +	struct list_head list;
> +	u16 opcode;
> +	u8 status;
> +	void *opt;
> +	void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
> +	void (*destructor)(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
> +};
> +
>  #define NUM_REASSEMBLY 4
>  struct hci_dev {
>  	struct list_head list;
> @@ -236,6 +247,9 @@ struct hci_dev {
>  
>  	struct list_head	mgmt_pending;
>  
> +	struct mutex		cb_list_lock;
> +	struct list_head	cb_list;
> +
>  	struct discovery_state	discovery;
>  	struct hci_conn_hash	conn_hash;
>  	struct list_head	blacklist;
> @@ -1092,5 +1106,12 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
>  int hci_cancel_le_scan(struct hci_dev *hdev);
>  
>  u8 bdaddr_to_le(u8 bdaddr_type);
> +struct hci_cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode);
> +int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
> +	       void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
> +	       void *opt,
> +	       void (*destructor)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
> +	       gfp_t flags);
> +void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd);

_cb usually meant that the function itself is a callback, we should put better
names here, maybe:

hci_callback_find()
hci_callback_send_cmd()
hci_callback_remove()

>  
>  #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 28bab9d..165c235 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -36,6 +36,7 @@
>  static void hci_rx_work(struct work_struct *work);
>  static void hci_cmd_work(struct work_struct *work);
>  static void hci_tx_work(struct work_struct *work);
> +static void hci_cb_clear(struct hci_dev *hdev);
>  
>  /* HCI device list */
>  LIST_HEAD(hci_dev_list);
> @@ -1645,6 +1646,7 @@ struct hci_dev *hci_alloc_dev(void)
>  
>  	mutex_init(&hdev->lock);
>  	mutex_init(&hdev->req_lock);
> +	mutex_init(&hdev->cb_list_lock);
>  
>  	INIT_LIST_HEAD(&hdev->mgmt_pending);
>  	INIT_LIST_HEAD(&hdev->blacklist);
> @@ -1652,6 +1654,7 @@ struct hci_dev *hci_alloc_dev(void)
>  	INIT_LIST_HEAD(&hdev->link_keys);
>  	INIT_LIST_HEAD(&hdev->long_term_keys);
>  	INIT_LIST_HEAD(&hdev->remote_oob_data);
> +	INIT_LIST_HEAD(&hdev->cb_list);
>  
>  	INIT_WORK(&hdev->rx_work, hci_rx_work);
>  	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
> @@ -1817,6 +1820,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
>  	hci_link_keys_clear(hdev);
>  	hci_smp_ltks_clear(hdev);
>  	hci_remote_oob_data_clear(hdev);
> +	hci_cb_clear(hdev);
>  	hci_dev_unlock(hdev);
>  
>  	hci_dev_put(hdev);
> @@ -2118,6 +2122,90 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
>  	return 0;
>  }
>  
> +static int hci_add_cb(struct hci_dev *hdev, __u16 opcode,
> +		      void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
> +		      void *opt,
> +		      void (*destructor)(struct hci_dev *hdev,
> +					 struct hci_cb_cmd *cmd),
> +		      gfp_t flags)

Then this on could be named hci_callback_add

> +{
> +	struct hci_cb_cmd *cmd;
> +
> +	cmd = kmalloc(sizeof(*cmd), flags);
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	cmd->cb = cb;
> +	cmd->opcode = opcode;
> +	cmd->opt = opt;
> +	cmd->status = 0;
> +	cmd->destructor = destructor;
> +
> +	mutex_lock(&hdev->cb_list_lock);
> +	list_add(&cmd->list, &hdev->cb_list);
> +	mutex_unlock(&hdev->cb_list_lock);

can't we do RCU here, of it is not possible spinlocks? Transverse a list is a
kind fast operation, we don't wanna pay two context switches here. It is
expensive I think.

> +
> +	return 0;
> +}
> +
> +struct hci_cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode)
> +{
> +	struct hci_cb_cmd *cmd;
> +
> +	mutex_lock(&hdev->cb_list_lock);
> +	list_for_each_entry(cmd, &hdev->cb_list, list)
> +		if (cmd->opcode == opcode) {
> +			mutex_unlock(&hdev->cb_list_lock);
> +			return cmd;
> +		}
> +	mutex_unlock(&hdev->cb_list_lock);
> +
> +	return NULL;
> +}
> +
> +void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd)
> +{
> +	BT_DBG("%s remove cmd %p", hdev->name, cmd);
> +
> +	mutex_lock(&hdev->cb_list_lock);
> +	list_del(&cmd->list);
> +	mutex_unlock(&hdev->cb_list_lock);
> +
> +	if (cmd->destructor) {
> +		cmd->destructor(hdev, cmd);

So what is the purpose of the destructor_cb? A2MP calls hci_cmd_cb and
register it, then for some reason A2MP end up calling hci_remove_cb() later,
and then cmd->destructor_cb() calls a function that actually belongs to A2MP.
What is the advantage here?
Or is this meant to be static and only called from hci_cb_clear()?

> +	} else {
> +		kfree(cmd->opt);
> +		kfree(cmd);
> +	}
> +}
> +
> +static void hci_cb_clear(struct hci_dev *hdev)
> +{
> +	struct hci_cb_cmd *cmd, *tmp;
> +
> +	list_for_each_entry_safe(cmd, tmp, &hdev->cb_list, list)
> +		hci_remove_cb(hdev, cmd);
> +}
> +
> +/* Send HCI command with callback */
> +int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
> +	       void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
> +	       void *opt,
> +	       void (*destructor)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
> +	       gfp_t flags)
> +{
> +	int ret;
> +
> +	if (!cb)
> +		return -EINVAL;
> +
> +	ret = hci_add_cb(hdev, opcode, cb, opt, destructor, flags);

Why do you need hci_add_cb()? just put all it code here, it is used only once.

	Gustavo
