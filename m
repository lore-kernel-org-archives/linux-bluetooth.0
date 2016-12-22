Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 22 Dec 2016 11:24:18 +0100
From: Antonio Ospite <ao2@ao2.it>
To: Juha Kuikka <juha.kuikka@synapse.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] sixaxis: Add support for pairing DS4 over USB
Message-Id: <20161222112418.31121c6b3d9b0a339649a282@ao2.it>
In-Reply-To: <1482384054-59718-3-git-send-email-juha.kuikka@synapse.com>
References: <1482384054-59718-1-git-send-email-juha.kuikka@synapse.com>
        <1482384054-59718-3-git-send-email-juha.kuikka@synapse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 21 Dec 2016 21:20:53 -0800
Juha Kuikka <juha.kuikka@synapse.com> wrote:

> This patch adds support for "pairing" a Dualshock4 controller over USB
> into the sixaxis plugin.
>
> Pairing is in quotes because we cannot do real bonding due to lack of
> API of setting link keys from the plugin so instead we just tell the
> controller that we are the master and to connect to us.
>

Hi Juha,

I do not have a DS4, so it is not immediately clear to me what the
difference is between having or not having this USB "pairing" with DS4
controllers.

Could you please elaborate a little more? Thanks.
I thought people were using DS4s via BT just fine without it.

And what about setup_leds() for the DS4?  Will it still be called when
the DS4 shows up via BT?

Also consider CCing these developers when you send a possible next
iteration, they worked on the DS4 kernel driver and could be interested:

Frank Praznik <frank.praznik@gmail.com>
Roderick Colenbrander <roderick.colenbrander@sony.com>

Maybe mention BlueZ in the title of the cover letter when you do that,
to make clearer to them that the changes are not about the kernel
driver.

Some comments inlined below.

> Actual bonding happens on first connection per usual.
> 
> This patch is based on information from sixpair tool.

Is there an official link to that?

> ---
>  plugins/sixaxis.c | 86 ++++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 66 insertions(+), 20 deletions(-)
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

If these devices have a different pairing mechanism maybe we can set
some function pointers here, and use a "callback" approach to handle it.

This would avoid having a lot of if...else in the functions below.

Something like:
		get_device_bdaddr = ds4_get_device_bdaddr,
		get_master_bdaddr = ds4_get_master_bdaddr,
		set_device_bdaddr = ds4_set_device_bdaddr,
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

This function will just become sixaxis_get_device_bdaddr, and a new
function called ds4_get_device_bdaddr will implement the DS4 paring
which uses a different feature report, with a different size and
structure.

This looks cleaner to me.

> +static bool is_dualshock4(int index)
> +{
> +	return devices[index].pid == 0x05c4 || devices[index].pid == 0x09cc;
> +}

this will not be needed,

> +
> +static int get_device_bdaddr(int fd, int index, bdaddr_t *bdaddr)

and neither changing the function parameters.

>  {
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

ditto.

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
> +	else
> +		baswap(bdaddr, (bdaddr_t *) (buf + 2));
>  
>  	return 0;
>  }
>  
> -static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
> +static int set_master_bdaddr(int fd, int index, const bdaddr_t *bdaddr)

ditto.

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
> +		memset(buf + 7, 0, 16); /* TODO: we could put the key here but there is no way to force a re-loading of link keys to the kernel */
> +	} else {
> +		report_length = 8;
> +
> +		buf[0] = 0xf5;
> +		buf[1] = 0x01;
> +		baswap((bdaddr_t *) (buf + 2), bdaddr);
> +	}
>  
>  	ret = ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
>  	if (ret < 0)
> @@ -262,10 +308,10 @@ static bool setup_device(int fd, int index, struct btd_adapter *adapter)
>  	const bdaddr_t *adapter_bdaddr;
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

Here the function pointers will be used, like:
	if (devices[index].get_device_bdaddr(fd, &device_bdaddr) < 0)
	...
	if (devices[index].get_master_bdaddr(fd, &master_bdaddr) < 0)

>  	/* This can happen if controller was plugged while already connected
> @@ -279,7 +325,7 @@ static bool setup_device(int fd, int index, struct btd_adapter *adapter)
>  	adapter_bdaddr = btd_adapter_get_address(adapter);
>  
>  	if (bacmp(adapter_bdaddr, &master_bdaddr)) {
> -		if (set_master_bdaddr(fd, adapter_bdaddr) < 0)
> +		if (set_master_bdaddr(fd, index, adapter_bdaddr) < 0)

and here too.

>  			return false;
>  	}
>  

If this approach sounds OK, send a preparatory patch which adds the
needed fields to the global struct and renames the sixaxis functions
maybe moving them before the definition of the devices[] array, and then
do the DS4 changes to add the new devices and callbacks.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
