Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Sep 2011 11:18:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Fix not sending a Link Key Negative Reply
Message-ID: <20110905081842.GA3517@dell.ger.corp.intel.com>
References: <1314985882-24059-1-git-send-email-vinicius.gomes@openbossa.org>
 <1314985882-24059-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314985882-24059-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Sep 02, 2011, Vinicius Costa Gomes wrote:
> In the case that there are no keys loaded in the adapter, we should
> also respond the Link Key Request event with the Link Key Negative
> Reply command.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 8404cd9..79f89d2 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2208,11 +2208,13 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
>  
>  	BT_DBG("%s", hdev->name);
>  
> -	if (!test_bit(HCI_LINK_KEYS, &hdev->flags))
> -		return;
> -
>  	hci_dev_lock(hdev);
>  
> +	if (!test_bit(HCI_LINK_KEYS, &hdev->flags)) {
> +		BT_DBG("%s has no keys", hdev->name);
> +		goto not_found;
> +	}
> +
>  	key = hci_find_link_key(hdev, &ev->bdaddr);
>  	if (!key) {
>  		BT_DBG("%s link key not found for %s", hdev->name,
> -- 
> 1.7.6.1

Nack. The purpose of this check in the beginning of the function is to
prevent breakage on systems that do not use the management interface.
With your patch you'd break all systems that use hciops. The
HCI_LINK_KEYS bit will only be set when user space sends the
MGMT_OP_LOAD_KEYS command.

Johan
