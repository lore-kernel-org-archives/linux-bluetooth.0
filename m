Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Oct 2022 13:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJVNSr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Oct 2022 09:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJVNSq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Oct 2022 09:18:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6402D277A02
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Oct 2022 06:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3DA7B80025
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Oct 2022 13:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80D5EC433C1
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Oct 2022 13:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666444722;
        bh=oWmt4teIwx3gmvwmEv4nfBSaLDQpVHlpX0/zcxdrr7Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Vq3dp69IiLTn4A6CmihIuS4lO6j1YOmvJzEiRcsj89pk8LXMinPxN6kpyuVTNR1mH
         w+BDfh8CCpV3GjoypcAJl4WsZRKhwFK7z8Nx1UlP3Fzi6CbSDp5NHTZIoOnsB7oq+Q
         5VBUr7pEdvlhQPfj7ifgmZv+bbNnv2xWP4Cfb/hMYlFLB6+VBl1ihSG4yY77/T2ln+
         kXUrDEdPqqQNabmsX47dOC1+wLorLjZN+u1iYEQTtBwg3Smm+dTZmLhVExuzc9kbuQ
         2/lvvWO8xpkpoNbnV70amP7WWcH4DbnucoxQx1QMtcncTzM7+1hUbikM+t5GVc/83u
         RNRdliECV2kFA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6CC2BC433E4; Sat, 22 Oct 2022 13:18:42 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216615] mSBC codec not supported for 0e8d:0616 (MediaTek RZ616)
Date:   Sat, 22 Oct 2022 13:18:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216615-62941-a22sSZUmAS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216615-62941@https.bugzilla.kernel.org/>
References: <bug-216615-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216615

--- Comment #1 from marelo64@gmail.com ---
(Correct link for Ubuntu ticket:
https://bugs.launchpad.net/ubuntu/+source/pipewire/+bug/1993668)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
