Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Nov 2014 14:44:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] android/gatt: Set proper MTU for BR/EDR link
Message-ID: <20141126124412.GA9449@t440s.lan>
References: <1416991660-21828-1-git-send-email-jakub.tyszkowski@tieto.com>
 <1416991660-21828-4-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416991660-21828-4-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Nov 26, 2014, Jakub Tyszkowski wrote:
> Minimum mtu depends on transport layer and is larger for BREDR link.
> ---
>  android/gatt.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index b9b3c7b..95ddba0 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1439,7 +1439,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>  	uint32_t status;
>  	GAttrib *attrib;
>  	uint16_t mtu;
> -	uint16_t cid;
> +	uint8_t dst_type;
>  
>  	if (dev->state != DEVICE_CONNECT_READY) {
>  		error("gatt: Device not in a connecting state!?");
> @@ -1459,9 +1459,11 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>  		goto reply;
>  	}
>  
> -	if (!bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &mtu, BT_IO_OPT_CID, &cid,
> -				BT_IO_OPT_INVALID) || cid == ATT_CID)
> -		mtu = ATT_DEFAULT_LE_MTU;
> +	mtu = ATT_DEFAULT_LE_MTU;
> +
> +	if (bt_io_get(io, &gerr, BT_IO_OPT_DEST_TYPE, &dst_type,
> +			BT_IO_OPT_INVALID) && (dst_type == BDADDR_BREDR))
> +		mtu = ATT_DEFAULT_L2CAP_MTU;
>  
>  	attrib = g_attrib_new(io, mtu);
>  	if (!attrib) {

Isn't this a kernel or BtIO bug if we get the wrong MTU from bt_io_get?

Johan
