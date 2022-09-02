Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D111AC6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 18:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiIBSpt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiIBSpr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Sep 2022 14:45:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30842C6531
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 11:45:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q7so4526034lfu.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Sep 2022 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fELvhiW/4THThnyDGiPmzu3K66jIoG87ARNOu3VAmTc=;
        b=aiZab5ezHuhYhabpIgBp9SFGrqECWJT7ez+DBRZ+MpcPLMM9dQkMLbqZ3fsKxQupuV
         /8fbMy2Telp2XGnPyp9PnNUoaOJ5tjPXonP9AyevTnmNFPy8cjoZwZbR05g+EyjR//w3
         3jUoehFavDf8Syp4lkKogAL6vLDbRy3o+mZa12gNOBQRcYAYZr4o3WbKw332PgDS6nvJ
         J8J3x0fnjTWIeYMV9ZwiDBp2gpNWSjPNklPkGo1Y71XIoEvOucEL8F58ldf5vh66bMJQ
         ikYOK9Kei5dc/ny20B7pKNnaiySKgmB5lMyDx1hVKU/YUrA7N8Dkg/jcxOVwPD5v6j0t
         zC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fELvhiW/4THThnyDGiPmzu3K66jIoG87ARNOu3VAmTc=;
        b=I61ivYAZjzIN6ggzWyOjlO9FDE2FhJDIBybjWT4HbPjSE/SP9FymXvcUbdar3+u+2X
         zwl7m8lDbQbF6+6279zC6aVLKc+v0M1+P6s1JJwocpOQviJbnqxJ2sAE7srPy1hu43/C
         MtmI9d3i6ntc3Fi7eSAMSatrq4uvkUxksZ4vzhVU9YlkgGeFjd/K1g36SLXrW/WpnO4l
         dQ1kH2F8A1IpB5VmJvcYeiQIKnfm/9qrC6+yxwnVVaz5RxOY/6nHArs1mEXpsYvKqJbH
         ofWnHqlRyfusnSqN6+uZtdNa3p76nyZoQma5TuF0HdaeUsY12M0+tXeCJSjOdiqtoNyG
         N3HA==
X-Gm-Message-State: ACgBeo0VK5DC5Mf3N4o8c0fk/gA6bvCiForL3LiGOGTKBf8Q8aAyZC2u
        RkSRfgEpWilVvSohm1J749SUNJKspIp5zVev4Jn5h5VbWmI=
X-Google-Smtp-Source: AA6agR5sepG7df+huAAzsWT4ZXI7DqutM/siL1w9/OVB8eiu3GSi4G83mkbRsCqEsaOESGoIO9Vlu3o/j7pfqAYE7bo=
X-Received: by 2002:a05:6512:b81:b0:494:78cc:ca9c with SMTP id
 b1-20020a0565120b8100b0049478ccca9cmr5737150lfv.564.1662144344375; Fri, 02
 Sep 2022 11:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016512d05e76bd837@google.com> <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
In-Reply-To: <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 2 Sep 2022 11:45:32 -0700
Message-ID: <CABBYNZLByK9M_eP_xCbVfGCSAuNOF6n+eUE4E=3hur-+bXdN4g@mail.gmail.com>
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

On Fri, Sep 2, 2022 at 4:23 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting attempt to schedule hdev->cmd_work work from system_wq
> WQ into hdev->workqueue WQ which is under draining operation [1], for
> commit c8efcc2589464ac7 ("workqueue: allow chained queueing during
> destruction") does not allow such operation.
>
> The check introduced by commit 877afadad2dce8aa ("Bluetooth: When HCI work
> queue is drained, only queue chained work") was incomplete.
>
> Use hdev->workqueue WQ when queuing hdev->{cmd,ncmd}_timer works because
> hci_{cmd,ncmd}_timeout() calls queue_work(hdev->workqueue). Also, protect
> the queuing operation with RCU read lock in order to avoid calling
> queue_delayed_work() after cancel_delayed_work() completed.

Didn't we introduce HCI_CMD_DRAIN_WORKQUEUE exactly to avoid queuing
after the cancel pattern? I wonder if wouldn't be better to introduce
some function that disables/enables the workqueue so we don't have to
do extra tracking in the driver/subsystem?

> Link: https://syzkaller.appspot.com/bug?extid=243b7d89777f90f7613b [1]
> Reported-by: syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 877afadad2dce8aa ("Bluetooth: When HCI work queue is drained, only queue chained work")
> ---
> This is a difficult to trigger race condition, and therefore reproducer is
> not available. Please do logical check in addition to automated testing.
>
>  net/bluetooth/hci_core.c  | 15 +++++++++++++--
>  net/bluetooth/hci_event.c |  6 ++++--
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index b3a5a3cc9372..9873d2e67988 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -597,6 +597,15 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
>
>         /* Cancel these to avoid queueing non-chained pending work */
>         hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
> +       /* Wait for
> +        *
> +        *    if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
> +        *        queue_delayed_work(&hdev->{cmd,ncmd}_timer)
> +        *
> +        * inside RCU section to see the flag or complete scheduling.
> +        */
> +       synchronize_rcu();
> +       /* Explicitly cancel works in case scheduled after setting the flag. */
>         cancel_delayed_work(&hdev->cmd_timer);
>         cancel_delayed_work(&hdev->ncmd_timer);
>
> @@ -4056,12 +4065,14 @@ static void hci_cmd_work(struct work_struct *work)
>                         if (res < 0)
>                                 __hci_cmd_sync_cancel(hdev, -res);
>
> +                       rcu_read_lock();
>                         if (test_bit(HCI_RESET, &hdev->flags) ||
>                             hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
>                                 cancel_delayed_work(&hdev->cmd_timer);
>                         else
> -                               schedule_delayed_work(&hdev->cmd_timer,
> -                                                     HCI_CMD_TIMEOUT);
> +                               queue_delayed_work(hdev->workqueue, &hdev->cmd_timer,
> +                                                  HCI_CMD_TIMEOUT);
> +                       rcu_read_unlock();
>                 } else {
>                         skb_queue_head(&hdev->cmd_q, skb);
>                         queue_work(hdev->workqueue, &hdev->cmd_work);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 6643c9c20fa4..d6f0e6ca0e7e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3766,16 +3766,18 @@ static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd)
>  {
>         cancel_delayed_work(&hdev->cmd_timer);
>
> +       rcu_read_lock();
>         if (!test_bit(HCI_RESET, &hdev->flags)) {
>                 if (ncmd) {
>                         cancel_delayed_work(&hdev->ncmd_timer);
>                         atomic_set(&hdev->cmd_cnt, 1);
>                 } else {
>                         if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
> -                               schedule_delayed_work(&hdev->ncmd_timer,
> -                                                     HCI_NCMD_TIMEOUT);
> +                               queue_delayed_work(hdev->workqueue, &hdev->ncmd_timer,
> +                                                  HCI_NCMD_TIMEOUT);
>                 }
>         }
> +       rcu_read_unlock();
>  }
>
>  static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data,
> --
> 2.18.4
>


-- 
Luiz Augusto von Dentz
