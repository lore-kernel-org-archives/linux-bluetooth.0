Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAC7C83F11
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Aug 2023 15:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjH0P5v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Aug 2023 11:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjH0P5P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Aug 2023 11:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289B4129
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Aug 2023 08:57:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA09A610D5
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Aug 2023 15:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B1A6C433C7
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Aug 2023 15:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693151832;
        bh=H+WefeKdEz7AXg2/m3h/UoWZawJ6bgLl8IR3i2fwATw=;
        h=From:To:Subject:Date:From;
        b=fekm4gUEX8uULsSSvbjSIMMLHWtlmrCa5DVr3gjCZtrmcC2WfUSc8b3xzWElCvFtU
         UT8z3NNkElFg5X1XTMQljP7EePgc6Yy54lNOA2PzSmWkaI13PSLvocfUpKHebutV6J
         0r472D5yNaqz2KT/DxlTHOGslfE0gJoo8ilMF7zq2m71zMTSrIt0dDVZ9rMlXaEQdW
         zMm0E8KfVv2684hZd+D720JaFDZToO29Nzdv+7g2ZPMcomzW5RcJNYzm3BLyfxbBpW
         /IKxjkf4XjghcImEAr+FphzNOCuDiTQpG3wgVRDahwLh2zUnBcgLzvYMkmnc5HcAP4
         SAg4WbYP789nw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0E45FC4332E; Sun, 27 Aug 2023 15:57:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTc4MzBdIE5ldzogYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFh?=
Date:   Sun, 27 Aug 2023 15:57:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pingo-power@hotmail.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217830-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217830

            Bug ID: 217830
           Summary: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pingo-power@hotmail.fr
        Regression: No

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
