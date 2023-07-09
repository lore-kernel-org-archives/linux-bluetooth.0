Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB73EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Jul 2023 22:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGIW4V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Jul 2023 18:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGIW4T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Jul 2023 18:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD0F124
        for <linux-bluetooth@vger.kernel.org>; Sun,  9 Jul 2023 15:56:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A23E160C4B
        for <linux-bluetooth@vger.kernel.org>; Sun,  9 Jul 2023 22:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E82DDC433C7
        for <linux-bluetooth@vger.kernel.org>; Sun,  9 Jul 2023 22:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688943377;
        bh=A2D7fu/INHV5YzKLzokqCC7OfPlRhAHRgKto5fOcLZ4=;
        h=From:To:Subject:Date:From;
        b=QBTzRkfWhd5hyx2+6cavavUaJ+Y6wjuMX9OFCXWgKYW9giad4IL9Zf+7ghdF+Vd3j
         msDtKJIM7mYvSERdFSoThLyk+BIluIAzTo2/VZkXeBbSAo4sABlRypROR2Aizj9RU3
         S282JFpVkEPEGNg3u9VaX2L+0AsHXrzxXM3V4yuBMsrvYQQx/grSWQjnkcVONpCxML
         wYrqGBzPs/+ekK5tSw9x3eim0O7kguFFj7mmHCXIfBoDD73NqtDMqop4mnBDJiub/v
         uCr7hN1IW97glKayuKKOpzHatEuyYmsyk9CXUjfCsUdnb12AUjhSPK4N5uv2BQiwF6
         /+Lz+QTXFm5Fw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CB5A1C4332E; Sun,  9 Jul 2023 22:56:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] New: BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Sun, 09 Jul 2023 22:56:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johnbholland@icloud.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

            Bug ID: 217651
           Summary: BCM20702B0  Bluetooth device in MacBook no longer
                    working
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: johnbholland@icloud.com
        Regression: No

BCM20702B0 Bluetooth device on intel MacBook from 2014 not found by kernel
6.4.2.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
