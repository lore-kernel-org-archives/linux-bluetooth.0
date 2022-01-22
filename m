Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF1FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jan 2022 05:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiAVFF5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Jan 2022 00:05:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39948 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiAVFFz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Jan 2022 00:05:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09C0E60E9F
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jan 2022 05:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CF80C34101
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jan 2022 05:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642827954;
        bh=hO+iEqaps4E18tcJpsy6pll3JD5a5UHa9j3dSPyGWjM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hsInn6wv0o+yazThcPIwKvU3nII4xSf+83IlfIpnmqmkJIxzR6qJK1Q4sLoiwI9KP
         CIBTogKsCWsuXxGU18iuKJpTdt7iQan2p8UE9m6dwP0IUJ9L2VmVkEI7tHF1oO/gAM
         35rdEKyXrFa2ypPhiLi6bSF6TD0mFzih3zf/UrmNS7LYkYybZzD3Cysa5h/86/lCT+
         mORvh1+GvKJFja/mAcHQ9MCwaqpqJqZnxVDCTVEDOKWlrIGJ8LFgxvVjwcYqiGQwpd
         HTdAD7ZqJR7rMFE5CFb6TpowmnCi4R9wH2VQs+i+YYR0Bc/PD3ZXcjv3MJ+V0M8Fiw
         9bDsiF4ZUVUwA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5D8F1CC13AA; Sat, 22 Jan 2022 05:05:54 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 22 Jan 2022 05:05:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-KZYS0bzJjP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #220 from Swyter (swyterzone@gmail.com) ---
Glad that v2 works. It's more or less the same thing, but now I understand a
bit better what is actually going on in the Bluetooth driver. So yeah, maybe
still in need of some tuning. It will get mainlined sooner or later; I'll k=
eep
tweaking the thingie until Marcel likes it. No rush.

After that I'm thinking of making another one blacklisting two fake dongles
that don't seem to like getting force-suspended. Maybe pverda's case is a f=
alse
positive, but this seems like the best way of doing it; opt-in.

With that I think we'll finally reach some 80 or 90% of compatibility in the
Chinese Bluetooth saga. Maybe other people will keep improving the quirk li=
st.
=C2=AF\_(=E3=83=84)_/=C2=AF

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
