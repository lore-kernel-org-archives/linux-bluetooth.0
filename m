Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DBCECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Sep 2022 11:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbiIELXv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Sep 2022 07:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238198AbiIELXq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Sep 2022 07:23:46 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BB95B791
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Sep 2022 04:23:43 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 285BNfPJ028744;
        Mon, 5 Sep 2022 20:23:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Mon, 05 Sep 2022 20:23:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 285BNfiO028741
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Sep 2022 20:23:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <24660886-da42-c129-77e6-87c344879a3b@I-love.SAKURA.ne.jp>
Date:   Mon, 5 Sep 2022 20:23:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] Bluetooth: use hdev->workqueue when queuing
 hdev->{cmd,ncmd}_timer works
Content-Language: en-US
To:     Schspa Shi <schspa@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <00000000000016512d05e76bd837@google.com>
 <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
 <CABBYNZLByK9M_eP_xCbVfGCSAuNOF6n+eUE4E=3hur-+bXdN4g@mail.gmail.com>
 <CABBYNZKv=dMHuHyOSxpqgG2G1je+xnRc8oM+juAQ0HzdfbBzKw@mail.gmail.com>
 <289ba1a9-e4f7-d0b5-545e-a98dcf365c68@I-love.SAKURA.ne.jp>
 <CABBYNZKdgsh5S7LkR8Gk2xW7EJnje5B_iYQoNw3h6SQEh311Jw@mail.gmail.com>
 <YxQLig28YbtjCVH+@slm.duckdns.org> <m2wnaixlwy.fsf@gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <m2wnaixlwy.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2022/09/05 17:24, Schspa Shi wrote:
> 
> Tejun Heo <tj@kernel.org> writes:
> 
>> Hello,
>>
>> On Sat, Sep 03, 2022 at 07:11:18PM -0700, Luiz Augusto von Dentz wrote:
>>> And we can check for __WQ_DRAINING? Anyway checking
>>
>> Please don't do that. That's an internal flag. It shouldn't be *that*
>> difficult to avoid this without peeking into wq internal state.
>>
>> Thanks.
> 
> It seems we only need to change hdev->{cmd,ncmd}_timer to
> hdev->workqueue, there will be no race because drain_workqueue will
> flush all pending work internally.

True for queue_work(), not always true for queue_delayed_work(). Explained below.

> Any new timeout work will see HCI_CMD_DRAIN_WORKQUEUE flags after we
> cancel and flushed all the delayed work.
> 

If you don't mind calling

  queue_work(&hdev->cmd_work) followed by hci_cmd_work() (case A below)

and/or

  queue_delayed_work(&hdev->ncmd_timer) potentially followed by hci_ncmd_timeout()/hci_reset_dev() (case B and C below)

after observing HCI_CMD_DRAIN_WORKQUEUE flag.
We need to use RCU protection if you mind one of these.



Case A:

hci_dev_do_reset() {
                                      hci_cmd_work() {
                                        if (test_bit(HCI_RESET, &hdev->flags) ||
                                          hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
                                            cancel_delayed_work(&hdev->cmd_timer);
                                          else
                                            queue_delayed_work(hdev->workqueue, &hdev->cmd_timer, HCI_CMD_TIMEOUT);
                                        } else {
                                          skb_queue_head(&hdev->cmd_q, skb);
  hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
  cancel_delayed_work(&hdev->cmd_timer);
  cancel_delayed_work(&hdev->ncmd_timer);
                                          queue_work(hdev->workqueue, &hdev->cmd_work); // Queuing after setting HCI_CMD_DRAIN_WORKQUEUE despite the intent of HCI_CMD_DRAIN_WORKQUEUE...
  drain_workqueue(hdev->workqueue); // Will wait for hci_cmd_timeout() queued by queue_work() to complete.

                                        }

  // Actual flush() happens here.

  hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
}



Case B:

hci_dev_do_reset() {
                                          handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd) {
                                            if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
  hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
  cancel_delayed_work(&hdev->cmd_timer);
                                              queue_delayed_work(hdev->workqueue, &hdev->ncmd_timer, HCI_NCMD_TIMEOUT);
  cancel_delayed_work(&hdev->ncmd_timer); // May or may not cancel hci_ncmd_timeout() queued by queue_delayed_work().
  drain_workqueue(hdev->workqueue); // Will wait for hci_ncmd_timeout() queued by queue_delayed_work() to complete if cancel_delayed_work() failed to cancel.

                                          }

  // Actual flush() happens here.

  hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
}



Case C:

hci_dev_do_reset() {
                                          handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd) {
                                            if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
  hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
  cancel_delayed_work(&hdev->cmd_timer);
  cancel_delayed_work(&hdev->ncmd_timer); // Does nothing.
                                              queue_delayed_work(hdev->workqueue, &hdev->ncmd_timer, HCI_NCMD_TIMEOUT);
  drain_workqueue(hdev->workqueue); // Will wait for hci_ncmd_timeout() queued by queue_delayed_work() to complete if delay timer has expired.

                                          }

  // Actual flush() happens here, but hci_ncmd_timeout() queued by queue_delayed_work() can be running if delay timer has not expired as of calling drain_workqueue().

  hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
}

