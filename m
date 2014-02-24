Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1393248318-5188-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393248318-5188-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 24 Feb 2014 18:17:29 +0200
Message-ID: <CABBYNZ+OmDt7QUaYf0ffv3cz-f-mM8Q1yjp7sKX=KZnXLUpj+Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] unit/avrcp: Refactor tests to use destroy_context()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Feb 24, 2014 at 3:25 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  unit/test-avrcp.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index 381e7cb..e9fe7e3 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -246,15 +246,7 @@ static void execute_context(struct context *context)
>  {
>         g_main_loop_run(context->main_loop);
>
> -       if (context->source > 0)
> -               g_source_remove(context->source);
> -
> -       avrcp_shutdown(context->session);
> -
> -       g_main_loop_unref(context->main_loop);
> -
> -       test_free(context->data);
> -       g_free(context);
> +       destroy_context(context);
>  }
>
>  static void test_server(gconstpointer data)
> --
> 1.8.3.2

Pushed with some changes to patch 2/3 to actually add a callback to
handle AVC_PLAY.


-- 
Luiz Augusto von Dentz
