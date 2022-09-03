Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC8BECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Sep 2022 06:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiICGtf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Sep 2022 02:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiICGte (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Sep 2022 02:49:34 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B2BE0F
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 23:49:31 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2836nTLb007007;
        Sat, 3 Sep 2022 15:49:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Sat, 03 Sep 2022 15:49:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2836nSJ7007000
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 3 Sep 2022 15:49:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <289ba1a9-e4f7-d0b5-545e-a98dcf365c68@I-love.SAKURA.ne.jp>
Date:   Sat, 3 Sep 2022 15:49:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] Bluetooth: use hdev->workqueue when queuing
 hdev->{cmd,ncmd}_timer works
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Schspa Shi <schspa@gmail.com>,
        syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <00000000000016512d05e76bd837@google.com>
 <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
 <CABBYNZLByK9M_eP_xCbVfGCSAuNOF6n+eUE4E=3hur-+bXdN4g@mail.gmail.com>
 <CABBYNZKv=dMHuHyOSxpqgG2G1je+xnRc8oM+juAQ0HzdfbBzKw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CABBYNZKv=dMHuHyOSxpqgG2G1je+xnRc8oM+juAQ0HzdfbBzKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2022/09/03 6:31, Luiz Augusto von Dentz wrote:
> Hi Tetsuo,
> 
> On Fri, Sep 2, 2022 at 11:45 AM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> Didn't we introduce HCI_CMD_DRAIN_WORKQUEUE exactly to avoid queuing
>> after the cancel pattern?

HCI_CMD_DRAIN_WORKQUEUE does not help for this case.

What extid=243b7d89777f90f7613b is reporting is

  hci_cmd_timeout() {                             hci_dev_do_reset() {
    starts sleeping due to e.g. preemption
                                                    hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE); // Sets HCI_CMD_DRAIN_WORKQUEUE flag
                                                    cancel_delayed_work(&hdev->cmd_timer); // does nothing because hci_cmd_timeout() is already running
                                                    cancel_delayed_work(&hdev->ncmd_timer);
                                                    drain_workqueue(hdev->workqueue) {
                                                      sets __WQ_DRAINING flag on hdev->workqueue
                                                      starts waiting for completion of all works on hdev->workqueue
    finishes sleeping due to e.g. preemption
    queue_work(hdev->workqueue,  &hdev->cmd_work) // <= complains attempt to queue work from system_wq into __WQ_DRAINING hdev->workqueue
  }
                                                      finishes waiting for completion of all works on hdev->workqueue
                                                      clears __WQ_DRAINING flag
                                                    }
                                                  }

race condition. Notice that cancel_delayed_work() does not wait for
completion of already started hci_cmd_timeout() callback.

If you need to wait for completion of already started callback,
you need to use _sync version (e.g. cancel_delayed_work_sync()).
And watch out for locking dependency when using _sync version.

>>                           I wonder if wouldn't be better to introduce
>> some function that disables/enables the workqueue so we don't have to
>> do extra tracking in the driver/subsystem?
>>
> 
> I was thinking on doing something like the following:
> 
> https://gist.github.com/Vudentz/a2288015fedbed366fcdb612264a9d16

That patch does not close race, for

@@ -4037,6 +4038,10 @@ static void hci_cmd_work(struct work_struct *work)
        BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
               atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
 
+       /* Don't queue while draining */
+       if (hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
+               return;
        /*
         * BUG: WE ARE FREE TO SLEEP FOR ARBITRARY DURATION IMMEDIATELY AFTER CHECKING THE FLAG.
         * ANY "TEST AND DO SOMETHING" NEEDS TO BE PROTECTED BY A LOCK MECHANISM.
         */
+
        /* Send queued commands */
        if (atomic_read(&hdev->cmd_cnt)) {
                skb = skb_dequeue(&hdev->cmd_q);

. In other words, HCI_CMD_DRAIN_WORKQUEUE does not fix what extid=63bed493aebbf6872647 is reporting.

If "TEST AND DO SOMETHING" does not sleep, RCU is a handy lock mechanism.

> 
> Since there is no reason to queue any command if we are draining and
> are gonna reset at the end it is pretty useless to queue commands at
> that point.

Then, you can add that check.

