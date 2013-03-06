Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH 2/7] Bluetooth: Update hci_le_scan to use HCI request
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362597059-4102-3-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 6 Mar 2013 11:22:59 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8D5CD7D8-BD50-4B5B-BAE0-8E0B9D722826@holtmann.org>
References: <1362597059-4102-1-git-send-email-andre.guedes@openbossa.org> <1362597059-4102-3-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch changes hci_le_scan helper so it uses the HCI request
> framework to enable LE scanning.
> 
> Also, the LE scanning disable timeout was removed from the helper
> and it is now handled in mgmt start_discovery code.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h |  3 +--
> net/bluetooth/hci_core.c         | 45 ++++++++++++++++++++++++++----------
> net/bluetooth/mgmt.c             | 49 ++++++++++++++++++++++++++++++++++++----
> 3 files changed, 79 insertions(+), 18 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 494f8f5..9efb571 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1169,8 +1169,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
> 							__u8 ltk[16]);
> int hci_do_inquiry(struct hci_dev *hdev, u8 length);
> int hci_cancel_inquiry(struct hci_dev *hdev);
> -int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
> -		int timeout);
> +int hci_le_scan(struct hci_request *req, u8 type, u16 interval, u16 window);
> int hci_cancel_le_scan(struct hci_dev *hdev);
> 
> u8 bdaddr_to_le(u8 bdaddr_type);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 7635c2e..160bfe3 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1943,27 +1943,48 @@ static void le_scan_work(struct work_struct *work)
> 		       param->timeout);
> }
> 
> -int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
> -		int timeout)
> +static int set_le_scan_param(struct hci_request *req, u8 type, u16 interval,
> +			     u16 window)
> {
> -	struct le_scan_params *param = &hdev->le_scan_params;
> +	struct hci_cp_le_set_scan_param cp;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.type = type;
> +	cp.interval = cpu_to_le16(interval);
> +	cp.window = cpu_to_le16(window);
> +
> +	return hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), &cp);
> +}
> +
> +static int enable_le_scan(struct hci_request *req)
> +{
> +	struct hci_cp_le_set_scan_enable cp;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.enable = 1;
> +	cp.filter_dup = 1;
> +
> +	return hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> +}

since we have this framework now. I do not want to see another 20 functions that are doing something obvious like this.

Please put this all in one function. And as I mentioned to Johan, use 0x01 for values out of the HCI parameters.

Can we please also check in what cases hci_req_add can actually fail. This seems be a pretty silly think to keep checking on it all the time.

Regards

Marcel

