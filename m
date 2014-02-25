Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Feb 2014 07:57:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v11 01/15] Bluetooth: Create hci_req_add_le_scan_disable
 helper
Message-ID: <20140225055717.GA776@localhost.P-661HNU-F1>
References: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
 <1393281061-14320-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393281061-14320-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Mon, Feb 24, 2014, Andre Guedes wrote:
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1128,6 +1128,7 @@ void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
>  void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
>  		    const void *param, u8 event);
>  void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
> +void hci_req_add_le_scan_disable(struct hci_request *req);

It doesn't feel right to put this straight next to the generic async
request API. I'd at least have an empty line between the generic API and
this new function.

> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3318,7 +3318,6 @@ static void le_scan_disable_work(struct work_struct *work)
>  {
>  	struct hci_dev *hdev = container_of(work, struct hci_dev,
>  					    le_scan_disable.work);
> -	struct hci_cp_le_set_scan_enable cp;
>  	struct hci_request req;
>  	int err;
>  
> @@ -3326,9 +3325,7 @@ static void le_scan_disable_work(struct work_struct *work)
>  
>  	hci_req_init(&req, hdev);
>  
> -	memset(&cp, 0, sizeof(cp));
> -	cp.enable = LE_SCAN_DISABLE;
> -	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> +	hci_req_add_le_scan_disable(&req);
>  
>  	err = hci_req_run(&req, le_scan_disable_work_complete);
>  	if (err)
> @@ -4872,3 +4869,12 @@ static void hci_cmd_work(struct work_struct *work)
>  		}
>  	}
>  }
> +
> +void hci_req_add_le_scan_disable(struct hci_request *req)
> +{
> +	struct hci_cp_le_set_scan_enable cp;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.enable = LE_SCAN_DISABLE;
> +	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> +}
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 25b8b27..c722914 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3526,7 +3526,6 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
>  	struct hci_cp_remote_name_req_cancel cp;
>  	struct inquiry_entry *e;
>  	struct hci_request req;
> -	struct hci_cp_le_set_scan_enable enable_cp;
>  	int err;
>  
>  	BT_DBG("%s", hdev->name);
> @@ -3562,10 +3561,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
>  		} else {
>  			cancel_delayed_work(&hdev->le_scan_disable);
>  
> -			memset(&enable_cp, 0, sizeof(enable_cp));
> -			enable_cp.enable = LE_SCAN_DISABLE;
> -			hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE,
> -				    sizeof(enable_cp), &enable_cp);
> +			hci_req_add_le_scan_disable(&req);
>  		}
>  
>  		break;

You've missed one place in clean_up_hci_state() in mgmt.c (which was
added by the recent "graceful power down" patch set.

Johan
