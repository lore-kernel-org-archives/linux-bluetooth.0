Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/2] Bluetooth: Fix connecting devices during LE device discovery
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404723036-28574-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 7 Jul 2014 11:02:10 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <355F2842-5B43-49EB-B2D8-01C789C12697@holtmann.org>
References: <1404723036-28574-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we have devices set as to be connected we should connect to them even
> during normal discovery if we get a connectable advertising event. If we
> also have HCI_CONNECTABLE set we should connect ADV_DIRECT_IND events
> even to devices that we don't have in our pend_le_conns list. This patch
> implements such behavior by passing the advertising report type to
> check_pending_le_conn() and calls that function regardless of what type
> of scanning we are doing.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 51 ++++++++++++++++++++++++++++-------------------
> 1 file changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 57837cad9919..1c4f667cc8a1 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4229,13 +4229,26 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
> 
> /* This function requires the caller holds hdev->lock */
> static bool check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
> -				  u8 addr_type)
> +				  u8 addr_type, u8 adv_type)
> {
> 	struct hci_conn *conn;
> 
> +	/* If the event is not connectable don't proceed further */
> +	if (adv_type != LE_ADV_IND && adv_type != LE_ADV_DIRECT_IND)
> +		return false;
> +
> +	/* If we're connectable, always connect any ADV_DIRECT_IND event */
> +	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
> +	    adv_type == LE_ADV_DIRECT_IND)
> +		goto connect;
> +
> +	/* If we're not connectable only connect devices that we have in
> +	 * our pend_le_conns list.
> +	 */
> 	if (!hci_pend_le_action_lookup(&hdev->pend_le_conns, addr, addr_type))
> 		return false;
> 
> +connect:
> 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
> 			      HCI_AT_NO_BONDING, HCI_LE_AUTOCONN_TIMEOUT);
> 	if (!IS_ERR(conn))
> @@ -4260,34 +4273,32 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
> 			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
> {
> 	struct discovery_state *d = &hdev->discovery;
> -	bool match;
> +	bool match, pend_conn;
> +	struct smp_irk *irk;
> 	u32 flags;
> 
> +	/* Check if we need to convert to identity address */
> +	irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
> +	if (irk) {
> +		bdaddr = &irk->bdaddr;
> +		bdaddr_type = irk->addr_type;
> +	}
> +
> +	/* Ignore if the device is blocked */
> +	if (hci_blacklist_lookup(hdev, bdaddr, bdaddr_type))
> +		return;

I am not sure that this one is correct. So in case of Start Discovery, we will now no longer report blocked devices. I do not think that is what we want.

The blacklist is for connections that come without user interaction. An active discovery should report this and also a Pair Device or L2CAP connect() triggered by the user should be possible.

Especially since when looking at BR/EDR, we do report devices from inquiry and allow outgoing connections.

Regards

Marcel

