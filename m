Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312474380.2158.21.camel@THOR>
References: <1312423146-99276-1-git-send-email-jaikumar@google.com> <1312474380.2158.21.camel@THOR>
From: Jaikumar Ganesh <jaikumar@google.com>
Date: Thu, 4 Aug 2011 14:37:35 -0700
Message-ID: <CAA8bQNjQ_U7FCLnVUcjB34Jr9brrDEVYx97JH08e81Y7TS=qMA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: bnep: Fix deadlock in session deletion.
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Aug 4, 2011 at 9:13 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On Wed, 2011-08-03 at 21:59 -0400, Jaikumar Ganesh wrote:
>> Commit f4d7cd4a4c25cb4a5c30a675d4cc0052c93b925a introduced
>> usage of <linux/kthread.h> API. kthread_stop is a blocking
>> function which returns only when the thread exits. In this
>> case, the thread couldn't exit because it was waiting to get
>> a write semaphore. bnep_del_connection function which calls
>> kthread_stop also held the read semaphore.
>>
>> Signed-off-by: Jaikumar Ganesh <jaikumar@google.com>
>> ---
>>  net/bluetooth/bnep/core.c |   47 ++++++++++++++++++++++++++------------------
>>  1 files changed, 28 insertions(+), 19 deletions(-)
>>
>> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
>> index eb8486f..f587b81 100644
>> --- a/net/bluetooth/bnep/core.c
>> +++ b/net/bluetooth/bnep/core.c
>> @@ -470,6 +470,31 @@ send:
>>       return len;
>>  }
>>
>> +static int cleanup_bnep_session(struct bnep_session *s)
>> +{
>> +     struct net_device *dev = s->dev;
>> +
>> +     /* Cleanup session */
>> +     down_write(&bnep_session_sem);
>> +
>> +     /* Delete network device */
>> +     unregister_netdev(dev);
>> +
>> +     /* Wakeup user-space polling for socket errors */
>> +     s->sock->sk->sk_err = EUNATCH;
>> +
>> +     wake_up_interruptible(sk_sleep(s->sock->sk));
>> +
>> +     /* Release the socket */
>> +     fput(s->sock->file);
>> +
>> +     __bnep_unlink_session(s);
>> +
>> +     up_write(&bnep_session_sem);
>> +     free_netdev(dev);
>> +     return 0;
>> +}
>> +
>>  static int bnep_session(void *arg)
>>  {
>>       struct bnep_session *s = arg;
>> @@ -511,25 +536,6 @@ static int bnep_session(void *arg)
>>       }
>>       __set_current_state(TASK_RUNNING);
>>       remove_wait_queue(sk_sleep(sk), &wait);
>> -
>> -     /* Cleanup session */
>> -     down_write(&bnep_session_sem);
>> -
>> -     /* Delete network device */
>> -     unregister_netdev(dev);
>> -
>> -     /* Wakeup user-space polling for socket errors */
>> -     s->sock->sk->sk_err = EUNATCH;
>> -
>> -     wake_up_interruptible(sk_sleep(s->sock->sk));
>> -
>> -     /* Release the socket */
>> -     fput(s->sock->file);
>> -
>> -     __bnep_unlink_session(s);
>> -
>> -     up_write(&bnep_session_sem);
>> -     free_netdev(dev);
>>       return 0;
>>  }
>
> This won't work because the session thread can exit itself (like if it
> discovers that the sk_state is no longer BT_CONNECTED).
>
>> @@ -651,6 +657,9 @@ int bnep_del_connection(struct bnep_conndel_req *req)
>>               err = -ENOENT;
>>
>>       up_read(&bnep_session_sem);
>> +
>> +     if (!err)
>> +             cleanup_bnep_session(s);
>
> Since the thread can exit itself, the session s may no longer be valid
> after the read lock is released.

I agree.

>
>>       return err;
>>  }
>>
>
> Does the patch below work for you?
>
> ---
>  net/bluetooth/bnep/bnep.h |    1 +
>  net/bluetooth/bnep/core.c |    9 +++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
> index 8e6c061..e7ee531 100644
> --- a/net/bluetooth/bnep/bnep.h
> +++ b/net/bluetooth/bnep/bnep.h
> @@ -155,6 +155,7 @@ struct bnep_session {
>        unsigned int  role;
>        unsigned long state;
>        unsigned long flags;
> +       atomic_t      terminate;
>        struct task_struct *task;
>
>        struct ethhdr eh;
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index 7e8ff3c..d9edfe8 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -487,7 +487,7 @@ static int bnep_session(void *arg)
>        while (1) {
>                set_current_state(TASK_INTERRUPTIBLE);
>
> -               if (kthread_should_stop())
> +               if (atomic_read(&s->terminate))
>                        break;
>                /* RX */
>                while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
> @@ -642,9 +642,10 @@ int bnep_del_connection(struct bnep_conndel_req
> *req)
>        down_read(&bnep_session_sem);
>
>        s = __bnep_get_session(req->dst);
> -       if (s)
> -               kthread_stop(s->task);
> -       else
> +       if (s) {
> +               atomic_inc(&s->terminate);
> +               wake_up_process(s->task);
> +       } else
>                err = -ENOENT;
>
>        up_read(&bnep_session_sem);
> --
> 1.7.4.1
>
>

The patch works fine.

Thanks
>
