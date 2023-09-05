Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F82DCA0FFD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349899AbjIEQWZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343978AbjIEDIm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 23:08:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD95ECC6
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 20:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BA9A60AC6
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 03:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C71BFC433C7
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 03:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693883317;
        bh=7d8uKoM+C8LIYfLRxC4d887k4i3+tzLgJWpKc4XEXR4=;
        h=From:To:Subject:Date:From;
        b=Be9Fx8CpT++/qBict7hTSojqdC6a/ajhi04HbUhWECJs1uhW87DFEWzwU2U3IcjFz
         rp1029lEVpVNYULG+slqlcFSgtXIcPKTrzoZEVJEbRlpId7Id12XLwXrpGH5qchjAe
         yWbLQLaBkZdpKx/UA9mE3mUieYUVm6IOmYGDQQV+ecZYVij2vxrs0nAjQ7Zxbum2L+
         dJ8LItkKmAzlqEYpiN3U4AznSmlxdIABVQ97kG9rytD0brqlsUaRZxufJGGwmrRjgk
         mtLAAt2Vl5TlNBgDazEaQ+09A6Qjfe+grlCgR3TxJvJz5IpBcjdJSMBmJeaUkuIpcO
         T3XQ+VkSgtCag==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id ABE59C4332E; Tue,  5 Sep 2023 03:08:37 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217870] New: ATS2851 chipset for Baseus BA07 Bluetooth does not
 connect, no bluetooth device connects, adapter does not turn on
Date:   Tue, 05 Sep 2023 03:08:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mg-tatangelo@hotmail.com.br
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217870-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217870

            Bug ID: 217870
           Summary: ATS2851 chipset for Baseus BA07 Bluetooth does not
                    connect, no bluetooth device connects, adapter does
                    not turn on
           Product: Drivers
           Version: 2.5
          Hardware: Other
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mg-tatangelo@hotmail.com.br
        Regression: No

doesn't connect/bugs on linux, mainly on KDE, on KDE it doesn't even show t=
hat
it's connected, on gnome it shows that the adapter is connected, but it loo=
ks
like it's plugged in and not plugged in at the same time, like, it really, =
IT
IS CONNECTED, but it appears that it is off, no device appears to pair and =
when
it appears (rare occasions), it keeps loading infinitely when I click to ma=
ke
the connection, an interesting fact that happened and I will leave it here =
as a
help: when I I use a virtual machine with Linux, THE SOUND CATCHES, the ada=
pter
picks up, I can hear what comes out of the virtual machine, with the same
headphones that I try to connect to the bluetooth adapter and it does not go
when Linux is my main OS, the only The thing that doesn't work is the phone,
through the virtual machine, but the sound comes out! so probably the chips=
et
works, but it must be misconfigured or have little/no support for the chips=
et
and that's it, I hope you can help me, hugs!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
