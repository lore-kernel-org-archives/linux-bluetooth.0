Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424178265-22175-1-git-send-email-luiz.dentz@gmail.com>
References: <1424178265-22175-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 18 Feb 2015 10:38:12 +0200
Message-ID: <CABBYNZJsA6AfAeEedK9JqVX7Z2JeYs_HrWgdtVSTU58tD-zmGQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/tester: Return failure if any test failed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Feb 17, 2015 at 3:04 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes sure tester can be used for unit tests that requires proper
> return in case of failure.
> ---
>  src/shared/tester.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/tester.c b/src/shared/tester.c
> index fb645a0..ffcc2ea 100644
> --- a/src/shared/tester.c
> +++ b/src/shared/tester.c
> @@ -270,7 +270,7 @@ void *tester_get_data(void)
>         return test->user_data;
>  }
>
> -static void tester_summarize(void)
> +static int tester_summarize(void)
>  {
>         unsigned int not_run = 0, passed = 0, failed = 0;
>         gdouble execution_time;
> @@ -321,6 +321,7 @@ static void tester_summarize(void)
>         execution_time = g_timer_elapsed(test_timer, NULL);
>         printf("Overall execution time: %.3g seconds\n", execution_time);
>
> +       return failed;
>  }
>
>  static gboolean teardown_callback(gpointer user_data)
> @@ -800,6 +801,7 @@ void tester_init(int *argc, char ***argv)
>  int tester_run(void)
>  {
>         guint signal;
> +       int ret;
>
>         if (!main_loop)
>                 return EXIT_FAILURE;
> @@ -818,9 +820,9 @@ int tester_run(void)
>
>         g_main_loop_unref(main_loop);
>
> -       tester_summarize();
> +       ret = tester_summarize();
>
>         g_list_free_full(test_list, test_destroy);
>
> -       return EXIT_SUCCESS;
> +       return ret == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
>  }
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz
