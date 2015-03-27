Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427446194-5646-1-git-send-email-luiz.dentz@gmail.com>
References: <1427446194-5646-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 27 Mar 2015 16:36:41 +0200
Message-ID: <CABBYNZKTahGAsP4fn9OxZwc9qih9S2Q8tsbm56spAs4XxV7MzA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] unit/test-avctp: Remove DBG calls
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 27, 2015 at 10:49 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  unit/test-avctp.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/unit/test-avctp.c b/unit/test-avctp.c
> index ce52222..689a825 100644
> --- a/unit/test-avctp.c
> +++ b/unit/test-avctp.c
> @@ -220,9 +220,6 @@ static ssize_t handler(struct avctp *session,
>                                         uint8_t *subunit, uint8_t *operands,
>                                         size_t operand_count, void *user_data)
>  {
> -       DBG("transaction %d code %d subunit %d operand_count %zu",
> -               transaction, *code, *subunit, operand_count);
> -
>         g_assert_cmpint(transaction, ==, 0);
>         g_assert_cmpint(*code, ==, 0);
>         g_assert_cmpint(*subunit, ==, 0);
> @@ -238,9 +235,6 @@ static gboolean handler_response(struct avctp *session,
>  {
>         struct context *context = user_data;
>
> -       DBG("code 0x%02x subunit %d operand_count %zu", code, subunit,
> -                                                               operand_count);
> -
>         g_assert_cmpint(code, ==, 0x0a);
>         g_assert_cmpint(subunit, ==, 0);
>         g_assert_cmpint(operand_count, ==, 0);
> @@ -265,7 +259,6 @@ static void test_server(gconstpointer data)
>
>                 ret = avctp_register_pdu_handler(context->session,
>                                         AVC_OP_VENDORDEP, handler, NULL);
> -               DBG("ret %d", ret);
>                 g_assert_cmpint(ret, !=, 0);
>         }
>
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz
