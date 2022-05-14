Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDDFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 May 2022 22:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiENWeA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 May 2022 18:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiENWd7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 May 2022 18:33:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C7165BE
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 May 2022 15:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BA9760C74
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 May 2022 22:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87E1DC341C5
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 May 2022 22:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652567636;
        bh=m0SCiEqVAfBG7XLDjqLefwoXETXLocp8m2NxOIsWbqU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=g3edN8Y2LKkG59UQgOz7C2jRpyRZ6yGTDhud0wGYlJP2p05Zcp3Lt7YyKDrrA2Ldt
         0nZKIvywOZLoYcLt9fpboh5sEe3IOleMS4UEx2yxaqvW9dVQw0nV355jfdHFEpoZtu
         5yzFOuX6BEo7al/AmeJo4HbisIQCJifB0gfXTkHS5rZtdJ/GsjYQ1ZiRvk0oUZB3Kn
         7ufqc1ck/ExzkrtCJUga1flzyriFVblHZeI+yFiNr9x/VW9mKcrDNjME4TjL+SQx+E
         2hgOMnmsgrmaH0JcNBKU/swoB+w9IUxdnjA2KGsM5WDF1UhhieMUSwANr3F1EtAUjG
         K+AYLjKVcF4xg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 743C2CC13B0; Sat, 14 May 2022 22:33:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 200039] BT advertising packet wakes up the system from S3 and
 suspend-to-idle
Date:   Sat, 14 May 2022 22:33:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bernie@codewiz.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-200039-62941-z15hloCprH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200039-62941@https.bugzilla.kernel.org/>
References: <bug-200039-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D200039

Bernie Innocenti (bernie@codewiz.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bernie@codewiz.org

--- Comment #40 from Bernie Innocenti (bernie@codewiz.org) ---
Not sure if I'm seeing the same bug, but my Lenovo X1 Gen7 wakes up immedia=
tely
after entering S3 when a BT headphone is paired.

The Bluetooth adapter is the same: Intel 8087:0aaa
Kernel version: 5.17.7-300.fc36.x86_64

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
