Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Sep 2013 14:01:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/3] Bluetooth: Fix waiting for clearing of BT_SK_SUSPEND
 flag
Message-ID: <20130913110125.GB15267@x220.p-661hnu-f1>
References: <1379061827-8595-1-git-send-email-johan.hedberg@gmail.com>
 <1379061827-8595-4-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_Pp87adXrnBEysFd99V+=cyXZmc65cF4MGJTQNHMyz90g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_Pp87adXrnBEysFd99V+=cyXZmc65cF4MGJTQNHMyz90g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Sep 13, 2013, Anderson Lizardo wrote:
> On Fri, Sep 13, 2013 at 4:43 AM,  <johan.hedberg@gmail.com> wrote:
> > +int bt_sock_wait_unsuspend(struct sock *sk, unsigned long flags)
> > +{
> > +       DECLARE_WAITQUEUE(wait, current);
> > +       unsigned long timeo;
> > +       int err = 0;
> > +
> > +       BT_DBG("sk %p", sk);
> > +
> > +       timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
> > +
> > +       add_wait_queue(sk_sleep(sk), &wait);
> > +       set_current_state(TASK_INTERRUPTIBLE);
> > +       while (test_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags)) {
> > +               if (!timeo) {
> > +                       err = -EAGAIN;
> > +                       break;
> > +               }
> > +
> > +               if (signal_pending(current)) {
> > +                       err = sock_intr_errno(timeo);
> > +                       break;
> > +               }
> > +
> > +               release_sock(sk);
> > +               timeo = schedule_timeout(timeo);
> > +               lock_sock(sk);
> > +               set_current_state(TASK_INTERRUPTIBLE);
> > +
> > +               err = sock_error(sk);
> > +               if (err)
> > +                       break;
> > +       }
> > +       __set_current_state(TASK_RUNNING);
> > +       remove_wait_queue(sk_sleep(sk), &wait);
> > +       return err;
> > +}
> 
> You can add a blank line before "return err" for slightly better legibility.

Sure. The reason it's not there is that I followed the existing similar
bt_sock_wait_state function implementation.

> > @@ -559,9 +559,12 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> >
> >         lock_sock(sk);
> >
> > +       err = bt_sock_wait_unsuspend(sk, msg->msg_flags);
> > +       if (err)
> > +               return err;
> > +
> 
> Is it okay to return without releasing the lock?

Nope, I'm pretty sure that's a bug. Good catch, I'll fix in a v2.

Johan
