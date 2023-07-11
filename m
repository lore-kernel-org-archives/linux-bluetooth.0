Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2ECEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jul 2023 16:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjGKQNT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jul 2023 12:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGKQNS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jul 2023 12:13:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBCCE4F
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 09:13:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98D7261560
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 16:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 055C3C433C9
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689091996;
        bh=Vhige8aDcYZbCJyPqT/HY22bRUf2YrWuTiOSo+fYgSg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LKK3wB+2EItBswLSi5rYwyZ1rrg1Cp3BbnOyyqjYrfh5pX7xsqX6L7FkvMWm5rZFI
         VOnGhGZpW2XX5ArSmZb63NNLGzO9tOcNry3upxLlzu9xVMCe/eVkfoADHp9EWDiI5k
         qu2afbV/A1DQyPsAx7ljRMnXVvZab+aXucev2sbfGlqEQZmlRiUFk9eezk+GGMDcdY
         lMhnyjYVh5kF85Rv/M5D5+3ugy1M/ngnEyLw7zC5gMyq+qIC4ivX4iqYecXLdgCVJd
         3KBkCuOq52kngUKGKhFb44a2hoEiBKonENCo/NiUJrs0whXDxSiW4OFPXYO+0IfV9Z
         Aqn/fZzXLbWiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E1366C53BD0; Tue, 11 Jul 2023 16:13:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Tue, 11 Jul 2023 16:13:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johnbholland@icloud.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217651-62941-XXVz87G6Jn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217651-62941@https.bugzilla.kernel.org/>
References: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

--- Comment #13 from johnbholland@icloud.com ---
> Thanks for trying to find the cause, that helpful and simply needed in ca=
ses
> like this. You might want to bisect between 6.3 and 6.4, as maybe it's so=
me
> change outside of bluetooth that broke things (but it's possible that you=
 are
> on the right track, too).
>
> Side notes:
> * might be worth giving 6.5-rc1 a try, with a bit of luck it might contai=
n a
> fix (but there is a decent chance we are unlucky).
> * cross-compiling might help to speed things up.


You're welcome. This is a new experience for me. It's pretty mechanical=20
at this point, it just takes a while for each kernel rebuild. I hope at=20
the end of it to have some useful information.I may be doing this off=20
and on for a couple days :) . I'm getting much more comfortable with the=20
steps to make my system boot with a new kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
