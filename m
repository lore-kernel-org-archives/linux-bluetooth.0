Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6296C0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 19:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjG0TXt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 15:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjG0TXr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 15:23:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21306E2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 12:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA4F361F18
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 19:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10E0AC433CB
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 19:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690485826;
        bh=7TgiHXKFalhIdebJ6YE5hi6rKiv8HgBt1RUgp02oTRE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WVhc2Zz+inUjdZ1BV1fOeAXXj6OPSkFxbzexCYmHx0ENangM6Loz7nbPDaVcZGtMi
         oryPBOuQUFx6OLGtM5cq8GdqH28MQdQecbdPAswOG2emhGMtPTKLgaQ2OXdHpaNCro
         LGQ95S22h4ufMgI7y9SmtOg9zqgVDPVbuhQQ3Rl0pNJaokUcv+5vQRjAzeH8X7y/dm
         VxnVl5YSvzMM4NzS5OAuw6IoRJkOVZ31GUcsh+K2BUx6HI/OGvOKwBAtFLLsLv4AZC
         Fv/tnuKBa/6GgJRvp1k9HDlaMzgnTj6pboU8Vhwo10GD3p2gSR5AZ37kV8gZ1SjpJb
         3gWpXl6uGzUkA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 007D4C53BD0; Thu, 27 Jul 2023 19:23:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 27 Jul 2023 19:23:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: egor.katkov@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-4KA4NoyjdQ@https.bugzilla.kernel.org/>
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

egor.katkov@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |egor.katkov@gmail.com

--- Comment #274 from egor.katkov@gmail.com ---
Hello! I am experienceing this bug with kernel version 5.15.0-78-generic

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
