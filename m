Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v3] Bluetooth: btusb: hci_event: handle msbc audio over
 USB Endpoints
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1534854465-3984-1-git-send-email-sathish.narasimman@intel.com>
Date: Tue, 21 Aug 2018 16:28:36 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sathish Narasimman <sathish.narasimman@intel.com>
Message-Id: <869DA895-1731-4A2C-B9F0-009C68D035E2@holtmann.org>
References: <1534854465-3984-1-git-send-email-sathish.narasimman@intel.com>
To: Sathish Narasimman <nsathish41@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sathish,

> For msbc encoded audio stream over usb transport, btusb driver
> to be set to alternate settings 6 as per BT core spec 5.0. This
> done from  hci_sync_conn_complete_evt. The type of air mode is known
> during this event. For this reason the btusb is to be notifed
> about the TRANSPARENT air mode and the ALT setting 6 is selected.
> The changes are made considering some discussion over the similar
> patch submitted earlier from Kuba Pawlak(link below)
> https://www.spinics.net/lists/linux-bluetooth/msg64577.html
> 
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
> drivers/bluetooth/btusb.c   | 142 ++++++++++++++++++++++++++++++--------------
> include/net/bluetooth/hci.h |   1 +
> net/bluetooth/hci_event.c   |   5 ++
> 3 files changed, 105 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index cd2e5cf..8e1d0b9 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -69,6 +69,9 @@ static struct usb_driver btusb_driver;
> #define BTUSB_BCM2045		0x40000
> #define BTUSB_IFNUM_2		0x80000
> #define BTUSB_CW6622		0x100000
> +#define BTUSB_ALT6_FLOW_CNTRL	6
> +
> +static int set_hci_packet_interval_flow = BTUSB_ALT6_FLOW_CNTRL;
> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> @@ -906,6 +909,37 @@ static void btusb_isoc_complete(struct urb *urb)
> 	}
> }
> 
> +static inline void __fill_isoc_descriptor_msbc(struct urb *urb, int len, int mtu)
> +{
> +	int i, offset = 0;
> +
> +	/* For msbc ALT 6 setting the host will send the packet at continuous flow
> +	 * As per core spec 5, vol 4, part B, table 2.1. For ALT setting 6 the
> +	 * HCI PACKET INTERVAL should be 7.5ms for every usb packets.
> +	 * To maintain the rate we send 63bytes of usb packets alternatively for
> +	 * 7ms and 8ms to maintain the rate as 7.5ms.
> +	 */
> +	if (set_hci_packet_interval_flow == 6)
> +		set_hci_packet_interval_flow = 7;
> +	else if (set_hci_packet_interval_flow == 7)
> +		set_hci_packet_interval_flow = 6;
> +
> +	BT_DBG("len %d mtu %d", len, mtu);
> +
> +	for (i = 0; i < set_hci_packet_interval_flow; i++) {
> +		urb->iso_frame_desc[i].offset = offset;
> +		urb->iso_frame_desc[i].length = offset;
> +	}
> +
> +	if (len && i < BTUSB_MAX_ISOC_FRAMES) {
> +		urb->iso_frame_desc[i].offset = offset;
> +		urb->iso_frame_desc[i].length = len;
> +		i++;
> +	}
> +
> +	urb->number_of_packets = i;
> +}
> +
> static inline void __fill_isoc_descriptor(struct urb *urb, int len, int mtu)
> {
> 	int i, offset = 0;
> @@ -1300,7 +1334,11 @@ static struct urb *alloc_isoc_urb(struct hci_dev *hdev, struct sk_buff *skb)
> 
> 	urb->transfer_flags  = URB_ISO_ASAP;
> 
> -	__fill_isoc_descriptor(urb, skb->len,
> +	if (data->isoc_altsetting == 6)
> +		__fill_isoc_descriptor_msbc(urb, skb->len,
> +			       le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
> +	else
> +		__fill_isoc_descriptor(urb, skb->len,
> 			       le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
> 
> 	skb->dev = (void *)hdev;
> @@ -1390,18 +1428,6 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 	return -EILSEQ;
> }
> 
> -static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
> -{
> -	struct btusb_data *data = hci_get_drvdata(hdev);
> -
> -	BT_DBG("%s evt %d", hdev->name, evt);
> -
> -	if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
> -		data->sco_num = hci_conn_num(hdev, SCO_LINK);
> -		schedule_work(&data->work);
> -	}
> -}
> -
> static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
> {
> 	struct btusb_data *data = hci_get_drvdata(hdev);
> @@ -1445,6 +1471,65 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
> 	return 0;
> }
> 
> +static int bt_switch_alt_setting(struct hci_dev *hdev, int new_alts)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	int err;
> +
> +	if (data->isoc_altsetting != new_alts) {
> +		unsigned long flags;
> +
> +		clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> +		usb_kill_anchored_urbs(&data->isoc_anchor);
> +
> +		/* When isochronous alternate setting needs to be
> +		 * changed, because SCO connection has been added
> +		 * or removed, a packet fragment may be left in the
> +		 * reassembling state. This could lead to wrongly
> +		 * assembled fragments.
> +		 *
> +		 * Clear outstanding fragment when selecting a new
> +		 * alternate setting.
> +		 */
> +		spin_lock_irqsave(&data->rxlock, flags);
> +		kfree_skb(data->sco_skb);
> +		data->sco_skb = NULL;
> +		spin_unlock_irqrestore(&data->rxlock, flags);
> +
> +		err = __set_isoc_interface(hdev, new_alts);
> +		if (err < 0)
> +			return err;
> +	}
> +	if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
> +		if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
> +			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> +		else
> +			btusb_submit_isoc_urb(hdev, GFP_KERNEL);
> +	}
> +
> +	return 0;
> +}
> +
> +static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +
> +	BT_DBG("%s evt %d", hdev->name, evt);
> +
> +	if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
> +		data->sco_num = hci_conn_num(hdev, SCO_LINK);
> +		schedule_work(&data->work);
> +	}
> +
> +	if (evt == HCI_NOTIFY_AIR_MODE_TRANSP) {
> +		/* Alt setting 6 is for msbc encoded audio channel */
> +		if( bt_switch_alt_setting(hdev, 6) < 0) {
> +			/* Fall back to ALT 2 if not supported */
> +			bt_switch_alt_setting(hdev, 2);
> +		}
> +	}

