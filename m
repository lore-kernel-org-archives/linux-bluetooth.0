Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/3] android/gatt: Move element_id creation helpers up
Date: Tue, 01 Apr 2014 13:49:37 +0200
Message-ID: <1752823.r1c4TL7u1F@uw000953>
In-Reply-To: <1396339404-14418-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396339404-14418-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ho Jakub,

On Tuesday 01 of April 2014 10:03:22 Jakub Tyszkowski wrote:
> This helpers should be in one place, in file's upper part.
> ---
>  android/gatt.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 61746b1..39195f0 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -135,6 +135,20 @@ static void uuid2android(const bt_uuid_t *src, uint8_t *uuid)
>  		uuid[15 - i] = src->value.u128.data[i];
>  }
>  
> +static void hal_srvc_id_to_element_id(const struct hal_gatt_srvc_id *from,
> +							struct element_id *to)
> +{
> +	to->instance = from->inst_id;
> +	android2uuid(from->uuid, &to->uuid);
> +}
> +
> +static void hal_gatt_id_to_element_id(const struct hal_gatt_gatt_id *from,
> +							struct element_id *to)
> +{
> +	to->instance = from->inst_id;
> +	android2uuid(from->uuid, &to->uuid);
> +}
> +
>  static void destroy_service(void *data)
>  {
>  	struct service *srvc = data;
> @@ -256,13 +270,6 @@ static bool match_char_by_element_id(const void *data, const void *user_data)
>  	return false;
>  }
>  
> -static void hal_gatt_id_to_element_id(const struct hal_gatt_gatt_id *from,
> -							struct element_id *to)
> -{
> -	to->instance = from->inst_id;
> -	android2uuid(from->uuid, &to->uuid);
> -}
> -
>  static void destroy_notification(void *data)
>  {
>  	struct notification_data *notification = data;
> @@ -1268,13 +1275,6 @@ static void discover_char_cb(uint8_t status, GSList *characteristics,
>  	free(data);
>  }
>  
> -static void hal_srvc_id_to_element_id(const struct hal_gatt_srvc_id *from,
> -							struct element_id *to)
> -{
> -	to->instance = from->inst_id;
> -	android2uuid(from->uuid, &to->uuid);
> -}
> -
>  static bool find_service(int32_t conn_id, struct element_id *service_id,
>  				struct gatt_device **dev, struct service **srvc)
>  {
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
