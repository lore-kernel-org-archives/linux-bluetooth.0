Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA79C3DA78
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Jan 2023 06:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjAQGAA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Jan 2023 01:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjAQF7f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Jan 2023 00:59:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42B4234C8
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jan 2023 21:59:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 778D3B80946
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jan 2023 05:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33E7CC433EF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jan 2023 05:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673935138;
        bh=jWXcqh3VLXfOi/Y/XcpSyqxI5QJhwEHncL+t0HPvZQQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a6UeVTjCjK9n2vW/Udw7bMxFHRfEWkih0ye3QGiU11ezMo8lyYHljb+UVwPDNR74j
         sJG3SWiwpyN5sO4Ir7g4gU2VbI4VtFXk8J5OLe9Kk4uhgWjJsOYO8nfih9epwgGvcY
         nTsQgicW0tbTdtA2B7w4W7rtkN2xPW+HLTFM6lADl52XuzeuA5ig33b7+C/FH7FISB
         ThzXdq1Cm2aXgkHE8eWJhWd1rNqqpgg8R0D/cAdpUyTq70syHAN9yH3yhSjszXz2FG
         qDMh4vA7YvicoXRizBdt/g3LFz+TP9jRq/6A/yUuj04LV3rgQjbPLCoXptcLfEJXns
         TyFcWte6LmI+w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 16E3FC43142; Tue, 17 Jan 2023 05:58:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Tue, 17 Jan 2023 05:58:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216936-62941-khsJBeTCTW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mario.limonciello@amd.com

--- Comment #4 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> Kernel 6.1.4 and previous kernels didn't have the issue.
> I had these errors with 6.1.4 as well.

Which one is it?

If you can find a definitive kernel it really was working 100% of the time a
bisect would be ideal.  But given the ambiguous result you indicated with
6.1.4, I suspect it's not really ever been 100% correct.

Perhaps turning on dynamic debugging for net/bluetooth would be helpful to
identify what about the sequence of init causes -ENODEV.  Naively it looks =
to
me that the main reason this can get returned is if a command is issued whi=
le
the device is actively being unregistered.

So perhaps your userspace is racing?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
