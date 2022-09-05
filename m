Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CCFECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Sep 2022 12:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiIEMid (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Sep 2022 08:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbiIEMiN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Sep 2022 08:38:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E954966A4B
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Sep 2022 05:32:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l3so8361074plb.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Sep 2022 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date;
        bh=MyYZdIpqS3+oZzACFDzJR8x696nNAmY9UXa3dTP4Qz0=;
        b=MYElDxAPdsdFm0YPLGEoF91DdJFkfENZFTcRePe0+bBb28j404s90amn4v2vDOWyNB
         6r3wnKyZGLMnvHBHzP+ANM84CRnKQpl8dnJkVrsHwscibYJthM8yHAjXN59nAl5VOzqB
         h2G9O5IdgKxPwLvYHdnlCsRcJBccsMCTiay4E60Hz0eA4TPPLoJP/wJmxcg7pnZSXCEY
         wW4lM06ls3nX87k7PillMOz9HmmN9FqIZHfQolDJ/GkNYIU13328kk0RKun7ZwtcYjgH
         YRke7dlzxmw1lvvQ1xpIPVKfB9IxzpHjFDhJuIs1KUM0sjxCrag9WA3b+vkS0tRwEm6g
         ofQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date;
        bh=MyYZdIpqS3+oZzACFDzJR8x696nNAmY9UXa3dTP4Qz0=;
        b=UxvBpjYcZzmbnW9m+0A5E4JzOjmirrSkrz/DOj4v0GhS52uKgojWSTfKsJlHntYhi0
         xSK+E7dCw/JHSruplPR9A2jteChwqKLWQPYnhFxs3rkjnfqVCU+4k5LkIhPyRWrrHPEd
         /wbtRRYQr1ghHAhKOLNQtfTyYlsIDqbY4c34w3w42bqg4Riif9EJIUtNB8WgUPAA8QrI
         n5VChUIFXTzrwO69Thk6FC4Ceq1darpzgHvKRsl/rY4CyQAeqoxC9/8INDRaIJZG2yhO
         IA9XyXep3q8Qz8/ticGvfaxxaz1t1cKuI4Szg8sC2/5qeI39doGb+p9Lr8H5oNMudzIn
         Xttw==
X-Gm-Message-State: ACgBeo3lsZ/qmb7tmz9hb2Q0/i94l+F9mrehxRveVzEa4EmCxIBndy2y
        1KHu5tNI32ZyTHY7nTw1Qrg=
X-Google-Smtp-Source: AA6agR4AP7vibNuCetOjy5F1QmOBdbcxRa81Hx5nqMp/M7zJa/W9asWgj6AdY3/y9pEk9d5B4chSdw==
X-Received: by 2002:a17:90b:314a:b0:200:5c13:e77a with SMTP id ip10-20020a17090b314a00b002005c13e77amr6063689pjb.18.1662381136791;
        Mon, 05 Sep 2022 05:32:16 -0700 (PDT)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id bf10-20020a170902b90a00b00172ff99d0afsm7403968plb.140.2022.09.05.05.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 05:32:16 -0700 (PDT)
References: <00000000000016512d05e76bd837@google.com>
 <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
 <CABBYNZLByK9M_eP_xCbVfGCSAuNOF6n+eUE4E=3hur-+bXdN4g@mail.gmail.com>
 <CABBYNZKv=dMHuHyOSxpqgG2G1je+xnRc8oM+juAQ0HzdfbBzKw@mail.gmail.com>
 <289ba1a9-e4f7-d0b5-545e-a98dcf365c68@I-love.SAKURA.ne.jp>
 <CABBYNZKdgsh5S7LkR8Gk2xW7EJnje5B_iYQoNw3h6SQEh311Jw@mail.gmail.com>
 <YxQLig28YbtjCVH+@slm.duckdns.org> <m2wnaixlwy.fsf@gmail.com>
 <24660886-da42-c129-77e6-87c344879a3b@I-love.SAKURA.ne.jp>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Bluetooth: use hdev->workqueue when queuing
 hdev->{cmd,ncmd}_timer works
Date:   Mon, 05 Sep 2022 20:26:52 +0800
In-reply-to: <24660886-da42-c129-77e6-87c344879a3b@I-love.SAKURA.ne.jp>
Message-ID: <m2bkruxarg.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> On 2022/09/05 17:24, Schspa Shi wrote:
>> 
>> Tejun Heo <tj@kernel.org> writes:
>> 
>>> Hello,
>>>
>>> On Sat, Sep 03, 2022 at 07:11:18PM -0700, Luiz Augusto von Dentz wrote:
>>>> And we can check for __WQ_DRAINING? Anyway checking
>>>
>>> Please don't do that. That's an internal flag. It shouldn't be *that*
>>> difficult to avoid this without peeking into wq internal state.
>>>
>>> Thanks.
>> 
>> It seems we only need to change hdev->{cmd,ncmd}_timer to
>> hdev->workqueue, there will be no race because drain_workqueue will
>> flush all pending work internally.
>
> True for queue_work(), not always true for queue_delayed_work(). Explained below.
>

Ok, you are right, got it now.

>> Any new timeout work will see HCI_CMD_DRAIN_WORKQUEUE flags after we
>> cancel and flushed all the delayed work.
>> 
>
> If you don't mind calling
>
>   queue_work(&hdev->cmd_work) followed by hci_cmd_work() (case A below)
>
> and/or
>
>   queue_delayed_work(&hdev->ncmd_timer) potentially followed by hci_ncmd_timeout()/hci_reset_dev() (case B and C below)
>
> after observing HCI_CMD_DRAIN_WORKQUEUE flag.
> We need to use RCU protection if you mind one of these.
>
>
>
> Case A:
>
> hci_dev_do_reset() {
>                                       hci_cmd_work() {
>                                         if (test_bit(HCI_RESET, &hdev->flags) ||
>                                           hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
>                                             cancel_delayed_work(&hdev->cmd_timer);
>                                           else
>                                             queue_delayed_work(hdev->workqueue, &hdev->cmd_timer, HCI_CMD_TIMEOUT);
>                                         } else {
>                                           skb_queue_head(&hdev->cmd_q, skb);
>   hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
>   cancel_delayed_work(&hdev->cmd_timer);
>   cancel_delayed_work(&hdev->ncmd_timer);
>                                           queue_work(hdev->workqueue, &hdev->cmd_work); // Queuing after setting HCI_CMD_DRAIN_WORKQUEUE despite the intent of HCI_CMD_DRAIN_WORKQUEUE...
>   drain_workqueue(hdev->workqueue); // Will wait for hci_cmd_timeout() queued by queue_work() to complete.
>
>                                         }
>
>   // Actual flush() happens here.
>
>   hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
> }
>
>
>
> Case B:
>
> hci_dev_do_reset() {
>                                           handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd) {
>                                             if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
>   hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
>   cancel_delayed_work(&hdev->cmd_timer);
>                                               queue_delayed_work(hdev->workqueue, &hdev->ncmd_timer, HCI_NCMD_TIMEOUT);
>   cancel_delayed_work(&hdev->ncmd_timer); // May or may not cancel hci_ncmd_timeout() queued by queue_delayed_work().
>   drain_workqueue(hdev->workqueue); // Will wait for hci_ncmd_timeout() queued by queue_delayed_work() to complete if cancel_delayed_work() failed to cancel.
>
>                                           }
>
>   // Actual flush() happens here.
>
>   hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
> }
>
>
>
> Case C:
>
> hci_dev_do_reset() {
>                                           handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd) {
>                                             if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
>   hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
>   cancel_delayed_work(&hdev->cmd_timer);
>   cancel_delayed_work(&hdev->ncmd_timer); // Does nothing.
>                                               queue_delayed_work(hdev->workqueue, &hdev->ncmd_timer, HCI_NCMD_TIMEOUT);
>   drain_workqueue(hdev->workqueue); // Will wait for hci_ncmd_timeout() queued by queue_delayed_work() to complete if delay timer has expired.
>
>                                           }
>
>   // Actual flush() happens here, but hci_ncmd_timeout() queued by queue_delayed_work() can be running if delay timer has not expired as of calling drain_workqueue().
>
>   hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
> }

-- 
BRs
Schspa Shi
