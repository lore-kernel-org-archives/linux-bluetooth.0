Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6DAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Oct 2022 18:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJASOx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Oct 2022 14:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJASOv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Oct 2022 14:14:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C1C237FA
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 11:14:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A558BB8075B
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 18:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53A17C433C1
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 18:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664648086;
        bh=B4RgK/EiYmzkhLMbsPClavygh+SI9147DaYwVnTMUi8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XooMkBQCWXEsBGXvH7lthBWWYPkqwm8Sdj7h6QTboRCJYem2krLKxk259AZxbmWC2
         ZYKAY6pIFj8E0pUVPmFti20STHtshIY0lt88fMK5bxP9lAjpFiYM0rFuDDf4WC4sjJ
         msgO/e1Dd84DT4k4nvN61B3xbK4sZhP6KdGp2hgTewP3o3MaSZGYEbASqfwW7qM3A4
         HaYGZa3A/QzXC3qU+uCdvs1p3q9N4sSNjwAvn9gYQMLFshHnygMwOc0iv4GtJ6Nwq4
         Mx1FcPiDGOTc+mu22stSkOHTpOp5e1Qe7aZnbviPLqtCe4oEdxzAxLuWCNSYU3l4j+
         Cb6BqPGmIwlXw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 35B71C433E6; Sat,  1 Oct 2022 18:14:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216546] ( ID 1131:1001) Integrated System Solution Corp.
 KY-BT100 Bluetooth Adapter fails to Initialize.
Date:   Sat, 01 Oct 2022 18:14:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: ivalin1996@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216546-62941-YxVlSVbR3Y@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216546-62941@https.bugzilla.kernel.org/>
References: <bug-216546-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216546

--- Comment #1 from Zetta1 Reid0 (ivalin1996@gmail.com) ---
Created attachment 301937
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301937&action=3Dedit
logs

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
