Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2] Bluetooth: Add new debugfs parameter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395785961-4321-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 26 Mar 2014 02:01:25 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <530BDEEE-43F2-48E8-9B82-46BA0C9039A2@holtmann.org>
References: <1395785961-4321-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> With this patch it is possible to control discovery interleaved
> timeout value from debugfs. Default value is 5120 ms.
> 
> It is for fine tuning of this timeout.
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
> include/net/bluetooth/hci_core.h | 2 +-
> net/bluetooth/hci_core.c         | 6 ++++++
> net/bluetooth/mgmt.c             | 2 +-
> 3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index c2a419c..abd38a2 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -199,6 +199,7 @@ struct hci_dev {
> 	__u16		le_scan_window;
> 	__u16		le_conn_min_interval;
> 	__u16		le_conn_max_interval;
> +	__u32		discov_interl_timeout;

are we using interl as abbreviation for interleaved anywhere else?

> 	__u8		ssp_debug_mode;
> 
> 	__u16		devid_source;
> @@ -1210,7 +1211,6 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
> #define DISCOV_LE_SCAN_WIN		0x12
> #define DISCOV_LE_SCAN_INT		0x12
> #define DISCOV_LE_TIMEOUT		msecs_to_jiffies(10240)
> -#define DISCOV_INTERLEAVED_TIMEOUT	msecs_to_jiffies(5120)

Leave this here.

> #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
> #define DISCOV_BREDR_INQUIRY_LEN	0x08
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index c6189d9..f51d572 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -61,6 +61,9 @@ static void hci_notify(struct hci_dev *hdev, int event)
> 
> /* ---- HCI debugfs entries ---- */
> 
> +/* Discovery interleaved timeout */
> +static u16 discov_timeout_ms = 5120;

The define is a lot better. Don’t do this extra variable.

> +
> static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
> 			     size_t count, loff_t *ppos)
> {
> @@ -1823,6 +1826,8 @@ static int __hci_init(struct hci_dev *hdev)
> 				    &lowpan_debugfs_fops);
> 		debugfs_create_file("le_auto_conn", 0644, hdev->debugfs, hdev,
> 				    &le_auto_conn_fops);
> +		debugfs_create_u16("discov_interleaved_timeout", 0644,
> +				   hdev->debugfs, &discov_timeout_ms);

I am not sure about the name. I think what this really is Interleaved Discovery Interval. Not sure if that is any better though.

> 	}
> 
> 	return 0;
> @@ -3786,6 +3791,7 @@ struct hci_dev *hci_alloc_dev(void)
> 
> 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
> 
> +	hdev->discov_interl_timeout = msecs_to_jiffies(discov_timeout_ms);

Using the define here is a lot better than a global variable.

> 	mutex_init(&hdev->lock);
> 	mutex_init(&hdev->req_lock);
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 37706e8..6229d1f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3372,7 +3372,7 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
> 
> 	case DISCOV_TYPE_INTERLEAVED:
> 		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
> -				   DISCOV_INTERLEAVED_TIMEOUT);
> +				   hdev->discov_interl_timeout);
> 		break;

Regards

Marcel

