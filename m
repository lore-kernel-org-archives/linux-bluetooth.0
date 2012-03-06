Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Subject: Re: [RFC 2/2] Bluetooth: Process HCI callbacks in a workqueue
Date: Tue, 6 Mar 2012 16:04:02 +0100
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1331039789-31519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>  <1331039789-31519-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331039789-31519-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201203061604.02445.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +
>  net/bluetooth/hci_core.c         |   42 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 2ef515e..47f1631 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1103,5 +1103,7 @@ int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
>  	void (*cb)(struct hci_dev *hdev, struct cb_cmd *cmd), void *opt,
>  				void (*destructor)(struct cb_cmd *cmd));
>  void hci_remove_cb(struct cb_cmd *cmd);
> +void hci_queue_cb(struct hci_dev *hdev, struct cb_cmd *cmd,
> +					struct workqueue_struct *workqueue);
>  
>  #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index cdc0220..2bd97b4 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2273,6 +2273,48 @@ struct cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode)
>  	return NULL;
>  }
>  
> +struct cb_work {
> +	struct work_struct work;
> +	struct hci_dev *hdev;
> +	struct cb_cmd *cmd;
> +};
> +
> +static void hci_cb_work(struct work_struct *w)
> +{
> +	struct cb_work *work = (struct cb_work *) w;
> +	struct cb_cmd *cmd = work->cmd;
> +	struct hci_dev *hdev = work->hdev;
> +
> +	cmd->cb(hdev, cmd);
> +
> +	hci_dev_put(hdev);
> +
> +	hci_remove_cb(cmd);
> +	kfree(w);
> +}
> +
> +void hci_queue_cb(struct hci_dev *hdev, struct cb_cmd *cmd,
> +					struct workqueue_struct *workqueue)
> +{
> +	struct cb_work *work;
> +
> +	BT_ERR("Queue cmd %p opt %p", cmd, cmd->opt);

BT_DBG I guess?

> +
> +	work = kmalloc(sizeof(*work), GFP_ATOMIC);
> +	if (!work)
> +		return;
> +
> +	INIT_WORK(&work->work, hci_cb_work);
> +	work->hdev = hdev;
> +	work->cmd = cmd;
> +	hci_dev_hold(hdev);
> +
> +	if (!queue_work(workqueue, &work->work)) {
> +		kfree(work);
> +		hci_dev_put(hdev);
> +	}
> +}
> +
>  void hci_remove_cb(struct cb_cmd *cmd)
>  {
>  	list_del(&cmd->list);
> 

-- 
BR
Szymon Janc
