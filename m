Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1379061827-8595-4-git-send-email-johan.hedberg@gmail.com>
References: <1379061827-8595-1-git-send-email-johan.hedberg@gmail.com>
	<1379061827-8595-4-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 13 Sep 2013 06:41:05 -0400
Message-ID: <CAJdJm_Pp87adXrnBEysFd99V+=cyXZmc65cF4MGJTQNHMyz90g@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Fix waiting for clearing of BT_SK_SUSPEND flag
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Sep 13, 2013 at 4:43 AM,  <johan.hedberg@gmail.com> wrote:
> +int bt_sock_wait_unsuspend(struct sock *sk, unsigned long flags)
> +{
> +       DECLARE_WAITQUEUE(wait, current);
> +       unsigned long timeo;
> +       int err = 0;
> +
> +       BT_DBG("sk %p", sk);
> +
> +       timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
> +
> +       add_wait_queue(sk_sleep(sk), &wait);
> +       set_current_state(TASK_INTERRUPTIBLE);
> +       while (test_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags)) {
> +               if (!timeo) {
> +                       err = -EAGAIN;
> +                       break;
> +               }
> +
> +               if (signal_pending(current)) {
> +                       err = sock_intr_errno(timeo);
> +                       break;
> +               }
> +
> +               release_sock(sk);
> +               timeo = schedule_timeout(timeo);
> +               lock_sock(sk);
> +               set_current_state(TASK_INTERRUPTIBLE);
> +
> +               err = sock_error(sk);
> +               if (err)
> +                       break;
> +       }
> +       __set_current_state(TASK_RUNNING);
> +       remove_wait_queue(sk_sleep(sk), &wait);
> +       return err;
> +}

You can add a blank line before "return err" for slightly better legibility.

> @@ -559,9 +559,12 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
>
>         lock_sock(sk);
>
> +       err = bt_sock_wait_unsuspend(sk, msg->msg_flags);
> +       if (err)
> +               return err;
> +

Is it okay to return without releasing the lock?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
