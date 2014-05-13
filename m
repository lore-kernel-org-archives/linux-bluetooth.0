Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v3 1/5] Bluetooth: Add conn info lifetime parameters to debugfs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399974751-7226-2-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Tue, 13 May 2014 09:18:51 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B60BB9AD-2C94-4B19-9FFF-3FA68400994F@holtmann.org>
References: <1399974751-7226-1-git-send-email-andrzej.kaczmarek@tieto.com> <1399974751-7226-2-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> This patch adds conn_info_min_age and conn_info_max_age parameters to
> debugfs which determine lifetime of connection information. Actual
> lifetime will be random value between min and max age.
> 
> Default values for min and max age are 1000ms and 3000ms respectively.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
> include/net/bluetooth/hci_core.h | 6 ++++++
> net/bluetooth/hci_core.c         | 7 +++++++
> 2 files changed, 13 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 211bad6..4623f45 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -145,6 +145,10 @@ struct oob_data {
> /* Default LE RPA expiry time, 15 minutes */
> #define HCI_DEFAULT_RPA_TIMEOUT		(15 * 60)
> 
> +/* Default min/max age of connection information (1s/3s) */
> +#define DEFAULT_CONN_INFO_MIN_AGE	1000
> +#define DEFAULT_CONN_INFO_MAX_AGE	3000
> +
> struct amp_assoc {
> 	__u16	len;
> 	__u16	offset;
> @@ -200,6 +204,8 @@ struct hci_dev {
> 	__u16		le_conn_min_interval;
> 	__u16		le_conn_max_interval;
> 	__u16		discov_interleaved_timeout;
> +	__u16		conn_info_min_age;
> +	__u16		conn_info_max_age;
> 	__u8		ssp_debug_mode;
> 
> 	__u16		devid_source;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d31f144..62ebcea 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1754,6 +1754,11 @@ static int __hci_init(struct hci_dev *hdev)
> 			    &blacklist_fops);
> 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
> 
> +	debugfs_create_u16("conn_info_min_age", 0644, hdev->debugfs,
> +			   &hdev->conn_info_min_age);
> +	debugfs_create_u16("conn_info_max_age", 0644, hdev->debugfs,
> +			   &hdev->conn_info_max_age);
> +

I know this is dead simple, but I rather have this done similar to how we do the sniff_max_interval and sniff_min_interval. So that you can not set wrong values or bad ranges.

Regards

Marcel

