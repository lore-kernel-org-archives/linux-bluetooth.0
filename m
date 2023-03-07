Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B73C678DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 18:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCGSGv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCGSGb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 13:06:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917FDACBB7
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 09:59:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA53BB819C1
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 17:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A758FC433D2
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678211944;
        bh=ng1TW4qXHSn2AZH+dGTPoXkcpYRxEKkHZv3adxtXops=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ApmZzVOl5SsF7lQIzN17E0BNGL0X+W8wR+aExWPvK/bI8/uB3lY8+0MPGcAnZcClm
         4D5Z8UiBlwUtJPlGXsUtjFkN8PZ0ksEvouVxeQHVzRtbspm2wFpE38Uc0QeNX/6Yxt
         g1c4n3fqLvq0zEPJM1845l+1UOMltQx92+utXQSXTq0IOaxVnghW/CUJGAoU3YrnkN
         HwidZRDshhOGQhEuPx+Ggrmi7B9cURibo3dYOPxMRye3LlX+tW6hHVtmn2sAOAHhZO
         6xCTmSrtNeumpC1afcmli6TTx4KrJxB9ATuqIIMyLg468M/eGKXbrkNd/p8TI0v8Ru
         PGnRHoWk/TmLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 83ADEC43141; Tue,  7 Mar 2023 17:59:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217150] Bluetooth USB Adapter that comes with Xbox One Wireless
 Controller stopped working on 6.3 rc1
Date:   Tue, 07 Mar 2023 17:59:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cmarobnjak@cock.email
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217150-62941-rb1GZfx0Eh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217150-62941@https.bugzilla.kernel.org/>
References: <bug-217150-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217150

--- Comment #7 from Smokus (cmarobnjak@cock.email) ---
I am sorry, but I am not sure that I understand what you mean.
I'm doing my best to comprehend all this, but I'm not that knowledgeable.

Have I done something wrong, or was it never supposed to work on 6.3?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
