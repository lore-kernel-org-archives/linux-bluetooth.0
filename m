Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 4/4] Bluetooth: Merge ADV_IND/ADV_SCAN_IND and SCAN_RSP together
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395650883-25577-4-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 24 Mar 2014 13:12:49 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <713211EC-11CA-424C-93FD-AEF338D4FFD9@holtmann.org>
References: <1395650883-25577-1-git-send-email-johan.hedberg@gmail.com> <1395650883-25577-4-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To avoid too many events being sent to user space and to help parsing of
> all available remote device data it makes sense for us to wait for the
> scan response and send a single merged Device Found event to user space.
> 
> This patch adds a few new variables to hci_dev to track the last
> received ADV_IND/ADV_SCAN_IND, i.e. those which will cause a SCAN_REQ to
> be send in the case of active scanning. When the SCAN_RSP is received
> the cached data is passed together with the SCAN_RSP to the
> mgmt_device_found function which takes care of merging them into a
> single Device Found event.
> 
> We also need a bit of extra logic to handle situations where we don't
> receive a SCAN_RSP after caching some data. In such a scenario we simply
> have to send out the cached data as it is and then operate on the new
> report as if the cache had been empty.
> 
> We also need to send out any pending cached data when scanning stops as
> well as ensure that the cache is empty at the start of a new active
> scanning session. These both cases are covered by the update to the
> hci_cc_le_set_scan_enable function in this patch.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  4 +++
> net/bluetooth/hci_event.c        | 76 ++++++++++++++++++++++++++++++++++++++--
> 2 files changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a1b8eab8a47d..59b112397d39 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -68,6 +68,10 @@ struct discovery_state {
> 	struct list_head	unknown;	/* Name state not known */
> 	struct list_head	resolve;	/* Name needs to be resolved */
> 	__u32			timestamp;
> +	bdaddr_t		last_adv_addr;
> +	u8			last_adv_addr_type;
> +	u8			last_adv_data[HCI_MAX_AD_LENGTH];
> +	u8			last_adv_data_len;
> };
> 
> struct hci_conn_hash {
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index e7e9c1688402..addc44f28c87 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1018,6 +1018,12 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
> 	hci_dev_unlock(hdev);
> }
> 
> +#define ADV_CACHE_EMPTY(d)	(!bacmp(&(d)->last_adv_addr, BDADDR_ANY))

maybe using something like has_pending_adv_report() is a bit better. I have a bit of a weird feeling see ADV_CACHE_EMPTY calls since it is not really a cache.

> +#define ADV_CACHE_CLEAR(d)	do { \
> +					bacpy(&(d)->last_adv_addr, BDADDR_ANY); \
> +					(d)->last_adv_data_len = 0; \
> +				} while (0)

clear_pending_adv_report() seems like a bit better name.

> +
> static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
> 				      struct sk_buff *skb)
> {
> @@ -1036,9 +1042,21 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
> 	switch (cp->enable) {
> 	case LE_SCAN_ENABLE:
> 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
> +		if (hdev->le_scan_type == LE_SCAN_ACTIVE)
> +			ADV_CACHE_CLEAR(&hdev->discovery);
> 		break;
> 
> 	case LE_SCAN_DISABLE:
> +		if (!ADV_CACHE_EMPTY(&hdev->discovery)) {
> +			struct discovery_state *d = &hdev->discovery;
> +

A comment why we do this here might be a good idea.

> +			mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
> +						  d->last_adv_addr_type, NULL,
> +						  0, 0, 1, d->last_adv_data,
> +						  d->last_adv_data_len,
> +						  NULL, 0);
> +		}
> +
> 		/* Cancel this timer so that we don't try to disable scanning
> 		 * when it's already disabled.
> 		 */
> @@ -3944,6 +3962,8 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
> static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
> 			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
> {
> +	struct discovery_state *d = &hdev->discovery;
> +
> 	/* Passive scanning shouldn't trigger any device found events */
> 	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
> 		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
> @@ -3951,8 +3971,60 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
> 	    return;
> 	}
> 
> -	mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL, rssi, 0, 1,
> -			  data, len, NULL, 0);
> +	/* If there's nothing cached either cache the data from this
> +	 * event or send an immediate device found event if the data is
> +	 * not cachable.
> +	 */

I would not use the word cache since it is not really a cache. It is just a pending report.

> +	if (ADV_CACHE_EMPTY(d)) {

Do we really need to check if the pending report is empty here. It will not match the bacmp() change anyway.

> +		if (type == LE_ADV_IND || type == LE_ADV_SCAN_IND)
> +			goto cache_data;
> +
> +		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
> +				  rssi, 0, 1, data, len, NULL, 0);
> +		return;
> +	}
> +
> +	/* If the cached data doesn't match this report or this isn't a
> +	 * scan response (e.g. we got a duplicate ADV_IND) then force
> +	 * sending of the cached data.
> +	 */
> +	if (type != LE_ADV_SCAN_RSP || bacmp(bdaddr, &d->last_adv_addr) ||
> +	    bdaddr_type != d->last_adv_addr_type) {
> +		/* Send out whatever is in the cache */
> +		mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
> +				  d->last_adv_addr_type, NULL, 0, 0, 1,
> +				  d->last_adv_data, d->last_adv_data_len,
> +				  NULL, 0);
> +
> +		/* If the new event should be cached store it there */
> +		if (type == LE_ADV_IND || type == LE_ADV_SCAN_IND)
> +			goto cache_data;
> +
> +		/* The event can't be cached so clear the cache and send
> +		 * an immediate event based on this report.
> +		 */
> +		ADV_CACHE_CLEAR(d);
> +		mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
> +				  d->last_adv_addr_type, NULL, rssi, 0, 1,
> +				  data, len, NULL, 0);
> +		return;
> +	}
> +
> +	/* If we get here we've got a cached ADV_IND or ADV_SCAN_IND and
> +	 * the new event is a SCAN_RSP. We can therefore proceed with
> +	 * sending a merged device found event.
> +	 */
> +	mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
> +			  d->last_adv_addr_type, NULL, rssi, 0, 1, data, len,
> +			  d->last_adv_data, d->last_adv_data_len);
> +	ADV_CACHE_CLEAR(d);
> +	return;
> +
> +cache_data:
> +	bacpy(&d->last_adv_addr, bdaddr);
> +	d->last_adv_addr_type = bdaddr_type;
> +	memcpy(d->last_adv_data, data, len);
> +	d->last_adv_data_len = len;
> }

Maybe have this as a store_pending_adv_report() is a nice idea.

> 
> static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
> — 

Regards

Marcel

