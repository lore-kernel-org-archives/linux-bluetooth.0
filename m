Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9A2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Oct 2022 13:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJVNSD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Oct 2022 09:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJVNSC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Oct 2022 09:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E393253BC6
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Oct 2022 06:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACB0B60DF6
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Oct 2022 13:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05D71C433D6
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Oct 2022 13:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666444681;
        bh=hQnmUz0dj0VOL9YYo+n1V1jXCuUsRbbkWTZqL6wjsdw=;
        h=From:To:Subject:Date:From;
        b=jcizucfBSRlzOqreQNxZ0IQsQM2bFhEJhyHYPcXeKjPINg31Z2qH50rrl/S4SZZTw
         qm/WM1CDerR8XBkJjxiRwSwTxdbcSRS3vt/0fUPPXTS8PdXeOEK/LKd8nW5gKtEy61
         oBIZKcwzWRnfq+zjel1WG6dXY1st/qZA+ukCOQWySlpWlMVOGAcqSmB1D6aJwWce1W
         hbtkt/fZDUym3VFvgmsp+q+O2usLn2TBdxPefVVCam35dVPn+Mg5hZQSilkDwnIB+u
         y0lglorPj5WkFFL6XxINiToNX5NRx2RqS/fADpYZnMt8ViFSNSxDIzecijdZOnqQjQ
         FEDs6SUopdy9A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DE412C433E4; Sat, 22 Oct 2022 13:18:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216615] New: mSBC codec not supported for 0e8d:0616 (MediaTek
 RZ616)
Date:   Sat, 22 Oct 2022 13:18:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marelo64@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-216615-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216615

            Bug ID: 216615
           Summary: mSBC codec not supported for 0e8d:0616 (MediaTek
                    RZ616)
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.19.0-21-generic
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: marelo64@gmail.com
        Regression: No

Created attachment 303073
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303073&action=3Dedit
Logs for multiple relevant commands

- Ubuntu ticket: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/=
2783
- Pipewire ticket:
https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2783

---

While the bluetooth adapter `0e8d:0616` is supposed to support HFP/mSBC
(detected as such by pipewire), when switching to it, it fails and fall bac=
k to
the low quality HFP/CVSD audio codec.

According to pipewire's dev, it could be an issue with the driver for that
specific adapter since my headset (Pixel Buds Pro) works well on another
machine with the exact same software stack (Ubuntu 22.10) but another bluet=
ooth
adapter where the Pixel Buds Pro works well with HFP/mSBC.

See logs attached.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
