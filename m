Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH BlueZ 4/5] plugins/sixaxis: add a get_leds_data() function
Date: Wed, 07 May 2014 22:04:42 +0200
Message-ID: <3241221.vQjXq9bzg2@athlon>
In-Reply-To: <1399370776-5027-5-git-send-email-ao2@ao2.it>
References: <1399370776-5027-1-git-send-email-ao2@ao2.it> <1399370776-5027-5-git-send-email-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Tuesday 06 May 2014 12:06:15 Antonio Ospite wrote:
> Get all the data necessary to set the LEDs (bitmap and/or sysfs paths)
> in a single function, returning a leds_data structure to be passed as
> argument to the setup_leds() callback.
> 
> For now only the bitmap field is populated, which is the only thing that
> set_leds_hidraw() needs.
> ---
>  plugins/sixaxis.c | 54
> +++++++++++++++++++++++++++++++++++++++++++++++------- 1 file changed, 47
> insertions(+), 7 deletions(-)
> 
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index b629c06..2b35d1c 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -61,6 +61,11 @@ static const struct {
>  	},
>  };
> 
> +struct leds_data {
> +	char *syspaths[4];
> +	uint8_t bitmap;
> +};
> +
>  static struct udev *ctx = NULL;
>  static struct udev_monitor *monitor = NULL;
>  static guint watch_id = 0;
> @@ -183,19 +188,25 @@ static gboolean set_leds_hidraw(int fd, uint8_t
> leds_bitmap) static gboolean setup_leds(GIOChannel *channel, GIOCondition
> cond, gpointer user_data)
>  {
> -	int number = GPOINTER_TO_INT(user_data);
> -	uint8_t bitmap = 0;
>  	int fd;
> +	int i;
> +	int ret;
> +	struct leds_data *data = (struct leds_data *)user_data;
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

if (!data) ..

> +		return NULL;
> +
> +	memset(data, 0, sizeof(*data));

You can use malloc0() from src/shared instead.

> +
> +	number = get_js_number(udevice);
> +	DBG("number %d", number);
> +
> +	ret = calc_leds_bitmap(number, &data->bitmap);
> +	if (ret == FALSE)
> +		goto err;

ret seems to be redundant

if (!calc_leds_bitmap())
  goto err

> +
> +	return data;
> +
> +err:
> +	for (i = 0; i < 4; i++)
> +		free(data->syspaths[i]);
> +	free(data);

Please add helper (eg. leds_data_destroy()) for clearing this and use where 
needed.

Add empty line here.

> +	return NULL;
> +}
> +
>  static int get_supported_device(struct udev_device *udevice, uint16_t *bus)
> {
>  	struct udev_device *hid_parent;
> @@ -374,7 +414,7 @@ static void device_added(struct udev_device *udevice)
>  		/* wait for events before setting leds */
>  		g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
>  				setup_leds,
> -				GINT_TO_POINTER(get_js_number(udevice)));
> +				get_leds_data(udevice));
> 
>  		break;
>  	default:

-- 
Szymon K. Janc
szymon.janc@gmail.com
