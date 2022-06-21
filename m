Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC79C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 10:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiFUKIw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347417AbiFUKIV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 06:08:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E8D5FDA
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 03:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0024CB816DC
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 10:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEB64C341D2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 10:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655806091;
        bh=3ars+8905ySy72ttc5d2NuBNa5wtMk7teCYt+1vjNuU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tD+xtHUv+xtgAhs/Rd4ERNFUylr1A68fI3ixXmO/4StQsVI0eK26waI8H5jfu3tpR
         Ljb17ERImdqlx/eEfxON0mTHx1SvTa0T8NkU4p+efcjHGdCitL84SD/K7jZLLPYCBJ
         0Vz7g/JYR1sIfOxydjbeCUVK3v0WxxcZAUVBQT0rRFSAnONzSyTNUyIb55lkQD4Rdu
         DM5/moX/kFxCzIlzMn7yrHF02Cj3pCaENWwDv9ENNF6tYZf1KF+npBlFb9SriEBmuO
         jD4csHfChpb0jalDvaqrHCklhaWeJ6lkS13mo1QJf2a7CWeUaeL78oQ8saDAfCCQbf
         PskWStk6HG4Mw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AD75BCC13B5; Tue, 21 Jun 2022 10:08:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Tue, 21 Jun 2022 10:08:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Krzysztof.Krason@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-EtmpzAtu6w@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209745-62941@https.bugzilla.kernel.org/>
References: <bug-209745-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209745

--- Comment #30 from Krzysztof.Krason@gmail.com ---
I moved from 5.18.3.

What is strange I tried to double check it, booted into 5.18.3, mouse and
keyboard connected almost right away. Booted back to 5.18.5 and it worked a=
lso.

And then I tried suspend and this is the issue on my end. Doing suspend and
resume causes the bluetooth devices not to reconnect (I need to connect
manually from bluetoothctl).

It is hard to tell when it stopped working because at around 5.18.x suspend
stopped working on my laptop, so it was basically  dying each night, 5.18.5
fixed that, but it broke bluetooth reconnect.

So basically, this is a different issue, I need to find the right kernel th=
at
had reliable suspend (it was one earlier 5.17.x).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
