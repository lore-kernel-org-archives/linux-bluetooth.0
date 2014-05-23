Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1400760182-16836-1-git-send-email-luiz.dentz@gmail.com>
References: <1400760182-16836-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 23 May 2014 16:51:11 +0300
Message-ID: <CABBYNZKQS46FO2KQTDwp=YeWQuKmnLFc=Mmq1z6CwJAB_5FNEQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/5] unit/test-queue: Add /queue/foreach_destroy test
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 22, 2014 at 3:02 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This tests queue_destroy from queue_foreach callback.
> ---
> v2: Fix patch 4/5: queue_find cannot be used for entries nodes.
>
>  unit/test-queue.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/unit/test-queue.c b/unit/test-queue.c
> index 7c6d2ad..55273e3 100644
> --- a/unit/test-queue.c
> +++ b/unit/test-queue.c
> @@ -58,11 +58,32 @@ static void test_basic(void)
>         queue_destroy(queue, NULL);
>  }
>
> +static void foreach_destroy(void *data, void *user_data)
> +{
> +       struct queue *queue = user_data;
> +
> +       queue_destroy(queue, NULL);
> +}
> +
> +static void test_foreach_destroy(void)
> +{
> +       struct queue *queue;
> +
> +       queue = queue_new();
> +       g_assert(queue != NULL);
> +
> +       queue_push_tail(queue, UINT_TO_PTR(1));
> +       queue_push_tail(queue, UINT_TO_PTR(2));
> +
> +       queue_foreach(queue, foreach_destroy, queue);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         g_test_init(&argc, &argv, NULL);
>
>         g_test_add_func("/queue/basic", test_basic);
> +       g_test_add_func("/queue/foreach_destroy", test_foreach_destroy);
>
>         return g_test_run();
>  }
> --
> 1.9.0

Pushed.


-- 
Luiz Augusto von Dentz
