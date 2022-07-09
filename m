Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B52C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jul 2022 13:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiGIN12 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jul 2022 09:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGIN11 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jul 2022 09:27:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FFE20BEA
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jul 2022 06:27:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82092B81D67
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jul 2022 13:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 241D0C341D6
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jul 2022 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657373244;
        bh=ALxE5xR9YpFh4nhre/lXYJoXyn5cZPhwbqSLiaWKnBw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q+XoGGUipDOvEtHggPP2gN8+03ZqZsKKdogAOH8wNbrY8sGiRcQ3efuLTQZ23eV0T
         R+kzpPRLMnolFRH+ecxhIeQJYYYDi6LAgGEooNeYIrOtpN4WMfifQnc4nxMMUrGEp5
         6mHDuoab9s2T4uFVIO6FP7Nr3gBIBh6MBEFmYpFG7OOlcCUAkjBBf5gcEKL6nXSCiY
         hI7mchM1cNrDCyTnEVyXgBAdqbOH/B6W4Kxk3p7iJ8i5KNVWkted2pI0//ceKU0Dtt
         OZbk5dR64wyME03BrmQAOk24Gwa3RfL3KkogaXBtMfRkvroEdeDXCw+e/cXSY5tq3v
         Mn/QhCae5SuNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 14374CC13BA; Sat,  9 Jul 2022 13:27:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Sat, 09 Jul 2022 13:27:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ifaigios@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215768-62941-gYzPf8FtW3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215768-62941@https.bugzilla.kernel.org/>
References: <bug-215768-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215768

--- Comment #32 from ifaigios (ifaigios@gmail.com) ---
Problem persists in 5.18.10 on Thinkpad X1 Carbon Gen 9, having bluetooth
devices connected  makes the laptop wake up immediately after suspending.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
