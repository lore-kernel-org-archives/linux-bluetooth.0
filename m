Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C86C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Nov 2022 05:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiKNFq1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 00:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbiKNFpu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 00:45:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF08117593
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 21:45:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A29B60EA5
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 05:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E77B8C433D7
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 05:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668404731;
        bh=6od0PvZw7cngLfJMzdHIX7JgSPKfE1L7hcw2n9tqRGM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sXdJkqTcrX0QPkY0yoRvuuF52pQRYzUUKy07LL1szb6at8UEgSQ4oxQae+7ngObnQ
         afI3y/Yj7zGWyWtrM2kuIDTmAyfvOI8DSCpyGZdG6rdLNu5+EJtHA6fcjn8g0SBLZ2
         y9FqeLEzxhYiDQkjz7CaizFIjJYoMikh9crAjNFwW//AsVRs+PkigZbV+EU00ybERg
         S55frGcG44vxuFXDapP/uLNfaUxJhWRoeGI7nni6P5f5uB5EksIEkJJMs0OMzILwgX
         FD6laHT6QI6vEGd0U9zuV/WBGJRlZ73k/Lw1UmLBxZbLrkXuTi/Kuf0j5K+2yB7om6
         PfWe8RixOTHdg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CAC6AC433E7; Mon, 14 Nov 2022 05:45:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Mon, 14 Nov 2022 05:45:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: frc.gabriel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216686-62941-goBzcI02Om@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216686-62941@https.bugzilla.kernel.org/>
References: <bug-216686-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216686

--- Comment #11 from frc.gabriel@gmail.com ---
Hi, these two attachments are when running the kernel from
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
(bluetooth-next branch).

I will try master branch.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
