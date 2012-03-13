Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Mar 2012 12:30:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Add DeviceInformation GATT Client
Message-ID: <20120313103002.GA28153@x220>
References: <1331619860-10973-1-git-send-email-chen.ganir@ti.com>
 <1331619860-10973-2-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331619860-10973-2-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Tue, Mar 13, 2012, chen.ganir@ti.com wrote:
> +static int deviceinfo_init(void)
> +{
> +	if (deviceinfo_manager_init() < 0) {
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}

Why not simply:

	return deviceinfo_manager_init();

> +int deviceinfo_manager_init(void)
> +{
> +	int ret;
> +
> +	ret = btd_register_device_driver(&deviceinfo_device_driver);
> +	if (ret < 0)
> +                return ret;
> +
> +	return 0;
> +}

Why not simply:

	return btd_register_device_driver(&deviceinfo_device_driver);

Johan
