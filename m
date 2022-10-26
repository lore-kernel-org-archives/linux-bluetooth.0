Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106ABC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Oct 2022 09:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiJZJRz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Oct 2022 05:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJZJRy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Oct 2022 05:17:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620849AC21
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Oct 2022 02:17:53 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oncXm-0005qX-EX; Wed, 26 Oct 2022 11:17:50 +0200
Message-ID: <818a55d5-ea65-a962-d83d-0186bd666c2d@leemhuis.info>
Date:   Wed, 26 Oct 2022 11:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US, de-DE
To:     linux-bluetooth@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <RJ4W7HKW.X5Y4H63W.RFY63IY6@7AFBARQQ.HKEIB7DO.6ME2HPJY>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [Regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
 unusable again with kernel 6.0 #forregzbot
In-Reply-To: <RJ4W7HKW.X5Y4H63W.RFY63IY6@7AFBARQQ.HKEIB7DO.6ME2HPJY>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666775873;47c96493;
X-HE-SMSGID: 1oncXm-0005qX-EX
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 24.10.22 23:11, Jack wrote:
> Cheap USB BT dongles that are bad clones of CSR  "ID 0a12:0001 Cambridge
> Silicon Radio, Ltd Bluetooth Dongle (HCI mode)" have had historic
> problems, due to various bad behaviors.  See [Bug 60824]
> [PATCH][regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
> unusable (https://bugzilla.kernel.org/show_bug.cgi) for more details and
> background.  The patch in that bug was initially mainlined in 5.9, and
> underwent several revisions since then.  It has continued to work
> through all of the 5.19 series, but it does not work with any of the 6.0
> kernels.
> [...]

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced 766ae2422b4312
#regzbot title net: bluetooth: Cambridge Silicon Radio, Ltd Bluetooth
Dongle unusable again with kernel 6.0
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
