Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 May 2014 15:22:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH BlueZ 4/5] plugins/sixaxis: add a get_leds_data() function
Message-ID: <20140509122232.GB4436@t440s.lan>
References: <1399370776-5027-1-git-send-email-ao2@ao2.it>
 <1399370776-5027-5-git-send-email-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399370776-5027-5-git-send-email-ao2@ao2.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Tue, May 06, 2014, Antonio Ospite wrote:
>  static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
>  							gpointer user_data)
>  {
> -	int number = GPOINTER_TO_INT(user_data);
> -	uint8_t bitmap = 0;
>  	int fd;
> +	int i;
> +	int ret;
> +	struct leds_data *data = (struct leds_data *)user_data;

No need to have an explicit cast for a void pointer.

>  
> -	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
> +	if (data == NULL)
>  		return FALSE;
>  
> -	DBG("number %d", number);
> +	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
> +		goto out;
>  
>  	fd = g_io_channel_unix_get_fd(channel);
>  
> -	if (calc_leds_bitmap(number, &bitmap))
> -		set_leds_hidraw(fd, bitmap);
> +	set_leds_hidraw(fd, data->bitmap);
> +
> +out:
> +	for (i = 0; i < 4; i++)
> +		free(data->syspaths[i]);
> +	free(data);
>  
>  	return FALSE;
>  }

I don't see you using the "int ret" anywhere in this function. Even if
you do end up using it later for returning something I suppose it should
be a boolean type and not int. However even then the variable should be
introduced in the patch that actually makes use of it. If you build test
each patch individually with --enable-maintainer-mode the compiler
should warn about unused variables (amongst many other things) for you.

> @@ -313,6 +324,35 @@ static int get_js_number(struct udev_device *udevice)
>  	return number;
>  }
>  
> +static struct leds_data *get_leds_data(struct udev_device *udevice)
> +{
> +	struct leds_data *data;
> +	int number;
> +	int i;
> +	int ret;
> +
> +	data = malloc(sizeof(*data));
> +	if (data == NULL)
> +		return NULL;
> +
> +	memset(data, 0, sizeof(*data));
> +
> +	number = get_js_number(udevice);
> +	DBG("number %d", number);
> +
> +	ret = calc_leds_bitmap(number, &data->bitmap);
> +	if (ret == FALSE)
> +		goto err;

Same here: if you're storing a boolean value into ret it should be
declared as a boolean type instead of int. Also, you don't need the
"== FALSE" comparison since boolean types are supposed to be valid
boolean expressions by themselves, i.e. "if (!ret)" should do.

Johan
