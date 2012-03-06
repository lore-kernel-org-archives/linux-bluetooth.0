Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Subject: Re: [RFC 1/2] Bluetooth: General HCI callback implementation
Date: Tue, 6 Mar 2012 16:02:17 +0100
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1331039789-31519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331039789-31519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201203061602.17443.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Hi Andrei,

> Add general HCI callback implementation. Can be used for executing
> HCI commands from A2MP protocol.

> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   18 ++++++++++++
>  net/bluetooth/hci_core.c         |   57 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index d12e353..2ef515e 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -131,6 +131,17 @@ struct le_scan_params {
>  
>  #define HCI_MAX_SHORT_NAME_LENGTH	10
>  
> +struct hci_dev;
> +
> +struct cb_cmd {

This name seems a bit too more generic to me, maybe prefix it with hci_?

> +	struct list_head list;
> +	u16 opcode;
> +	u8 status;
> +	void *opt;
> +	void (*cb)(struct hci_dev *hdev, struct cb_cmd *cmd);
> +	void (*destructor)(struct cb_cmd *cmd);
> +};
> +
>  #define NUM_REASSEMBLY 4
>  struct hci_dev {
>  	struct list_head list;
> @@ -237,6 +248,7 @@ struct hci_dev {
>  	__u16			init_last_cmd;
>  
>  	struct list_head	mgmt_pending;
> +	struct list_head	cb_list;
>  
>  	struct discovery_state	discovery;
>  	struct hci_conn_hash	conn_hash;
> @@ -1086,4 +1098,10 @@ int hci_cancel_inquiry(struct hci_dev *hdev);
>  int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
>  								int timeout);
>  
> +struct cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode);
> +int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
> +	void (*cb)(struct hci_dev *hdev, struct cb_cmd *cmd), void *opt,
> +				void (*destructor)(struct cb_cmd *cmd));
> +void hci_remove_cb(struct cb_cmd *cmd);
> +
>  #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 5b1ddab..cdc0220 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1826,6 +1826,8 @@ int hci_register_dev(struct hci_dev *hdev)
>  
>  	INIT_LIST_HEAD(&hdev->mgmt_pending);
>  
> +	INIT_LIST_HEAD(&hdev->cb_list);
> +
>  	INIT_LIST_HEAD(&hdev->blacklist);
>  
>  	INIT_LIST_HEAD(&hdev->uuids);
> @@ -2239,6 +2241,61 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
>  	return 0;
>  }
>  

hci_add_cb could return error on failure and that could be used in hci_cmd_cb().

> +void hci_add_cb(struct hci_dev *hdev, __u16 opcode,
> +			void (*cb)(struct hci_dev *hdev, struct cb_cmd *cmd),
> +			void *opt, void (*destructor)(struct cb_cmd *cmd))
> +{
> +	struct cb_cmd *cmd;
> +
> +	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);

Why atomic? Maybe allow to pass custom gfp mask?

> +	if (!cmd)
> +		return;
> +
> +	cmd->cb = cb;
> +	cmd->opcode = opcode;
> +	cmd->opt = opt;
> +	cmd->status = 0;
> +
> +	if (destructor)
> +		cmd->destructor = destructor;

That could leave cmd->destructor uninitialized (cmd is allocated with kmalloc).
I would assign destructor unconditionally.

> +
> +	list_add(&cmd->list, &hdev->cb_list);
> +}
> +
> +struct cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode)
> +{
> +	struct cb_cmd *cmd;
> +
> +	list_for_each_entry(cmd, &hdev->cb_list, list)
> +		if (cmd->opcode == opcode)
> +			return cmd;
> +
> +	return NULL;
> +}
> +
> +void hci_remove_cb(struct cb_cmd *cmd)
> +{
> +	list_del(&cmd->list);
> +
> +	if (cmd->destructor) {
> +		cmd->destructor(cmd);
> +	} else {
> +		kfree(cmd->opt);
> +		kfree(cmd);
> +	}
> +}
> +
> +/* Send HCI command with callback */
> +int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
> +			void (*cb)(struct hci_dev *hdev, struct cb_cmd *cmd),
> +			void *opt, void (*destructor)(struct cb_cmd *cmd))
> +{
> +	if (cb)
> +		hci_add_cb(hdev, opcode, cb, opt, destructor);

Is this if really needed? If one would like to send cmd without cb he can just
call hci_send_cmd directly. And I would also check if hci_add_cb failed before
sending command.

> +
> +	return hci_send_cmd(hdev, opcode, plen, param);
> +}
> +
>  /* Get data from the previously sent command */
>  void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
>  {
> 
