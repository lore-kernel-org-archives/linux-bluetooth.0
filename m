Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/gatt: Move get_sec_level function
Date: Tue, 17 Jun 2014 21:57:11 +0200
Message-ID: <2294168.zuOePBTdec@athlon>
In-Reply-To: <1403011871-8354-1-git-send-email-marcin.kraglak@tieto.com>
References: <1403011871-8354-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tuesday 17 June 2014 15:31:09 Marcin Kraglak wrote:
> This will be used in read and write handlers functions.
> ---
>  android/gatt.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index a19fe5c..9531577 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -2715,6 +2715,22 @@ static void read_char_cb(guint8 status, const guint8
> *pdu, guint16 len, free(data);
>  }
> 
> +static int get_sec_level(struct gatt_device *dev)
> +{
> +	GIOChannel *io;
> +	int sec_level;
> +
> +	io = g_attrib_get_channel(dev->attrib);
> +
> +	if (!bt_io_get(io, NULL, BT_IO_OPT_SEC_LEVEL, &sec_level,
> +							BT_IO_OPT_INVALID)) {
> +		error("gatt: Failed to get sec_level");
> +		return -1;
> +	}
> +
> +	return sec_level;
> +}
> +
>  static void handle_client_read_characteristic(const void *buf, uint16_t
> len) {
>  	const struct hal_cmd_gatt_client_read_characteristic *cmd = buf;
> @@ -2835,22 +2851,6 @@ static bool signed_write_cmd(struct gatt_device *dev,
> uint16_t handle, return true;
>  }
> 
> -static int get_sec_level(struct gatt_device *dev)
> -{
> -	GIOChannel *io;
> -	int sec_level;
> -
> -	io = g_attrib_get_channel(dev->attrib);
> -
> -	if (!bt_io_get(io, NULL, BT_IO_OPT_SEC_LEVEL, &sec_level,
> -							BT_IO_OPT_INVALID)) {
> -		error("gatt: Failed to get sec_level");
> -		return -1;
> -	}
> -
> -	return sec_level;
> -}
> -
>  static void handle_client_write_characteristic(const void *buf, uint16_t
> len) {
>  	const struct hal_cmd_gatt_client_write_characteristic *cmd = buf;

This patch is now applied. Thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
