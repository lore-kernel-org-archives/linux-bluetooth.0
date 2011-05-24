Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 May 2011 14:15:34 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 10/11] Bluetooth: Check advertising cache in
 hci_connect()
Message-ID: <20110524111534.GH2480@null>
References: <1305936645-15007-1-git-send-email-andre.guedes@openbossa.org>
 <1305936645-15007-10-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305936645-15007-10-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, May 20, 2011 at 09:10:44PM -0300, ext Andre Guedes wrote:
> When connecting to a LE device, we need to check the advertising
> cache in order to know the address type of that device.
> 
> If its advertising entry is not found, the connection is not
> established and hci_connect() returns error.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>

Acked-by: Ville Tervo <ville.tervo@nokia.com>

> ---
>  net/bluetooth/hci_conn.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index b21cbb3..468d2aa 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -451,10 +451,17 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>  	BT_DBG("%s dst %s", hdev->name, batostr(dst));
>  
>  	if (type == LE_LINK) {
> +		struct adv_entry *entry;
> +
>  		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
>  		if (le)
>  			return ERR_PTR(-EBUSY);
> -		le = hci_conn_add(hdev, LE_LINK, dst, 0);
> +
> +		entry = hci_find_adv_entry(hdev, dst);
> +		if (!entry)
> +			return ERR_PTR(-EHOSTUNREACH);
> +
> +		le = hci_conn_add(hdev, LE_LINK, dst, entry->bdaddr_type);
>  		if (!le)
>  			return ERR_PTR(-ENOMEM);
>  
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
