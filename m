Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AADAECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 09:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiIAJzq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiIAJzp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 05:55:45 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F2C74B9B;
        Thu,  1 Sep 2022 02:55:43 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oTgvG-0004mr-A3; Thu, 01 Sep 2022 11:55:42 +0200
Message-ID: <f39757a6-f636-39d6-81f6-3d327fcd7155@leemhuis.info>
Date:   Thu, 1 Sep 2022 11:55:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: Bug 216382 - [bisected][regression] mediatek bluetooth 13d3:3563
 (mt7921e) doesn't work with audio devices.
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
References: <167d11c6-68a4-c10a-9703-fceaddac3e42@leemhuis.info>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
In-Reply-To: <167d11c6-68a4-c10a-9703-fceaddac3e42@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1662026143;eab69712;
X-HE-SMSGID: 1oTgvG-0004mr-A3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 24.08.22 12:19, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
> 
> I noticed a regression reported in bugzilla.kernel.org that seems to be
> handled there already, nevertheless I'd like to add to the tracking to
> ensure it's doesn't fall through the cracks in the end:
> 
> #regzbot introduced: 26afbd826ee326e63a334c37fd45e82e50a61
> https://bugzilla.kernel.org/show_bug.cgi?id=216382
> #regzbot ignore-activity

Luiz, what's up with the regression?
https://bugzilla.kernel.org/show_bug.cgi?id=216382

You replied and asked for details the reporter seems to have provided
nearly two weeks ago, but it looks like nothing happened since then. Do
you still have it on your radar? Or was there any progress I just missed?

BTW, is this somehow related, as it seems to be caused by the same commit:
https://lore.kernel.org/all/5a667caf-642f-11d5-f4a4-6a73ed5742fa@eknoes.de/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

#regzbot poke

