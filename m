Return-Path: <nish.aravamudan@gmail.com>
Message-ID: <29495f1d05012210441655fa20@mail.gmail.com>
Date: Sat, 22 Jan 2005 10:44:20 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [KJ] Re: [UPDATE PATCH 18/39] net/core: use wait_event_timeout()
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, kernel-janitors@lists.osdl.org,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Max Krasnyansky <maxk@qualcomm.com>
In-Reply-To: <1106416648.8118.3.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20050120235123.GG2600@us.ibm.com>
	 <1106267534.7955.36.camel@pegasus> <20050121190909.GD3340@us.ibm.com>
	 <1106416648.8118.3.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Sat, 22 Jan 2005 18:57:28 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nishanth,
> 
> > Description: Use wait_event_timeout() instead of custom wait-queue code.
> > The current code uses TASK_INTERRUPTIBLE but only cares about timing out and the
> > wq event taking place (does not actively do anything in response to signals), so
> > wait_event_timeout() should be ok.
> >
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> >
> >
> > --- 2.6.11-rc1-kj-v/net/bluetooth/hidp/core.c 2005-01-15 16:55:44.000000000 -0800
> > +++ 2.6.11-rc1-kj/net/bluetooth/hidp/core.c   2005-01-21 11:07:11.000000000 -0800
> > @@ -36,6 +36,7 @@
> >  #include <linux/ioctl.h>
> >  #include <linux/file.h>
> >  #include <linux/init.h>
> > +#include <linux/wait.h>
> >  #include <net/sock.h>
> >
> >  #include <linux/input.h>
> > @@ -325,7 +326,6 @@ static int hidp_session(void *arg)
> >       struct sk_buff *skb;
> >       int vendor = 0x0000, product = 0x0000;
> >       wait_queue_t ctrl_wait, intr_wait;
> > -     unsigned long timeo = HZ;
> >
> >       BT_DBG("session %p", session);
> >
> > @@ -370,28 +370,14 @@ static int hidp_session(void *arg)
> >
> >       hidp_del_timer(session);
> >
> > -     if (intr_sk->sk_state != BT_CONNECTED) {
> > -             init_waitqueue_entry(&ctrl_wait, current);
> > -             add_wait_queue(ctrl_sk->sk_sleep, &ctrl_wait);
> > -             while (timeo && ctrl_sk->sk_state != BT_CLOSED) {
> > -                     set_current_state(TASK_INTERRUPTIBLE);
> > -                     timeo = schedule_timeout(timeo);
> > -             }
> > -             set_current_state(TASK_RUNNING);
> > -             remove_wait_queue(ctrl_sk->sk_sleep, &ctrl_wait);
> > -             timeo = HZ;
> > -     }
> > +     if (intr_sk->sk_state != BT_CONNECTED)
> > +             wait_event_timeout(*(ctrl_sk->sk_sleep),
> > +                             (ctrl_sk->sk_state == BT_CLOSED), HZ);
> 
> and this does not make it look better. For me this is too much pointer
> stuff here. I think the interface of wait_event_timeout() is wrong. It
> should take a pointer to wait_queue_head_t.

Maybe; I'm not the designer of the interface, though, so I was just
trying to use what exists. To be honest, this particular driver is the
*only* one of a good number I've tried to convert that has this issue.
Everywhere else, {add,remove}_wait_queue() is called like so:

{add,remove}_wait_queue(&wq, &wait);

just as it is called via prepare_to_wait() in wait_event(). core.c is
the first driver I've come across that called the functions via:

{add,remove}_wait_queue(wq, &wait);

wait_event() is just a large macro which expands to the first form,
given wq as a parameter, so I think it should be ok, as that form is
the far more common one in the kernel currently.

What do you think? I am open to other ideas/suggestions, but I'm not
certain changing an existing / working interface (which other drivers
are being converted to) is the best idea.

Thanks,
Nish
