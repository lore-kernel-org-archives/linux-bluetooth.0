Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10443C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 20:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95ED64F17
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 20:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhBZUKw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:10:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhBZUKn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 15:10:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EEFB564E38
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614370145;
        bh=oMRyE2BArVTj5MIFH/3sv/b1F8h3NTuLQBz9u08tVeg=;
        h=From:To:Subject:Date:From;
        b=Qo+qnkIz9ms4dCSeKQFYMl1d9eIt/poe85z2tkDMlM1qslT0UWDiz4zLQsewrwUDC
         PgXbdv/S+UI5LQIzoDevlOVWh860tQDM7Ce8KnkZQBaiiBackX5Ozg7/AdadzvKomV
         7UU8+GwGpEhXCf/78j6s+Of4OrdyiN2L8Tsy7anjcy3KQ34omYs6UHXu41bNAKX9f4
         +xlw+dkgsMQIpanar1WoJUA8tp3LYLyQYgA2J+hfPq0TNcWsCknGfIe9RtVml0fsYe
         gOvsZ1i7/dBNer+VLwJ9BGfDgTpRERgZkDdqSUcK3DEPU/gLeXu/1/Z4CZWgcHd9W6
         8Z7kf9RhIxwxw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 211969] New: AX200 Bluetooth audio devices disconnect after
 random intervals
Date:   Fri, 26 Feb 2021 20:09:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ddimaggio324@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-211969-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211969

            Bug ID: 211969
           Summary: AX200 Bluetooth audio devices disconnect after random
                    intervals
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.11.1
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: ddimaggio324@gmail.com
        Regression: No

I've personally observed this issue on kernels 5.10 and 5.11.
Connecting my headphones with both PulseAudio and PipeWire causes disconnec=
ts
since a linux-firmware package upgrade (20210208.b79d239-1, Arch Linux).
Downgrading the package to 20201218.646f159-1 solves my problem.
The bug causes my headphones to disconnect after anywhere from 5 minutes to=
 3
hours, though I found PipeWire causes the disconnect to happen closer to th=
e 30
minute range.


There are a few user accounts posting about their experiences with this in =
the
following links:


https://bbs.archlinux.org/viewtopic.php?pid=3D1957011#p1957011
https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/732

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
