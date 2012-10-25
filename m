Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 12:55:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v7 15/16] input: Retrieve device name from cache directory
Message-ID: <20121025095512.GC24756@x220>
References: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
 <1351089258-25179-16-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1351089258-25179-16-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Wed, Oct 24, 2012, Frédéric Danis wrote:
> ---
>  profiles/input/device.c |   26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 9dd8002..41b7a5c 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -37,6 +37,7 @@
>  #include <bluetooth/sdp_lib.h>
>  #include <bluetooth/uuid.h>
>  
> +#include <glib.h>
>  #include <gdbus.h>
>  
>  #include "log.h"
> @@ -757,7 +758,9 @@ static struct input_device *input_device_new(struct btd_device *device,
>  {
>  	struct btd_adapter *adapter = device_get_adapter(device);
>  	struct input_device *idev;
> -	char name[249], src_addr[18], dst_addr[18];
> +	char src_addr[18], dst_addr[18];
> +	char filename[PATH_MAX + 1];
> +	GKeyFile *key_file;
>  
>  	idev = g_new0(struct input_device, 1);
>  	bacpy(&idev->src, adapter_get_address(adapter));
> @@ -770,9 +773,24 @@ static struct input_device *input_device_new(struct btd_device *device,
>  	ba2str(&idev->src, src_addr);
>  	ba2str(&idev->dst, dst_addr);
>  
> -	if (read_device_name(src_addr, dst_addr, device_get_addr_type(device),
> -				name) == 0)
> -		idev->name = g_strdup(name);
> +	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", src_addr,
> +			dst_addr);
> +	filename[PATH_MAX] = '\0';
> +	key_file = g_key_file_new();
> +
> +	if (g_key_file_load_from_file(key_file, filename, 0, NULL)) {
> +		int len;
> +
> +		idev->name = g_key_file_get_string(key_file, "General",
> +								"Name", NULL);
> +		if (idev->name) {
> +			len = strlen(idev->name);
> +			if (len > HCI_MAX_NAME_LENGTH)
> +				idev->name[HCI_MAX_NAME_LENGTH] = '\0';
> +		}
> +	}
> +
> +	g_key_file_free(key_file);
>  
>  	if (g_dbus_register_interface(btd_get_dbus_connection(),
>  					idev->path, INPUT_DEVICE_INTERFACE,

Same thing here with accessing core-daemon keyfiles directly. Just use
the btd_device_get_name function.

Johan
