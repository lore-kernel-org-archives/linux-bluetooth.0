Return-Path: <cyrus@holtmann.org>
Message-ID: <1331312796.14217.14.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix extra conversion to __le32
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 09 Mar 2012 09:06:36 -0800
In-Reply-To: <1331290850-30092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331290850-30092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Value to be converted is already in __le32 format.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 7fcff88..97b5b6c 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3107,7 +3107,7 @@ int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  	bacpy(&ev.addr.bdaddr, bdaddr);
>  	ev.addr.type = link_to_mgmt(link_type, addr_type);
>  	ev.confirm_hint = confirm_hint;
> -	put_unaligned_le32(value, &ev.value);
> +	ev.value = value;

actually we do not need put_unaligned_le32 anyway here since the struct
itself is already __packed. So you might wanna go through the code and
fix these up as well.

Regards

Marcel


