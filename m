Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E498ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 19:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiIBTGI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Sep 2022 15:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiIBTGG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Sep 2022 15:06:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC51ACA08
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 12:06:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F0BAB82ADC
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 19:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9C16C433C1
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 19:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662145562;
        bh=ckbc+A3J4w4BnUs92AbFIAukq4PTSO0RTEKYAVY7Ok0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WDsAaeZ7roTo4iuu84DZmiWITl5caJ5+NXcnLYjLkDJxCz7PERfFxC65zPWJtlTJ6
         q5AJY5YpVrk0JG5ylPvOlVk/hhy8+JxrtTRbxTTfMj6NnwlYVdxZdZDzeP6vdZJxKp
         cjjfw0OJV7hZH3vRXKEqh7X/wIGRyebGKSs3YrmO/ZIndxnCbWceVZ19lYWx33K5TU
         KAx2beUjFrbEI8p3CcP7ipBR94QB8RlEDT/qgU7QW7Kzdvbjo0hiI/RHxgCdXe6I2/
         1fFz7PpWgU1FzvjMhn99bUNhW+d3nM94PeOc4FGdA6hB5IytqTVJxK2kkvTUEGrg1g
         pZsBWQqlXmRDA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A3158C433E6; Fri,  2 Sep 2022 19:06:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216382] [bisected][regression] mediatek bluetooth 13d3:3563
 (mt7921e) doesn't work with audio devices.
Date:   Fri, 02 Sep 2022 19:06:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216382-62941-syi4Zlt4mO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216382-62941@https.bugzilla.kernel.org/>
References: <bug-216382-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216382

--- Comment #5 from Arek Ru=C5=9Bniak (arek.rusi@gmail.com) ---
thanks Luiz for fix this, i've tested it on top rc3 & master and my headpho=
nes
live again.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
