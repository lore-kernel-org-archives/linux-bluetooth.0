Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 1/2] android/bluetooth: Add threashold to RSSI change
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390952835-23251-1-git-send-email-szymon.janc@tieto.com>
Date: Tue, 28 Jan 2014 16:09:53 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <46CB790A-A0DF-47A4-ACD1-DD7C0F0A9D2D@holtmann.org>
References: <1390952835-23251-1-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> There is no need to report very small RSSI changes.
> ---
> android/bluetooth.c | 15 ++++++++++++++-
> 1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index b105ac8..b95023c 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1045,6 +1045,19 @@ static uint8_t bdaddr_type2android(uint8_t type)
> 	return HAL_TYPE_LE;
> }
> 
> +static bool rssi_threashold(int old, int new)

lets write it threshold ;)

And I think a better name would be is_above_threshold or rssi_above_threshold.

> +{
> +	int delta;
> +
> +	if (old > new)
> +		delta = old - new;
> +	else
> +		delta = new - old;
> +
> +	/* only 8 dBm or more */
> +	return delta >= 8;

	int delta = old > new ? old - new : new - old;

> +}
> +
> static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
> 					int8_t rssi, bool confirm,
> 					const uint8_t *data, uint8_t data_len)
> @@ -1113,7 +1126,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
> 		(*num_prop)++;
> 	}
> 
> -	if (rssi) {
> +	if (rssi && rssi_threashold(dev->rssi, rssi)) {
> 		dev->rssi = rssi;
> 
> 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_RSSI,

One other idea might to just use rate limit on the timestamp. Only report once every x seconds.

The inquiry TX on the remote side might not be always the same for every device. If we want to be precise we have to make sure to get the TX power level from EIR and calculate the path loss.

Regards

Marcel

