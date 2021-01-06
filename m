Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC89C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 09:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B3023102
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 09:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbhAFJ0i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:26:38 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:42367 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAFJ0i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 04:26:38 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.1.150] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D371F1BF210;
        Wed,  6 Jan 2021 09:25:55 +0000 (UTC)
Message-ID: <ebbb9f334f6f0cecdb46ddce63483df165ea12ec.camel@hadess.net>
Subject: Re: [PATCH] Bluetooth: L2CAP: Try harder to accept device not
 knowing options
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Florian Dollinger <dollinger.florian@gmx.de>
Date:   Wed, 06 Jan 2021 10:25:55 +0100
In-Reply-To: <6e6d72ff9aa14a65d6d0df5bd68a6ad6887f31c2.camel@hadess.net>
References: <20201208172912.4352-1-hadess@hadess.net>
         <CABBYNZJNTDek+kKS5wtrr67Xx8DmFGvcV13cLSxULgJRa5N+3g@mail.gmail.com>
         <6e6d72ff9aa14a65d6d0df5bd68a6ad6887f31c2.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2020-12-16 at 16:49 +0100, Bastien Nocera wrote:
> <snip>
> The tests fail for me in the same on a kernel with and without
> the
> patch:
> - Expected that the IUT transmits an L2CAP_ConfigRsp includes the
> unsupported option that Lower Tester sent.
> Final Verdict:FAIL
> L2CAP/COS/CFD/BV-14-C finished
> 
> Is this expected? I was using an 5.10-rc7 kernel with and without the
> patch I sent. I can send you the full results off-list if you want
> them.

Any news on that? Is the error expected, should I test with a newer
version of the kernel? I'd really like to finally land this...

