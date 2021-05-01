Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54038C433B4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 01:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE5361407
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 01:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhEACAb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Apr 2021 22:00:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46864 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhEACAa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Apr 2021 22:00:30 -0400
Received: from smtpclient.apple (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 05F80CED0F;
        Sat,  1 May 2021 04:07:30 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [BlueZ v2] monitor: Update manpage
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKYDBQFqf8uVeXZNg-OVBks96fqRMk+8S+029Y26dSiow@mail.gmail.com>
Date:   Sat, 1 May 2021 03:59:40 +0200
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <BA960BC0-D602-4B59-BFF4-6ADF1B487081@holtmann.org>
References: <20210428062214.335567-1-hj.tedd.an@gmail.com>
 <CABBYNZJJHLZdhOFHrTHV7XN7++t4XKq3yHxS2wsi2bJ2AkRnVw@mail.gmail.com>
 <87c5b74558d3062f301dbfa28b93cdbfbe310dd2.camel@gmail.com>
 <CABBYNZKYDBQFqf8uVeXZNg-OVBks96fqRMk+8S+029Y26dSiow@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>>> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>>>> 
>>>> This patch updates the manpage for btmon written in rst format.
>>>> ---
>>>> Makefile.am       |  26 ++++---
>>>> Makefile.tools    |   4 ++
>>>> configure.ac      |   4 ++
>>>> doc/btmon.txt     |  35 ----------
>>>> monitor/btmon.rst | 172 ++++++++++++++++++++++++++++++++++++++++++++++
>>> 
>>> I do wonder why you change the location from doc to monitor, I think
>>> we actually should keep all the documentation under doc and perhaps
>>> even have a dedicated make target for those since we would likely want
>>> to generate all the manpages from rst which may be time consuming so
>>> people not interested on it can just skip it.
>> 
>> I converted all manpages in the tree to .rst and ready to submit.
>> Can I combine all in this series or wait for this to merge first?
> 
> Have you added a make target for those? I really don't mind having the
> manpages generated within the same location of the binary, although I
> think it would be more organized to have it in one place, but a make
> target would probably be a good practice.

the way how this works is that in a git tree they are always generated unless disabled or rst2man is not available. And in a tarball, the generated manual pages are shipped, which means they are not needed to be generated. So no specific make target required. Lets just copy what iwd repository doing since that is working fine.

Regards

Marcel

