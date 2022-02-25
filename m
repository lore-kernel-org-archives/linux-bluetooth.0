Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F61C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Feb 2022 15:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbiBYPv0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Feb 2022 10:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiBYPvZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Feb 2022 10:51:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABF91BE0CC
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 07:50:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AA2161A0D
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 15:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10A77C340F1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 15:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645804253;
        bh=KdX87iJhu/FJo+gl5YaGO9zSZM8wc/f60jiR4MtDCu0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U6n1dwp1i2phkaCDEq5f+ZQXPedp9Er6EUtw9cqziYK2aMr7FfT1yBNF99fD1UZnR
         c4x1+MK6epqDz75lFijevql0GbVOzVOAJPwkClduBq+YJglhpTJvEdwnOuDXqexKrq
         iU3VRbnwHxPN4k56Zy/CNuZ5+FwlMgRCp8RouI8MIjgUo1jYBOGWas7GPfILydfBDT
         Z3oibbhGjrm8bxKTOcKtJEOwRJWR98lGZi9kn71DFJaEHnn/G64505H1NF0XmH1IIW
         0fFrAQRy4oYpsy6J1EpwxFMBmTABBwoqNCOC/fvnBeXJ08AbD2XTUi85+0OtiqrXP7
         xdmA2uBiYnXwg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E9578C05FD0; Fri, 25 Feb 2022 15:50:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210611] No Bluetooth on Intel AX200
Date:   Fri, 25 Feb 2022 15:50:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lnicola@dend.ro
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-210611-62941-hHdMsSbnnE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210611-62941@https.bugzilla.kernel.org/>
References: <bug-210611-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210611

Laurentiu Nicola (lnicola@dend.ro) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #4 from Laurentiu Nicola (lnicola@dend.ro) ---
As mentioned, this must be a hardware problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
