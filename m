Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2C7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 14:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiB1OVQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 09:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiB1OVP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 09:21:15 -0500
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 06:20:37 PST
Received: from nmtao202.oxsus-vadesecure.net (mta-202a.oxsus-vadesecure.net [51.81.232.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D34B5D673
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 06:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; bh=to5mGanr23V3+NjCmy2QFaJhOsnQ1lWGN+6Vwf
 rVUWU=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1646057735;
 x=1646662535; b=UYD4R+MbknYseuDPkWnql8GY1x4kzHCr1OlpcYX2YmfXxzkhXkLXe1N
 YiOJQKGq3rR0WVnWaCREoOZTLGlv94vQIwjFwlVkjvIwmgez3eEOuasUS2WT+8SwDihGawF
 kXz91RRfB6xEuVZscjfyfJHLPZ3VyT0HSd0NxuYJSYylEGVVecYwuwe2+XSHzzEsJ/7gY+E
 UI+IlDb0CYiuCjIHNb6FBxDWxLOAv++iO8iyJZSJ4y8U9ZwYf3lVz8VJEF48YrihrODl14f
 MxJ0BdpIOuIGCPc8VEgtka0mnkZnGfE67AQZvBvHfy9rrJDcoOL6fb46LD/4Jz7P27N4w0s
 EgA==
Received: from [192.168.1.152] ([104.185.76.86])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao02p with ngmta
 id e1b53b85-16d7f8ca16939665; Mon, 28 Feb 2022 14:15:35 +0000
Message-ID: <f46af838-8b28-79e6-5298-4458b44664ca@mindspring.com>
Date:   Mon, 28 Feb 2022 09:15:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     linux-bluetooth@vger.kernel.org
Content-Language: en-US
From:   Ed Beroset <beroset@mindspring.com>
Subject: Battery1 vs. GATT reporting
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In 
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=713f6f09 a 
flag named "external" was added which, if I'm understanding correctly, 
is supposed to mark the Battery1 profile as safe to also share via GATT. 
  However, I was recently working on an application that relies on the 
GATT API for battery power and found that it only seemed to work as 
expected (reporting via both) if I set the flag to false rather than 
true as in the commit.  I looked through the code and it all looks 
correct, but my observation indicates that perhaps the sense of the flag 
is somehow inverted.

Here's the project I was working on, with the relevant bug report.
https://github.com/AsteroidOS/libasteroid/issues/13

So can someone verify that:
1. the interface is intended to be shared via GATT and Battery1
2. that it does not work that way today

Ed

