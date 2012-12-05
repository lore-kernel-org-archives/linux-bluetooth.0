Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Dec 2012 12:29:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] adapter: Fix compilation on some architectures
Message-ID: <20121205102958.GA1650@x220.ger.corp.intel.com>
References: <1354701750-15578-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1354701750-15578-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Dec 05, 2012, Szymon Janc wrote:
> plain char may be treated as signed or unsigned depending on compiler
> (as oposite to other integer types). Use signed char explicitly when
> signed type is needed.
> 
> This fix following compilation error on ARM:
> 
>   CC     src/bluetoothd-adapter.o
> src/adapter.c: In function ‘convert_entry’:
> src/adapter.c:2710:2: error: comparison is always true due to limited
> 	range of data type [-Werror=type-limits]
> cc1: all warnings being treated as errors
> make[1]: *** [src/bluetoothd-adapter.o] Error 1
> ---
>  src/adapter.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 3c5d277..0cbce78 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2673,7 +2673,7 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
>  static void convert_entry(char *key, char *value, void *user_data)
>  {
>  	struct device_converter *converter = user_data;
> -	char device_type = -1;
> +	signed char device_type = -1;
>  	char filename[PATH_MAX + 1];
>  	GKeyFile *key_file;
>  	char *data;

Couldn't we just initialize the value to BDADDR_BREDR or maybe use an
int for it. And the naming is confusing as the value contains an address
type and not a device type.

Johan
