Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 02/12] Bluetooth: Run all background scan updates through req_workqueue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447179274-12276-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 11 Nov 2015 07:26:01 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BB80F3DD-E6BD-4902-BEC4-B3768883ABAC@holtmann.org>
References: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com> <1447179274-12276-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Instead of firing off a simple async request queue all background scan
> updates through req_workqueue and use hci_req_sync() there to ensure
> that no two updates overlap with each other.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_request.c      | 39 +++++++++++++++++----------------------
> net/bluetooth/hci_request.h      |  6 +++++-
> net/bluetooth/mgmt.c             |  2 +-
> 4 files changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 15e6a2bffc2b..c2ca6a58d1e0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -327,6 +327,8 @@ struct hci_dev {
> 	struct work_struct	cmd_work;
> 	struct work_struct	tx_work;
> 
> +	struct work_struct	bg_scan_update;
> +
> 	struct sk_buff_head	rx_q;
> 	struct sk_buff_head	raw_q;
> 	struct sk_buff_head	cmd_q;
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index cfb63fe8545e..842f64cd8800 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -731,28 +731,6 @@ void __hci_update_background_scan(struct hci_request *req)
> 	}
> }
> 
> -static void update_background_scan_complete(struct hci_dev *hdev, u8 status,
> -					    u16 opcode)
> -{
> -	if (status)
> -		BT_DBG("HCI request failed to update background scanning: "
> -		       "status 0x%2.2x", status);
> -}
> -
> -void hci_update_background_scan(struct hci_dev *hdev)
> -{
> -	int err;
> -	struct hci_request req;
> -
> -	hci_req_init(&req, hdev);
> -
> -	__hci_update_background_scan(&req);
> -
> -	err = hci_req_run(&req, update_background_scan_complete);
> -	if (err && err != -ENODATA)
> -		BT_ERR("Failed to run HCI request: err %d", err);
> -}
> -
> void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
> 		      u8 reason)
> {
> @@ -846,10 +824,27 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
> 	return 0;
> }
> 
> +static void update_bg_scan(struct hci_request *req, unsigned long opt)
> +{
> +	hci_dev_lock(req->hdev);
> +	__hci_update_background_scan(req);
> +	hci_dev_unlock(req->hdev);
> +}
> +
> +static void bg_scan_update(struct work_struct *work)
> +{
> +	struct hci_dev *hdev = container_of(work, struct hci_dev,
> +					    bg_scan_update);
> +
> +	hci_req_sync(hdev, update_bg_scan, 0, HCI_CMD_TIMEOUT);
> +}
> +
> void hci_request_setup(struct hci_dev *hdev)
> {
> +	INIT_WORK(&hdev->bg_scan_update, bg_scan_update);
> }
> 
> void hci_request_cleanup(struct hci_dev *hdev)
> {
> +	cancel_work_sync(&hdev->bg_scan_update);
> }
> diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
> index df02afb517fa..6adf91e793de 100644
> --- a/net/bluetooth/hci_request.h
> +++ b/net/bluetooth/hci_request.h
> @@ -64,12 +64,16 @@ void __hci_update_page_scan(struct hci_request *req);
> int hci_update_random_address(struct hci_request *req, bool require_privacy,
> 			      u8 *own_addr_type);
> 
> -void hci_update_background_scan(struct hci_dev *hdev);
> void __hci_update_background_scan(struct hci_request *req);
> 
> int hci_abort_conn(struct hci_conn *conn, u8 reason);
> void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
> 		      u8 reason);
> 
> +static inline void hci_update_background_scan(struct hci_dev *hdev)
> +{
> +	queue_work(hdev->req_workqueue, &hdev->bg_scan_update);
> +}
> +
> void hci_request_setup(struct hci_dev *hdev);
> void hci_request_cleanup(struct hci_dev *hdev);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 7f22119276f3..4afe1d58a32c 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2510,7 +2510,7 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
> 		hci_req_init(&req, hdev);
> 		update_adv_data(&req);
> 		update_scan_rsp_data(&req);
> -		__hci_update_background_scan(&req);
> +		hci_update_background_scan(hdev);
> 		hci_req_run(&req, NULL);

this interleaving of a sync request with the creation of another request needs a comment. Or just move it before hci_req_init or after hci_req_run.

Regards

Marcel

