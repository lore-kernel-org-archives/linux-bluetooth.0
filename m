Return-Path: <cyrus@holtmann.org>
Message-ID: <1359256447.16748.22.camel@aeonflux>
Subject: Re: [PATCH 3/9 v4] Bluetooth: Keep track of UUID type upon addition
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 27 Jan 2013 04:14:07 +0100
In-Reply-To: <1359239495-3444-4-git-send-email-johan.hedberg@gmail.com>
References: <1359239495-3444-1-git-send-email-johan.hedberg@gmail.com>
	 <1359239495-3444-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The primary purpose of the UUIDs is to enable generation of EIR and AD
> data. In these data formats the UUIDs are split into separate fields
> based on whether they're 16, 32 or 128 bit UUIDs. To make the generation
> of these data fields simpler this patch adds a type member to the
> bt_uuid struct and assigns a value to it as soon as the UUID is added to
> the kernel. This way the type doesn't need to be calculated each time
> the UUID list is later iterated.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/mgmt.c             |   48 ++++++++++++++++++--------------------
>  2 files changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index bcf8ffe..90cf75a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -86,6 +86,7 @@ struct bdaddr_list {
>  struct bt_uuid {
>  	struct list_head list;
>  	u8 uuid[16];
> +	u8 size;
>  	u8 svc_hint;
>  };

seems you just went for the size approach. Fine with me as well.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


