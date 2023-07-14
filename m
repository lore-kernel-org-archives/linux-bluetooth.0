Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40BAC001B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jul 2023 15:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbjGNPHl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jul 2023 11:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjGNPHj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jul 2023 11:07:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8F32702
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 08:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE30461D70
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 15:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 501CCC433C7
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 15:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689347258;
        bh=HGd9ocdbxyEalzYLlpCGQFfKl+8zkN/f6YEvmn1LGCc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=P7fToaxXyPPPV1Ovm+80cu9k37hvKHN842tNtdnINdbWxTpm2o7nxqW4paNqm7a3u
         M5v1L1ObQQyAcydQd3/KvVG9MI0RvAe5G11ohR5SX5h8b7rOQTWlyfZ8lBqhwD2IcO
         B2YGaSzblhZmmRBKUQtTQo8Ziz7KJHf3yVz1MNJnJkVgoHLLalRTNS8kXnq54Rqm9L
         D63jglQaUTrmrOQ8emr452Y8hifrmcbGmsS6qu2k7HttrjoDra3Yelbkltmc7/wI3W
         wFGT2BAYAEXM5+yCNzEKt8bxnIVYK8pe5xzouqeDkO9wR65rS+TLClB3ftk5ftnK3t
         Ab/EwwkR2v59A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 429EEC53BD3; Fri, 14 Jul 2023 15:07:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 14 Jul 2023 15:07:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marwane.elbaraka@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-ZG9SPXrZpg@https.bugzilla.kernel.org/>
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

--- Comment #273 from MarTCM (marwane.elbaraka@gmail.com) ---
(In reply to MarTCM from comment #272)
> (In reply to Marcos Ferreira from comment #271)
> > The device support will be dropped down?
> > There is a possibility to keep this device working since the changes ab=
ove
> > can make to the device work, even with some logs in dmesg...
>=20
> That patch doesn't seem to work anymore *sigh*

nvm the file was changed and so did the number of the line that needed chan=
ging
I ended up doing it manually and I'm now waiting for the kernel to compile.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
