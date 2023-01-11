Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03830C5479D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 19:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjAKTqq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Jan 2023 14:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbjAKTpo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Jan 2023 14:45:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0E039F96
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 11:44:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AA8C61DE3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 19:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF733C433F1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673466266;
        bh=16WR/Qhsd1s2lQJJhIcg0FIJJDRNgQtfznyxGllgKPc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hRnxgUqyg+/srD7SBdsyP5ieJHyU5opsJ+ywSi0lAqikSsUGBW/+pky8CYGOowgon
         qoKi6UOnE+PIKqzXId8KorzTR6537Zl6Eo7SlWC1ToZYFYmeOTC3oXHtF3mC9AQ1L2
         SiWFFkZuCMyS1iZvJ3AXRB0pKH4OZcxAZdx4yqUQS8jtxUrNFh6huEzGcfUohPCHeT
         zT3H32GPnYwS11qT3NRSEB0T6vJYmG0ZbX3KUL8Pzx0X5ArgojYqwRFy+5F7pVuDAC
         Km6kuRE1yqo2lFeVGOwy+FerxD8r9Hd37AwLA1bscHS1XO9EelfzpY3+25A27s4CIz
         fBTtk9Fr7NpUA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9FBF8C43144; Wed, 11 Jan 2023 19:44:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Wed, 11 Jan 2023 19:44:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_file_loc
Message-ID: <bug-216817-62941-5P8zChYoJY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216817-62941@https.bugzilla.kernel.org/>
References: <bug-216817-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216817

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                URL|                            |https://bugzilla.redhat.com
                   |                            |/show_bug.cgi?id=3D2149136

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
