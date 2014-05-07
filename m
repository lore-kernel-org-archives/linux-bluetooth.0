Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH BlueZ 2/5] plugins/sixaxis: factor out a set_leds_hidraw() function
Date: Wed, 07 May 2014 21:58:09 +0200
Message-ID: <2255265.xHg6cUfLQi@athlon>
In-Reply-To: <1399370776-5027-3-git-send-email-ao2@ao2.it>
References: <1399370776-5027-1-git-send-email-ao2@ao2.it> <1399370776-5027-3-git-send-email-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Tuesday 06 May 2014 12:06:13 Antonio Ospite wrote:
> This is in preparation for a set_leds_sysfs() function.
> 
> Also use TRUE as the return value of set_leds_hidraw() in the success
> case just to be more semantically nice; the return value is not used in
> setup_leds() anyway because the latter has to always return FALSE.

I'd just make it return void then.

> ---
>  plugins/sixaxis.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index 9db14ec..61fd0b5 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -125,8 +125,7 @@ static int set_master_bdaddr(int fd, const bdaddr_t
> *bdaddr) return ret;
>  }
> 
> -static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
> -							gpointer user_data)
> +static gboolean set_leds_hidraw(int fd, int number)
>  {
>  	/*
>  	 * the total time the led is active (0xff means forever)
> @@ -147,14 +146,7 @@ static gboolean setup_leds(GIOChannel *channel,
> GIOCondition cond, 0xff, 0x27, 0x10, 0x00, 0x32, /* LED_1 */
>  		0x00, 0x00, 0x00, 0x00, 0x00,
>  	};
> -	int number = GPOINTER_TO_INT(user_data);
>  	int ret;
> -	int fd;
> -
> -	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
> -		return FALSE;
> -
> -	DBG("number %d", number);
> 
>  	/* TODO we could support up to 10 (1 + 2 + 3 + 4) */
>  	if (number > 7)
> @@ -167,11 +159,9 @@ static gboolean setup_leds(GIOChannel *channel,
> GIOCondition cond,
> 
>  	leds_report[10] |= 0x01 << number;
> 
> -	fd = g_io_channel_unix_get_fd(channel);
> -
>  	ret = write(fd, leds_report, sizeof(leds_report));
>  	if (ret == sizeof(leds_report))
> -		return FALSE;
> +		return TRUE;
> 
>  	if (ret < 0)
>  		error("sixaxis: failed to set LEDS (%s)", strerror(errno));
> @@ -181,6 +171,23 @@ static gboolean setup_leds(GIOChannel *channel,
> GIOCondition cond, return FALSE;
>  }
> 
> +static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
> +							gpointer user_data)
> +{
> +	int number = GPOINTER_TO_INT(user_data);
> +	int fd;
> +
> +	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
> +		return FALSE;
> +
> +	DBG("number %d", number);
> +
> +	fd = g_io_channel_unix_get_fd(channel);
> +	set_leds_hidraw(fd, number);
> +
> +	return FALSE;
> +}
> +
>  static bool setup_device(int fd, int index, struct btd_adapter *adapter)
>  {
>  	char device_addr[18], master_addr[18], adapter_addr[18];

-- 
Szymon K. Janc
szymon.janc@gmail.com
