Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E92C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jun 2022 19:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiFRTSD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Jun 2022 15:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiFRTSD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Jun 2022 15:18:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3192C1181B
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jun 2022 12:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4223B80B46
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jun 2022 19:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97F6BC341CB
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jun 2022 19:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655579878;
        bh=XUog+OAKwyqJq+K+HVXg3y+ZoEjwYeBPXmlYCOAjYCA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=L4mDaEFv+h5M7BQabIDNlMwjOm5qo5eU17vxZW+5xIiUOfWUSZ90F+lfL1XDALsTZ
         Gr+gt4ODRk5yDxsJCtwFzU6VesiiPoj41hTogZDXQj4oVPun6E1yF3KdwJniP9hsbV
         Dz1mXl4qGdfBh4EBhWbQTDY0god/qXfnYNBUPOO3odiVFzj8PN8QafhtSGv4YmkHvH
         dInCdpmiftiJcloRzFuxf+f1Zn9EqGBKZkssX8DDWCSNKlZiwWfLcFyKtOAAhhvftZ
         n++BS98S17N+hyK4r5kIrB9qXRRdUq0/l5fVrvWacpBSc6YlBv/3dTQxahhOhzp2f/
         LAk2CNy/LOofA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 85467C05FD6; Sat, 18 Jun 2022 19:17:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Sat, 18 Jun 2022 19:17:57 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215576-62941-Akfq3BLHhQ@https.bugzilla.kernel.org/>
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

--- Comment #15 from wavexx@thregr.org ---
Created attachment 301217
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301217&action=3Dedit
Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN to btmtk to fix mSBC

I'm testing now 5.18.5 (from debian unstable) where this has been backporte=
d.

Still broken on mt7921e, mSBM doesn't work.

I see no quirk set there. Adding HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN =
to
btmtk fixes it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
