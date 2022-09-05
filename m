Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD614ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Sep 2022 20:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiIEUj7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Sep 2022 16:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIEUj6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Sep 2022 16:39:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46082222BB
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Sep 2022 13:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2A01B815D8
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Sep 2022 20:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEC98C43150
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Sep 2022 20:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662410393;
        bh=ue5kMlPJov2zowk0VJHVrpgLDR8yN/U7YQs++i0aqwY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hoINiMYdgSIGnb6IvDTCwOBymUrYgSvMUdhX7bfN3qb6une17b4giAtQkqHCqZKbt
         zPMH21nmMXqooWfXFwjkxyyIpm0pWGX3omdP0ergNAEEDU74/WH14uwFiHFCU9Le/E
         XcY+g6p8p5SPdHlL+8cufidmlJ71iulHHQmiH4xiaxFWfoaIEdgl0lhD7/yt6uCFIZ
         BlsnqPWD5lytjXjsn4wkoigbJ+Vf3FrFxLfLDxIei8Im+L0AgyOzkiVeGkWTezyABW
         FfksNenEOfG3Npu7q7Bw/lv4ewMz/G2YachmTXU/pT/UyhzCtP4stN2emPN0NxWMiY
         7xTJFoJ8Y1p1w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A0202C433EA; Mon,  5 Sep 2022 20:39:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Mon, 05 Sep 2022 20:39:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215768-62941-7jmuzo5lyZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215768-62941@https.bugzilla.kernel.org/>
References: <bug-215768-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215768

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #42 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
Michael, thank you for your report, please open a new issue though. (And it
would be great, if you could bisect the issue.)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
