Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84852C46467
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Jan 2023 13:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjAPN3d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Jan 2023 08:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjAPN3c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Jan 2023 08:29:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEF91A4A3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jan 2023 05:29:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8695260FA1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jan 2023 13:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F084CC433F1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jan 2023 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673875771;
        bh=mGlDBroaBR89CevP6TgmIWiW/pgLUBAdrrJY0oyGkmE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lQHmn1eK89DJbeZOF85umyAcz2ErJPC8mSqIdLMBuJen0f5jzUKotSHXgBx6zKQML
         MWzCmOG74a25AuxCl/9dQjgJCxjv6s6/ciZvlX1ArIJ7MhDoCY1KaVmNjdLERLCQda
         9yybeNEwKIF9NvRZ/wIrdol0tHCe4mIyL1rRPBm0yC1vFRIMw5EquISelZCRxrTwmt
         jDhlFaa5KB4RparjHFfXszKAXiP1wxem/iy4i1qgQcuf9xuGTYTzhSLNA/IjHoPIOq
         hGMo243joBktooq5r47xveXs0+22hrHPRUOGHekh4yFChEFN/XlMEqFqGI1sJiCvJi
         9tEhWlAMG9F4Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CBFC2C43142; Mon, 16 Jan 2023 13:29:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Mon, 16 Jan 2023 13:29:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216817-62941-2IhLqClKuj@https.bugzilla.kernel.org/>
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

--- Comment #10 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to Mario Limonciello (AMD) from comment #9)
> As this completely broke bluetooth for a number of people,

Did it? Ohh, interesting.

> can you please
> consider this to be sent up to 6.2-rc in a fixes PR rather than waiting f=
or
> 6.3 and
>=20
> Cc: stable@vger.kernel.org # 6.1

Luiz, that sounds like a reasonable request. Did you work on that front?
Doesn't look like it from here, but maybe I missed something.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
