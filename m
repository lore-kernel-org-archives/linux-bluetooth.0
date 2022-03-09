Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0575DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Mar 2022 11:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiCILvV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiCILvT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Mar 2022 06:51:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2136E6D877
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Mar 2022 03:50:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B22E1618DE
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Mar 2022 11:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22B23C340F5
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Mar 2022 11:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646826620;
        bh=QT5OX4qqkAlNMxgfmCSN0L9bY/hQUjzfjAR6MxW6TTA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Nf+kjoeNrBporJrjz2vP4jofqyi86XsOD8eqqDLZkjRRyjm6ExmWOk9HB+6EGtMqT
         m/g6FiFPhlVwcLO0aOLSbhHpunpE1NBYkz4fqIuVm23g/BbIHCUmSM+FZPBLdfZibo
         afiIHYRcCpUpWsCgwb0JVEx9sYuUu7ZsNM1CFIMUemmJPpj3k5VGqhIRAEmEGuaMcY
         SprKzdVTNZkEPEDYJXAkvm3kTgx6r3ZLzLsxmepRwGry+GBwFRDyiNkqAcXKlswRbM
         EjgnnSHyLW43Vnbv517cCGWoVe7O7pfdBvhXtVSgnasQ4TX4Q5N3K6EGs+us03W7w3
         H+31qzTqvDQJw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 08619CAC6E2; Wed,  9 Mar 2022 11:50:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Wed, 09 Mar 2022 11:50:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wavexx@thregr.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215576-62941-eErM8QcOF3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

--- Comment #9 from wavexx@thregr.org ---
Any consensus at least of what a proper fix would look like? I have to rebu=
ild
a new kernel for this laptop and I can help test around @pav's patch if nee=
ded.

Is Kiran in the loop?

I no longer have access to an AX20? chipset to make some tests on it sadly.

Maybe we just need to check a controller capabilities flag for E-SCO in
addition to the device's own capabilities.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
