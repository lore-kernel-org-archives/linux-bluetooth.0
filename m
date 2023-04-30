Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17277C77B60
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Apr 2023 08:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjD3IoZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Apr 2023 04:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjD3IoX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Apr 2023 04:44:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ACC172B
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 01:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B9ED60AD1
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 08:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8958FC433EF
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 08:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682844261;
        bh=LAw6rD3Erf+PUSIPlp3IpZe6zoVhaEyVQcTx/lqqar0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=p/BeFchOj9swgJZTrLlNgfbkoUFC7CD4yoLn11GHO4gy5V1RajMTEaFTu1omagCka
         wmcB8jZqXi7TcCedgzkGRwCAeaLKhnkSjmJNGX8KZ7d7dDt4SIyqlUYbD6ab581uvL
         ePo8ZYSgue5MXOwav+DJARC2MAKQVAgaSR16JzhkWFcOsu+zcgNjpgRH7rdo2APvFo
         +j6zARvJlh4ms9+Pn/0fioJavR+yndYlx9sqZ6xDg/U4P0Gsi2eTwMYI5MmxvsuRnp
         7/wNzxZJJs79sC6834/UJUlS6m/FNvBqvRahodZTBb+rnEHBpn0R2OqnYIf4ymquhh
         v4N/3/WPCW1hA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6C5FDC43143; Sun, 30 Apr 2023 08:44:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Sun, 30 Apr 2023 08:44:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jay+bko@jp-hosting.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-pG7LHiDs9W@https.bugzilla.kernel.org/>
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

--- Comment #9 from James Addison (jay+bko@jp-hosting.net) ---
> I'm not yet sure whether there's a specific series of actions to recreate=
 the
> failure.

Maybe a clue: of three recent boots with the 8260, two were "cold" (system
booted entirely from poweroff state), and one was "warm" (a system reboot).=
=20
I'm not sure if that terminology is correct, but: the "Failed to send firmw=
are
data" error occurred during both of the cold boots, and did not appear duri=
ng
the warm boot.

Does any of that seem relevant in your (9260) case, Artem?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
