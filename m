Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Sep 2013 22:22:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Provide high speed configuration option
Message-ID: <20130929192209.GA1115@x220.p-661hnu-f1>
References: <1380452005-7211-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380452005-7211-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 29, 2013, Marcel Holtmann wrote:
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -32,8 +32,6 @@
>  #include <net/bluetooth/mgmt.h>
>  #include <net/bluetooth/smp.h>
>  
> -bool enable_hs;
> -
>  #define MGMT_VERSION	1
>  #define MGMT_REVISION	3
>  
> @@ -382,8 +380,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
>  		settings |= MGMT_SETTING_LINK_SECURITY;
>  	}
>  
> -	if (enable_hs)
> -		settings |= MGMT_SETTING_HS;
> +	settings |= MGMT_SETTING_HS;

I know it's a bug in the original code, but we may as well fix it in the
same go: I suppose this setting should be behind the lmp_bredr_capable
check as LE-only controllers would not support it. That said, we might
also want to be looking at the controller version.

>  
>  	if (lmp_le_capable(hdev)) {
>  		settings |= MGMT_SETTING_LE;
> @@ -1344,10 +1341,6 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
>  
>  	BT_DBG("request for %s", hdev->name);
>  
> -	if (!enable_hs)
> -		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
> -				  MGMT_STATUS_NOT_SUPPORTED);
> -
>  	if (cp->val != 0x00 && cp->val != 0x01)
>  		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
>  				  MGMT_STATUS_INVALID_PARAMS);

It seems like the command handler is also missing a check for
lmp_bredr_capable and a NOT_SUPPORTED return in that case. This should
probably be part of a separate patch though.

Some mgmt-tester cases for all this would be nice too :)

Johan
