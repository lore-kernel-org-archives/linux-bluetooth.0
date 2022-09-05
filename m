Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A817ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Sep 2022 08:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbiIEIce (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbiIEIcH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Sep 2022 04:32:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC0B19C
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Sep 2022 01:31:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t6-20020a17090a950600b0020063f8f964so1499135pjo.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Sep 2022 01:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date;
        bh=tPd9b7KpNUkFOZOqNXWb0cJaT1vmg0PM/YxQ/a9zN6w=;
        b=ltfA0Xbz8AQsSlcUSBw1z2ccIHm9iW1693cCpit/rTzINMWE6lrAdlPyt6ahGQBTf/
         KDYbrVZQZGUWw1TnEn9s8UXDhrNFci0uRtK8ENScIuTn8bmUSvz7voMI55epPBkEM54p
         orKsxr6FGOCD5C9Ky2UfxTlvaeZs6/6eqoqzrMXNjwWG9HcfZMjidYj1D1oEfnSKu8UN
         PQ2BgtdgkAYWLYg116vMeyyhArqy2jL/Qf4BLrFyd+prqFACUl6FjRD0g0naAsAdP82X
         /Yek15SAF5127VLIiihNXQcsaU+tG8J9DHRPcC/M9cGfNTbn05nNPoweLSLn+K5ubUE8
         dQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date;
        bh=tPd9b7KpNUkFOZOqNXWb0cJaT1vmg0PM/YxQ/a9zN6w=;
        b=xLCRDbRjt6L3FoR/2/Knq1J7IcJ1lX5rMnv4QDBOOIlQelRVq8mM9Oj4llQeHESuwY
         NiycKghPlrvir9KwyV6XO5t2EjJcOpauFEMXqflMkAIN2o36nTxuDEoxOgdAZbyQd/Kl
         p9oM/SHxCL8XiDdA0W+iEcdHbyQQVp8bP+wz13uIWKU+fXzlAoY99YoC6GJLOl27F37w
         +0wJsv/cZROxm5vKs/pheR+ruk6d8KFH3KDTi/M1P/Yqt9ee2KaAiu6qFLT8PME8cmmr
         CIbTISdix7HCULjoB8ard2gfDeOuJHxpxnrmdGuvL2AGC4iFZGGrd1+EJoXPud4YZ/EQ
         261w==
X-Gm-Message-State: ACgBeo0DupYu2vHx0MecS7eXs70cCRKSHUaW+fFFfvU4xbBAjbuaf8tD
        dRkoSRG6tUujkXEOJk48N3UG6Ym7yg/Epw==
X-Google-Smtp-Source: AA6agR58WiA4qH1hmOiv1fSgHUQdy8cKIbovbgRkhjg7pDOe26RzUWQHHg5JubGXx3uflkD9nnhojA==
X-Received: by 2002:a17:903:1c8:b0:171:2ed3:6780 with SMTP id e8-20020a17090301c800b001712ed36780mr49189876plh.30.1662366683893;
        Mon, 05 Sep 2022 01:31:23 -0700 (PDT)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902eb8e00b001750361f430sm6728333plg.155.2022.09.05.01.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:31:23 -0700 (PDT)
References: <00000000000016512d05e76bd837@google.com>
 <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
 <CABBYNZLByK9M_eP_xCbVfGCSAuNOF6n+eUE4E=3hur-+bXdN4g@mail.gmail.com>
 <CABBYNZKv=dMHuHyOSxpqgG2G1je+xnRc8oM+juAQ0HzdfbBzKw@mail.gmail.com>
 <289ba1a9-e4f7-d0b5-545e-a98dcf365c68@I-love.SAKURA.ne.jp>
 <CABBYNZKdgsh5S7LkR8Gk2xW7EJnje5B_iYQoNw3h6SQEh311Jw@mail.gmail.com>
 <YxQLig28YbtjCVH+@slm.duckdns.org>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: use hdev->workqueue when queuing
 hdev->{cmd,ncmd}_timer works
Date:   Mon, 05 Sep 2022 16:24:06 +0800
In-reply-to: <YxQLig28YbtjCVH+@slm.duckdns.org>
Message-ID: <m2wnaixlwy.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Tejun Heo <tj@kernel.org> writes:

> Hello,
>
> On Sat, Sep 03, 2022 at 07:11:18PM -0700, Luiz Augusto von Dentz wrote:
>> And we can check for __WQ_DRAINING? Anyway checking
>
> Please don't do that. That's an internal flag. It shouldn't be *that*
> difficult to avoid this without peeking into wq internal state.
>
> Thanks.

It seems we only need to change hdev->{cmd,ncmd}_timer to
hdev->workqueue, there will be no race because drain_workqueue will
flush all pending work internally.
Any new timeout work will see HCI_CMD_DRAIN_WORKQUEUE flags after we
cancel and flushed all the delayed work.

-- 
BRs
Schspa Shi
