Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AABC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Feb 2022 06:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347804AbiBHGty (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Feb 2022 01:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347792AbiBHGtx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Feb 2022 01:49:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AD6C0401EF
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Feb 2022 22:49:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D16EDB817D3
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Feb 2022 06:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88080C340F2
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Feb 2022 06:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644302990;
        bh=x8/gwAyS/ckucuPb1yFG3M2FH+1673+LOHSSiwkkTvU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RZ7rn5VOtn56hnxDFb1BgtReorSaREQINDtHRyA2rzQx+C2KnlcDExZAvI6YFJJt0
         OYIvTtBUSXFFwtej8ctgzdtIyl3X/KBf8FcDqV7eKDhRw1NOCAYjVKcOgRgGSgQ+zL
         8HeV+bdz28kX8CZJHtd0HWj6OJ4cEnswJRHZOXMl836TVLGgJAuLeXuxNdI4U0oGbj
         pfHHtNhZ7YV+OAJTuvXw7FcFIZi/XEnYtlpyHV6B5ZjPwNgHtSt82PNiXkhlyzIFQ4
         SxLgIZp63f4FybhBXWpApqq9Uzey1PUK0lFkaGMuweuNa5HF7SBbLyKG0fZJ6nODfv
         OcJBA79TLsuPQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 72932C05FE2; Tue,  8 Feb 2022 06:49:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Tue, 08 Feb 2022 06:49:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215576-62941-vwLe9opE7R@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
[TLDR: I'm adding the regression report below to regzbot, the Linux
kernel regression tracking bot; all text you find below is compiled from
a few templates paragraphs you might have encountered already already
from similar mails.]

Hi, this is your Linux kernel regression tracker speaking.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 07.02.22 19:00, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D215576
>=20
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
>=20
> Created attachment 300405
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D300405&action=3Dedit
> dmesg with 5.16.7
>=20
> Between v5.15 and v5.16, mSBC via pipewire stopped working with the QCA61=
74
> adapter.
>=20
> Switching to the HSP/HFP profile with mSBC codec in pipewire produces a l=
oud
> buzzing sound, and the microphone does not function. When using PulseAudio
> instead of pipewire, the buzzing is absent but audio input/output also do=
n't
> work.
>=20
> Other users are reporting the same issue at [1].
>=20
> I ran a git bisect between these two versions and the issue seems to have
> been
> caused by this commit:
>=20
> [b2af264ad3af437238c9500aa830ebcafb180e05] Bluetooth: Add support for
> HCI_Enhanced_Setup_Synchronous_Connection command
>=20
> [1] https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2019

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced b2af264ad3af437238c9500aa830ebcafb180e05
#regzbot title bluetooth: HSP/HFP mSBC profile broken with QCA6174
#regzbot ignore-activity
#regzbot link https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

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

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
