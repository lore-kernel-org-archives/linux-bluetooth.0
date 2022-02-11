Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29244C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 12:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350134AbiBKMgN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 07:36:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350129AbiBKMgN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 07:36:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785AD2BF
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 04:36:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21D01B829DF
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 12:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF140C340EE
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 12:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644582969;
        bh=d1WKq62oIZE3TlpCgA+1U7agPhja7lfuncqhnktLygI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LEhjAhUiFt6ocSOGhG05uMwyoU1Dh5bWP0wVmQCKfmrBfMklZcb5gkmgFdlx5pogO
         BUK5lVQX+I8MyufOEq/Mwv+jYLtzsCzJuq7KmcQbXAuc/XL0d4lTfGqH2sUB59391k
         xdfRpcvL27z9LEOIbRF5BXAD3Zaj/PNGQUPTsnMhMuFy3Zv+jkkOuQAiK8kG5WzFU2
         HSxghEAUf3i30Ctjh7bpLDIBEAQcEPgoIiAHSccg5+KZNMU471Ya5drfQW3zqDtx/e
         kuNvcVy9Mea1H3m9S9HcIPkZkv+tz0m+5QLJF+FgIRurxRc8nxSDtnZgpqysxfCQlz
         LaDc1y0b86DgQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A03FFC05FCE; Fri, 11 Feb 2022 12:36:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215589] Random bluetooth dropout after sleep.
Date:   Fri, 11 Feb 2022 12:36:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rodomar705@protonmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215589-62941-6P4HY0L9ym@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215589-62941@https.bugzilla.kernel.org/>
References: <bug-215589-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215589

Marco (rodomar705@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #4 from Marco (rodomar705@protonmail.com) ---
It was my fault, coming from a non deleted DSDT override from my previous
testing from bluetooth related issues. Sorry for the noise.

Marco.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
