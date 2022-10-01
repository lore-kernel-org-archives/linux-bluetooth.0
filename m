Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AC6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Oct 2022 18:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJASNG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Oct 2022 14:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJASNE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Oct 2022 14:13:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6344D248
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 11:13:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0091B8075B
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 18:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31FB8C433D6
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 18:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664647981;
        bh=6Dmfr0ete1pmFavAJA2a3c43Gfr7SwFOteBLXArU88w=;
        h=From:To:Subject:Date:From;
        b=Ubxr6ByjXrO0egRdWoDbGfjAA14QS17ejHMWTB7eLNP/Okc/qFLyOeTueK2b1Zzf6
         LkPsHJFLMxtdcaXIjjLSC6HstKt0Ylyiv+Gz1hjdjzCAhf5hS4QXMJlVROiI8rybMe
         BxiDptNAQ2X6+SsD5FIpQveLDMIYb6ubV2c1F3/7eNUtJnA+QKs3+6X2NmwrTEXwV3
         9vBfgMZF3ORZ5m5xKTKmPCCAoPbaYbFajwBBMgWJ/0tE3pe2RrlnuXQlNg/G3XnFfm
         cxVOwhuKZD5zJEG95CZkHeqxmFtiKdtIq/UPQGyjZRvMGvu/qRdQGGJ+VExzMUcxPS
         3bZQCqpc9VuQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 12AE7C433E6; Sat,  1 Oct 2022 18:13:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216546] New: ( ID 1131:1001) Integrated System Solution Corp.
 KY-BT100 Bluetooth Adapter fails to Initialize.
Date:   Sat, 01 Oct 2022 18:13:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216546-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216546

            Bug ID: 216546
           Summary: ( ID 1131:1001) Integrated System Solution Corp.
                    KY-BT100 Bluetooth Adapter fails to Initialize.
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.19.12
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: ivalin1996@gmail.com
        Regression: No

The device does not initialize. See btmon output bellow. It appears the dev=
ice
reports functionallity that doesn't actually support and fails to initializ=
e.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
