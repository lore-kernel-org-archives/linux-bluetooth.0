Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1392142591-10150-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1392142591-10150-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Wed, 12 Feb 2014 11:53:50 +0200
Message-ID: <CABBYNZ+ESeXaez9yFL-f1dEKawzGaF4rs3YPpCrq6VZZr8A2gQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] unit: Fix memory leaks in gobex tests
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Tue, Feb 11, 2014 at 8:16 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> ---
>  unit/test-gobex-apparam.c  |    2 ++
>  unit/test-gobex-transfer.c |    2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/unit/test-gobex-apparam.c b/unit/test-gobex-apparam.c
> index e6a42cc..976c541 100644
> --- a/unit/test-gobex-apparam.c
> +++ b/unit/test-gobex-apparam.c
> @@ -250,6 +250,8 @@ static void test_apparam_get_multi(void)
>         g_assert(string != NULL);
>         g_assert_cmpstr(string, ==, "ABC");
>
> +       g_free(string);
> +
>         g_obex_apparam_free(apparam);
>  }
>
> diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
> index 128a467..7c9fd43 100644
> --- a/unit/test-gobex-transfer.c
> +++ b/unit/test-gobex-transfer.c
> @@ -511,6 +511,7 @@ static void test_stream_put_req_abort(void)
>         g_obex_unref(obex);
>
>         g_assert_error(d.err, G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED);
> +       g_error_free(d.err);
>  }
>
>  static void test_stream_put_rsp_abort(void)
> @@ -556,6 +557,7 @@ static void test_stream_put_rsp_abort(void)
>         g_obex_unref(obex);
>
>         g_assert_error(d.err, G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED);
> +       g_error_free(d.err);
>  }
>
>  static void handle_put_seq_wait(GObex *obex, GObexPacket *req,
> --
> 1.7.9.5

Applied, thanks.


-- 
Luiz Augusto von Dentz
