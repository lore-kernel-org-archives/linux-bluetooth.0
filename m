Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 12:52:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v7 13/16] device: Retrieve name from cache directory
Message-ID: <20121025095212.GA24756@x220>
References: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
 <1351089258-25179-14-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1351089258-25179-14-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Wed, Oct 24, 2012, Frédéric Danis wrote:
> ---
>  src/device.c |   25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)

I've applied patches 1-12 since they seemed fine to me but there are
some things to consider with 13-16:

> --- a/src/device.c
> +++ b/src/device.c
> @@ -1573,6 +1573,8 @@ struct btd_device *device_create(struct btd_adapter *adapter,
>  	const bdaddr_t *src;
>  	char srcaddr[18], alias[MAX_NAME_LENGTH + 1];
>  	uint16_t vendor, product, version;
> +	char filename[PATH_MAX + 1];
> +	GKeyFile *key_file;
>  
>  	device = g_try_malloc0(sizeof(struct btd_device));
>  	if (device == NULL)
> @@ -1600,7 +1602,28 @@ struct btd_device *device_create(struct btd_adapter *adapter,
>  	src = adapter_get_address(adapter);
>  	ba2str(src, srcaddr);
>  
> -	read_device_name(srcaddr, address, bdaddr_type, device->name);
> +	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", srcaddr,
> +			address);
> +	filename[PATH_MAX] = '\0';
> +	key_file = g_key_file_new();
> +
> +	if (g_key_file_load_from_file(key_file, filename, 0, NULL)) {
> +		char *str;
> +		int len;
> +
> +		str = g_key_file_get_string(key_file, "General", "Name", NULL);
> +		if (str) {
> +			len = strlen(str);
> +			if (len > HCI_MAX_NAME_LENGTH)
> +				str[HCI_MAX_NAME_LENGTH] = '\0';
> +
> +			strcpy(device->name, str);
> +			g_free(str);
> +		}
> +	}
> +
> +	g_key_file_free(key_file);
> +

I'd rather have you split off a separate function to load the config
like you have for adapters.

Regarding the device name, I think the idea is that removing the cache
shouldn't cause any bad behavior with the persistent part of the storage
(i.e. configured devices). So we should probably also have the name in
the per-device storage file and try to read it from there first and if
that fails fall back to the cache.

Johan
