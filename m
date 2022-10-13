Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAC1C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiJMPkI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJMPjo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 11:39:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7A6DEEE
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 08:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B44B4B80DFB
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 15:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63E3CC433B5
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 15:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665675580;
        bh=pgLBD2UIPadXPbinkZr2a8FISuGLuSQjCCbOn/8vehw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ay0dgPhNRi0kUuOBuADWqE4QihfT6w6lCi0mXtXUjxemSOMbn5gYNg6PZdoGSoSMi
         Q/p0QJXtb0LJqk9CxJ42jFFvn4Sfs6DtyAdGubNhKh+nzy8pCloNz4PoaAdMJonhLU
         slxN3uwa0WplNsL/WBoVNftCTfFJ2RbxsflR+H8V6urMzBYMvudy6lEFDxDL/qwDQJ
         UHHIjlaUL3JJQ7oWXQc/K18KlCg67MymoCfuKjfb664ipFW1tz3RKEfPjA9mcEbJnK
         /62i5XX5WsIUatLSPsKCf5lHTEKYwJr8RKJhmfTvyuDlGLcICJ9vEl+9WOtdb+qOhO
         ImEF022KyvrUg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 49E2CC433E7; Thu, 13 Oct 2022 15:39:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216580] Jabra Elite 75t (ear buds):Unable to connect and use
 (`hci0: Opcode 0x 401 failed: -16`)
Date:   Thu, 13 Oct 2022 15:39:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216580-62941-PFaBugDlaW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216580-62941@https.bugzilla.kernel.org/>
References: <bug-216580-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216580

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Created attachment 302992
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D302992&action=3Dedit
`journalctl -o short-precise -u bluetooth -b`

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
