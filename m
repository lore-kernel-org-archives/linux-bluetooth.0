Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Oct 2011 10:16:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/9] Get thermometer service range to load the driver.
Message-ID: <20111010071601.GB4094@fusion.localdomain>
References: <1317303988-26310-1-git-send-email-sancane@gmail.com>
 <1317303988-26310-2-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317303988-26310-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Thu, Sep 29, 2011, Santiago Carot-Nemesio wrote:
>  static int thermometer_driver_probe(struct btd_device *device, GSList *uuids)
>  {
> -	return thermometer_register(connection, device);
> +	struct att_primary *tattr;
> +	GSList *list;
> +
> +	list = device_services_from_record(device, uuids);
> +	if (!list)
> +		return -1;

Could you try to avoid -1 error values. Please choose some appropriate
POSIX error code instead (e.g. EINVAL in this case). Also (and I know
we're note very consistent with this) when you're testing whether a
pointer is NULL use "pointer == NULL" instead of "!pointer". This makes
is directly clear that this is not a variable of some boolean type.

Johan
