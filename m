Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv2 9/9] Bluetooth: Guarantee BR-EDR device will be
 registered as hci0
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Date: Wed, 19 Oct 2011 12:17:08 -0700
In-Reply-To: <1319046247-3391-10-git-send-email-mathewm@codeaurora.org>
References: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
	 <1319046247-3391-10-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319051830.15441.178.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> It's convenient to use the HCI device index the AMP controller id, but
> the spec requires that an AMP controller never has id 0.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/hci_core.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index fdcbf8f..78e6b05 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1426,7 +1426,7 @@ int hci_add_adv_entry(struct hci_dev *hdev,
>  int hci_register_dev(struct hci_dev *hdev)
>  {
>  	struct list_head *head = &hci_dev_list, *p;
> -	int i, id = 0, error;
> +	int i, id, error;
>  	BT_DBG("%p name %s bus %d owner %p", hdev, hdev->name,
>  						hdev->bus, hdev->owner);
> @@ -1434,6 +1434,8 @@ int hci_register_dev(struct hci_dev *hdev)
>  	if (!hdev->open || !hdev->close || !hdev->destruct)
>  		return -EINVAL;
>  
> +	id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
> +

this is a pretty nasty hack. Especially since we can have as many BR/EDR
controllers as we want and then our list of AMPs can have empty spots in
their list. Also it can happen that the first AMP controller has id 2 or
higher.

In general I am fine with this, but please add an extra comment about
the AMP not allowed to be id 0 above this change (similar to what your
commit message says).

Regards

Marcel


