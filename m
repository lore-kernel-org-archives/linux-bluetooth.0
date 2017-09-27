Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org,
        Juha Kuikka <juha.kuikka@gmail.com>
Subject: Re: [PATCH 8/9] plugins/sixaxis: Add support for DualShock 4/PS4 cable pairing
Date: Wed, 27 Sep 2017 11:12:01 +0200
Message-ID: <8659915.mKjsMy947m@ix>
In-Reply-To: <20170904181212.5639-8-hadess@hadess.net>
References: <20170904181212.5639-1-hadess@hadess.net> <20170904181212.5639-8-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Monday, 4 September 2017 20:12:11 CEST Bastien Nocera wrote:
> From: Juha Kuikka <juha.kuikka@gmail.com>
> 
> This patch adds support for "pairing" a Dualshock4 controller over USB
> into the sixaxis plugin, similarly to what the Sixaxis/PS3 controller
> supported.
> 
> Actual bonding happens on first connection, but the device will be
> marked as trusted when the agent replies.
> 
> This patch is based on DS4 supprt for sixpair tool by t0xicCode:
> https://github.com/t0xicCode/sixpair/commit/975c38cb6cd61a2f0be350714f0f64ce
> f5f0432c ---
>  plugins/sixaxis.c | 73
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed, 72
> insertions(+), 1 deletion(-)
> 
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index b62834d72..eb15acb92 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -83,10 +83,34 @@ static int sixaxis_get_device_bdaddr(int fd, bdaddr_t
> *bdaddr) return 0;
>  }
> 
> +static int ds4_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
> +{
> +	uint8_t buf[7];
> +	int ret;
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	buf[0] = 0x81;
> +
> +	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
> +	if (ret < 0) {
> +		error("ds4: failed to read device address (%s)",
> +		      strerror(errno));

Lets prefix all sixaxis error/info logs with "sixaxis:"

> +		return ret;
> +	}
> +
> +	/* address is little-endian on DS4 */
> +	bacpy(bdaddr, (bdaddr_t*) (buf + 1));
> +
> +	return 0;
> +}
> +
>  static int get_device_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType
> type) {
>  	if (type == CABLE_PAIRING_SIXAXIS)
>  		return sixaxis_get_device_bdaddr(fd, bdaddr);
> +	else if (type == CABLE_PAIRING_DS4)
> +		return ds4_get_device_bdaddr(fd, bdaddr);
>  	return -1;
>  }
> 
> @@ -111,10 +135,34 @@ static int sixaxis_get_master_bdaddr(int fd, bdaddr_t
> *bdaddr) return 0;
>  }
> 
> +static int ds4_get_master_bdaddr(int fd, bdaddr_t *bdaddr)
> +{
> +	uint8_t buf[16];
> +	int ret;
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	buf[0] = 0x12;
> +
> +	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
> +	if (ret < 0) {
> +		error("ds4: failed to read master address (%s)",
> +		      strerror(errno));
> +		return ret;
> +	}
> +
> +	/* address is little-endian on DS4 */
> +	bacpy(bdaddr, (bdaddr_t*) (buf + 10));
> +
> +	return 0;
> +}
> +
>  static int get_master_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType
> type) {
>  	if (type == CABLE_PAIRING_SIXAXIS)
>  		return sixaxis_get_master_bdaddr(fd, bdaddr);
> +	else if (type == CABLE_PAIRING_DS4)
> +		return ds4_get_master_bdaddr(fd, bdaddr);
>  	return -1;
>  }
> 
> @@ -136,11 +184,33 @@ static int sixaxis_set_master_bdaddr(int fd, const
> bdaddr_t *bdaddr) return ret;
>  }
> 
> +static int ds4_set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
> +{
> +	uint8_t buf[23];
> +	int ret;
> +
> +	buf[0] = 0x13;
> +	bacpy((bdaddr_t*) (buf + 1), bdaddr);
> +	/* TODO: we could put the key here but
> +	   there is no way to force a re-loading
> +	   of link keys to the kernel from here. */
> +	memset(buf + 7, 0, 16);
> +
> +	ret = ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
> +	if (ret < 0)
> +		error("ds4: failed to write master address (%s)",
> +		      strerror(errno));
> +
> +	return ret;
> +}
> +
>  static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr,
>  					CablePairingType type)
>  {
>  	if (type == CABLE_PAIRING_SIXAXIS)
>  		return sixaxis_set_master_bdaddr(fd, bdaddr);
> +	else if (type == CABLE_PAIRING_DS4)
> +		return ds4_set_master_bdaddr(fd, bdaddr);
>  	return -1;
>  }
> 
> @@ -279,7 +349,8 @@ static void device_added(struct udev_device *udevice)
>  						&name,
>  						&source,
>  						&version);
> -	if (type != CABLE_PAIRING_SIXAXIS)
> +	if (type != CABLE_PAIRING_SIXAXIS &&
> +	    type != CABLE_PAIRING_DS4)
>  		return;
>  	if (bus != BUS_USB)
>  		return;


-- 
pozdrawiam
Szymon Janc
