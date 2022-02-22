Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84624C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Feb 2022 06:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiBVG1u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Feb 2022 01:27:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiBVG1t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Feb 2022 01:27:49 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC24577AA6
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 22:27:23 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nMOdr-0003pO-Jz; Tue, 22 Feb 2022 07:27:19 +0100
Message-ID: <a13178af-2f2b-1b61-387c-f9b268b80b38@leemhuis.info>
Date:   Tue, 22 Feb 2022 07:27:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Since commit e8907f76544ffe225ab95d70f7313267b1d0c76d bluetooth
 scanning stopped working on my system
Content-Language: en-BS
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <f648f2e11bb3c2974c32e605a85ac3a9fac944f1.camel@redhat.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <f648f2e11bb3c2974c32e605a85ac3a9fac944f1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1645511243;e54fc7e0;
X-HE-SMSGID: 1nMOdr-0003pO-Jz
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


[TLDR: I'm adding the regression report below to regzbot, the Linux
kernel regression tracking bot; all text you find below is compiled from
a few templates paragraphs you might have encountered already already
from similar mails.]

Hi, this is your Linux kernel regression tracker speaking.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 21.02.22 23:37, Maxim Levitsky wrote:
> Today I updated to a new kernel and I am bisecting few regressions:
> 
> I noticed that if I open GNOME's bluetooth setting, it hangs for like minute or so,
> and then shows only the paired devices and no scan results.
> 
> I bisected this to this commit.
> 
> For reference I am running fairly old fedora 32 on this machine, and thus I have
> bluez 5.55 and stock GNOME from fedora 32.
> 
> I can provide any more info on anything if required and/or test patches.
> 
> I wasn't able tor revert this commit as it is part of a bigger rewrite of scanning
> which makes sense.
> 
> I tried merging bluetooth-next master as of today,
> into my kernel but no noticeable improvement.

Thanks for the report.

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced e8907f76544ffe225ab95d70f73
#regzbot title bluetooth: scanning stopped working
#regzbot ignore-activity

Reminder for developers: when fixing the issue, please add a 'Link:'
tags pointing to the report (the mail quoted above) using
lore.kernel.org/r/, as explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'. This allows the bot to connect
the report with any patches posted or committed to fix the issue; this
again allows the bot to show the current status of regressions and
automatically resolve the issue when the fix hits the right tree.

I'm sending this to everyone that got the initial report, to make them
aware of the tracking. I also hope that messages like this motivate
people to directly get at least the regression mailing list and ideally
even regzbot involved when dealing with regressions, as messages like
this wouldn't be needed then.

Don't worry, I'll send further messages wrt to this regression just to
the lists (with a tag in the subject so people can filter them away), if
they are relevant just for regzbot. With a bit of luck no such messages
will be needed anyway.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.
