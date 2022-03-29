Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA31C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 08:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiC2IDi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 04:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiC2IDh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 04:03:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72471E3DE
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 01:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68182B80CCD
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 08:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEB8FC340F2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648540912;
        bh=/9ozGYZ6mGnpWJP2vacgPYZzGmZHVQuO6KJl+Sj3VWo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=q/eByb6aYMb26Qd8bjN9jF2bCBgAC2aiPrW4dILzYk9NE8bHnvFeVnA6EOuE1IkwJ
         FnfysKB2+Ng/IYf5d1ICijJSETLh8/2pOETO1jd/n2j0Y3gz+KAL5yyTTZ7K4JT4Qn
         L3fcDhE9A71j81bbecbvUwRCzA+87h/dOORlLYdozTMGGN7hopaBmNb4h7R8opmCYP
         PuQlXBeV0h78pcm7vdUKkxzonYPMdQNzV9uNPoqyWxAyxDA6CoeM5D+sZeVRpH0G7w
         sbLk6F7WRMlmt/8i0ufR/6lg7mterx6z8YEkXKEy+pJvDx8a0MNkxn4Ektindfb37+
         J7yeElOmj/oHA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C9200C05FD0; Tue, 29 Mar 2022 08:01:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215725] Basilisk X Hyperspeed Bluetooth LE mouse fail to
 connect under 5.17 with Opcode 0x2043 failure
Date:   Tue, 29 Mar 2022 08:01:52 +0000
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
Message-ID: <bug-215725-62941-MtkKAbJFu1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215725-62941@https.bugzilla.kernel.org/>
References: <bug-215725-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215725

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Hi, this is your Linux kernel regression tracker.

On 22.03.22 14:38, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D215725
>=20
>             Bug ID: 215725
>            Summary: Basilisk X Hyperspeed Bluetooth LE mouse fail to
>                     connect under 5.17 with Opcode 0x2043 failure

Hey bluetooth maintainers, what's up here? That's a report about a
regression that was submitted more than a week ago. Has anything
happened to get it fixed? Reminder: this ideally should be fixed in
5.17.y before 5.16.y becomes EOL, which I guess will happen in round
about two or three weeks from now.

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
