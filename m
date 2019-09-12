Return-Path: <SRS0=he+3=XH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A21DC4CECB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Sep 2019 11:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763EF206CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Sep 2019 11:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfILLWv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:22:51 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:47600 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbfILLWv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Sep 2019 07:22:51 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2019 07:22:50 EDT
Received: from localhost.localdomain (unknown [88.128.80.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 74CEFC11ED;
        Thu, 12 Sep 2019 13:14:57 +0200 (CEST)
Subject: Re: ANNOUNCE: rpld an another RPL implementation for Linux
To:     Alexander Aring <alex.aring@gmail.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Cc:     Michael Richardson <mcr@sandelman.ca>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Robert Kaiser <robert.kaiser@hs-rm.de>,
        Martin Gergeleit <martin.gergeleit@hs-rm.de>,
        Kai Beckmann <kai.beckmann@hs-rm.de>, koen@bergzand.net,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        reubenhwk@gmail.com,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        sebastian.meiling@haw-hamburg.de,
        Marcel Holtmann <marcel@holtmann.org>,
        Werner Almesberger <werner@almesberger.net>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>
References: <CAB_54W7h9ca0UJAZtk=ApPX-2ZCvzu4774BTFTaB5mtkobWCtw@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <78e83575-4bae-cb8b-be8c-c108ac488a37@datenfreihafen.org>
Date:   Thu, 12 Sep 2019 13:14:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAB_54W7h9ca0UJAZtk=ApPX-2ZCvzu4774BTFTaB5mtkobWCtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Alex.

On 29.08.19 23:57, Alexander Aring wrote:
> Hi,
> 
> I had some free time, I wanted to know how RPL [0] works so I did a
> implementation. It's _very_ basic as it only gives you a "routable"
> (is that a word?) thing afterwards in a very constrained setup of RPL
> messages.
> 
> Took ~1 month to implement it and I reused some great code from radvd
> [1]. I released it under the same license (BSD?). Anyway, I know there
> exists a lot of memory leaks and the parameters are just crazy as not
> practical in a real environment BUT it works.
> 
> I changed a little bit the dependencies from radvd (because fancy new things):
> 
> - lua for config handling
> - libev for event loop handling
> - libmnl for netlink handling
> 
> The code is available at:
> 
> https://github.com/linux-wpan/rpld

I finally had a first look at it and played around a little bit.

How do you want to review patches for this? Pull requests on the github
repo or patches send on the linux-wpan list?

So far just some basic stuff I stumbled over when playing with it. Build
fixes (SCOPE_ID and different lua pkgconfig namings), leak fixes to
config.c as well as a travis setup to get building on CI as well as
submitting to Coverity scan service (the later two are already tested in
practice with some dev branches I pushed to the github repo, hope you
don't mind).

regards
Stefan Schmidt
