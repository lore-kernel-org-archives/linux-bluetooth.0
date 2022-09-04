Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E9BC38145
	for <linux-bluetooth@archiver.kernel.org>; Sun,  4 Sep 2022 02:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiIDCLd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Sep 2022 22:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIDCLc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Sep 2022 22:11:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8AB43E7D
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Sep 2022 19:11:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q7so8635440lfu.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Sep 2022 19:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5AJtIDs83bJ40lkLyH8OsxdvpqTzUfCp8en0Qt9m45o=;
        b=UhivNLWTV8B+2s10Mfb+nmdBj+qmdpcNXwIZWOM3eDplr7EDxfeP4uRXvGKm7Vn5ph
         W84S48K9+fsL/PlPk7iZwK5a44nDJGUQulnaZPJMSMjFpRdox4xIouPc58kGAPvj7orn
         K7v/IUa7t5TUAVU4yficRXFc3KfktrjCwIRgAsWezj6PYaky3CfFi091y9Fo6+k+G0jC
         TnRq2u+BSZj5t5P5Km107scrG/mA2qKctJh7+snaweXSDqe2/nCQhvIPWKH/mJTrVzri
         7WDHUcFp+reWHAbizxHnQM46ovF5k7AmKS/2aDfG5T2hfRRPL0sU7CqdL2FWcTLotN27
         aQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5AJtIDs83bJ40lkLyH8OsxdvpqTzUfCp8en0Qt9m45o=;
        b=RI+saVM+o8v/kNaCZu+gkLMZDLIiARcfJs0zcP4TlWRSQsQ4cb7JcVFNFRh7Xkpfbu
         fa9i+TWCO1V1+ZnQ+gyKBknBxgR5nsONfdgQp1bjyRlvUgiTGEWhwyaED+AotlohKZvz
         qCpop/qj8AlvF4nqY6kboypnbdN2Hu4jrmfcu6dzPKLJowOQVCiW6Uvw+I02f1bvL9QW
         gqZFhaf51iy7BkhAHH23JoAuuPrWGQ36/K3LWh5jROdQ4g7M76COZ3N6I+TtkbZO/lqg
         BrdllqfOWb2N4WyIOpbtaIGGNyn08MgEZxH6uZEHcYi0jWUcMTxph16WpfDEWXvDaYVA
         4C3g==
X-Gm-Message-State: ACgBeo1C3iaNCXe2BSqkJ71n6Bs6k3BSUq9yXF3vY6f1B8x0kMR+V2wM
        jjtPCEr1WN2lEa0U71n5k3g4/yIGMne/tTt79uw=
X-Google-Smtp-Source: AA6agR7H1YZCacDNy6fnIw7brlcRlspC0PbkM6vda06rlzVabjvA0sc/DC64Snggwg0+YJoDHLAPHq79P7XnXonIjXQ=
X-Received: by 2002:a05:6512:33c9:b0:494:79c1:8ea1 with SMTP id
 d9-20020a05651233c900b0049479c18ea1mr7184479lfg.26.1662257489458; Sat, 03 Sep
 2022 19:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016512d05e76bd837@google.com> <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
 <CABBYNZLByK9M_eP_xCbVfGCSAuNOF6n+eUE4E=3hur-+bXdN4g@mail.gmail.com>
 <CABBYNZKv=dMHuHyOSxpqgG2G1je+xnRc8oM+juAQ0HzdfbBzKw@mail.gmail.com> <289ba1a9-e4f7-d0b5-545e-a98dcf365c68@I-love.SAKURA.ne.jp>
In-Reply-To: <289ba1a9-e4f7-d0b5-545e-a98dcf365c68@I-love.SAKURA.ne.jp>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 3 Sep 2022 19:11:18 -0700
Message-ID: <CABBYNZKdgsh5S7LkR8Gk2xW7EJnje5B_iYQoNw3h6SQEh311Jw@mail.gmail.com>
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

On Fri, Sep 2, 2022 at 11:49 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2022/09/03 6:31, Luiz Augusto von Dentz wrote:
> > Hi Tetsuo,
> >
> > On Fri, Sep 2, 2022 at 11:45 AM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> >> Didn't we introduce HCI_CMD_DRAIN_WORKQUEUE exactly to avoid queuing
> >> after the cancel pattern?
>
> HCI_CMD_DRAIN_WORKQUEUE does not help for this case.
>
> What extid=243b7d89777f90f7613b is reporting is
>
>   hci_cmd_timeout() {                             hci_dev_do_reset() {
>     starts sleeping due to e.g. preemption
>                                                     hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE); // Sets HCI_CMD_DRAIN_WORKQUEUE flag
>                                                     cancel_delayed_work(&hdev->cmd_timer); // does nothing because hci_cmd_timeout() is already running
>                                                     cancel_delayed_work(&hdev->ncmd_timer);
>                                                     drain_workqueue(hdev->workqueue) {
>                                                       sets __WQ_DRAINING flag on hdev->workqueue
>                                                       starts waiting for completion of all works on hdev->workqueue
>     finishes sleeping due to e.g. preemption
>     queue_work(hdev->workqueue,  &hdev->cmd_work) // <= complains attempt to queue work from system_wq into __WQ_DRAINING hdev->workqueue

And we can check for __WQ_DRAINING? Anyway checking
HCI_CMD_DRAIN_WORKQUEUE seems useless so we either have to check if
queue_work can be used or not.

>   }
>                                                       finishes waiting for completion of all works on hdev->workqueue
>                                                       clears __WQ_DRAINING flag
>                                                     }
>                                                   }
>
> race condition. Notice that cancel_delayed_work() does not wait for
> completion of already started hci_cmd_timeout() callback.
>
> If you need to wait for completion of already started callback,
> you need to use _sync version (e.g. cancel_delayed_work_sync()).
> And watch out for locking dependency when using _sync version.
>
> >>                           I wonder if wouldn't be better to introduce
> >> some function that disables/enables the workqueue so we don't have to
> >> do extra tracking in the driver/subsystem?
> >>
> >
> > I was thinking on doing something like the following:
> >
> > https://gist.github.com/Vudentz/a2288015fedbed366fcdb612264a9d16
>
> That patch does not close race, for
>
> @@ -4037,6 +4038,10 @@ static void hci_cmd_work(struct work_struct *work)
>         BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
>                atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
>
> +       /* Don't queue while draining */
> +       if (hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
> +               return;
>         /*
>          * BUG: WE ARE FREE TO SLEEP FOR ARBITRARY DURATION IMMEDIATELY AFTER CHECKING THE FLAG.
>          * ANY "TEST AND DO SOMETHING" NEEDS TO BE PROTECTED BY A LOCK MECHANISM.
>          */

Then we need a lock not a flag.

>         /* Send queued commands */
>         if (atomic_read(&hdev->cmd_cnt)) {
>                 skb = skb_dequeue(&hdev->cmd_q);
>
> . In other words, HCI_CMD_DRAIN_WORKQUEUE does not fix what extid=63bed493aebbf6872647 is reporting.
>
> If "TEST AND DO SOMETHING" does not sleep, RCU is a handy lock mechanism.
>
> >
> > Since there is no reason to queue any command if we are draining and
> > are gonna reset at the end it is pretty useless to queue commands at
> > that point.
>
> Then, you can add that check.
>


-- 
Luiz Augusto von Dentz
