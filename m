Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11A9C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Apr 2021 07:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E85613B3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Apr 2021 07:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhD3Ha4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Apr 2021 03:30:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48858 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhD3Hay (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Apr 2021 03:30:54 -0400
Received: from smtpclient.apple (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id EBBF8CECFD;
        Fri, 30 Apr 2021 09:37:54 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [BlueZ v2] monitor: Update manpage
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJJHLZdhOFHrTHV7XN7++t4XKq3yHxS2wsi2bJ2AkRnVw@mail.gmail.com>
Date:   Fri, 30 Apr 2021 09:30:05 +0200
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F0707FBF-6B60-40E2-9254-72658E2BC60E@holtmann.org>
References: <20210428062214.335567-1-hj.tedd.an@gmail.com>
 <CABBYNZJJHLZdhOFHrTHV7XN7++t4XKq3yHxS2wsi2bJ2AkRnVw@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> This patch updates the manpage for btmon written in rst format.
>> ---
>> Makefile.am       |  26 ++++---
>> Makefile.tools    |   4 ++
>> configure.ac      |   4 ++
>> doc/btmon.txt     |  35 ----------
>> monitor/btmon.rst | 172 ++++++++++++++++++++++++++++++++++++++++++++++
> 
> I do wonder why you change the location from doc to monitor, I think
> we actually should keep all the documentation under doc and perhaps
> even have a dedicated make target for those since we would likely want
> to generate all the manpages from rst which may be time consuming so
> people not interested on it can just skip it.

in iwd, we moved all the manual pages next to the source of the daemon/tools. So yes, I would put this into monitor directory as well.

Regards

Marcel

