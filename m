Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Mar 2014 11:12:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/5] android/bluetooth: Filter out not discoverable LE
 devices
Message-ID: <20140324091241.GB30302@t440s.lan>
References: <1395610854-30579-1-git-send-email-szymon.janc@tieto.com>
 <1395610854-30579-3-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395610854-30579-3-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sun, Mar 23, 2014, Szymon Janc wrote:
> Filter out the LE devices that do not have Discoverable flag or Limited
> Discoverable flag set.
> ---
>  android/bluetooth.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index d2795e3..3c859e8 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1258,6 +1258,11 @@ static void update_device(struct device *dev, int8_t rssi,
>  					HAL_EV_REMOTE_DEVICE_PROPS, size, buf);
>  }
>  
> +static bool is_le_dev_discoverable(unsigned int flags)
> +{
> +	return flags & (EIR_FLAG_LIM_DISC | EIR_FLAG_GEN_DISC);
> +}
> +
>  static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
>  					int8_t rssi, bool confirm,
>  					const uint8_t *data, uint8_t data_len)
> @@ -1271,6 +1276,19 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
>  
>  	dev = find_device(bdaddr);
>  
> +	if (bdaddr_type != BDADDR_BREDR) {
> +		/* Notify Gatt if its registered for LE events */
> +		if (gatt_device_found_cb)
> +			gatt_device_found_cb(bdaddr, bdaddr_type, rssi,
> +							sizeof(eir), &eir);
> +
> +		if (adapter.cur_discovery_type != SCAN_TYPE_NONE &&
> +					!is_le_dev_discoverable(eir.flags)) {
> +			eir_data_free(&eir);
> +			return;
> +		}
> +	}

Do note the recent changes I had to do for the normal bluetoothd since
it's not possible to distinguish ADV_IND/ADV_SCAN_IND from SCAN_RSP
events. The flags field is not permitted to be in the SCAN_RSP so you'd
not be able to take advantage of any data in such events if you discard
the data when the flags are not around.

Also be aware of the recent kernel patch set I sent which merges these
events into a single device found event and again makes it possible to
do strict checking of the flags. That said, this all depends on what
kind of kernel version we want to depend on. If we're going to rely also
on the kernel-side passive for LE (which will probably land in 3.16)
then it's probably fine to overlook this issue for now.

Johan
