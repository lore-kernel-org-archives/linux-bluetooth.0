Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4F7C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 19:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiCYThr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiCYThk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 15:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB14C17942F
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 12:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D55261B4A
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 18:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C63FEC34113
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648232796;
        bh=RAx6FOewcKaU5ZAVz9H7p6QpEigmHpoJxw5PnIWiTOk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cntaN1QJj/HizxMjnAZqeof8eXKs1LKwChxx7j37NLtMmnueS8S9Cgn6It4XpR68I
         wKaxLRunJPUiHNxlcQds8T7my4/V7YbEmKiOKCAQl82+FzxHQze4WZfTIdBlLOH0nM
         Ba5SiK/TQUYBQoGFlOaUkkUlgP5EHS70cGPVg5sbmH4sUEyHXpQGHeFh7j1vOz+vlu
         RkqXW8/Eg0abRg+cNxc++NSFI8FIGrFEOrz1U5TFMYOGl4/qGlMuJAcN8lyjmqX3wW
         fSF0bn3VZZEUAlqpAxCyTNq9ykSpe2USWy/5LWfONY7DCHdM/rLed13/RvVjghuXCI
         FNM4WFC4HeLVQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A90C2CAC6E2; Fri, 25 Mar 2022 18:26:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Fri, 25 Mar 2022 18:26:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215528-62941-sAB5pnuGd5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215528-62941@https.bugzilla.kernel.org/>
References: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

--- Comment #15 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Artem S. Tashkinov from comment #13)
> @Luiz Von Dentz
>=20
> Why doesn't Linux 5.17 include this patch? Could you please push it to
> stable?

I thought Cc: stable@vger.kernel.org was just for severe bugs not something
like this that has almost no effect other than spam dmesg.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
