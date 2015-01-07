Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1420645810-20081-1-git-send-email-szymon.janc@tieto.com>
References: <1420645810-20081-1-git-send-email-szymon.janc@tieto.com>
Date: Wed, 7 Jan 2015 14:08:52 -0200
Message-ID: <CABBYNZKZ_YQCN+rPFjwUr1YaE+52N-O9-xNvWwinWvqYi-gUbw@mail.gmail.com>
Subject: Re: [PATCH 1/2] unit/test-queue: Add /queue/remove_all test
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jan 7, 2015 at 1:50 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> This test verify that queue_remove_all propertly sets entries count.
> ---
>  unit/test-queue.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/unit/test-queue.c b/unit/test-queue.c
> index cb85605..15c79bd 100644
> --- a/unit/test-queue.c
> +++ b/unit/test-queue.c
> @@ -214,6 +214,29 @@ static void test_push_after(void)
>         queue_destroy(queue, NULL);
>  }
>
> +static bool match_int(const void *a, const void *b)
> +{
> +       int i = PTR_TO_INT(a);
> +       int j = PTR_TO_INT(b);
> +
> +       return i == j;
> +}
> +
> +static void test_remove_all(void)
> +{
> +       struct queue *queue;
> +
> +       queue = queue_new();
> +       g_assert(queue != NULL);
> +
> +       g_assert(queue_push_tail(queue, INT_TO_PTR(10)));
> +
> +       g_assert(queue_remove_all(queue, match_int, INT_TO_PTR(10), NULL) == 1);
> +       g_assert(queue_isempty(queue));
> +
> +       queue_destroy(queue, NULL);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         g_test_init(&argc, &argv, NULL);
> @@ -226,6 +249,7 @@ int main(int argc, char *argv[])
>                                                 test_foreach_remove_backward);
>         g_test_add_func("/queue/destroy_remove", test_destroy_remove);
>         g_test_add_func("/queue/push_after", test_push_after);
> +       g_test_add_func("/queue/remove_all", test_remove_all);
>
>         return g_test_run();
>  }
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
