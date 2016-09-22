Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH 2/3] Bluetooth: Fix local name validation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1474552899-3837-2-git-send-email-michal.narajowski@codecoup.pl>
Date: Thu, 22 Sep 2016 17:50:55 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AE915D0F-ED22-4090-BE75-0739114D2C57@holtmann.org>
References: <1474552899-3837-1-git-send-email-michal.narajowski@codecoup.pl>
 <1474552899-3837-2-git-send-email-michal.narajowski@codecoup.pl>
To: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> Short name should be shorter than complete name
> and it should be a prefix of complete name.
> 
> Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
> ---
> net/bluetooth/mgmt.c | 24 ++++++++++++++++++++++++
> 1 file changed, 24 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 7b2bac4..5709377 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3099,6 +3099,24 @@ unlock:
> 	hci_dev_unlock(hdev);
> }
> 
> +static bool name_is_valid(u8 *complete_name, u8 *short_name)
> +{
> +	size_t complete_len = strlen(complete_name);
> +	size_t short_len = strlen(short_name);
> +
> +	if (complete_len <= short_len)
> +		return false;
> +
> +	/* Core Specification Supplement, A, 1.2.1:
> +	 * A shortened name shall only contain contiguous characters from
> +	 * the beginning of the full name.
> +	 */
> +	if (strncmp(short_name, complete_name, short_len) != 0)
> +		return false;
> +
> +	return true;
> +}
> +

actually I do not want to enforce that from the kernel side. Lets keep the mgmt interface flexible and let bluetoothd enforce this if needed.

Regards

Marcel

