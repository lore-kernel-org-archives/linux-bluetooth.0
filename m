Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415878033-6766-4-git-send-email-marcin.kraglak@tieto.com>
References: <1415878033-6766-1-git-send-email-marcin.kraglak@tieto.com>
	<1415878033-6766-4-git-send-email-marcin.kraglak@tieto.com>
Date: Fri, 14 Nov 2014 14:54:21 +0200
Message-ID: <CABBYNZKJYSu0Ms8au9dY-X4qhuVTuWSP6xi3S-vg_-8O3mfQyQ@mail.gmail.com>
Subject: Re: [RFC 03/11] unit/test-gatt: Fix not calling test step function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thu, Nov 13, 2014 at 1:27 PM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> ---
>  unit/test-gatt.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 39cdda3..8898762 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -323,6 +323,18 @@ static void compare_chars(const bt_gatt_characteristic_t *a,
>                 compare_descs(&a->descs[i], &b->descs[i]);
>  }
>
> +typedef void (*test_step_t)(struct context *context);
> +
> +struct test_step {
> +       test_step_t func;
> +       uint16_t handle;
> +       uint16_t end_handle;
> +       uint8_t uuid[16];
> +       uint8_t expected_att_ecode;
> +       const uint8_t *value;
> +       uint16_t length;
> +};
> +
>  static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
>  {
>         struct context *context = user_data;
> @@ -357,6 +369,13 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
>
>         g_assert(!bt_gatt_service_iter_next(&iter, &service));
>
> +       if (context->data->step) {
> +               const struct test_step *step = context->data->step;
> +
> +               step->func(context);
> +               return;
> +       }
> +
>         context_quit(context);
>  }
>
> @@ -453,16 +472,6 @@ static void execute_context(struct context *context)
>         destroy_context(context);
>  }
>
> -typedef void (*test_step_t)(struct context *context);
> -
> -struct test_step {
> -       test_step_t func;
> -       uint16_t handle;
> -       uint8_t expected_att_ecode;
> -       const uint8_t *value;
> -       uint16_t length;
> -};
> -
>  static void test_read_cb(bool success, uint8_t att_ecode,
>                                         const uint8_t *value, uint16_t length,
>                                         void *user_data)
> --
> 1.9.3

I went ahead and applied this one, next time please send fixes separately.


-- 
Luiz Augusto von Dentz
