Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v2 1/3] android/bluetooth: Add threshold to RSSI change
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1391531663-13143-1-git-send-email-szymon.janc@tieto.com>
Date: Tue, 4 Feb 2014 08:43:41 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <6CC640A0-21E5-47D8-BD5C-F266DC8223CC@holtmann.org>
References: <1391531663-13143-1-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> There is no need to report very small RSSI changes.
> ---
> v2: Fix name and use abs()
> 
> android/bluetooth.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index d74d792..5aed4af 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1045,6 +1045,12 @@ static uint8_t bdaddr_type2android(uint8_t type)
> 	return HAL_TYPE_LE;
> }
> 
> +static bool rssi_above_threshold(int old, int new)
> +{
> +	/* only 8 dBm or more */
> +	return abs(old - new) >= 8;
> +}
> +
> static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
> 					int8_t rssi, bool confirm,
> 					const uint8_t *data, uint8_t data_len)
> @@ -1113,7 +1119,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
> 		(*num_prop)++;
> 	}
> 
> -	if (rssi) {
> +	if (rssi && rssi_above_threshold(dev->rssi, rssi)) {

this is a good first step, but I think we should additionally work on handling pathloss via the TX power EIR element in combination with RSSI. Since that really gives a good idea of the distance of a device and if it has moved or not.

The 3D glasses for example rely on this for proximity association.

Regards

Marcel

