Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 4/6] Bluetooth: Make max age for connection information configurable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399664133-2892-5-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Fri, 9 May 2014 14:28:00 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <967074B7-CC06-4725-9699-ECCADF70C51C@holtmann.org>
References: <1399664133-2892-1-git-send-email-andrzej.kaczmarek@tieto.com> <1399664133-2892-5-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> This patch adds debugfs entry to configure max age of connection
> information. Cached values will be only refreshed by Get Connection
> Information request if cache is older than this value. Default value
> is 2000ms.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
> include/net/bluetooth/hci_core.h | 4 ++++
> net/bluetooth/hci_core.c         | 4 ++++
> net/bluetooth/mgmt.c             | 4 +---
> 3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 9be523a..6353617 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -145,6 +145,9 @@ struct oob_data {
> /* Default LE RPA expiry time, 15 minutes */
> #define HCI_DEFAULT_RPA_TIMEOUT		(15 * 60)
> 
> +/* Default max age of connection information, 2 sec */
> +#define DEFAULT_CONN_INFO_MAX_AGE	2000
> +
> struct amp_assoc {
> 	__u16	len;
> 	__u16	offset;
> @@ -200,6 +203,7 @@ struct hci_dev {
> 	__u16		le_conn_min_interval;
> 	__u16		le_conn_max_interval;
> 	__u16		discov_interleaved_timeout;
> +	__u16		conn_info_max_age;
> 	__u8		ssp_debug_mode;
> 
> 	__u16		devid_source;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d31f144..b2d1eee1e3 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1754,6 +1754,9 @@ static int __hci_init(struct hci_dev *hdev)
> 			    &blacklist_fops);
> 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
> 
> +	debugfs_create_u16("conn_info_max_age", 0644, hdev->debugfs,
> +			   &hdev->conn_info_max_age);
> +
> 	if (lmp_bredr_capable(hdev)) {
> 		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
> 				    hdev, &inquiry_cache_fops);
> @@ -3789,6 +3792,7 @@ struct hci_dev *hci_alloc_dev(void)
> 
> 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
> 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
> +	hdev->conn_info_max_age = DEFAULT_CONN_INFO_MAX_AGE;
> 
> 	mutex_init(&hdev->lock);
> 	mutex_init(&hdev->req_lock);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 2d86ce1..a7f45d2 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -114,8 +114,6 @@ static const u16 mgmt_events[] = {
> 
> #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
> 
> -#define CONN_INFO_MAX_AGE	msecs_to_jiffies(2 * 1000)
> -

so instead of introducing it here and the later moving it around. Lets just get this right first and introduce the debugfs setting first before using the value.

Regards

Marcel

