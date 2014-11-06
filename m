Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415278034-19223-1-git-send-email-marcin.kraglak@tieto.com>
References: <1415278034-19223-1-git-send-email-marcin.kraglak@tieto.com>
Date: Thu, 6 Nov 2014 17:43:37 +0200
Message-ID: <CABBYNZJfo+6ornwsBvJKYXLUf-Wt3hop7ZimD-EjE_8OuN5tKA@mail.gmail.com>
Subject: Re: [PATCH 1/9] unit/test-gatt: Use one generic search callback
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thu, Nov 6, 2014 at 2:47 PM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> In these callbacks only success is verified, so there is no need to
> duplicate them.
> ---
>  unit/test-gatt.c | 34 +++++++---------------------------
>  1 file changed, 7 insertions(+), 27 deletions(-)
>
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 27471ea..f343fe6 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -259,29 +259,7 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
>         return context;
>  }
>
> -static void primary_cb(bool success, uint8_t att_ecode,
> -                                               struct bt_gatt_result *result,
> -                                               void *user_data)
> -{
> -       struct context *context = user_data;
> -
> -       g_assert(success);
> -
> -       context_quit(context);
> -}
> -
> -static void characteristic_cb(bool success, uint8_t att_ecode,
> -                                               struct bt_gatt_result *result,
> -                                               void *user_data)
> -{
> -       struct context *context = user_data;
> -
> -       g_assert(success);
> -
> -       context_quit(context);
> -}
> -
> -static void included_cb(bool success, uint8_t att_ecode,
> +static void generic_search_cb(bool success, uint8_t att_ecode,
>                                                 struct bt_gatt_result *result,
>                                                 void *user_data)
>  {
> @@ -328,7 +306,8 @@ static void test_search_primary(gconstpointer data)
>         const struct test_data *test_data = data;
>
>         bt_gatt_discover_all_primary_services(context->att, test_data->uuid,
> -                                               primary_cb, context, NULL);
> +                                                       generic_search_cb,
> +                                                       context, NULL);
>
>         execute_context(context);
>  }
> @@ -338,7 +317,8 @@ static void test_search_included(gconstpointer data)
>         struct context *context = create_context(512, data);
>
>         bt_gatt_discover_included_services(context->att, 0x0001, 0xffff,
> -                                               included_cb, context, NULL);
> +                                                       generic_search_cb,
> +                                                       context, NULL);
>
>         execute_context(context);
>  }
> @@ -348,8 +328,8 @@ static void test_search_chars(gconstpointer data)
>         struct context *context = create_context(512, data);
>
>         g_assert(bt_gatt_discover_characteristics(context->att, 0x0010, 0x0020,
> -                                               characteristic_cb, context,
> -                                               NULL));
> +                                                       generic_search_cb,
> +                                                       context, NULL));
>
>         execute_context(context);
>  }
> --
> 1.9.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
