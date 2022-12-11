Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A45C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Dec 2022 15:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiLKPhz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Dec 2022 10:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiLKPhx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Dec 2022 10:37:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093B8D5C
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Dec 2022 07:37:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7F5DB80AEA
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Dec 2022 15:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 701ADC433EF
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Dec 2022 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670773069;
        bh=WuBb1g3TDEGCDbfT0WldqUW0t3d3Bcr6B3Zswl/oKXU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XBeicMGpNxX1+xD57mPNQKEQrECXvOsmg/nUYo1K3o2eBWor6O858DioecOF1ZNp6
         pTxaBaErN/jgbLi8DTVkEFC1+ejzEdF17pOWS11RGRmwjO+vIQLWLQJgKJNJLb48Vv
         1OB3hGGZ8qyyhzZzfqX3Jsmv+xiVvatXE5VqwXSdjbOrJ55Jcm77GUR2mWl8ImME6D
         QZKAS0OKsuGIFNnzUrXcrGgoEiCUKzohJnjSPbcPMCsnEW/JDFQciYixgvuOc1LF2L
         zVPBbvBcm4n1TOfcJG7w3zK0yqLkGx1ZNuY7o+J4/VSoX32OrYM1GGNZsmyPoAOb6w
         9B71geN9hNh9g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5FFA6C43143; Sun, 11 Dec 2022 15:37:49 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 11 Dec 2022 15:37:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-6UW5wdjWYW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #261 from Swyter (swyterzone@gmail.com) ---
Good news on my end, it seems like Greg Kroah-Hartman has added my two late=
st
patches to both the 5.10-stable and 6.0-stable trees. So they have been
thankfully backported and not only shipped as part of future Linux versions,
and all is well with the world.

Happy to at least see this fixed, even if Luiz Augusto von Dentz didn't acc=
ept
my third patch to add a kernel command-line toggle to improve compatibility,
haven't received any signals afterwards and I don't know how to ask them ag=
ain.
Maybe someone wants to pick that one up and fight for it.

But yeah, in general the sweat paid off.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
