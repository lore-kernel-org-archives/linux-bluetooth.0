Return-Path: <cyrus@holtmann.org>
Message-ID: <1322497710.29909.40.camel@aeonflux>
Subject: Re: [PATCH v2 6/9] Bluetooth: Add LE scan functions to hci_core
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 28 Nov 2011 17:28:30 +0100
In-Reply-To: <1322265226-6404-7-git-send-email-andre.guedes@openbossa.org>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
	 <1322265226-6404-7-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds to hci_core functions to init LE scan and cancel
> an ongoing scanning (hci_do_le_scan and hci_cancel_le_scan).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    3 +++
>  net/bluetooth/hci_core.c         |   32 ++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a48c699..db137ca 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -998,5 +998,8 @@ void hci_le_ltk_neg_reply(struct hci_conn *conn);
>  
>  int hci_do_inquiry(struct hci_dev *hdev, u8 length);
>  int hci_cancel_inquiry(struct hci_dev *hdev);
> +int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
> +								int timeout);
> +int hci_cancel_le_scan(struct hci_dev *hdev);
>  
>  #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8e96e3b..1e5d9db 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2678,5 +2678,37 @@ int hci_cancel_inquiry(struct hci_dev *hdev)
>  	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
>  }
>  
> +int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
> +								int timeout)
> +{
> +	struct le_scan_params *params = &hdev->le_scan_params;
> +
> +	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> +		return -EINPROGRESS;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	params->type = type;
> +	params->interval = interval;
> +	params->window = window;
> +	params->timeout = timeout;
> +
> +	queue_work(hdev->workqueue, &hdev->le_scan);

so you are using the controller workqueue already. That is good. However
if the send command are already processed in a workqueue, we could just
sleep for their results. No need for hci_req_complete handling that we
are using for ioctl based triggers. We could have a lot simpler
hci_request handling from within the workqueue.

> +
> +	return 0;
> +}
> +
> +int hci_cancel_le_scan(struct hci_dev *hdev)
> +{
> +	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> +		return -EPERM;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	del_timer(&hdev->le_scan_timer);
> +
> +	return send_le_scan_enable_cmd(hdev, 0);
> +}
> +

Don't you need to clear out the work struct as well? In case that one is
still running? Meaning cancel gets called quickly after starting the
scan. The window might be small, but this is a race condition.

Regards

Marcel


