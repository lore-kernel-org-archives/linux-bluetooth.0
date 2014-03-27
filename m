Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v3 1/2] Bluetooth: Keep msec in DISCOV_INTERLEAVED_TIMEOUT
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395935344-31715-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 27 Mar 2014 09:05:13 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <220080C5-FD9E-4DAE-87F4-8A6AF37E3A91@holtmann.org>
References: <1395935344-31715-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> Keep msec instead of jiffies in this define. This is needed by folowing
> patch where we want this timeout to be exposed in debugfs.
> 
> Note: This default value comes from BT Spec. 4.0 Vol 3 chapter 13.2.1.
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/mgmt.c             | 13 +++++++++----
> 2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e2bfcda..1c6776a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1210,7 +1210,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
> #define DISCOV_LE_SCAN_WIN		0x12
> #define DISCOV_LE_SCAN_INT		0x12
> #define DISCOV_LE_TIMEOUT		msecs_to_jiffies(10240)
> -#define DISCOV_INTERLEAVED_TIMEOUT	msecs_to_jiffies(5120)
> +#define DISCOV_INTERLEAVED_TIMEOUT	5120 /* msec */

okay, then lets change both to use msecs instead of jiffies.

> #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
> #define DISCOV_BREDR_INQUIRY_LEN	0x08
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 6487c73..e6d906f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3352,6 +3352,8 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
> 
> static void start_discovery_complete(struct hci_dev *hdev, u8 status)
> {
> +	unsigned long timeout = 0;
> +
> 	BT_DBG("status %d", status);
> 
> 	if (status) {
> @@ -3367,13 +3369,11 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
> 
> 	switch (hdev->discovery.type) {
> 	case DISCOV_TYPE_LE:
> -		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
> -				   DISCOV_LE_TIMEOUT);
> +		timeout = DISCOV_LE_TIMEOUT;
> 		break;
> 
> 	case DISCOV_TYPE_INTERLEAVED:
> -		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
> -				   DISCOV_INTERLEAVED_TIMEOUT);
> +		timeout = msecs_to_jiffies(DISCOV_INTERLEAVED_TIMEOUT);
> 		break;
> 
> 	case DISCOV_TYPE_BREDR:
> @@ -3382,6 +3382,11 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
> 	default:
> 		BT_ERR("Invalid discovery type %d", hdev->discovery.type);
> 	}
> +
> +	if (!timeout)
> +		return;
> +
> +	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable, timeout);
> }

Regards

Marcel

