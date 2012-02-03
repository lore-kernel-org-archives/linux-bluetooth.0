Return-Path: <cyrus@holtmann.org>
Message-ID: <1328311628.2062.49.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Move debug macros
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 03 Feb 2012 15:27:08 -0800
In-Reply-To: <1321992859-12473-2-git-send-email-andre.guedes@openbossa.org>
References: <1321992859-12473-1-git-send-email-andre.guedes@openbossa.org>
	 <1321992859-12473-2-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Move debug macros so they provide us more meaningful information
> during debugging analysis.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_core.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index ef0423e..8487483 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2594,11 +2594,11 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length)
>  	u8 lap[3] = { 0x33, 0x8b, 0x9e };
>  	struct hci_cp_inquiry cp;
>  
> -	BT_DBG("%s", hdev->name);
> -
>  	if (test_bit(HCI_INQUIRY, &hdev->flags))
>  		return -EINPROGRESS;
>  
> +	BT_DBG("%s", hdev->name);
> +

I actually do not like this change much. Can we just add the flags into
the debug print instead.

Regards

Marcel


