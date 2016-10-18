Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH 1/2] Bluetooth: Shorten complete name if no short name in
 set local name
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1476796224-14476-1-git-send-email-michal.narajowski@codecoup.pl>
Date: Tue, 18 Oct 2016 15:47:14 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AE792548-F5D9-4A23-BE8B-F3D08B1F3883@holtmann.org>
References: <1476796224-14476-1-git-send-email-michal.narajowski@codecoup.pl>
To: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> Generate shortened local name if no short name specified
> to simplify appending local name to scan rsp data.
> 
> Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
> ---
> net/bluetooth/mgmt.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 7360380..cc6e571 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3103,7 +3103,16 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
> 		goto failed;
> 	}
> 
> -	memcpy(hdev->short_name, cp->short_name, sizeof(hdev->short_name));
> +	/* if no short name set and complete name is longer than max
> +	 * short name length then shorten complete name
> +	 */
> +	if (!strlen(cp->short_name) &&
> +	    (strlen(cp->name) > HCI_MAX_SHORT_NAME_LENGTH)) {
> +		memcpy(hdev->short_name, cp->name, sizeof(hdev->short_name));
> +	} else {
> +		memcpy(hdev->short_name, cp->short_name,
> +		       sizeof(hdev->short_name));
> +	}

I would prefer if we do not store this value. Remember that Read Extended Controller Info returns hdev->short_name and that that is suppose to be the short name from Set Local Name. These two need to be consistent. We can not just return a generated value in Read Extended Controller Info.

Regards

Marcel

