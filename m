Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C09EEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 13:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjF0NXG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 09:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjF0NXF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 09:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F58C1701
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 06:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0A9261198
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 13:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24373C433C9
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687872183;
        bh=+Vx0xCQCJAvh7VurlaNAJeSCVZYSVd7gkHUswVMzbBw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iFPkxLXQ37ct3J2L6UXCZ6K5lZH7vtXv5x51y9PBZcf5gTCx2v7Y04i094PunwjCx
         l6wYyeWBZOtl+USRnhorBXIKonysLYYENFyer5XSpCwmRGd1i7Xj3lS7QGlrCKU2AW
         aCPw6+cIN+M/weaVS7FxW/agNQegPSylQkXOGCn5OxdIFd7501L+lJQrNozNqlmUer
         24m7gRbvsXHKqjkS23H2xRPl1iMpwPWwQCTumVGcxUtNTV9hBgWes0IXxog45YAuW8
         j+/5hV4eEUVAV2mvp/qV/xsUWVSy+r8Ololp9nIvcc8eE2bw29rQDg1ZdnZYpID+iA
         h4/ciXWL1oNTQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 09602C4332E; Tue, 27 Jun 2023 13:23:03 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217581] Bluetooth L2CAP use-after-free
Date:   Tue, 27 Jun 2023 13:23:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mohamed-yassine.jebabli@witbe.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217581-62941-Ap8CjuByRk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217581-62941@https.bugzilla.kernel.org/>
References: <bug-217581-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217581

--- Comment #5 from Mohamed Yassine JEBABLI (mohamed-yassine.jebabli@witbe.=
net) ---
(In reply to Bagas Sanjaya from comment #4)
> (In reply to Mohamed Yassine JEBABLI from comment #0)
> > In reconnect slave mode, I start direct advertising. After establishing=
 the
> > connection with the central device, we begin ATT exchanges over the L2C=
AP
> > socket, and then I receive a disconnect with L2CAP traces. This issue is
> > observed across different kernel versions such as 5.17, 6.2, 6.3, 6.3.7,
> etc.
> >=20
>=20
> Do you have this issue on v5.15?

Not tested on v5.15. I started with 5.17 version.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
