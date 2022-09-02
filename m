Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1385CECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 21:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiIBVb3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Sep 2022 17:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiIBVb0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Sep 2022 17:31:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEE5EF9C7
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 14:31:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m7so5011605lfq.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Sep 2022 14:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1HUYQ0WXSqyyYUjemoMGHrTDFTH7hVfA5fewAKp4po8=;
        b=UvPuX4vVDTri0VM55S64lvBoG/KKo4UmAJQnYGaxXsRFwT6SaZ8xw9GssHzYgU5kfd
         mSK6fmbyXIs+6VJrXWTjXDvNxmUuxSLqVk3/pwqB6oOoGd/Vz8durd9bd7QKKmwu5f80
         sWPnpLllC8tZqi9FRBQXTsq1n63h1HSXc12cOcgTCmCmhU9tAGRjcL3JE/wz4XT4IQQb
         lt1mz9e4ZrLY4slGbrgzZmS/jry6iaWdGsgXAWlRakHYKixuZc8WisRd8ZAidsh2G3f7
         JppyvZ9ezqa1jA1O64+8MXJ7pqvBBi0Vt9BJsW76O4OcQHBU+BZdOLgIDrhSZaqtm7g8
         mIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1HUYQ0WXSqyyYUjemoMGHrTDFTH7hVfA5fewAKp4po8=;
        b=5IHZWgLvS2d1zvN5/BzoDyJmW80OfA5sNV83zza6bMGLBQDMARNTUC5yg/nmE8gEMQ
         oA/PqepSNYZKlQq0hhL0Elq0cGfrKKN/YJtCEed6OUfYF3+ci/RbWnIzMurE6WAic48U
         /PY6x1iOerrD9fiRXnbn9N7CxOynGVQeNaLe198tfLljC+dzNIyMnBs27a60wDke5/Mn
         e4GqXW1f9UtbSClwrCy2KU598l9dNCojpyXs0NP0z9nwUleMDOrj80UTZ9q2cO5tpdlD
         qNw+Irpa3JHLK/R3TdittN9X1m7v6mz1J/32qRqVUIda0PkAxlsw+30FnHG8AGlO+6P0
         E9yw==
X-Gm-Message-State: ACgBeo0ZFWe5bdS5lfF7IL3ArRIPxUMBnoibS/eUG1UpXYcWf7ELXpR/
        DjSdOjAoMx8FpAtI5cyox9cbq/Wd7M3QBBS2SAE=
X-Google-Smtp-Source: AA6agR6lfv2Py5bEONKmyhQTISWMrp+E11UbS/TT971Za1IlPbak4UbKYrUXKoFwVTOopMy6OR+thDw9CDNkacfowmg=
X-Received: by 2002:a05:6512:b81:b0:494:78cc:ca9c with SMTP id
 b1-20020a0565120b8100b0049478ccca9cmr5898581lfv.564.1662154282662; Fri, 02
 Sep 2022 14:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016512d05e76bd837@google.com> <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
 <CABBYNZLByK9M_eP_xCbVfGCSAuNOF6n+eUE4E=3hur-+bXdN4g@mail.gmail.com>
In-Reply-To: <CABBYNZLByK9M_eP_xCbVfGCSAuNOF6n+eUE4E=3hur-+bXdN4g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 2 Sep 2022 14:31:11 -0700
Message-ID: <CABBYNZKv=dMHuHyOSxpqgG2G1je+xnRc8oM+juAQ0HzdfbBzKw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: use hdev->workqueue when queuing
 hdev->{cmd,ncmd}_timer works
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Schspa Shi <schspa@gmail.com>,
        syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tetsuo,

