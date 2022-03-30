Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8486DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 16:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbiC3QNo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 12:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbiC3QNm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 12:13:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524F73BFBD
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 09:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD21461775
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 16:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47F1AC3410F
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648656716;
        bh=SMwyuxsG2M3TgqzWbs2LRpDQ1Lc+QdlFs2WeMICSSe4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oo5JZ63fMSdP2k0biH5FMtAVQm5tZ4SvPeoJpvjTftfxaXZhHkgt3ed30PMnUXOC6
         PU+wUquNyfEftWpP8WKaBYk33Pqa0WdtQdejIChihltvk6K7CaL58MQ/xVPoOCj5LH
         it8wLLpyPjszTz5N+m2uk6NaxOsA8G9HGvsx8orocxMUH7r1r4DZ6pQBmbEW+wDEwJ
         +nedPC9IMyFs1IB42VCz8/BtduMuW4C+YwlfxM+Rff4uMAi83Gfy5omD2C5/rRN19C
         1lnSyZu/PFdq+EEi9E9XN1ddga8iAZHaSghdKGOFyboeho1N+CIPW6fZ9mm3t20QiT
         13zFSqJJvi7sg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 280F3C05FCE; Wed, 30 Mar 2022 16:11:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215776] Unable to reconnect Bluetooth keyboard after
 disconnection
Date:   Wed, 30 Mar 2022 16:11:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zacmarco@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215776-62941-gkONsGEaWk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215776-62941@https.bugzilla.kernel.org/>
References: <bug-215776-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215776

--- Comment #2 from Marco Zaccheria (zacmarco@gmail.com) ---
Hi Artem,

thanks for the quick reply, the problem I have is that 5.17.1 seems to tric=
ky
to get precompiled for my distro (Ubuntu 20.04 LTS), because of unmet
dependencies (libssl3).

Being a work PC, I would avoid going through the process of manually compil=
ing
the kernel or external packages, or doing a full system upgrade unless stri=
ctly
necessary (for example, if I'm sure this would resolve my keyboard issue).

Said that, is there anyone in he BT support team that could try such a
configuration? To be honest, it seems to be a very common issue out there as
there are plenty of forums covering (with no final answer) the same topic, =
so
it doesn't seem strictly related to my current keyboard.

Could you please advice?

Thank you

   Marco

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
