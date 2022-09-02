Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DED1ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 00:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiIBA3x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 20:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiIBA3v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 20:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26947244
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 17:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28A3B62096
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 00:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88D58C433C1
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 00:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662078583;
        bh=OTwNOiMK5zT/f/uEzINHHzzYEDfdRYS4ZYs1gSvxz40=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=n8MOYRkxkU6Vk435UfveQ8anRhB/rmk4btW2HlnC8tNW0BC6tW8l/WBv7AWRODIMV
         DoBiX2v80bLKp7v1YHJHBND/uDqkIt5eliTDbWTvGMsAcPkAaVOljFevQr3NI8N+mi
         aqq1ViWdHku6JrNacL+Zqecxw8Ax2q0weNXgdpdFQiao7/Dr5C+nejzTEV/DlFV0FO
         s+L29QO0IUxyMTsqZ9K+zhoHTXAsVSTFq/iC2yFj31W5S9c38VfA6JnMMS4CeGKbzL
         LRBFqG1pQMKUH+3qDTRyRQbaWDCFXP/0q2l/xR2/01Xcv0jxi3HRw44Vbjito1A4J5
         Gm0J5yLiLKb7A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 65666C433E4; Fri,  2 Sep 2022 00:29:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216382] [bisected][regression] mediatek bluetooth 13d3:3563
 (mt7921e) doesn't work with audio devices.
Date:   Fri, 02 Sep 2022 00:29:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216382-62941-0py7LhofeD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216382-62941@https.bugzilla.kernel.org/>
References: <bug-216382-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216382

--- Comment #4 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Created attachment 301727
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301727&action=3Dedit
Patch

This shall fix the problem, weird that CI didn't find it though since it qu=
ite
clear that ACL buffers will not be initialized thus preventing any ACL traf=
fic.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
