Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Dec 2010 00:59:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Sheldon Demario <sheldon.demario@openbossa.org>
Subject: Re: [PATCH v2 2/5] Change CreatePairedDevice to support LE devices
Message-ID: <20101220225909.GA6365@jh-x301>
References: <20101216210111.GA25720@jh-x301>
 <1292885021-21619-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292885021-21619-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> +static struct btd_device *create_common(DBusConnection *conn,

I don't really like this name since it doesn't explain what the function
does in any way except that it creates "something". Could you call it
e.g. __create_device() or create_device_internal()?

> +	if (type == DEVICE_TYPE_LE && !event_is_connectable(dev->evt_type)) {
> +		if (force)
> +			goto create;
> +
> +		if (err)
> +			*err = -ENOTCONN;
> +
> +		return NULL;
> +	}
> +
> +create:

You could avoid the label and goto by simply adding if (!force && type...
to the beginning of the if-statement.

> +int device_browse_primary(struct btd_device *device, DBusConnection *conn,
> +				DBusMessage *msg, gboolean sec_level_high)

Could you call the gboolean parameter just "secure"?

Johan
