Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1473326960-18003-1-git-send-email-marcin.kraglak@tieto.com>
References: <1473326960-18003-1-git-send-email-marcin.kraglak@tieto.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Sep 2016 17:47:35 +0300
Message-ID: <CABBYNZ+LhaAkX==LySdObw6+D5G3iswoSkH6eZ2ndWhqvEgL6A@mail.gmail.com>
Subject: Re: [PATCH] core/device: Fix using not initialised uuid value.
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thu, Sep 8, 2016 at 12:29 PM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> ---
>  src/device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/device.c b/src/device.c
> index 9586022..788554a 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2058,6 +2058,7 @@ static void store_incl(struct gatt_db_attribute *attr, void *user_data)
>
>         sprintf(handle, "%04hx", handle_num);
>
> +       gatt_db_attribute_get_service_uuid(service, &uuid);
>         bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
>         sprintf(value, GATT_INCLUDE_UUID_STR ":%04hx:%04hx:%s", start,
>                                                                 end, uuid_str);
> --
> 2.5.5

Applied, thanks.

-- 
Luiz Augusto von Dentz
