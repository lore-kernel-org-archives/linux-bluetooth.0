Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B04EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 16:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGLQeH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGLQeG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 12:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58E1E69
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 09:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A7186182F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 16:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC48BC433CA
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689179644;
        bh=LhYFAj+wAymiN3qQ51tVQ372vHrf6IkReDq5NSQje4w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h16jnyAi6U91025V3KNpGaOsf9fBszU1kOXs/BCHfXOmU+U7xrF8aq3ekgl3NGzrZ
         QO7SRLtTFfUquuD9bPTEJPoBBHS4XTV1fy0J91hYSEz8ffxoAXudj/KzXZvywrOtUn
         CWxzu4HLwKG1upjSSmDeVVxaBSuIT+3f/waw5ukCU4GzApMxhVNx/yo2TIj/iTwUra
         vRm/xni7tN+oj1E6FKwj57wL9zYkw52RTLXgpWkaJU8bSgwLCYrT8Rke7XMfjQKDcw
         oLgFTaSWif61TuUuiMdE6fLi0Wgj2uBPjrIhseFsb1IvYfcB9Sdlk3J88X1pGOU4Gf
         bEaBxMH9CWx+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 89896C53BD1; Wed, 12 Jul 2023 16:34:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Wed, 12 Jul 2023 16:34:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: espritlibre@yadim.dismail.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-3KzxO5G3BO@https.bugzilla.kernel.org/>
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

--- Comment #14 from espritlibre (espritlibre@yadim.dismail.de) ---
i made some progress, i found the kernel version which introduced this bug.
good linux-5.19.9.arch1-1
bad linux-6.0.arch1-1

i started the bisect but while building the 2nd kernel i got build errors. i
will start from scratch when i find the time again, this already took me a
couple hours due to the annoying nature of this bug...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
