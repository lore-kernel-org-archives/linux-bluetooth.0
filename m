Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1402569825-27168-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402569825-27168-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 12 Jun 2014 13:05:45 +0200
Message-ID: <CABD6X-+BNF20ghcnuSnJSRByhtzCNrNK+NRKym2SSkZ5xFWUpw@mail.gmail.com>
Subject: Re: [PATCH] android/gatt: Fix wrong initial value
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On 12 June 2014 12:43, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Initialize value_len to -1 since otherwise check value_len >= 0 does not
> make sense.
> ---
>  android/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index 8da77d0..8260a8d 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4147,7 +4147,7 @@ static void read_requested_attributes(void *data, void *user_data)
>         struct request_processing_data *process_data = user_data;
>         uint32_t permissions;
>         uint8_t *value, error;
> -       int value_len = 0;
> +       int value_len = -1;

What will happen if check_device_permissions will fail?
>
>         if (!gatt_db_get_attribute_permissions(gatt_db, resp_data->handle,
>                                                                 &permissions)) {
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

BR
Marcin
