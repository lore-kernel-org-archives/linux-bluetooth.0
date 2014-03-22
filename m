Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 3/3] Bluetooth: Merge adv_ind/adv_direct_ind ans scan_rsp together
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395506915-23058-3-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 22 Mar 2014 11:54:17 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AFA78EB0-FC63-422A-9A62-69B2473DF163@holtmann.org>
References: <1395506915-23058-1-git-send-email-johan.hedberg@gmail.com> <1395506915-23058-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To avoid too many events being sent to user space and to help parsing of
> all available remote device data it makes sense for us to wait for the
> scan response and send a single merged Device Found event to user space.
> 
> This patch adds a new hdev->pending_adv cache which gets allocated
> whenever active scanning gets started and freed when scanning stops. The
> cache is able to hold a single advertising report and is operated upon
> each time we get an advertising report event.
> 
> Normally we simply merge scan responses into data in the cache that was
> gotten from a previous adv_ind or adv_direct_ind report. Exceptions are
> if we don't get a matching scan response (or no scan response at all) or
> if there is not enough space in the cache, in which case we force
> sending of any data that there is before continuing further.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 10 ++++++
> net/bluetooth/hci_core.c         |  3 ++
> net/bluetooth/hci_event.c        | 74 ++++++++++++++++++++++++++++++++++++++--
> 3 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 5f8bc05694ac..323f1e64e299 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -148,9 +148,18 @@ struct amp_assoc {
> 	__u8	data[HCI_MAX_AMP_ASSOC_SIZE];
> };
> 
> +struct hci_adv_ind {
> +	bdaddr_t	bdaddr;
> +	u8		bdaddr_type;
> +	s8		rssi;
> +	u8		len;
> +	u8		data[256];

I think this should be HCI_MAX_AD_LENGTH instead of 256.

> +};
> +
> #define HCI_MAX_PAGES	3
> 
> #define NUM_REASSEMBLY 4
> +
> struct hci_dev {
> 	struct list_head list;
> 	struct mutex	lock;
> @@ -282,6 +291,7 @@ struct hci_dev {
> 
> 	struct crypto_blkcipher	*tfm_aes;
> 
> +	struct hci_adv_ind	*pending_adv;
> 	struct discovery_state	discovery;

so my idea would have been to include this into the discovery_state structure.

@@ -68,6 +68,10 @@ struct discovery_state {
        struct list_head        unknown;        /* Name state not known */
        struct list_head        resolve;        /* Name needs to be resolved */
        __u32                   timestamp;
+       bdaddr_t                last_adv_addr;
+       u8                      last_adv_addr_type;
+       u8                      last_adv_data[HCI_MAX_AD_LENGTH];
+       u8                      last_adv_data_len;
 };

That is what I was thinking about. I left the RSSI value out since in case there is no scan response we might better send it without RSSI value since the report would be delayed. However we can also store it and use it.

> 	struct hci_conn_hash	conn_hash;
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 1c6ffaa8902f..a8e225899e6a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2437,6 +2437,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> 	kfree_skb(hdev->recv_evt);
> 	hdev->recv_evt = NULL;
> 
> +	kfree(hdev->pending_adv);
> +	hdev->pending_adv = NULL;
> +
> 	/* After this point our queues are empty
> 	 * and no tasks are scheduled. */
> 	hdev->close(hdev);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 403c1d96331a..f35a398e80a9 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1018,6 +1018,12 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
> 	hci_dev_unlock(hdev);
> }
> 
> +#define ADV_CACHE_EMPTY(p)	(!bacmp(&(p)->bdaddr, BDADDR_ANY))
> +#define ADV_CACHE_CLEAR(p)	do { \
> +					bacpy(&(p)->bdaddr, BDADDR_ANY); \
> +					(p)->len = 0; \
> +				} while (0)
> +
> static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
> 				      struct sk_buff *skb)
> {
> @@ -1036,9 +1042,31 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
> 	switch (cp->enable) {
> 	case LE_SCAN_ENABLE:
> 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
> +
> +		if (hdev->le_scan_type != LE_SCAN_ACTIVE)
> +			break;
> +
> +		/* Allocate buffer for merging ADV_IND and SCAN_RSP */
> +		if (!hdev->pending_adv)
> +			hdev->pending_adv = kzalloc(sizeof(*hdev->pending_adv),
> +						    GFP_KERNEL);
> +

So instead of allocating it, sticking it into discovery_state seems better and in the end a lot simpler.

> 		break;
> 
> 	case LE_SCAN_DISABLE:
> +		if (hdev->pending_adv) {
> +			struct hci_adv_ind *p = hdev->pending_adv;
> +
> +			if (!ADV_CACHE_EMPTY(p))
> +				mgmt_device_found(hdev, &p->bdaddr, LE_LINK,
> +						  p->bdaddr_type, NULL,
> +						  p->rssi, 0, 1, p->data,
> +						  p->len);
> +
> +			hdev->pending_adv = NULL;
> +			kfree(p);
> +		}
> +

I wonder if this should not all be centralized in the discovery set_state function.

> 		/* Cancel this timer so that we don't try to disable scanning
> 		 * when it's already disabled.
> 		 */
> @@ -3944,6 +3972,8 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
> static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
> 			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
> {
> +	struct hci_adv_ind *p = hdev->pending_adv;
> +
> 	/* Passive scanning shouldn't trigger any device found events */
> 	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
> 		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
> @@ -3951,8 +3981,48 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
> 	    return;
> 	}
> 
> -	mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL, rssi, 0, 1,
> -			  data, len);
> +	/* If we don't have a cache, or we don't have data in the cache
> +	 * and we got a scan response just send the mgmt event without
> +	 * doing anything else.
> +	 */
> +	if (!p || (ADV_CACHE_EMPTY(p) && type == LE_ADV_SCAN_RSP)) {
> +		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
> +				  rssi, 0, 1, data, len);
> +		return;
> +	}
> +
> +	/* If there's nothing cached proceed to updating the cache */
> +	if (ADV_CACHE_EMPTY(p))
> +		goto update_cache;
> +
> +	/* If the cached data doesn't match this report or there is not
> +	 * enough space in the cache (unlikely but we have to check for
> +	 * it to avoid buffer overflow) then force sending of the cached
> +	 * data.
> +	 */
> +	if (bacmp(bdaddr, &p->bdaddr) || bdaddr_type != p->bdaddr_type ||
> +	    len > (sizeof(p->data) - p->len)) {
> +		mgmt_device_found(hdev, &p->bdaddr, LE_LINK, p->bdaddr_type,
> +				  NULL, p->rssi, 0, 1, p->data, p->len);
> +		ADV_CACHE_CLEAR(p);
> +	}
> +
> +update_cache:
> +	/* Update the cache with data from this report */
> +	bacpy(&p->bdaddr, bdaddr);
> +	p->bdaddr_type = bdaddr_type;
> +	p->rssi = rssi;
> +	memcpy(p->data + p->len, data, len);
> +	p->len += len;
> +
> +	/* If this report will not trigger a scan request just send the
> +	 * device found event without doing anything else.
> +	 */
> +	if (type != LE_ADV_IND && type != LE_ADV_DIRECT_IND) {

		s/LE_ADV_DIRECT_IND/LE_ADV_SCAN_IND/

> +		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
> +				  rssi, 0, 1, p->data, p->len);
> +		ADV_CACHE_CLEAR(p);
> +	}
> }

Regards

Marcel

