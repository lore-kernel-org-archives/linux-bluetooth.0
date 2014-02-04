Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391514294-25337-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391514294-25337-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 4 Feb 2014 15:45:55 +0200
Message-ID: <CABBYNZ+faTa_quDagjhNkkCmqcZ2tjwojN9x0xgK8dSrjzn3eg@mail.gmail.com>
Subject: Re: [PATCH] unit/avctp: Add test TP/NFR/BV-03-C
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 4, 2014 at 1:44 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> The test verifies that IUT (TG) correctly reports the parameters of the
> incoming command in the handler callback.
> ---
>  unit/test-avctp.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/unit/test-avctp.c b/unit/test-avctp.c
> index c0d16a4..6d7e34a 100644
> --- a/unit/test-avctp.c
> +++ b/unit/test-avctp.c
> @@ -249,10 +249,35 @@ static void test_client(gconstpointer data)
>         execute_context(context);
>  }
>
> +static size_t handler(struct avctp *session,
> +                                       uint8_t transaction, uint8_t *code,
> +                                       uint8_t *subunit, uint8_t *operands,
> +                                       size_t operand_count, void *user_data)
> +{
> +       DBG("transaction %d code %d subunit %d operand_count %zu",
> +               transaction, *code, *subunit, operand_count);
> +
> +       g_assert_cmpint(transaction, ==, 0);
> +       g_assert_cmpint(*code, ==, 0);
> +       g_assert_cmpint(*subunit, ==, 0);
> +       g_assert_cmpint(operand_count, ==, 0);
> +
> +       return operand_count;
> +}
> +
>  static void test_server(gconstpointer data)
>  {
>         struct context *context = create_context(0x0100, data);
>
> +       if (g_str_equal(context->data->test_name, "/TP/NFR/BV-03-C")) {
> +               int ret;
> +
> +               ret = avctp_register_pdu_handler(context->session, 0x00,
> +                                                               handler, NULL);
> +               DBG("ret %d", ret);
> +               g_assert_cmpint(ret, !=, 0);
> +       }
> +
>         g_idle_add(send_pdu, context);
>
>         execute_context(context);
> @@ -284,6 +309,8 @@ int main(int argc, char *argv[])
>         define_test("/TP/CCM/BV-03-C", test_dummy, raw_pdu(0x00));
>         define_test("/TP/CCM/BV-04-C", test_dummy, raw_pdu(0x00));
>
> +       /* Non-Fragmented Messages tests */
> +
>         define_test("/TP/NFR/BV-01-C", test_client,
>                                 raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x00, 0x00));
>
> @@ -291,6 +318,10 @@ int main(int argc, char *argv[])
>                                 raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x00, 0x00),
>                                 raw_pdu(0x02, 0x11, 0x0e, 0x0a, 0x00, 0x00));
>
> +       define_test("/TP/NFR/BV-03-C", test_server,
> +                               raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x00, 0x00),
> +                               raw_pdu(0x02, 0x11, 0x0e, 0x00, 0x00, 0x00));
> +
>         define_test("/TP/NFR/BI-01-C", test_server,
>                                 raw_pdu(0x00, 0xff, 0xff, 0x00, 0x00, 0x00),
>                                 raw_pdu(0x03, 0xff, 0xff));
> --
> 1.8.3.2
>
> --

Applied, thanks.


-- 
Luiz Augusto von Dentz
