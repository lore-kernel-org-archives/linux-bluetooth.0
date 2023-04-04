Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC6C76188
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 21:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjDDVXd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Apr 2023 17:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbjDDVXc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Apr 2023 17:23:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953091BFC
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 14:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C716636EF
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 21:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89C30C433EF
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 21:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680643410;
        bh=fS+82gg3WM/rCfITJm2+e0NAaoDnL44oOBO/dS54hUQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MDjPvJ4CAzb9sBjYTFlMde5s5ymp6HM1vGITpN4ujlsURelz3f/5r4y3LaANAyuY0
         iCzzn8eZaPCNt00kfDU8SAPx1v144JNT8rV7ooUgDbPCNij/9L7wgxDFcRvaXTP6b/
         qkRPB9UifD7UjYeuSkhsMAH/OvZOuHHl5v+Cfg4CrMhiNdAt/m2wKoYiENM2LH84ie
         /+TqWU9BuWNrzrinYrPWMOZwboy40M3Bs7EgIHsocPFbyJe6TwZIp37O3LA9WEoN7Q
         cxQ4Kx4rZmBG5BrXauQTJFWrE59tGcdx/dS4iUUiUIEu4mMgTMdG+uNCvk1tgZRbbG
         08p7L5MUz4cbg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7ABD0C43142; Tue,  4 Apr 2023 21:23:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213203] KASAN: null-ptr-deref in range
 [0x0000000000000000-0x0000000000000007] when ASUS USB-BT500 bluetooth dongle
 is connected
Date:   Tue, 04 Apr 2023 21:23:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-213203-62941-BKpQbDuVKR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213203-62941@https.bugzilla.kernel.org/>
References: <bug-213203-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213203

Erhard F. (erhard_f@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #2 from Erhard F. (erhard_f@mailbox.org) ---
No longer reproduceable on 6.3-rcs nor on current stable 6.2.x.

Closing here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
