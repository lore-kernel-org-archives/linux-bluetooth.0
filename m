Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4] Bluetooth: Fix __hci_request synchronization for
 hci_open_dev
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1292590111-6564-1-git-send-email-johan.hedberg@gmail.com>
References: <1292590111-6564-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Dec 2010 06:46:42 -0800
Message-ID: <1292942802.2658.49.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The initialization function used by hci_open_dev (hci_init_req) sends
> many different HCI commands. The __hci_request function should only
> return when all of these commands have completed (or a timeout occurs).
> Several of these commands cause hci_req_complete to be called which
> causes __hci_request to return prematurely.
> 
> This patch fixes the issue by adding a new hdev->req_last_cmd variable
> which is set during the initialization procedure. The hci_req_complete
> function will no longer mark the request as complete until the command
> matching hdev->req_last_cmd completes.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
> v4: Use __u16 instead of int for req_last_cmd
> 
>  include/net/bluetooth/hci_core.h |    3 ++-
>  net/bluetooth/hci_core.c         |   10 +++++++---
>  net/bluetooth/hci_event.c        |   33 +++++++++++++++++++++++----------
>  3 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 3786ee8..a29feb0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -129,6 +129,7 @@ struct hci_dev {
>  	wait_queue_head_t	req_wait_q;
>  	__u32			req_status;
>  	__u32			req_result;
> +	__u16			req_last_cmd;
>  
>  	struct inquiry_cache	inq_cache;
>  	struct hci_conn_hash	conn_hash;
> @@ -693,6 +694,6 @@ struct hci_sec_filter {
>  #define hci_req_lock(d)		mutex_lock(&d->req_lock)
>  #define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
>  
> -void hci_req_complete(struct hci_dev *hdev, int result);
> +void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result);
>  
>  #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 1a4ec97..787c8df 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -91,9 +91,12 @@ static void hci_notify(struct hci_dev *hdev, int event)
>  
>  /* ---- HCI requests ---- */
>  
> -void hci_req_complete(struct hci_dev *hdev, int result)
> +void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
>  {
> -	BT_DBG("%s result 0x%2.2x", hdev->name, result);
> +	BT_DBG("%s command 0x%04x result 0x%2.2x", hdev->name, cmd, result);
> +
> +	if (hdev->req_last_cmd && cmd != hdev->req_last_cmd)
> +		return;
>  
>  	if (hdev->req_status == HCI_REQ_PEND) {
>  		hdev->req_result = result;
> @@ -149,7 +152,7 @@ static int __hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev,
>  		break;
>  	}
>  
> -	hdev->req_status = hdev->req_result = 0;
> +	hdev->req_last_cmd = hdev->req_status = hdev->req_result = 0;
>  
>  	BT_DBG("%s end: err %d", hdev->name, err);
>  
> @@ -252,6 +255,7 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
>  	/* Connection accept timeout ~20 secs */
>  	param = cpu_to_le16(0x7d00);
>  	hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
> +	hdev->req_last_cmd = HCI_OP_WRITE_CA_TIMEOUT;

just for style consistency add an empty line before this command.

And actually hci_init_req is not the only function where you would need
to add hdev->req_last_cmd entries. There are hci_reset_req and some
others. Without that, the rest of your patch makes hci_req_complete a
non functional operation.

Regards

Marcel


