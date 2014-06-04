Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Set attrib MTU correctly
Date: Wed, 04 Jun 2014 19:38:29 +0200
Message-ID: <31158844.FpJplVcR4q@leonov>
In-Reply-To: <1401886448-28463-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401886448-28463-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wednesday 04 of June 2014 14:54:08 Marcin Kraglak wrote:
> We should set g_attrib mtu with MIN of two values: Remote Rx MTU
> and local Tx MTU. In previous solution once we set g_attrib mtu, we
> could only reduce MTU (because we took previously set g_attrib MTU
> and Remote Rx MTU). It affected cases when remote wanted to increase
> MTU

According to spec:
section 3.4.2.1: "This [Exchange MTU] request shall only be sent once during a 
connection by the client."
section 3.4.2.2: "A device's Exchange MTU Request shall contain the same MTU 
as the device's Exchange MTU Response (i.e. the MTU shall be symmetric)."

So if I get the spec correctly it is illegal to increase (or decrease) MTU 
after it was exchanged (we should probably respond with error if client is 
sending request more than one).

Please correct me if I'm wrong.

> .
> ---
>  android/gatt.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 429181f..5bf7694 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4857,8 +4857,8 @@ static uint8_t read_request(const uint8_t *cmd,
> uint16_t cmd_len, static uint8_t mtu_att_handle(const uint8_t *cmd,
> uint16_t cmd_len, struct gatt_device *dev)
>  {
> -	uint16_t mtu, imtu;
> -	size_t omtu;
> +	uint16_t mtu, imtu, omtu;
> +	size_t length;
>  	GIOChannel *io;
>  	GError *gerr = NULL;
>  	uint16_t len;
> @@ -4877,6 +4877,7 @@ static uint8_t mtu_att_handle(const uint8_t *cmd,
> uint16_t cmd_len,
> 
>  	bt_io_get(io, &gerr,
>  			BT_IO_OPT_IMTU, &imtu,
> +			BT_IO_OPT_OMTU, &omtu,
>  			BT_IO_OPT_INVALID);
>  	if (gerr) {
>  		error("bt_io_get: %s", gerr->message);
> @@ -4884,10 +4885,10 @@ static uint8_t mtu_att_handle(const uint8_t *cmd,
> uint16_t cmd_len, return ATT_ECODE_UNLIKELY;
>  	}
> 
> -	rsp = g_attrib_get_buffer(dev->attrib, &omtu);
> +	rsp = g_attrib_get_buffer(dev->attrib, &length);
> 
>  	/* Respond with our IMTU */
> -	len = enc_mtu_resp(imtu, rsp, omtu);
> +	len = enc_mtu_resp(imtu, rsp, length);
>  	if (!len)
>  		return ATT_ECODE_UNLIKELY;

-- 
BR
Szymon Janc