as pointed out in the other reply, please figure out what alternate settings are available during the btusb_probe() and not result to try-and-error here.

> +}
> +
> static void btusb_work(struct work_struct *work)
> {
> 	struct btusb_data *data = container_of(work, struct btusb_data, work);
> @@ -1472,36 +1557,7 @@ static void btusb_work(struct work_struct *work)
> 			new_alts = data->sco_num;
> 		}
> 
> -		if (data->isoc_altsetting != new_alts) {
> -			unsigned long flags;
> -
> -			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> -			usb_kill_anchored_urbs(&data->isoc_anchor);
> -
> -			/* When isochronous alternate setting needs to be
> -			 * changed, because SCO connection has been added
> -			 * or removed, a packet fragment may be left in the
> -			 * reassembling state. This could lead to wrongly
> -			 * assembled fragments.
> -			 *
> -			 * Clear outstanding fragment when selecting a new
> -			 * alternate setting.
> -			 */
> -			spin_lock_irqsave(&data->rxlock, flags);
> -			kfree_skb(data->sco_skb);
> -			data->sco_skb = NULL;
> -			spin_unlock_irqrestore(&data->rxlock, flags);
> -
> -			if (__set_isoc_interface(hdev, new_alts) < 0)
> -				return;
> -		}
> -
> -		if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
> -			if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
> -				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> -			else
> -				btusb_submit_isoc_urb(hdev, GFP_KERNEL);
> -		}
> +		bt_switch_alt_setting(hdev, new_alts);

Since we are touching this anyway and the core has moved to workqueue processing (compared to previously tasklets) we should no longer need to schedule yet another workqueue for this. So can we try to first remove the workqueue and change the alternate setting directly in the btusb_notify callback.

> 	} else {
> 		clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> 		usb_kill_anchored_urbs(&data->isoc_anchor);
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index cdd9f1f..3498c6b 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -52,6 +52,7 @@
> #define HCI_NOTIFY_CONN_ADD		1
> #define HCI_NOTIFY_CONN_DEL		2
> #define HCI_NOTIFY_VOICE_SETTING	3
> +#define HCI_NOTIFY_AIR_MODE_TRANSP	4
> 
> /* HCI bus types */
> #define HCI_VIRTUAL	0
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index f12555f..8ef5220 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4100,6 +4100,11 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
> 		break;
> 	}
> 
> +	if (ev->air_mode == SCO_AIRMODE_TRANSP) {
> +		if (hdev->notify)
> +			hdev->notify(hdev, HCI_NOTIFY_AIR_MODE_TRANSP);
> +	}
> +

This is not a good way of doing this. We need to count the number of SCO/eSCO connections and consider the air mode. So I assume the air mode is stored somewhere in hci_conn structure. So that btusb_notify callback can make a useful decision. Or add something like hci_conn_transp_esco to indicate if we have a transparent transport or not.

And I think this really need to be handled via the existing CONN_ADD and CONN_DEL notifications.

> 	hci_connect_cfm(conn, ev->status);
> 	if (ev->status)
> 		hci_conn_del(conn);

Regards

Marcel
