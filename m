Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414525067-15076-7-git-send-email-marcin.kraglak@tieto.com>
References: <1414525067-15076-1-git-send-email-marcin.kraglak@tieto.com>
	<1414525067-15076-7-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 28 Oct 2014 17:40:46 -0700
Message-ID: <CAHrH25T-96W_RRsZWgJaa+GxmchYGymUPAqg1kS=UFj2=TeUcQ@mail.gmail.com>
Subject: Re: [PATCHv2 7/7] unit/test-gatt: Add search characteristics test case
From: Arman Uguray <armansito@chromium.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tue, Oct 28, 2014 at 12:37 PM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> ---
>  unit/test-gatt.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 3ee9460..27471ea 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -270,6 +270,17 @@ static void primary_cb(bool success, uint8_t att_ecode,
>         context_quit(context);
>  }
>
> +static void characteristic_cb(bool success, uint8_t att_ecode,
> +                                               struct bt_gatt_result *result,
> +                                               void *user_data)
> +{
> +       struct context *context = user_data;
> +
> +       g_assert(success);
> +
> +       context_quit(context);
> +}
> +
>  static void included_cb(bool success, uint8_t att_ecode,
>                                                 struct bt_gatt_result *result,
>                                                 void *user_data)
> @@ -332,6 +343,17 @@ static void test_search_included(gconstpointer data)
>         execute_context(context);
>  }
>
> +static void test_search_chars(gconstpointer data)
> +{
> +       struct context *context = create_context(512, data);
> +
> +       g_assert(bt_gatt_discover_characteristics(context->att, 0x0010, 0x0020,
> +                                               characteristic_cb, context,
> +                                               NULL));

It's good that we're adding test cases using gatt-helpers. Are you
going to add a CLIENT case as well? It would be good to at least have
a test case where we initialize bt_gatt_client and use the iterators
to verify all the services, characteristics, etc. were cached
correctly.

> +
> +       execute_context(context);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         g_test_init(&argc, &argv, NULL);
> @@ -413,5 +435,19 @@ int main(int argc, char *argv[])
>                         raw_pdu(0x08, 0x06, 0x00, 0xff, 0xff, 0x02, 0x28),
>                         raw_pdu(0x01, 0x08, 0x06, 0x00, 0x0a));
>
> +       define_test("/TP/GAD/CL/BV-04-C", test_search_chars, ATT, NULL,
> +                       raw_pdu(0x02, 0x00, 0x02),
> +                       raw_pdu(0x03, 0x00, 0x02),
> +                       raw_pdu(0x08, 0x10, 0x00, 0x20, 0x00, 0x03, 0x28),
> +                       raw_pdu(0x09, 0x07, 0x11, 0x00, 02, 0x12, 0x00, 0x25,
> +                                       0x2a),
> +                       raw_pdu(0x08, 0x12, 0x00, 0x20, 0x00, 0x03, 0x28),
> +                       raw_pdu(0x09, 0x15, 0x13, 0x00, 0x02, 0x14, 0x00, 0x85,
> +                                       0x00, 0xef, 0xcd, 0xab, 0x89, 0x67,
> +                                       0x45, 0x23, 0x01, 0x00, 0x00, 0x00,
> +                                       0x00, 0x00, 0x00),
> +                       raw_pdu(0x08, 0x14, 0x00, 0x20, 0x00, 0x03, 0x28),
> +                       raw_pdu(0x01, 0x08, 0x12, 0x00, 0x0a));
> +
>         return g_test_run();
>  }
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
Arman
