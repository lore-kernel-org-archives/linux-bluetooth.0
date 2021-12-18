Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C125C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Dec 2021 06:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhLRGPP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Dec 2021 01:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhLRGPO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Dec 2021 01:15:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD56C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 22:15:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B53D7CE0D9A
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Dec 2021 06:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5CE1C36AE0
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Dec 2021 06:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639808109;
        bh=iKCpGuEmJXicWHlDKPHV7W/DeczfS7stqGNlskrfG9U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KQsQK7xKhxVGRqJ1k0q6Mlnsd0cG9BtQjF9jBBXKK0+uESbsI8YIDAdPZ1AvYtEn1
         sTVqsE9upOYzt89DHND3+PaibcL2la+8rkg4OG0NV6KNc0Yt9ogruzQbgAfoH3whDE
         f2qW3sD/vue8LS9lJZLd4b/FmRx/RAwHj6ULpql7GZfQF4Kcux5AyCydNKdcsgGcpq
         scUA8PjzoD9aVfk5yTFtlPYgp1EBoZSW/6WRyUc2M5plxKR0p8qhhmI2LE5Wblu2AC
         Ef8LBz7QPDbpWwW31NuUn9Yl+HDxTozj8gsLa5VYPvMGTdNde8w53a3tOnOOq1dmZh
         EXKYB4t5pMRaw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id CD25160F55; Sat, 18 Dec 2021 06:15:09 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Sat, 18 Dec 2021 06:15:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: hui.wang@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215347-62941-2R9xWyRRRI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215347-62941@https.bugzilla.kernel.org/>
References: <bug-215347-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215347

--- Comment #5 from Hui Wang (hui.wang@canonical.com) ---
Created attachment 300059
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300059&action=3Dedit
btmon log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
