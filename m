Return-Path: <cyrus@holtmann.org>
Message-ID: <1359220151.16748.16.camel@aeonflux>
Subject: Re: [PATCH 4/9 v3] Bluetooth: Simplify UUID removal code
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 26 Jan 2013 18:09:11 +0100
In-Reply-To: <1359194924-3151-5-git-send-email-johan.hedberg@gmail.com>
References: <1359194924-3151-1-git-send-email-johan.hedberg@gmail.com>
	 <1359194924-3151-5-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The UUID removal code can be simplified by using
> list_for_each_entry_safe instead of list_for_each_safe.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index d9f6b2c..ea8d74a 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1372,7 +1372,7 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
>  {
>  	struct mgmt_cp_remove_uuid *cp = data;
>  	struct pending_cmd *cmd;
> -	struct list_head *p, *n;
> +	struct bt_uuid *match, *tmp;
>  	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

while seeing this patch, this could have been static const actually. Not
that is affects this patch, just saying.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


