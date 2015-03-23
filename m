Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 3/7] Bluetooth: Add data structure for advertising instance
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426921417-3419-4-git-send-email-armansito@chromium.org>
Date: Mon, 23 Mar 2015 11:32:11 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4439E74D-2216-4C99-A6C9-606D2D774DFF@holtmann.org>
References: <1426921417-3419-1-git-send-email-armansito@chromium.org> <1426921417-3419-4-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch introduces a new data structure to represent advertising
> instances that were added using the "Add Advertising" mgmt command.
> Initially an hci_dev structure will support only one of these instances
> at a time, so the current instance is simply stored as a direct member
> of hci_dev.
> 
> Signed-off-by: Arman Uguray <armansito@chromium.org>
> ---
> include/net/bluetooth/hci_core.h | 16 ++++++++++++++++
> net/bluetooth/hci_core.c         |  1 +
> 2 files changed, 17 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b65c53d..2d853d8 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -155,6 +155,15 @@ struct oob_data {
> 	u8 rand256[16];
> };
> 
> +struct adv_info {
> +	__u8 instance;
> +	__u32 flags;
> +	__u16 adv_data_len;
> +	__u8 adv_data[HCI_MAX_AD_LENGTH];
> +	__u16 scan_rsp_len;
> +	__u8 scan_rsp_data[HCI_MAX_AD_LENGTH];
> +};
> +

seems I missed this one in the previous review. Please align the field names.

	__u8  instance;
	__u32 flags;
	__16  adv_data_len;
	__u8  adv_data[..


> #define HCI_MAX_SHORT_NAME_LENGTH	10
> 
> /* Default LE RPA expiry time, 15 minutes */
> @@ -364,6 +373,8 @@ struct hci_dev {
> 	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
> 	__u8			scan_rsp_data_len;
> 
> +	struct adv_info		adv_instance;
> +
> 	__u8			irk[16];
> 	__u32			rpa_timeout;
> 	struct delayed_work	rpa_expired;
> @@ -550,6 +561,11 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
> 	hdev->discovery.scan_duration = 0;
> }
> 
> +static inline void adv_info_init(struct hci_dev *hdev)
> +{
> +	memset(&hdev->adv_instance, 0, sizeof(struct adv_info));
> +}

I wonder if we should just set adv_instance->instance = 0xff to make sure it is not accidentally the level 0 instance.

> +
> bool hci_discovery_active(struct hci_dev *hdev);
> 
> void hci_discovery_set_state(struct hci_dev *hdev, int state);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 773f216..db3dd0c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3125,6 +3125,7 @@ struct hci_dev *hci_alloc_dev(void)
> 
> 	hci_init_sysfs(hdev);
> 	discovery_init(hdev);
> +	adv_info_init(hdev);
> 
> 	return hdev;
> }

Regards

Marcel

