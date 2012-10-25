Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 12:54:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v7 14/16] dbusoob: Store device name in cache directory
Message-ID: <20121025095419.GB24756@x220>
References: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
 <1351089258-25179-15-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1351089258-25179-15-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Wed, Oct 24, 2012, Frédéric Danis wrote:
> ---
>  plugins/dbusoob.c |   26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
> index 5c5b6ef..82d512c 100644
> --- a/plugins/dbusoob.c
> +++ b/plugins/dbusoob.c
> @@ -31,6 +31,7 @@
>  
>  #include <errno.h>
>  #include <gdbus.h>
> +#include <sys/stat.h>
>  
>  #include <bluetooth/bluetooth.h>
>  #include <bluetooth/hci.h>
> @@ -194,6 +195,11 @@ static gboolean parse_data(DBusMessageIter *data, struct oob_data *remote_data)
>  static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
>  {
>  	bdaddr_t bdaddr;
> +	char filename[PATH_MAX + 1];
> +	char s_addr[18];
> +	GKeyFile *key_file;
> +	char *str;
> +	gsize length = 0;
>  
>  	str2ba(data->addr, &bdaddr);
>  
> @@ -207,9 +213,23 @@ static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
>  		write_remote_class(adapter_get_address(adapter), &bdaddr,
>  								data->class);
>  
> -	if (data->name)
> -		write_device_name(adapter_get_address(adapter), &bdaddr, 0,
> -								data->name);
> +	if (data->name) {
> +		ba2str(adapter_get_address(adapter), s_addr);
> +		snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
> +				s_addr, data->addr);
> +		filename[PATH_MAX] = '\0';
> +		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> +
> +		key_file = g_key_file_new();
> +		g_key_file_load_from_file(key_file, filename, 0, NULL);
> +		g_key_file_set_string(key_file, "General", "Name", data->name);
> +
> +		str = g_key_file_to_data(key_file, &length, NULL);
> +		g_file_set_contents(filename, str, length, NULL);
> +		g_free(str);
> +
> +		g_key_file_free(key_file);
> +	}

There shouldn't this kind of core-daemon keyfile access from plugins, In
this case you should get a btd_device object and simply do a
btd_device_set_name (and if that function doesn't yet write to storage
update it so that it does).

Johan
