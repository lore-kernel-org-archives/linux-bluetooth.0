Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C012AEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 11:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjGMLbM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjGMLbL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 07:31:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDC418E
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 04:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64A5460DDC
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 11:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF393C433CA
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 11:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689247869;
        bh=OvQcyOH364lNrEQOlfp4yscoT2DurjjU7p7JOjm3TWw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Wk6rSNQsuKRw2+nl3EkpNeAkJ4VGDOgud2QdgD6nV17PoXC7yI3qc9pbxUDpV0A2L
         KCfMlqUCNJBX6287MYiH+BKp0uKzPeDp6nJp+GNAfwChA7/V25yGoSP45LXoq4jXYb
         1/jr21peNLt5NT3YfiSE2Rt7wgy2G2APANMuZpJqCgP13C9DDAB0YeyvmhjFbYPMOF
         YoKXzYNutI6c7KI5eOwMgQyrVvMpiz7g4YUX5vwyyHJ1WQ/nylzEy958tKLLoibCF+
         2O1DROvJ9FopuLDsAZMQzQXK/y5ifu845JAkZMJgJsE6PSo/ZWW+mslNJB2H3hfkfN
         Rv8lhgyxO46aQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B5F0EC53BD1; Thu, 13 Jul 2023 11:31:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Thu, 13 Jul 2023 11:31:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nick4temp-lfsofm@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217651-62941-gNmKB2X7Tu@https.bugzilla.kernel.org/>
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

Nick Bates (nick4temp-lfsofm@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |nick4temp-lfsofm@yahoo.com

--- Comment #19 from Nick Bates (nick4temp-lfsofm@yahoo.com) ---
I also have a problem with bluetooth, also on ArchLinux, but on a Dell Lati=
tude
E7240. I'll try with the kernel versions mentioned above, and also try Toma=
sz's
patch, in the next few days (urgent tasks first ...).

Bear in mind, I still see the bluetooth controller, but bluetoothd either
crashes or exhibits strange behaviour when my Plantronics BackBeat GO 600
headphones connect.

Does anyone want to see my lspci/journalctl output?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
