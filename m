Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Nov 2014 11:26:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v9 1/3] Bluetooth: add hci_restart_le_scan
Message-ID: <20141125092625.GA15104@t440s.ger.corp.intel.com>
References: <1416728993-4189-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416728993-4189-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Sat, Nov 22, 2014, Jakub Pawlowski wrote:
> Currently there is no way to restart le scan. It's needed in
> preparation for new service scan method. The way it work: it disable,
> and then enable le scan on controller. During this restart special flag
> is set to make sure we won't remove disable scan work from workqueue.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  include/net/bluetooth/hci.h      |  1 +
>  include/net/bluetooth/hci_core.h |  3 +++
>  net/bluetooth/hci_core.c         | 43 ++++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        |  9 ++++++---
>  4 files changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index e56f909..2f0bce2 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -203,6 +203,7 @@ enum {
>  	HCI_FAST_CONNECTABLE,
>  	HCI_BREDR_ENABLED,
>  	HCI_LE_SCAN_INTERRUPTED,
> +	HCI_LE_SCAN_RESTARTING,
>  };

This should break 32-bit systems since we already have 32 flags for
hdev->dev flags. The same goes for the HCI_SERVICE_FILTER you add in a
later patch.

One solution that comes to mind is to extend the discovery struct with
its own unsigned long flags field - at least the second flag you're
adding doesn't really belong in dev_flags anyway.

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
> +	set_bit(HCI_LE_SCAN_RESTARTING, &hdev->dev_flags);
> +
> +	err = hci_req_run(&req, le_scan_restart_work_complete);
> +	if (err)
> +		BT_ERR("Disable LE scanning request failed: err %d", err);
> +}

Shouldn't you be checking the value of HCI_LE_SCAN before adding any HCI
commands to the request (after all this function gets called with a delay
and the state may have changed).

Shouldn't the error log talk about restarting instead of disabling?

Johan
