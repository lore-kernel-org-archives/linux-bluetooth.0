Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9FFC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 16:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 575CF61377
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 16:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhEGQIw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 12:08:52 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60132 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhEGQIv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 12:08:51 -0400
Received: from smtpclient.apple (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3FA15CECE3;
        Fri,  7 May 2021 18:15:41 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH] bluetooth: fix potential gfp
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <YJVdJEMKz6YcnwOW@hovoldconsulting.com>
Date:   Fri, 7 May 2021 18:07:50 +0200
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <BFCF660F-B919-47EB-874D-5568E41927C6@holtmann.org>
References: <20210501150445.4055-1-paskripkin@gmail.com>
 <9A08CBDA-3501-48F6-9F7A-60958C5CF888@holtmann.org>
 <YJU8iP+O9aSYwYp/@hovoldconsulting.com>
 <CDE30B55-E91B-4513-80E4-2198F8A32217@holtmann.org>
 <YJVdJEMKz6YcnwOW@hovoldconsulting.com>
To:     Johan Hovold <johan@kernel.org>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

>>>>> In qca_power_shutdown() qcadev local variable is
>>>>> initialized by hu->serdev.dev private data, but
>>>>> hu->serdev can be NULL and there is a check for it.
>>>>> 
>>>>> Since, qcadev is not used before
>>>>> 
>>>>> 	if (!hu->serdev)
>>>>> 		return;
>>>>> 
>>>>> we can move its initialization after this "if" to
>>>>> prevent gfp.
>>>>> 
>>>>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>>>>> ---
>>>>> drivers/bluetooth/hci_qca.c | 4 ++--
>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>> 
>>>> patch has been applied to bluetooth-next tree.
>>> 
>>> Why did you pick the v1 when it is clear from thread that a v2 has been
>>> posted?
>> 
>> because I only saw that email after I applied the patch and the v2 is
>> nowhere in sight as it seems. If it shows up, I replace this one then.
> 
> Here it is
> 
> 	https://lore.kernel.org/lkml/20210503100605.5223-1-paskripkin@gmail.com/

seems to have missed my inbox. Fixed now.

Regards

Marcel

