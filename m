Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391521658-28893-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391521658-28893-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 5 Feb 2014 13:40:07 +0200
Message-ID: <CABBYNZLutDMC++6hZUv10qjs9Fdza4oFkLnEzck+d4f5EDNGTg@mail.gmail.com>
Subject: Re: [PATCH] unit/avctp: Add TP/NFR/BV-04-C test
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 4, 2014 at 3:47 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Add test TP/NFR/BV-04-C for AVCTP.
> ---
>  unit/test-avctp.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
>
> diff --git a/unit/test-avctp.c b/unit/test-avctp.c
> index 6d7e34a..581f88c 100644
> --- a/unit/test-avctp.c
> +++ b/unit/test-avctp.c
> @@ -240,15 +240,6 @@ static void execute_context(struct context *context)
>         destroy_context(context);
>  }
>
> -static void test_client(gconstpointer data)
> -{
> -       struct context *context = create_context(0x0100, data);
> -
> -       avctp_send_vendordep_req(context->session, 0, 0, NULL, 0, NULL, NULL);
> -
> -       execute_context(context);
> -}
> -
>  static size_t handler(struct avctp *session,
>                                         uint8_t transaction, uint8_t *code,
>                                         uint8_t *subunit, uint8_t *operands,
> @@ -265,6 +256,33 @@ static size_t handler(struct avctp *session,
>         return operand_count;
>  }
>
> +static gboolean handler_response(struct avctp *session,
> +                                       uint8_t code, uint8_t subunit,
> +                                       uint8_t *operands, size_t operand_count,
> +                                       void *user_data)
> +{
> +       struct context *context = user_data;
> +
> +       DBG("code 0x%02x subunit %d operand_count %zu", code, subunit,
> +                                                               operand_count);
> +
> +       g_assert_cmpint(code, ==, 0x0a);
> +       g_assert_cmpint(subunit, ==, 0);
> +       g_assert_cmpint(operand_count, ==, 0);
> +
> +       return context_quit(context);
> +}
> +
> +static void test_client(gconstpointer data)
> +{
> +       struct context *context = create_context(0x0100, data);
> +
> +       avctp_send_vendordep_req(context->session, 0, 0, NULL, 0,
> +                                               handler_response, context);
> +
> +       execute_context(context);
> +}
> +
>  static void test_server(gconstpointer data)
>  {
>         struct context *context = create_context(0x0100, data);
> @@ -322,6 +340,10 @@ int main(int argc, char *argv[])
>                                 raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x00, 0x00),
>                                 raw_pdu(0x02, 0x11, 0x0e, 0x00, 0x00, 0x00));
>
> +       define_test("/TP/NFR/BV-04-C", test_client,
> +                               raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x00, 0x00),
> +                               raw_pdu(0x02, 0x11, 0x0e, 0x0a, 0x00, 0x00));
> +
>         define_test("/TP/NFR/BI-01-C", test_server,
>                                 raw_pdu(0x00, 0xff, 0xff, 0x00, 0x00, 0x00),
>                                 raw_pdu(0x03, 0xff, 0xff));
> --
> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
