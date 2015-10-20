Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Oct 2015 08:35:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core/device: Fix build on some platforms
Message-ID: <20151020053510.GA29126@t440s.P-661HNU-F1>
References: <1445296472-2276-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445296472-2276-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Oct 19, 2015, Jakub Pawlowski wrote:
> due to type promotions in C this code was failing on some platforms.
> 
> src/device.c:2016:8: error: format specifies type 'unsigned short' but the
>       argument has type 'uint8_t' (aka 'unsigned char') [-Werror,-Wformat]
>   properties, uuid_str);
>   ^~~~~~~~~~
> /build/falco/usr/include/bits/stdio2.h:39:7: note: expanded from macro 'sprintf'
>                            __VA_ARGS__)
>                            ^
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/device.c b/src/device.c
> index 0d3a655..b4e6d53 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2015,7 +2015,7 @@ static void store_chrc(struct gatt_db_attribute *attr, void *user_data)
>  
>  	sprintf(handle, "%04hx", handle_num);
>  	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> -	sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%s", value_handle,
> +	sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02x:%s", value_handle,
>  							properties, uuid_str);

Wouldn't the right format specifier be %hhx in this case?

Johan
