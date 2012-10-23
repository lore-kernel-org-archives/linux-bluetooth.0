Return-Path: <cyrus@holtmann.org>
Message-ID: <1351028238.1785.51.camel@aeonflux>
Subject: Re: [PATCH 3/7] Bluetooth: Disallow LE scanning and connecting in
 peripheral mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Oct 2012 14:37:18 -0700
In-Reply-To: <1351011241-32515-4-git-send-email-johan.hedberg@gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	 <1351011241-32515-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When an adapter is in the LE peripheral mode scanning for other devices
> or initiating connections to them is not allowed. This patch makes sure
> that such attempts will result in appropriate error returns.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_conn.c |    3 +++
>  net/bluetooth/hci_core.c |    3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index fe64621..a75b30e 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -502,6 +502,9 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>  {
>  	struct hci_conn *le;
>  
> +	if (test_bit(HCI_LE_PERIPHERAL, &hdev->flags))
> +		return ERR_PTR(-ENOTSUPP);
> +
>  	le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
>  	if (!le) {
>  		le = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 487308b..b2adef4 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1575,6 +1575,9 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
>  
>  	BT_DBG("%s", hdev->name);
>  
> +	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
> +		return -ENOTSUPP;
> +
>  	if (work_busy(&hdev->le_scan))
>  		return -EINPROGRESS;
>  

I am fine with this patch, but maybe it would be better to introduce
this flag first. Specific the semantics in the commit message and the
mgmt documentation, then add this patch and only after that actually
start implementing support for it.

Regards

Marcel


