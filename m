Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B095C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Oct 2022 18:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJOSpo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Oct 2022 14:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJOSpn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Oct 2022 14:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2102E30F62
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 11:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6707601D0
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 18:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC9DBC433D7
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665859541;
        bh=NQRfhiqegqF7V9Tcvb99UVV+SJKnLZ9rSEd5EH5N59A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=T1tkgpgDIzS6lEtG4Mfcgcso4eYCArMpJhIKeA4KJQd5kKZLeTjn4dBM+FMu9zsLE
         /CQjIPfdvoRlcvcvEYfKuLeH2ouFzG8rqNnq9RfVcP7gVPlJBzFWWmI7DuypoykMkd
         y4s7xt8C3v8nV6z0iXYaZSLEbVvfa88/1EBr06E+Qd8AiabFQGPb0bP31K22DBnWHl
         DxJZtYXSRhRCXZrdNSuLM3LmQkX/xkg6Pd6UEd2JbmFkmuwd3Ajm+gH0D7aOvSTiN7
         nwYIa7lGVPYgmPCOiL8uJJNGygANN+ZQS3lm4FrJIZ2IT7JyJXk6KeBhPNJizjpZee
         tt1SJfyGEMKkw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D7733C433E9; Sat, 15 Oct 2022 18:45:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 205821] ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
 Dongle (HCI mode)
Date:   Sat, 15 Oct 2022 18:45:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-205821-62941-GT0upI3Xnr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205821-62941@https.bugzilla.kernel.org/>
References: <bug-205821-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D205821

Jack (ostroffjh@users.sourceforge.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ostroffjh@users.sourceforge
                   |                            |.net

--- Comment #7 from Jack (ostroffjh@users.sourceforge.net) ---
Is this just a duplicate of 60824?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
