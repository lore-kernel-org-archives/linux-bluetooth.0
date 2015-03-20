Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 6/6] Bluetooth: Add Advertising Added/Removed events
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426809877-22469-7-git-send-email-armansito@chromium.org>
Date: Thu, 19 Mar 2015 17:47:56 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BED01ED0-6BC6-4894-BCE8-D1556E81381E@holtmann.org>
References: <1426809877-22469-1-git-send-email-armansito@chromium.org> <1426809877-22469-7-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch introduces the Advertising Added and Advertising Removed
> events. The events are sent when an advertising instance is added
> or removed from an hci_dev.
> 
> Signed-off-by: Arman Uguray <armansito@chromium.org>
> ---
> include/net/bluetooth/mgmt.h | 10 ++++++++++
> net/bluetooth/mgmt.c         | 37 +++++++++++++++++++++++++++++--------
> 2 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index c60a408..874e2a2 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -766,3 +766,13 @@ struct mgmt_ev_local_oob_data_updated {
> 	__le16	eir_len;
> 	__u8	eir[0];
> } __packed;
> +
> +#define MGMT_EV_ADVERTISING_ADDED	0x0023
> +struct mgmt_ev_advertising_added {
> +	__u8	instance;
> +} __packed;
> +
> +#define MGMT_EV_ADVERTISING_REMOVED	0x0024
> +struct mgmt_ev_advertising_removed {
> +	__u8	instance;
> +} __packed;

put these into your first patch. I am pretty confident that these will not change much.

> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index eae280d..5d04dd8 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -137,6 +137,8 @@ static const u16 mgmt_events[] = {
> 	MGMT_EV_EXT_INDEX_ADDED,
> 	MGMT_EV_EXT_INDEX_REMOVED,
> 	MGMT_EV_LOCAL_OOB_DATA_UPDATED,
> +	MGMT_EV_ADVERTISING_ADDED,
> +	MGMT_EV_ADVERTISING_REMOVED,
> };
> 
> #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
> @@ -6441,6 +6443,24 @@ static bool adv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *adv_data,
> 	return true;
> }
> 
> +static void advertising_added(struct hci_dev *hdev, u8 instance)
> +{
> +	struct mgmt_ev_advertising_added ev;
> +
> +	ev.instance = instance;
> +
> +	mgmt_event(MGMT_EV_ADVERTISING_ADDED, hdev, &ev, sizeof(ev), NULL);
> +}
> +
> +static void advertising_removed(struct hci_dev *hdev, u8 instance)
> +{
> +	struct mgmt_ev_advertising_removed ev;
> +
> +	ev.instance = instance;
> +
> +	mgmt_event(MGMT_EV_ADVERTISING_REMOVED, hdev, &ev, sizeof(ev), NULL);
> +}
> +

You want to skip the socket the Add Advertising command has been executed on. Like we do with every other command. So you need to support that. Look at device_added().

> static void add_advertising_complete(struct hci_dev *hdev, u8 status,
> 				     u16 opcode)
> {
> @@ -6453,9 +6473,9 @@ static void add_advertising_complete(struct hci_dev *hdev, u8 status,
> 
> 	if (status) {
> 		hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
> -		hdev->cur_adv_index = 0;
> +		advertising_removed(hdev, hdev->cur_adv_index);
> 
> -		/* TODO: Send Advertising Removed event */
> +		hdev->cur_adv_index = 0;
> 	}
> 
> 	cmd = pending_find(MGMT_OP_ADD_ADVERTISING, hdev);
> @@ -6535,10 +6555,11 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
> 		memcpy(hdev->adv_instance.scan_rsp_data,
> 		       cp->data + cp->adv_data_len, cp->scan_rsp_len);
> 
> -	/* TODO: Send Advertising Added event if the index changed
> -	 * from 0 to 1.
> -	 */
> -	hdev->cur_adv_index = cp->instance;
> +	if (hdev->cur_adv_index != cp->instance) {
> +		hdev->cur_adv_index = cp->instance;
> +
> +		advertising_added(hdev, hdev->cur_adv_index);
> +	}
> 
> 	hci_dev_set_flag(hdev, HCI_ADVERTISING_INSTANCE);
> 
> @@ -6640,11 +6661,11 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
> 		goto unlock;
> 	}
> 
> +	advertising_removed(hdev, hdev->cur_adv_index);
> +
> 	memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
> 	hdev->cur_adv_index = 0;
> 
> -	/* TODO" Send Advertising Removed event */
> -
> 	hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
> 
> 	/* If the HCI_ADVERTISING flag is set or the device isn't powered then

since this is all pretty much simple, you might just squash this into the patches for the add and remove feature. Seems pretty straight forward from an event perspective.

Regards

Marcel