On Fri, Sep 2, 2022 at 11:45 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Tetsuo,
>
> On Fri, Sep 2, 2022 at 4:23 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > syzbot is reporting attempt to schedule hdev->cmd_work work from system_wq
> > WQ into hdev->workqueue WQ which is under draining operation [1], for
> > commit c8efcc2589464ac7 ("workqueue: allow chained queueing during
> > destruction") does not allow such operation.
> >
> > The check introduced by commit 877afadad2dce8aa ("Bluetooth: When HCI work
> > queue is drained, only queue chained work") was incomplete.
> >
> > Use hdev->workqueue WQ when queuing hdev->{cmd,ncmd}_timer works because
> > hci_{cmd,ncmd}_timeout() calls queue_work(hdev->workqueue). Also, protect
> > the queuing operation with RCU read lock in order to avoid calling
> > queue_delayed_work() after cancel_delayed_work() completed.
>
> Didn't we introduce HCI_CMD_DRAIN_WORKQUEUE exactly to avoid queuing
> after the cancel pattern? I wonder if wouldn't be better to introduce
> some function that disables/enables the workqueue so we don't have to
> do extra tracking in the driver/subsystem?
>
> > Link: https://syzkaller.appspot.com/bug?extid=243b7d89777f90f7613b [1]
> > Reported-by: syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Fixes: 877afadad2dce8aa ("Bluetooth: When HCI work queue is drained, only queue chained work")
> > ---
> > This is a difficult to trigger race condition, and therefore reproducer is
> > not available. Please do logical check in addition to automated testing.
> >
> >  net/bluetooth/hci_core.c  | 15 +++++++++++++--
> >  net/bluetooth/hci_event.c |  6 ++++--
> >  2 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index b3a5a3cc9372..9873d2e67988 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -597,6 +597,15 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
> >
> >         /* Cancel these to avoid queueing non-chained pending work */
> >         hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
> > +       /* Wait for
> > +        *
> > +        *    if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
> > +        *        queue_delayed_work(&hdev->{cmd,ncmd}_timer)
> > +        *
> > +        * inside RCU section to see the flag or complete scheduling.
> > +        */
> > +       synchronize_rcu();
> > +       /* Explicitly cancel works in case scheduled after setting the flag. */
> >         cancel_delayed_work(&hdev->cmd_timer);
> >         cancel_delayed_work(&hdev->ncmd_timer);
> >
> > @@ -4056,12 +4065,14 @@ static void hci_cmd_work(struct work_struct *work)
> >                         if (res < 0)
> >                                 __hci_cmd_sync_cancel(hdev, -res);
> >
> > +                       rcu_read_lock();
> >                         if (test_bit(HCI_RESET, &hdev->flags) ||
> >                             hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
> >                                 cancel_delayed_work(&hdev->cmd_timer);
> >                         else
> > -                               schedule_delayed_work(&hdev->cmd_timer,
> > -                                                     HCI_CMD_TIMEOUT);
> > +                               queue_delayed_work(hdev->workqueue, &hdev->cmd_timer,
> > +                                                  HCI_CMD_TIMEOUT);
> > +                       rcu_read_unlock();
> >                 } else {
> >                         skb_queue_head(&hdev->cmd_q, skb);
> >                         queue_work(hdev->workqueue, &hdev->cmd_work);
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 6643c9c20fa4..d6f0e6ca0e7e 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3766,16 +3766,18 @@ static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd)
> >  {
> >         cancel_delayed_work(&hdev->cmd_timer);
> >
> > +       rcu_read_lock();
> >         if (!test_bit(HCI_RESET, &hdev->flags)) {
> >                 if (ncmd) {
> >                         cancel_delayed_work(&hdev->ncmd_timer);
> >                         atomic_set(&hdev->cmd_cnt, 1);
> >                 } else {
> >                         if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
> > -                               schedule_delayed_work(&hdev->ncmd_timer,
> > -                                                     HCI_NCMD_TIMEOUT);
> > +                               queue_delayed_work(hdev->workqueue, &hdev->ncmd_timer,
> > +                                                  HCI_NCMD_TIMEOUT);
> >                 }
> >         }
> > +       rcu_read_unlock();
> >  }
> >
> >  static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data,
> > --
> > 2.18.4
> >

I was thinking on doing something like the following:

https://gist.github.com/Vudentz/a2288015fedbed366fcdb612264a9d16

Since there is no reason to queue any command if we are draining and
are gonna reset at the end it is pretty useless to queue commands at
that point.

>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
