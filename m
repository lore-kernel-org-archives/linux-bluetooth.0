Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v2 1/6] Bluetooth: Update hci_le_scan to use HCI request
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362783979-10142-2-git-send-email-andre.guedes@openbossa.org>
Date: Fri, 8 Mar 2013 17:24:03 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A808B013-E121-4A50-9AEF-09C5B2F6DA39@holtmann.org>
References: <1362783979-10142-1-git-send-email-andre.guedes@openbossa.org> <1362783979-10142-2-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch changes hci_le_scan helper so it uses the HCI request
> framework to enable LE scanning.
> 
> Also, the LE scanning disable timeout was removed from the helper
> and it is now handled in mgmt start_discovery code.

just a heads up, these need to become way more verbose. Explain what you are doing.

> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h |  3 +--
> net/bluetooth/hci_core.c         | 29 +++++++++++++++++----------
> net/bluetooth/mgmt.c             | 43 ++++++++++++++++++++++++++++++++++++----
> 3 files changed, 59 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index d6c3256..964b270 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1173,8 +1173,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
> 							__u8 ltk[16]);
> int hci_do_inquiry(struct hci_dev *hdev, u8 length);
> int hci_cancel_inquiry(struct hci_dev *hdev);
> -int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
> -		int timeout);
> +int hci_le_scan(struct hci_request *req, u8 type, u16 interval, u16 window);
> int hci_cancel_le_scan(struct hci_dev *hdev);
> 
> u8 bdaddr_to_le(u8 bdaddr_type);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index a49c445..59f583b 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1945,25 +1945,34 @@ static void le_scan_work(struct work_struct *work)
> 		       param->timeout);
> }
> 
> -int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
> -		int timeout)
> +int hci_le_scan(struct hci_request *req, u8 type, u16 interval, u16 window)
> {
> -	struct le_scan_params *param = &hdev->le_scan_params;
> +	struct hci_dev *hdev = req->hdev;
> +	struct hci_cp_le_set_scan_param param_cp;
> +	struct hci_cp_le_set_scan_enable enable_cp;
> 
> 	BT_DBG("%s", hdev->name);
> 
> 	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
> 		return -ENOTSUPP;
> 
> -	if (work_busy(&hdev->le_scan))
> -		return -EINPROGRESS;
> +	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> +		return -EALREADY;

This check in here is silly. Why bother initializing a request and then abort it later. You know it ahead of time. This whole thing of hci_req_init in on part and the hci_req_add somewhere else is not a good idea. See comment below.

I am serious, that I want to get rid of this spaghetti type of coding. The HCI transaction should be simple and easy to understand. That is why I insisted on that Johan having to redo his patch set many times. It needs to read like this:

	start transaction

	add something
	add something more

	run it

And that should be all in one function so that people can actually follow what is happening when we do something like enabling LE scanning. I do not want to look into 3-4 different functions to see what is going on.

> +
> +	memset(&param_cp, 0, sizeof(param_cp));
> +	param_cp.type = type;
> +	param_cp.interval = cpu_to_le16(interval);
> +	param_cp.window = cpu_to_le16(window);
> +
> +	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
> +		    &param_cp);
> 
> -	param->type = type;
> -	param->interval = interval;
> -	param->window = window;
> -	param->timeout = timeout;
> +	memset(&enable_cp, 0, sizeof(enable_cp));
> +	enable_cp.enable = 0x01;
> +	enable_cp.filter_dup = 0x01;
> 
> -	queue_work(system_long_wq, &hdev->le_scan);
> +	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
> +		    &enable_cp);
> 
> 	return 0;
> }
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 39395c7..fbf3265 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2428,11 +2428,34 @@ int mgmt_interleaved_discovery(struct hci_dev *hdev)
> 	return err;
> }
> 
> +static void enable_le_scan_complete(struct hci_dev *hdev, u8 status)
> +{
> +	BT_DBG("status %d", status);
> +
> +	if (status)
> +		return;
> +
> +	switch (hdev->discovery.type) {
> +	case DISCOV_TYPE_LE:
> +		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
> +				   msecs_to_jiffies(LE_SCAN_TIMEOUT_LE_ONLY));
> +		break;
> +
> +	case DISCOV_TYPE_INTERLEAVED:
> +		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
> +				   msecs_to_jiffies(LE_SCAN_TIMEOUT_BREDR_LE));
> +		break;
> +	default:
> +		BT_ERR("Invalid discovery type %d", hdev->discovery.type);
> +	}
> +}
> +

Why don't we have one complete handler for LE only and one for interleaved scanning. Seriously, it gets all smashed together for no apparent reason. I fully understand that before this was needed, but with the request framework, the core takes care of everything for you. It makes sure that the right complete handler gets call. So lets stop being silly here.

If you want to look into examples from userspace, then look into what the changes to a proper mgmt framework did to make this simpler and cleaner. No crazy state tracking to remember who was calling what. Just can rely on that the caller gives a proper complete function.

On a different note, can we please get rid of this msecs_to_jiffies calls in place. They should be made part of the constant definition. It is a waste of space and they just clutter up the code.

> static int start_discovery(struct sock *sk, struct hci_dev *hdev,
> 			   void *data, u16 len)
> {
> 	struct mgmt_cp_start_discovery *cp = data;
> 	struct pending_cmd *cmd;
> +	struct hci_request req;
> 	int err;
> 
> 	BT_DBG("%s", hdev->name);
> @@ -2485,8 +2508,14 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
> 			goto failed;
> 		}
> 
> -		err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
> -				  LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
> +		hci_req_init(&req, hdev);
> +
> +		err = hci_le_scan(&req, LE_SCAN_TYPE, LE_SCAN_INT,
> +				  LE_SCAN_WIN);
> +		if (err)
> +			break;
> +
> +		err = hci_req_run(&req, enable_le_scan_complete);
> 		break;

So this is one thing I do not want to see. I want hci_req_init, hci_req_add and hci_req_run in the same function. No go off and call some magic helper that does 4 other things. Put the HCI opcodes and parameters right where they are suppose to be.

If you need to put the transaction into a separate function because it is shared or more complex, then also hci_req_init and hci_req_run should go into that function.

> 	case DISCOV_TYPE_INTERLEAVED:
> @@ -2497,8 +2526,14 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
> 			goto failed;
> 		}
> 
> -		err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT, LE_SCAN_WIN,
> -				  LE_SCAN_TIMEOUT_BREDR_LE);
> +		hci_req_init(&req, hdev);
> +
> +		err = hci_le_scan(&req, LE_SCAN_TYPE, LE_SCAN_INT,
> +				  LE_SCAN_WIN);
> +		if (err)
> +			break;
> +
> +		err = hci_req_run(&req, enable_le_scan_complete);
> 		break;

What is the difference between the code statement above and the one be below now.

So you smash the different handling into the complete callback to save space, but then the calling side is duplicated. You can do better than this.

Regards

Marcel

