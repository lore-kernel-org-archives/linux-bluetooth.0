Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D21EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 10:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjFUKTg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjFUKTT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 06:19:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F12219A6
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 03:18:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B752561486
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 10:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 206B9C433C8
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687342732;
        bh=ScJ3JeP9B3pX6IzdpZFDS7N9qD8uUlMnhMSQc2/75tQ=;
        h=From:To:Subject:Date:From;
        b=lqFWkP+cWsdhPsJEdKd/om7cC7ESyz1WwrBt8Q7CmRdiPgihc4ERP0g5odH9T/sTn
         MnBgEZ4kMXn9EltWXxbondaVXphObdfTCpogQq36CQNeKbkkJzGNBCjZvESAMwFK2a
         NekeMmoYrGFsZmpqWx0hXnae1h/vXtYo0SDR8BmnK4Gnia3zzaE5DaLJLaraVkqdxK
         1scLwzMEg1ZGTBPCmG42wDbHOsLWDm3fEjkE5KFMXr3yoKPZdoOH853FfwmNEikud+
         EdwgFnJjzVCzZqOzH+mWuOaqYimEA6EIMEX671/e1/zJ1ZP7W4jRfsNCokm1pyxLuZ
         Rm7qnU6v/vYBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 035A0C4332E; Wed, 21 Jun 2023 10:18:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217581] New: Bluetooth L2CAP use-after-free
Date:   Wed, 21 Jun 2023 10:18:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mohamed-yassine.jebabli@witbe.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217581-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217581

            Bug ID: 217581
           Summary: Bluetooth L2CAP use-after-free
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mohamed-yassine.jebabli@witbe.net
        Regression: No

In reconnect slave mode, I start direct advertising. After establishing the
connection with the central device, we begin ATT exchanges over the L2CAP
socket, and then I receive a disconnect with L2CAP traces. This issue is
observed across different kernel versions such as 5.17, 6.2, 6.3, 6.3.7, et=
c.

Kernel log with bluetooth debugfs activated.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
