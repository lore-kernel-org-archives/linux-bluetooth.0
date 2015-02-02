Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v11 1/2] Bluetooth: Add le_scan_restart work for LE scan restarting
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422325138-20113-1-git-send-email-jpawlowski@google.com>
Date: Sun, 1 Feb 2015 21:13:55 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <40854BA3-0525-48FF-A4E7-30223B09FEE1@holtmann.org>
References: <1422325138-20113-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> Currently there is no way to restart le scan, and it's needed in
> service scan method. The way it work: it disable, and then enable le
> scan on controller.
> 
> During the restart, we must remember when the scan was started, and
> it's duration, to later re-schedule the le_scan_disable work, that was
> stopped during the stop scan phase.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> include/net/bluetooth/hci_core.h |  5 +++
> net/bluetooth/hci_core.c         | 69 ++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/mgmt.c             | 11 ++++++-
> 3 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 0f5e59f..6261679 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -79,6 +79,8 @@ struct discovery_state {
> 	s8			rssi;
> 	u16			uuid_count;
> 	u8			(*uuids)[16];
> +	unsigned long		scan_start;
> +	unsigned long		scan_duration;
> };
> 
> struct hci_conn_hash {
> @@ -351,6 +353,7 @@ struct hci_dev {
> 	unsigned long		dev_flags;
> 
> 	struct delayed_work	le_scan_disable;
> +	struct delayed_work	le_scan_restart;
> 
> 	__s8			adv_tx_power;
> 	__u8			adv_data[HCI_MAX_AD_LENGTH];
> @@ -527,6 +530,8 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
> 	hdev->discovery.uuid_count = 0;
> 	kfree(hdev->discovery.uuids);
> 	hdev->discovery.uuids = NULL;
> +	hdev->discovery.scan_start = 0;
> +	hdev->discovery.scan_duration = 0;
> }
> 
> bool hci_discovery_active(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index bb831d6..399bf49 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1617,6 +1617,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> 		cancel_delayed_work(&hdev->service_cache);
> 
> 	cancel_delayed_work_sync(&hdev->le_scan_disable);
> +	cancel_delayed_work_sync(&hdev->le_scan_restart);
> 
> 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
> 		cancel_delayed_work_sync(&hdev->rpa_expired);
> @@ -2791,6 +2792,8 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
> 		return;
> 	}
> 
> +	hdev->discovery.scan_start = 0;
> +
> 	switch (hdev->discovery.type) {
> 	case DISCOV_TYPE_LE:
> 		hci_dev_lock(hdev);
> @@ -2830,6 +2833,8 @@ static void le_scan_disable_work(struct work_struct *work)
> 
> 	BT_DBG("%s", hdev->name);
> 
> +	cancel_delayed_work_sync(&hdev->le_scan_restart);
> +
> 	hci_req_init(&req, hdev);
> 
> 	hci_req_add_le_scan_disable(&req);
> @@ -2839,6 +2844,69 @@ static void le_scan_disable_work(struct work_struct *work)
> 		BT_ERR("Disable LE scanning request failed: err %d", err);
> }
> 
> +static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status,
> +					  u16 opcode)
> +{
> +	unsigned long timeout, duration, scan_start, jiffy;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	if (status) {
> +		BT_ERR("Failed to restart LE scan: status %d", status);
> +		return;
> +	}
> +
> +	if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
> +	    !hdev->discovery.scan_start)
> +		return;
> +
> +	duration = hdev->discovery.scan_duration;
> +	scan_start = hdev->discovery.scan_start;
> +	jiffy = jiffies;
> +	if (jiffy - scan_start <= duration) {
> +		int elapsed;
> +
> +		if (jiffy >= scan_start)
> +			elapsed = jiffy - scan_start;
> +		else
> +			elapsed = ULONG_MAX - scan_start + jiffy;
> +
> +		timeout = duration - elapsed;
> +	} else {
> +		timeout = 0;
> +	}

we really need a comment here to explain what this is doing and more importantly why this is correct.

> +	queue_delayed_work(hdev->workqueue,
> +			   &hdev->le_scan_disable, timeout);
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
> +	/* If controller is not scanning we are done. */
> +	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> +		return;
> +
> +	hci_req_init(&req, hdev);
> +
> +	hci_req_add_le_scan_disable(&req);
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.enable = LE_SCAN_ENABLE;
> +	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
> +	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> +
> +	err = hci_req_run(&req, le_scan_restart_work_complete);
> +	if (err)
> +		BT_ERR("Restart LE scan request failed: err %d", err);
> +}
> +
> /* Copy the Identity Address of the controller.
>  *
>  * If the controller has a public BD_ADDR, then by default use that one.
> @@ -2934,6 +3002,7 @@ struct hci_dev *hci_alloc_dev(void)
> 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
> 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
> 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
> +	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
> 
> 	skb_queue_head_init(&hdev->rx_q);
> 	skb_queue_head_init(&hdev->cmd_q);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 25e40e8..2012163 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3876,9 +3876,18 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
> 		break;
> 	}
> 
> -	if (timeout)
> +	if (timeout) {
> +		if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
> +			     &hdev->quirks) &&
> +		    (hdev->discovery.uuid_count > 0 ||
> +		     hdev->discovery.rssi != HCI_RSSI_INVALID)) {
> +			hdev->discovery.scan_start = jiffies;
> +			hdev->discovery.scan_duration = timeout;
> +		}
> +

Same here. Add a comment above the switch statement explaining why that is there.

> 		queue_delayed_work(hdev->workqueue,
> 				   &hdev->le_scan_disable, timeout);
> +	}
> 
> unlock:
> 	hci_dev_unlock(hdev);

The rest looks fine to me.

Regards

Marcel

