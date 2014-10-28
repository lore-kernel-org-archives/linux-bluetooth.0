Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v1 1/4] Add le_scan_restart that can be used to restart le scan. In order to use it please i.e. do:
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414442504-14290-2-git-send-email-jpawlowski@google.com>
Date: Tue, 28 Oct 2014 09:38:23 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9BB6F5A6-2A50-4812-B258-ACD89CE77B14@holtmann.org>
References: <1414442504-14290-1-git-send-email-jpawlowski@google.com> <1414442504-14290-2-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

please look at the submitting patches documentation in the kernel. You need to follow the guidelines on how to create patches and have proper subjects and commit message.

> On Oct 27, 2014, at 13:41, Jakub Pawlowski <jpawlowski@google.com> wrote:
> 
> queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart, 300);

Explain what your patch is doing in plain text first.

However if we want to make this usable, then this should be exposed as a simple function call and not be done via queue_delayed_work call. That is an internal detail.

> ---
> include/net/bluetooth/hci_core.h |  3 +++
> net/bluetooth/hci_core.c         | 39 +++++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_event.c        |  3 ++-
> 3 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b8685a7..0865bc1 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -307,6 +307,8 @@ struct hci_dev {
> 	struct discovery_state	discovery;
> 	struct hci_conn_hash	conn_hash;
> 
> +	bool scan_restart;
> +

Using hdev->dev_flags seems simple then adding another bool here.

> 	struct list_head	mgmt_pending;
> 	struct list_head	blacklist;
> 	struct list_head	whitelist;
> @@ -334,6 +336,7 @@ struct hci_dev {
> 	unsigned long		dev_flags;
> 
> 	struct delayed_work	le_scan_disable;
> +	struct delayed_work	le_scan_restart;
> 
> 	__s8			adv_tx_power;
> 	__u8			adv_data[HCI_MAX_AD_LENGTH];
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index cb05d7f..343279c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2580,6 +2580,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> 		cancel_delayed_work(&hdev->service_cache);
> 
> 	cancel_delayed_work_sync(&hdev->le_scan_disable);
> +	cancel_delayed_work_sync(&hdev->le_scan_restart);
> 
> 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
> 		cancel_delayed_work_sync(&hdev->rpa_expired);
> @@ -3846,6 +3847,8 @@ static void le_scan_disable_work(struct work_struct *work)
> 
> 	BT_DBG("%s", hdev->name);
> 
> +	cancel_delayed_work_sync(&hdev->le_scan_restart);
> +
> 	hci_req_init(&req, hdev);
> 
> 	hci_req_add_le_scan_disable(&req);
> @@ -3855,6 +3858,39 @@ static void le_scan_disable_work(struct work_struct *work)
> 		BT_ERR("Disable LE scanning request failed: err %d", err);
> }
> 
> +static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status)
> +{
> +	hdev->scan_restart = false;
> +
> +	if (status)
> +		BT_ERR("Failed to restart LE scanning: status %d", status);
> +}
> +
> +static void le_scan_restart_work(struct work_struct *work)
> +{
> +	struct hci_dev *hdev = container_of(work, struct hci_dev,
> +					    le_scan_restart.work);
> +	struct hci_request req;
> +	struct hci_cp_le_set_scan_enable cp;
> +	int err;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	hci_req_init(&req, hdev);
> +
> +	hci_req_add_le_scan_disable(&req);
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.enable = LE_SCAN_ENABLE;
> +	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> +
> +	hdev->scan_restart = true;
> +
> +	err = hci_req_run(&req, le_scan_restart_work_complete);
> +	if (err)
> +		BT_ERR("Disable LE scanning request failed: err %d", err);
> +}
> +
> static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
> {
> 	struct hci_dev *hdev = req->hdev;
> @@ -4007,6 +4043,8 @@ struct hci_dev *hci_alloc_dev(void)
> 	hdev->conn_info_min_age = DEFAULT_CONN_INFO_MIN_AGE;
> 	hdev->conn_info_max_age = DEFAULT_CONN_INFO_MAX_AGE;
> 
> +	hdev->scan_restart = false;
> +
> 	mutex_init(&hdev->lock);
> 	mutex_init(&hdev->req_lock);
> 
> @@ -4032,6 +4070,7 @@ struct hci_dev *hci_alloc_dev(void)
> 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
> 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
> 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
> +	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
> 
> 	skb_queue_head_init(&hdev->rx_q);
> 	skb_queue_head_init(&hdev->cmd_q);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 9629153..0191f76 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1155,7 +1155,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
> 		/* Cancel this timer so that we don't try to disable scanning
> 		 * when it's already disabled.
> 		 */
> -		cancel_delayed_work(&hdev->le_scan_disable);
> +		if (!hdev->scan_restart)
> +			cancel_delayed_work(&hdev->le_scan_disable);

I think you need to add a comment here on why this is now conditional.

Regards

Marcel

