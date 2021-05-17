Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97A4C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 13:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B62611BF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 13:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhEQN5H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 09:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237525AbhEQN5F (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 09:57:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AF2C061364
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 13:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621259748;
        bh=tnFVD2/KOSRh88rewoa4G3v3OV59bYA/LedbO6BPKG0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KaVPatnqNXgwaahQnNuY4U4nG+ZAniSN6icmx7ZC90I8P6fWKmjxndJ6AglOZKgun
         7xk+GGxtrhDEg7jbTDjZKxkzJ9VVnH/ayszLPcxDVX5Y9Cvgf28q651tzfQweNV2+k
         sYvxOUXfSoK/S3dVLLLo8hHBPcxbOOl3iPH1QAK+ymPY+X8Bq4ASFN93rCiAI7Kbgd
         aPHKlhFlybUUmJilEzNPITamMLQxwOhrbRWCZl9kOApTQqI9pZaMa8ijdUzjDdfQIR
         LcodQYDpayl5RQNN2Y9EXeUV6Ia6Ygf+da6sV2yQaCOOYzB9c4/RHhyzuGayS8EO6h
         y/+mmYH89ycWQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 17 May 2021 13:55:45 +0000
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
Message-ID: <bug-60824-62941-2Odl3ScxRA@https.bugzilla.kernel.org/>
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

--- Comment #180 from Swyter (swyterzone@gmail.com) ---
Newer versions of the kernel should detect (most) fake CSR dongles and warn=
 via
dmesg, check this out:
https://github.com/torvalds/linux/commit/cde1a8a992875a7479c4321b2a4a190c2e=
92ec2a#diff-82175cb30d8f0e6fd9fb8b83571c33aac5db6db4d5f79dd97d4255116a79c79=
eR1813

My mainlined patch also adds a few known workarounds, which with the latest
bluez changes seem insufficient. But when I originally submitted the patch =
it
made my dongle work just fine. So in theory using an older patched kernel
should work.=20

Improvements are welcome, while getting a new dongle is a decent solution
ideally we'd fix the counterfeit ones enough to work as well as on Windows.=
 The
problem is that bluez is a moving target, with new modes being introduced a=
ll
the time, regressing these fickle chips.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
