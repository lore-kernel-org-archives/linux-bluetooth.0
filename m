Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Juha Kuikka <juha.kuikka@synapse.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] sixaxis: Add support for pairing DS4 over USB
Date: Wed, 28 Dec 2016 17:14:46 +0100
Message-ID: <7529288.f5mXksFJ8c@ix>
In-Reply-To: <1482384054-59718-3-git-send-email-juha.kuikka@synapse.com>
References: <1482384054-59718-1-git-send-email-juha.kuikka@synapse.com> <1482384054-59718-3-git-send-email-juha.kuikka@synapse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Juha,

On Wednesday, 21 December 2016 21:20:53 CET Juha Kuikka wrote:
> This patch adds support for "pairing" a Dualshock4 controller over USB
> into the sixaxis plugin.
> 
> Pairing is in quotes because we cannot do real bonding due to lack of
> API of setting link keys from the plugin so instead we just tell the
> controller that we are the master and to connect to us.
> 
> Actual bonding happens on first connection per usual.
> 
> This patch is based on information from sixpair tool.
> ---
>  plugins/sixaxis.c | 86
> ++++++++++++++++++++++++++++++++++++++++++------------- 1 file changed, 66
> insertions(+), 20 deletions(-)
> 
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index fcc93bc..1fb2091 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -69,6 +69,20 @@ static const struct {
>  		.pid = 0x042f,
>  		.version = 0x0000,
>  	},
> +	{
> +		.name = "Wireless Controller",
> +		.source = 0x0002,
> +		.vid = 0x054c,
> +		.pid = 0x05c4,
> +		.version = 0x0001,
> +	},
> +	{
> +		.name = "Wireless Controller",
> +		.source = 0x0002,
> +		.vid = 0x054c,
> +		.pid = 0x09cc,
> +		.version = 0x0001,
> +	},
>  };
> 
>  struct leds_data {
> @@ -86,57 +100,89 @@ static struct udev *ctx = NULL;
>  static struct udev_monitor *monitor = NULL;
>  static guint watch_id = 0;
> 
> -static int get_device_bdaddr(int fd, bdaddr_t *bdaddr)
> +static bool is_dualshock4(int index)
> +{
> +	return devices[index].pid == 0x05c4 || devices[index].pid == 0x09cc;
> +}
> +
> +static int get_device_bdaddr(int fd, int index, bdaddr_t *bdaddr)
>  {

While passing index isn't that bad for differentiating pads it would be great 
to have dedicated get/set callbacks in devices[] structures. AFAIR there are 
some chinese DS3 counterfeits that don't work currently with sixaxis plugin 
that could possibly use custom calbacks.

What do you think about such approach?

>  	uint8_t buf[18];
> -	int ret;
> +	int ret, report_length;
> 
>  	memset(buf, 0, sizeof(buf));
> 
> -	buf[0] = 0xf2;
> +	if (is_dualshock4(index)) {
> +		report_length = 7;
> +		buf[0] = 0x81;
> +	} else {
> +		report_length = 18;
> +		buf[0] = 0xf2;
> +	}
> 
> -	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
> +	ret = ioctl(fd, HIDIOCGFEATURE(report_length), buf);
>  	if (ret < 0) {
>  		error("sixaxis: failed to read device address (%s)",
>  							strerror(errno));
>  		return ret;
>  	}
> 
> -	baswap(bdaddr, (bdaddr_t *) (buf + 4));
> +	if (is_dualshock4(index))
> +		memcpy(bdaddr->b, buf + 1, 6); // little-endian on DS4
> +	else
> +		baswap(bdaddr, (bdaddr_t *) (buf + 4));
> 
>  	return 0;
>  }
> 
> -static int get_master_bdaddr(int fd, bdaddr_t *bdaddr)
> +static int get_master_bdaddr(int fd, int index, bdaddr_t *bdaddr)
>  {
> -	uint8_t buf[8];
> -	int ret;
> +	uint8_t buf[16];
> +	int ret, report_length;
> 
>  	memset(buf, 0, sizeof(buf));
> 
> -	buf[0] = 0xf5;
> +	if (is_dualshock4(index)) {
> +		report_length = 16;
> +		buf[0] = 0x12;
> +	} else {
> +		report_length = 8;
> +		buf[0] = 0xf5;
> +	}
> 
> -	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
> +	ret = ioctl(fd, HIDIOCGFEATURE(report_length), buf);
>  	if (ret < 0) {
>  		error("sixaxis: failed to read master address (%s)",
>  							strerror(errno));
>  		return ret;
>  	}
> 
> -	baswap(bdaddr, (bdaddr_t *) (buf + 2));
> +	if (is_dualshock4(index))
> +		memcpy(bdaddr->b, buf + 10, 6); // little-endian on DS4

I'd prefer use of bacpy(). Also please use /* */ style comments.

> +	else
> +		baswap(bdaddr, (bdaddr_t *) (buf + 2));
> 
>  	return 0;
>  }
> 
> -static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
> +static int set_master_bdaddr(int fd, int index, const bdaddr_t *bdaddr)
>  {
> -	uint8_t buf[8];
> -	int ret;
> +	uint8_t buf[23];
> +	int ret, report_length;
> 
> -	buf[0] = 0xf5;
> -	buf[1] = 0x01;
> +	if (is_dualshock4(index)) {
> +		report_length = 23;
> 
> -	baswap((bdaddr_t *) (buf + 2), bdaddr);
> +		buf[0] = 0x13;
> +		memcpy(buf + 1, bdaddr->b, 6);
> +		memset(buf + 7, 0, 16); /* TODO: we could put the key here but there 
is
> no way to force a re-loading of link keys to the kernel */ +	} else {

80 characters limit.

> +		report_length = 8;
> +
> +		buf[0] = 0xf5;
> +		buf[1] = 0x01;
> +		baswap((bdaddr_t *) (buf + 2), bdaddr);
> +	}
> 
>  	ret = ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
>  	if (ret < 0)
> @@ -262,10 +308,10 @@ static bool setup_device(int fd, int index, struct
> btd_adapter *adapter) const bdaddr_t *adapter_bdaddr;
>  	struct btd_device *device;
> 
> -	if (get_device_bdaddr(fd, &device_bdaddr) < 0)
> +	if (get_device_bdaddr(fd, index, &device_bdaddr) < 0)
>  		return false;
> 
> -	if (get_master_bdaddr(fd, &master_bdaddr) < 0)
> +	if (get_master_bdaddr(fd, index, &master_bdaddr) < 0)
>  		return false;
> 
>  	/* This can happen if controller was plugged while already connected
> @@ -279,7 +325,7 @@ static bool setup_device(int fd, int index, struct
> btd_adapter *adapter) adapter_bdaddr = btd_adapter_get_address(adapter);
> 
>  	if (bacmp(adapter_bdaddr, &master_bdaddr)) {
> -		if (set_master_bdaddr(fd, adapter_bdaddr) < 0)
> +		if (set_master_bdaddr(fd, index, adapter_bdaddr) < 0)
>  			return false;
>  	}


-- 
pozdrawiam
Szymon Janc
