Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669AFC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 18:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD8F6144C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 18:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhENSjU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 14:39:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58203 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhENSjU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 14:39:20 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 78E8ECEC82;
        Fri, 14 May 2021 20:45:57 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [RFC] Bluetooth: Move scanning update into synchronous function
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJ5wqg-ztbXUovxhr3mm2vSc9bzVHYRRCkPbTNS3cWu0g@mail.gmail.com>
Date:   Fri, 14 May 2021 20:38:04 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <51A56819-7F1E-40B1-8E1A-E82D2413B217@holtmann.org>
References: <20210505210518.183861-1-marcel@holtmann.org>
 <CABBYNZJ5wqg-ztbXUovxhr3mm2vSc9bzVHYRRCkPbTNS3cWu0g@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> With recent specification version, the setup for LE scanning or LE
>> advertising started to more complex than it was with Bluetooth 4.0 which
>> initially introduced LE support. So historically, bringing the
>> controller into a link layer state (being it scanning or advertising)
>> was composed of two HCI commands. This meant using hci_req_sync worked
>> nicely.
>> 
>> However over time, the pattern of pushing work into a workqueue and then
>> utilizing hci_req_sync list of 5 or more commands became the normality.
>> With the usage of hci_req_sync it means that all states and error need
>> to be predicted ahead of time. This is no longer workable. Since the
>> work is already pushed into a workqueue, the usage of __hci_cmd_sync is
>> possible and process the HCI commands one command at a time.
> 
> Remind me why we introduce the concept of hci_req in the first place,
> was that to guarantee the command will be queued is the exact order?
> With the use of sync version I assume that will no longer be necessary
> but perhaps we also have a problem locking a context/thread for too
> long with sync.

I don’t remember anymore. I must have made sense for hci_req_run at some point, but right now I fail to connect the dots. For all complicated tasks we spawn into a work queue anyway.

The hci_req_run is something I can see kinda making sense since you have a real callback for the result. The hci_req_sync just puts the HCI command collection into a function, but both will wait. The hci_cmd_sync is essentially a hci_req_sync with a single command. So just a helper around it.

> 
>> The idea of this patch is to push towards usage of __hci_cmd_sync and
>> just process the changes to scanning and advertising one command at a
>> time and thus being able to fail gracefully and eventually recover.
> 
> Another remark I have here is that hci_cmd_sync and hci_req_sync seem
> to be doing almost the same thing with only real different is that
> hci_req_sync takes a callback to construct the command while
> hci_cmd_sync it needs to be constructed ahead of time, the former
> looks more flexible imo. Perhaps we could just make hci_cmd_sync to
> call into hci_req_sync, anyway this could be done later depending on
> how the code evolves.

That difference is beyond me actually. I think that hci_req_sync usage should be just replaced.

> 
>> Now the problem is that the usage of hci_req_sync is widespread and
>> touches pretty much everything. There is also hci_req_run that first
>> needed to be convert to use a workqueue and also process each command
>> one a time.
> 
> This part confuses me, do we have a problem with the sync version or
> it is actually hci_req_run? I thought the problem was the latter where
> we queue multiple commands that depend on one another which makes it
> hard to handle in an asynchronous way, reverting the states, etc.
> Perhaps we could introduce something like hci_req_run_sync which stops
> whenever the status != success then the caller can evaluate if it
> needs to continue to send the remaining commands in the queue or just
> abort, rollback, etc, then we can just convert one by one the
> instances that need this sort of lockstep mode.

Even the sync version is utilizing hci_req_run in the background.

The problem with hci_req_run is that there is no rollback possible since you really don’t know where it stopped. This made all sense if you have to send two commands to get something started, but if you send more than 2 than it becomes undeterministic.

Regards

Marcel

