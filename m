Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60ACC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jun 2022 22:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245737AbiFOWTv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jun 2022 18:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiFOWTu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jun 2022 18:19:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7333EBD
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 15:19:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05144B8218C
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 22:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62A02C3411F
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 22:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655331586;
        bh=PHqsXisFbGlCyqGj+UHpAgfq/sWVCV31DlWrzvZHyfU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lyYKq/bPQSWQa+DEJifwRrexAnOeOnexwdJy+3KVrEPE7zSvTEkNfSzJ5YxD8+W1B
         m7HsdM5ZdOy+YZ2l+e9gwMKnn1XKil49kTT12VqwD49UAxmEhLLuIHab2VidyH9lVb
         YCsKjsD2j6At1zzQB+YN+LGtsw39+UkR4aCj7pCc0vDDj1xCxFhB3aivjLeLLBiHl7
         qsSUcpcIGlV/56GwndJKbLAZlsa22ka1TsKiH5kFhKsB/XJuJkJIPsto6gkAOvCvMi
         2W3Za2w5kvctHkImPSBS4RXZQyynMp7VilGhkr5+xey2BD8WyiLvuUCz+m4I1LBkC/
         t6unbJYfvnQ7w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4FC21CC13B3; Wed, 15 Jun 2022 22:19:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date:   Wed, 15 Jun 2022 22:19:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andri@dot.ee
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204589-62941-mcIVLUKSd0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204589-62941@https.bugzilla.kernel.org/>
References: <bug-204589-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D204589

--- Comment #7 from Andri M=C3=B6ll (andri@dot.ee) ---
I know this bug is about the Magic Trackpad, but just in case they're relat=
ed,
I'm experiencing the same drops with multiple ca 2010=E2=80=932012 Apple Ma=
gic Mouse
products.

This with two different computers, kernel versions and BT chipsets:
- Arch Linux LTS v5.15.38-1-lts and Intel Corp. Wireless-AC 3168 Bluetooth
- Fedora v5.17.13-300.fc36.x86_64 and Intel Corp. AX201 Bluetooth
(linux-firmware @ 20220610)

There's definitely something reproducible. The common suggestion to disable
eSCO does not help.

I also noticed another possibly related issue:
https://bugzilla.kernel.org/show_bug.cgi?id=3D103631

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
