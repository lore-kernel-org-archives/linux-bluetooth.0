Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Aug 2015 12:47:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: marcel@holtmann.org, gustavo@padovan.org, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluetooth:Fix error checking in the function
 hci_disconn_complete_evt
Message-ID: <20150824094749.GA6958@t440s.lan>
References: <1439993129-27049-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439993129-27049-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicholas,

On Wed, Aug 19, 2015, Nicholas Krause wrote:
> This fixes error checking in the function hci_disconn_complete_evt
> to properly check if it's call to the function hci_remove_link_key
> returns NULL to signal it has not correctly removed the link key
> on the passed hci_dev structure pointer and if so jump to the goto
> label unlock to unlock the caller's passed hci_dev structure pointer
> as this function cannot continue its intended work after this failed
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  net/bluetooth/hci_event.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 32363c2..5174649 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2448,8 +2448,10 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  				reason, mgmt_connected);
>  
>  	if (conn->type == ACL_LINK) {
> -		if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
> -			hci_remove_link_key(hdev, &conn->dst);
> +		if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags)) {
> +			if (!hci_remove_link_key(hdev, &conn->dst))
> +				goto unlock;
> +		}
>  
>  		hci_update_page_scan(hdev);
>  	}

This doesn't look correct to me. The only scenario where
hci_remove_link_key() may fail is if there was no existing key (it'll
return -ENOENT then). This is a perfectly normal thing that will occur
for a disconnection of a non-paired device, so any other cleanups like
hci_update_page_scan() should still go ahead.

Johan
