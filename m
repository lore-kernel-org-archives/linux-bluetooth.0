Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C99C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 07:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiCEHIZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Mar 2022 02:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiCEHIY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Mar 2022 02:08:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD6924F2C
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 23:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 251D9B80B22
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Mar 2022 07:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9242C340F1
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Mar 2022 07:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646464047;
        bh=Rp+pZ1o8YSwuldVkCmOD77B2qhl05Ren3ovSgqqt0AU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZHU3xe/x6FB0Zx8WU3qMLQBUiCQgEQ4AdCT+VFBEvbwDd+4UpCs6fXFeKDOxz1CmP
         HtJYMvUDpbLp8WOco4F/7iWwbjNv3SFOrlg798KQNNJNbXYLG6+XvlE867ze0a0t+H
         2tHpgoNUl+kmlIuTqOKwm/zTsqy0dyLC+1RHTyCMi+P7aYwdZ7kPjSxOy1BrHRHl9M
         9P5xJEXVRfeGrOlazyGbVJ1jLZEVnvlNExXdKIzG/oBB0IFeVRHG8NMQuNKGOMW8j0
         zxOAwtzKEKldcIByAsznL6+KNV3AZKZHoJBQSoMR93M4ZYfA4tDJPJmHS+S0mu7WSc
         hURF3cP5zza3g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B4BD5C05FD6; Sat,  5 Mar 2022 07:07:27 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 05 Mar 2022 07:07:11 +0000
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
Message-ID: <bug-60824-62941-Mc8QPuRgIw@https.bugzilla.kernel.org/>
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

--- Comment #225 from Swyter (swyterzone@gmail.com) ---
Quick heads up, had some time today and sent v3 for kernel review. We'll se=
e if
they like it:
https://patchwork.kernel.org/project/bluetooth/patch/3b6c7c18-dc48-b924-bd0=
9-3638a5c741a4@gmail.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
