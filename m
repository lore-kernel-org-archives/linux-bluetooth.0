Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99888CDB46E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Oct 2023 00:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjJLAa0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 20:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjJLAa0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 20:30:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ACB94
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 17:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7CD5C43395
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697070624;
        bh=ctuIfpSJad9z4GWy5bysIlRTEo7H4EzzrOzrQEUcQKQ=;
        h=From:To:Subject:Date:From;
        b=EujncZgfwC2F8sz7dxfQBZZPqEfFfUggmo3HYELhJN56NdwRHS9M/o7ku5YDWHsB8
         wFCGYK3FJyZbkvXfNJe6h/8530FTVsznc8NQkO435DUA7PaESb66IQTJI6dYEc1WgB
         7LEO6clZOaH5HCzCmi2CXJDX5Tj8B1Rar7WDgDR9WQxxTLopnLSw6rJAOjeBAKnezI
         cv7pDq03MfAAGUw3exFQGhFKgz/MuIWfM6pWoO9IoWC44+DjIOLlSkFp5EREVi6zXf
         HyNYquqdkEQWfM4FPjq4w/4UVMoqlNpQFISvS5sJiY/bNmZXWYdAQ/xcAn6arFDw45
         M2jVAGgFg2jvQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C113BC4332E; Thu, 12 Oct 2023 00:30:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 218001] New: bt shotdown
Date:   Thu, 12 Oct 2023 00:30:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yejwrrc@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218001-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218001

            Bug ID: 218001
           Summary: bt shotdown
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: yejwrrc@gmail.com
        Regression: No

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
