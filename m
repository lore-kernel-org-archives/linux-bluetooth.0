Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1755FC54E76
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Jan 2023 20:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjAQUpk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Jan 2023 15:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjAQUhZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Jan 2023 15:37:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A2283C5
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jan 2023 11:22:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D56B614E8
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jan 2023 19:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BFBFC433F1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jan 2023 19:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673983346;
        bh=9gQAxEWdKlKIP0mbQa3Nz7+n8mSkOf+cWlg6ZLuopgU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M1VLZx3v8jZbwokI7/fPUjuX2A7/c1XVHSLmNv1oAL3crPQl0rN7FjclEu5B5VTZg
         R/udVB87YNK4B8E1/eQSOHUvl+8DYRkhTnbHpM5jkB8+N6/V2uymbJ6Lf99G5Itx7N
         VVJ4nB+O6K3lzvOSeNoVdwdpYCfI9k/MrhGo5+ALkS/Kuax57jzsp70wSaUJTVBwFX
         Ptxoz+45dsZyl0xbwrqQf+CXISeTORa3zclkYmldyc4yfqJvZqxfZ31hccycrn8Nbg
         GYOr1PbbgSkdL/14G20Mw1L6qbTdqdsRejljVoKs2U7io6anxbNlhOvld+vAAquI98
         exahDVhOXdfzw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 88463C43141; Tue, 17 Jan 2023 19:22:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Tue, 17 Jan 2023 19:22:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216817-62941-5IeyilTF5E@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216817-62941@https.bugzilla.kernel.org/>
References: <bug-216817-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216817

--- Comment #11 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Sorry for late reply, long weekend here, I will create a pull request for n=
et
so hopefully this get in the next rc.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
