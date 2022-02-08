Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A9EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Feb 2022 06:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346913AbiBHGtt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Feb 2022 01:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbiBHGts (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Feb 2022 01:49:48 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151F2C0401EF
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Feb 2022 22:49:48 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nHKJu-0004ue-HD; Tue, 08 Feb 2022 07:49:46 +0100
Message-ID: <d565674e-b12c-2444-6efc-65c1e6e540d1@leemhuis.info>
Date:   Tue, 8 Feb 2022 07:49:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Bug 215576] New: HSP/HFP mSBC profile broken with QCA6174
Content-Language: en-BS
To:     bugzilla-daemon@kernel.org, linux-bluetooth@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1644302988;921d95a5;
X-HE-SMSGID: 1nHKJu-0004ue-HD
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

On 07.02.22 19:00, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215576
> 
>             Bug ID: 215576
>            Summary: HSP/HFP mSBC profile broken with QCA6174
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 5.16.7
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Bluetooth
>           Assignee: linux-bluetooth@vger.kernel.org
>           Reporter: mike@mjones.io
>         Regression: No
> 
> Created attachment 300405
>   --> https://bugzilla.kernel.org/attachment.cgi?id=300405&action=edit
> dmesg with 5.16.7
> 
> Between v5.15 and v5.16, mSBC via pipewire stopped working with the QCA6174
> adapter.
> 
> Switching to the HSP/HFP profile with mSBC codec in pipewire produces a loud
> buzzing sound, and the microphone does not function. When using PulseAudio
> instead of pipewire, the buzzing is absent but audio input/output also don't
> work.
> 
> Other users are reporting the same issue at [1].
> 
> I ran a git bisect between these two versions and the issue seems to have been
> caused by this commit:
> 
> [b2af264ad3af437238c9500aa830ebcafb180e05] Bluetooth: Add support for
> HCI_Enhanced_Setup_Synchronous_Connection command
> 
> [1] https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2019

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced b2af264ad3af437238c9500aa830ebcafb180e05
#regzbot title bluetooth: HSP/HFP mSBC profile broken with QCA6174
#regzbot ignore-activity
#regzbot link https://bugzilla.kernel.org/show_bug.cgi?id=215576

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

