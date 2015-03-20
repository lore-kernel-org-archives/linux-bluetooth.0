Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 3/6] Bluetooth: Add data structure for advertising instance
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426809877-22469-4-git-send-email-armansito@chromium.org>
Date: Thu, 19 Mar 2015 17:47:55 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5CC6A398-A75A-4BB1-932A-E73C7CE0E951@holtmann.org>
References: <1426809877-22469-1-git-send-email-armansito@chromium.org> <1426809877-22469-4-git-send-email-armansito@chromium.org>
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
> include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
> net/bluetooth/hci_core.c         |  1 +
> 2 files changed, 19 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b65c53d..4e32e06 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -155,6 +155,15 @@ struct oob_data {
> 	u8 rand256[16];
> };
> 
> +struct le_adv_instance {
> +	__u8 index;

I would prefer that we better call it id or instance here. I also wonder if we should just have this as le_adv_info struct to keep the names a bit shorter. And in that case then use rather __u8 instance over __u8 id.

You also do not need to carry the le_ prefix around all the time. Advertising is by definition LE only. I would just strip it here.

> +	__u32 flags;
> +	__u16 adv_data_len;
> +	__u8 adv_data[HCI_MAX_AD_LENGTH];
> +	__u16 scan_rsp_len;
> +	__u8 scan_rsp_data[HCI_MAX_AD_LENGTH];
> +};
> +
> #define HCI_MAX_SHORT_NAME_LENGTH	10
> 
> /* Default LE RPA expiry time, 15 minutes */
> @@ -364,6 +373,9 @@ struct hci_dev {
> 	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
> 	__u8			scan_rsp_data_len;
> 
> +	struct le_adv_instance	adv_instance;
> +	__u8			cur_adv_index;
> +

I do not follow what the cur_adv_index would give us. Since initially we would only support a single instance, we can just use the hdev->dev_flag for this that you defined.

> 	__u8			irk[16];
> 	__u32			rpa_timeout;
> 	struct delayed_work	rpa_expired;
> @@ -550,6 +562,12 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
> 	hdev->discovery.scan_duration = 0;
> }
> 
> +static inline void hci_le_adv_instance_init(struct hci_dev *hdev)
> +{
> +	memset(&hdev->adv_instance, 0, sizeof(struct le_adv_instance));
> +	hdev->cur_adv_index = 0;
> +}
> +
> bool hci_discovery_active(struct hci_dev *hdev);
> 
> void hci_discovery_set_state(struct hci_dev *hdev, int state);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 773f216..50a5f4c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3125,6 +3125,7 @@ struct hci_dev *hci_alloc_dev(void)
> 
> 	hci_init_sysfs(hdev);
> 	discovery_init(hdev);
> +	hci_le_adv_instance_init(hdev);

I would not go overboard with the naming for local functions. So adv_info_init() might be just enough.

Regards

Marcel

