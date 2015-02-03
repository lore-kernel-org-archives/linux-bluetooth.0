Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] android/gatt: Fix initial setting of MTU
Date: Tue, 03 Feb 2015 12:45:49 +0100
Message-ID: <1432325.UU2MSNSUEs@uw000953>
In-Reply-To: <1422564649-32210-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1422564649-32210-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 29 of January 2015 21:50:48 Lukasz Rymanowski wrote:
> Initial setting of MTU should be IMTU. This is actually our assumption
> in other part of code, that IMTU is something we start with and change
> if needed after exchange MTU procedure.
> 
> If we are not able to get IMTU from the socket just disconnect, there is
> something wrong going on.
> 
> Without this patch you can face the issue with following scenario:
> 1. On connection complete MTU is set to 23
> 2. BfA sends Exchange MTU Request with MTU set to IMTU
> 3. Remote device response with MTU equal to what BfA sends
> 4. In that case, since remote MTU is equal to ours, there is no
> update in bt_att, so bt_att keep using  MTU = 23
> 5. Remote sends packets highier then 23 and bt_att start to drop not
> complete packets.
> 
> Issue found and fix tested on UPF50
> ---
> v2: Use local GError instead the one provided as a function parameter
> 
>  android/gatt.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 466c1ea..23ffb9e 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1488,6 +1488,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>  	struct connect_data data;
>  	struct att_range range;
>  	uint32_t status;
> +	GError *err = NULL;
>  	GAttrib *attrib;
>  	uint16_t mtu;
>  	uint16_t cid;
> @@ -1510,9 +1511,14 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>  		goto reply;
>  	}
>  
> -	if (!bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &mtu, BT_IO_OPT_CID, &cid,
> -				BT_IO_OPT_INVALID) || cid == ATT_CID)
> -		mtu = ATT_DEFAULT_LE_MTU;
> +	if (!bt_io_get(io, &err, BT_IO_OPT_IMTU, &mtu, BT_IO_OPT_CID, &cid,
> +							BT_IO_OPT_INVALID)) {
> +		error("gatt: Could not get imtu: %s", err->message);
> +		device_set_state(dev, DEVICE_DISCONNECTED);
> +		status = GATT_FAILURE;
> +		g_error_free(err);
> +		goto reply;
> +	}
>  
>  	attrib = g_attrib_new(io, mtu);
>  	if (!attrib) {
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
