Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13548C28B2B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Aug 2022 18:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350835AbiHSSjE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350829AbiHSSjD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Aug 2022 14:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0C997D76
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 11:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2674960F18
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 18:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C374C433D6
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660934341;
        bh=YUeKUdwSHcanwnhqluArk3QaYIVQfaemRZ/7WUDRTLU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BsRDv1MAfVf6lAaKIbeYFTuiCznp0TpsZKAOG56keK7+v4YeEXbqvmwqm9bwlmByb
         wmn4wgTNXhXH9i/QhrB18lfc0qtbS/mn2bejxZvQbHBF9TjS09G6Csv+LAsPzCr38H
         YQkH60ayvsfQGh+QW54pKZq4kP2KnL16Wr2vLnRq/SyccTfDBuC3rsP6mrgKbB0PYL
         0a0QFiUqu07gcGBz00gQ64KAx/P8Y1PwGNF1py+Xf5hi6FztGBhN1IlgbYf1AMj2oc
         +QKri7IdWtaG/39+8WYLVJssnwLzV4HKxLqXf8KmvCdM/umbD2E6/4W2Dj6HdDfKDp
         iyQLYhEDrofbA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5C32AC433E4; Fri, 19 Aug 2022 18:39:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216382] [bisected][regression] mediatek bluetooth 13d3:3563
 (mt7921e) doesn't work with audio devices.
Date:   Fri, 19 Aug 2022 18:39:01 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216382-62941-OMfP46GOtA@https.bugzilla.kernel.org/>
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

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #1 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
I suspect this could be due some HCI command during initialization, could y=
ou
please collect the HCI using btmon?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
