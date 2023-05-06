Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF91C77B75
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 May 2023 13:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjEFNhA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 May 2023 09:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjEFNg4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 May 2023 09:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047674481
        for <linux-bluetooth@vger.kernel.org>; Sat,  6 May 2023 06:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EFCC615C8
        for <linux-bluetooth@vger.kernel.org>; Sat,  6 May 2023 13:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3ED5C4339C
        for <linux-bluetooth@vger.kernel.org>; Sat,  6 May 2023 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683380215;
        bh=2fhiGPgLV80Uxdf5Hj1cZd3+zXD5o18S8L+sdu/ffoc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=D9U+0lBUs+CUmPRQIVPVdRAwPK1KtvLgPnLag93ncIQvgsjQwwoz3z9HC+axuIzxG
         SpEQKS+akwliqttXEkwL0BLd0QcNbeQIiwqCJf+tnG3QHbbpzarnFTo1QelHnmBDqD
         poW/FRL0D3k23prF5Zkd6hT7xk6OVulPTsKneQCkaoRHL8LqHCmVpLmLeRsw3xXuAc
         EU19rUqLain8wLT/qdjpz5qM7voXC8AiFiHbbgUqawSMSa/QNYl2SwsU21D5R2rVI9
         pEuH0JScT5qr4Wtmb72La8bvM7aSMRjHJA3N4nlPJiCQ4V6gDtrIj4K27tt4Bc2QEG
         KJaY7OvUWKisg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DF74EC43144; Sat,  6 May 2023 13:36:54 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 200007] HP Elite Presenter Mouse support
Date:   Sat, 06 May 2023 13:36:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: denisclopotaritei@yahoo.it
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-200007-62941-Yxk3HQbeaV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200007-62941@https.bugzilla.kernel.org/>
References: <bug-200007-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D200007

Denis AC (denisclopotaritei@yahoo.it) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |denisclopotaritei@yahoo.it

--- Comment #2 from Denis AC (denisclopotaritei@yahoo.it) ---
Same issue had on Solus (though there I could use the gesture-mouse functio=
n),
Ubuntu & Manjaro (and a few others I cannot recall).

The issue spread across multiple kernels, the current one I'm using being:
5.15.108-1-MANJARO=20

The devices used were:
HP ProBook 455 G5
HP Pavillion

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
