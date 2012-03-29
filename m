Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Mar 2012 13:15:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/5] Add DeviceInformation GATT Client
Message-ID: <20120329101547.GA23176@x220>
References: <1332948405-1104-1-git-send-email-chen.ganir@ti.com>
 <1332948405-1104-2-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332948405-1104-2-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Mar 28, 2012, chen.ganir@ti.com wrote:
> +struct deviceinfo {
> +	struct btd_device	*dev;		/* Device reference */
> +};

Would it make sense to use device_info instead of deviceinfo? Or maybe
just di? In general I'm not so happy with this long word though I'm not
sure what the best replacement for it would be. Same goes for the
subdirectory and the filenames.

> +static GSList *deviceinfoservers = NULL;

You could call this just "servers" since it's static and already inside
a file called deviceinfo.c.

> +static void deviceinfo_exit(void)
> +{
> +	if (!main_opts.gatt_enabled)
> +		return;
> +
> +	deviceinfo_manager_exit();
> +}

I think it's a bug if *_exit() gets called even if *_init() failed. So
probably the check for gatt_enabled is unnecessary here.

Johan
