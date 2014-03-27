Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v3 2/2] Bluetooth: Add new debugfs parameter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395935344-31715-2-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 27 Mar 2014 09:06:47 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0333237E-E20D-41EF-92F4-D66E0732DFA3@holtmann.org>
References: <1395935344-31715-1-git-send-email-lukasz.rymanowski@tieto.com> <1395935344-31715-2-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> With this patch it is possible to control discovery interleaved
> timeout value from debugfs.
> 
> It is for fine tuning of this timeout.
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
> include/net/bluetooth/hci_core.h | 1 +
> net/bluetooth/hci_core.c         | 4 ++++
> net/bluetooth/mgmt.c             | 2 +-
> 3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 1c6776a..6a5922f 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -199,6 +199,7 @@ struct hci_dev {
> 	__u16		le_scan_window;
> 	__u16		le_conn_min_interval;
> 	__u16		le_conn_max_interval;
> +	__u16		discov_interleaved_timeout;
> 	__u8		ssp_debug_mode;
> 
> 	__u16		devid_source;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index c6189d9..4ae237c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1823,6 +1823,9 @@ static int __hci_init(struct hci_dev *hdev)
> 				    &lowpan_debugfs_fops);
> 		debugfs_create_file("le_auto_conn", 0644, hdev->debugfs, hdev,
> 				    &le_auto_conn_fops);
> +		debugfs_create_u16("discov_interleaved_timeout", 0644,
> +				   hdev->debugfs,
> +				   &hdev->discov_interleaved_timeout);
> 	}
> 
> 	return 0;
> @@ -3786,6 +3789,7 @@ struct hci_dev *hci_alloc_dev(void)
> 
> 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;

remove this empty line.

> 
> +	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;

And add an empty line here.

> 	mutex_init(&hdev->lock);
> 	mutex_init(&hdev->req_lock);
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index e6d906f..b97477f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3373,7 +3373,7 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
> 		break;
> 
> 	case DISCOV_TYPE_INTERLEAVED:
> -		timeout = msecs_to_jiffies(DISCOV_INTERLEAVED_TIMEOUT);
> +		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
> 		break;

Regards

Marcel

