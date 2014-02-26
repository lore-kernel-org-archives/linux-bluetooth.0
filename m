Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 17/17] Bluetooth: Update background scan parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393362104-12175-18-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 25 Feb 2014 22:47:35 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6A72DFF9-91F8-4207-9A3C-A33CD12383BF@holtmann.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org> <1393362104-12175-18-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> If new scanning parameters are set while background scan is running,
> we should restart background scanning so these parameters are updated.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         | 26 ++++++++++++++++++++++++++
> net/bluetooth/mgmt.c             |  7 +++++++
> 3 files changed, 34 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e0e0eab..8f0ddc8 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -814,6 +814,7 @@ void hci_pend_le_conn_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
> void hci_pend_le_conns_clear(struct hci_dev *hdev);
> 
> void hci_update_background_scan(struct hci_dev *hdev);
> +void hci_restart_background_scan(struct hci_dev *hdev);
> 
> void hci_uuids_clear(struct hci_dev *hdev);
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e776624..f5c0e97 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -5183,3 +5183,29 @@ void hci_update_background_scan(struct hci_dev *hdev)
> 	if (err)
> 		BT_ERR("Failed to run HCI request: err %d", err);
> }
> +
> +static void restart_background_scan_complete(struct hci_dev *hdev, u8 status)
> +{
> +	if (status)
> +		BT_DBG("HCI request failed to restart background scan: "
> +		       "status 0x%2.2x", status);
> +}
> +
> +void hci_restart_background_scan(struct hci_dev *hdev)
> +{
> +	struct hci_request req;
> +	int err;
> +
> +	hci_req_init(&req, hdev);
> +
> +	hci_req_add_le_scan_disable(&req);
> +	hci_req_add_le_passive_scan(&req, hdev);
> +
> +	err = hci_req_run(&req, restart_background_scan_complete);
> +	if (err) {
> +		BT_ERR("Failed to run HCI request: err %d", err);
> +		return;
> +	}
> +
> +	BT_DBG("%s re-starting background scanning", hdev->name);
> +}
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 2e6564e..08d52f2 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3924,6 +3924,13 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
> 
> 	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS, 0, NULL, 0);
> 
> +	/* If background scan is running, restart it so new parameters are
> +	 * loaded.
> +	 */
> +	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
> +	    hdev->discovery.state == DISCOVERY_STOPPED)
> +		hci_restart_background_scan(hdev);
> +

unless there are some other plans, then put the hci_req directly into the body of the if statement. No need to split this out into a public function. And even you want to use this later, I rather see this confined right now and keep public function to a minimum.

Regards

Marcel

