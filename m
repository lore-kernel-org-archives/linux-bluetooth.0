Return-Path: <cyrus@holtmann.org>
Message-ID: <53AD3126.3060909@message-id.googlemail.com>
Date: Fri, 27 Jun 2014 10:53:58 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH BlueZ 3/5] unit/test-queue: Add /queue/foreach_remove_all
 test
References: <1400754843-4759-1-git-send-email-luiz.dentz@gmail.com> <1400754843-4759-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1400754843-4759-3-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Am 22.05.2014 12:34, schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This tests queue_remove_all from queue_foreach callback.

this test is broken. It always fails.

export MALLOC_CHECK_=3
export MALLOC_PERTURB_=69

seife@susi:/local/seife/src/git-repos/bluez-git> unit/test-queue 
/queue/basic: OK
/queue/foreach_destroy: OK
/queue/foreach_remove_all: Segmentation fault

in gdb:

/queue/basic: OK
/queue/foreach_destroy: OK
/queue/foreach_remove_all: 
Program received signal SIGSEGV, Segmentation fault.
queue_foreach (queue=0x55555575a140, function=0x555555554b20 <foreach_remove_all>, user_data=0x55555575a140)
    at src/shared/queue.c:206
206                     entry = tmp->next;
(gdb) bt
#0  queue_foreach (queue=0x55555575a140, function=0x555555554b20 <foreach_remove_all>, 
    user_data=0x55555575a140) at src/shared/queue.c:206
#1  0x00007ffff7b408f1 in test_case_run (tc=0x55555575a260) at gtestutils.c:2059
#2  g_test_run_suite_internal (suite=suite@entry=0x555555759840, path=path@entry=0x7ffff7b96d5e "")
    at gtestutils.c:2120
#3  0x00007ffff7b40ab6 in g_test_run_suite_internal (suite=suite@entry=0x555555759820, 
    path=path@entry=0x7ffff7b96d5e "") at gtestutils.c:2131
#4  0x00007ffff7b40e0b in g_test_run_suite (suite=0x555555759820) at gtestutils.c:2184
#5  0x00007ffff7b40e41 in g_test_run () at gtestutils.c:1488
#6  0x00005555555549fb in main (argc=1, argv=0x7fffffffdae8) at unit/test-queue.c:109
(gdb) print tmp
$1 = (struct queue_entry *) 0x4545454545454545
(gdb) 


I noticed the build failing after trying to update openSUSE
Factory to bluez 5.20 and bisected the problem to this test.

For now I disabled the test in the openSUSE package.

Best regards,

	Stefan

> ---
>  unit/test-queue.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/unit/test-queue.c b/unit/test-queue.c
> index 55273e3..af7dfd3 100644
> --- a/unit/test-queue.c
> +++ b/unit/test-queue.c
> @@ -78,12 +78,33 @@ static void test_foreach_destroy(void)
>  	queue_foreach(queue, foreach_destroy, queue);
>  }
>  
> +static void foreach_remove_all(void *data, void *user_data)
> +{
> +	struct queue *queue = user_data;
> +
> +	queue_remove_all(queue, NULL, NULL, NULL);
> +}
> +
> +static void test_foreach_remove_all(void)
> +{
> +	struct queue *queue;
> +
> +	queue = queue_new();
> +	g_assert(queue != NULL);
> +
> +	queue_push_tail(queue, UINT_TO_PTR(1));
> +	queue_push_tail(queue, UINT_TO_PTR(2));
> +
> +	queue_foreach(queue, foreach_remove_all, queue);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	g_test_init(&argc, &argv, NULL);
>  
>  	g_test_add_func("/queue/basic", test_basic);
>  	g_test_add_func("/queue/foreach_destroy", test_foreach_destroy);
> +	g_test_add_func("/queue/foreach_remove_all", test_foreach_remove_all);
>  
>  	return g_test_run();
>  }

-- 
Stefan Seyfried
Linux Consultant & Developer -- GPG Key: 0x731B665B

B1 Systems GmbH
Osterfeldstraße 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537
