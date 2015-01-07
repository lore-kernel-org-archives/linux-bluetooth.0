Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1420647963-5469-1-git-send-email-szymon.janc@tieto.com>
References: <1420647963-5469-1-git-send-email-szymon.janc@tieto.com>
Date: Wed, 7 Jan 2015 20:38:44 -0200
Message-ID: <CABBYNZ+j52_K0cE22VTbRWU_gcbTPhwJ8G+UoFuSSuu4fNgZyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] unit/test-queue: Extend /queue/remove_all with NULL
 data checks
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jan 7, 2015 at 2:26 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> queue_remove_all should correctly handle NULL data.
> ---
>  unit/test-queue.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/unit/test-queue.c b/unit/test-queue.c
> index 15c79bd..12319b0 100644
> --- a/unit/test-queue.c
> +++ b/unit/test-queue.c
> @@ -222,6 +222,11 @@ static bool match_int(const void *a, const void *b)
>         return i == j;
>  }
>
> +static bool match_ptr(const void *a, const void *b)
> +{
> +       return a == b;
> +}
> +
>  static void test_remove_all(void)
>  {
>         struct queue *queue;
> @@ -234,6 +239,14 @@ static void test_remove_all(void)
>         g_assert(queue_remove_all(queue, match_int, INT_TO_PTR(10), NULL) == 1);
>         g_assert(queue_isempty(queue));
>
> +       g_assert(queue_push_tail(queue, NULL));
> +       g_assert(queue_remove_all(queue, match_ptr, NULL, NULL) == 1);
> +       g_assert(queue_isempty(queue));
> +
> +       g_assert(queue_push_tail(queue, UINT_TO_PTR(0)));
> +       g_assert(queue_remove_all(queue, match_int, UINT_TO_PTR(0), NULL) == 1);
> +       g_assert(queue_isempty(queue));
> +
>         queue_destroy(queue, NULL);
>  }
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
