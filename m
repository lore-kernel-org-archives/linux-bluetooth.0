Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Dec 2010 10:42:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 2/5] Change CreatePairedDevice to support LE devices
Message-ID: <20101221084243.GA14108@jh-x301>
References: <20101220225909.GA6365@jh-x301>
 <1292889434-3773-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292889434-3773-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Mon, Dec 20, 2010, Sheldon Demario wrote:
> +static struct btd_device *create_device_internal(DBusConnection *conn,
> +						struct btd_adapter *adapter,
> +						const gchar *address,
> +						gboolean secure, int *err)
> +{
> +	struct remote_dev_info *dev, match;
> +	struct btd_device *device;
> +	device_type_t type;
> +
> +	memset(&match, 0, sizeof(struct remote_dev_info));
> +	str2ba(address, &match.bdaddr);
> +	match.name_status = NAME_ANY;
> +
> +	dev = adapter_search_found_devices(adapter, &match);
> +	if (dev && dev->flags)
> +		type = flags2type(dev->flags);
> +	else
> +		type = DEVICE_TYPE_BREDR;
> +
> +	if (!secure && type == DEVICE_TYPE_LE &&
> +					!event_is_connectable(dev->evt_type)) {

I think you got something mixed up here. I asked you to change the
sec_level_high variable occurences to secure. Here you've gone and
changed the force variable to secure (something that I didn't request).

I.e. please use "force" like before (since that describes its purpose
within the create_device_internal function more intuitively) and change
the following:

> +int device_browse_primary(struct btd_device *device, DBusConnection *conn,
> +				DBusMessage *msg, gboolean sec_level_high)

> +int device_browse_primary(struct btd_device *device, DBusConnection *conn,
> +				DBusMessage *msg, gboolean sec_level_high);

>  int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
>  					bt_primary_t cb, void *user_data,
> +					gboolean sec_level_high,
>  					bt_destroy_t destroy)

>  int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
>  					bt_primary_t cb, void *user_data,
> +					gboolean sec_level_high,
>  					bt_destroy_t destroy);

Johan
