Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C10ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Oct 2022 08:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJ1Iog (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Oct 2022 04:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJ1Iof (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Oct 2022 04:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DA412AC2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 01:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5AE9626E3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 08:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AF30C43146
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 08:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666946673;
        bh=Aqs676O+l6lXRWPnK9L1Qgphh801O5VBCeCLMUSuosw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=icLrcw77rBDBl8XY3ti1kFlhVJd/Ibqoe6aZSyoIlMpd6kuT0cWgfIRXDvdwYx0Ls
         Jy/2Bb2zZCCS3XnZhIS0mLzErc7uR7dRCzHpe3cqb/4Yh8q0/b+nfM/4QOor/39b22
         LAErIHTG6If1Jb5MeE+CG1k7vgdjRX9NFG1IDD3Zm/O+imfQ+qFO4GTO6FmlQ56z0T
         OOTKE+aAyb4BtGO1BGplQG47Fn2rDXLEX4moRBw4CKPI37ciMfnhKlu34FYTf2ryGZ
         4sX7a5AqaWbr7qZ3hDG7P5oHVp3yVudPD/1cEd8XmBm7rey2fLzwvSyu4EUOesl0tL
         zE9CvieONbNaA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0DD75C433EA; Fri, 28 Oct 2022 08:44:33 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 28 Oct 2022 08:44:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-FgtBMHDT8E@https.bugzilla.kernel.org/>
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

--- Comment #241 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.d=
e) ---
Zijun, that commit is in Linux since v5.18-rc1, so that cannot be, cf. `git=
 tag
--contains b3cf94c8b6b2f1a2b94825a025db291da2b151fd`.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
