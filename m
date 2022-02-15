Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12D5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 11:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbiBOLdW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:33:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbiBOLdD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 06:33:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537921EC79
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 03:32:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 52498CE1E35
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 11:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2C66C340F4
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644924746;
        bh=xcCQmPLYrrHNm0ygYZNP9ncHfmVlH+bQ7P61wkj+0iM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZeWI6bM/u8g1cO1s/krFk49qlBwTTCWJY8XgKiS1cenQAPSYCwUnmn4MHfRBLoDRl
         DLMzBWXmj6nGyMGFpKFuBjBrCFEVWvRcTf7TSN4sm4F7YjDvg2kdhQxWlliej2U1lc
         tP2TBNH2WR++LLxtt6Y/vfI3/BA71/EJc/qSUoRG+IHruGCR85XqhNCQqffjY4sHYn
         kp+iQYXMCb9uW3bmLzR6T3dKRjCQMzW9x5MPxdA1B0QHEf4xMh6LTgw4MkdLqsRn1T
         EvFp2AEfIoUam0886Psozkh5UEHQeNq4BapF1L+pQhchTMO0v99T7gmP4RSn/3zFq9
         dOmFwauvV02XA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A0E68C05FCE; Tue, 15 Feb 2022 11:32:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Tue, 15 Feb 2022 11:32:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215528-62941-kHqQ6roPs0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215528-62941@https.bugzilla.kernel.org/>
References: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

--- Comment #10 from Artem S. Tashkinov (aros@gmx.com) ---
Can you please rate limit these messages for Christ's sake?

Specially "SCO packet for unknown connection handle X" - I'm not even sure =
they
should be logged in the first place unless debugging is enabled.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
