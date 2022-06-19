Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58928C43334
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Jun 2022 17:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiFSRsD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 Jun 2022 13:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiFSRsC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 Jun 2022 13:48:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195FC10E4
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jun 2022 10:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDFB5B80D32
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jun 2022 17:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63370C341CE
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jun 2022 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655660879;
        bh=2VOiNj9bpUDNciRFan8F3TrQwwr++SXJ2Ce9GY9A/r4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ff7BgKWWW5kr88ABoVJumEFnSf1mA77zYyojoDIJocY5Uk9FSip0r4feG5tQYVmsw
         iJMsW33BMbNmynJeLW3VAnT5lJYpeSVU4rHxflzAMEAa9e9hPQNegGK+Q8Wd0//zV5
         XS3wOYSk5yRa8csUprgmfJvIcxHbR+Th7tyTrfr/8JKbJC9ALuE4HkN5xiVOyxI+ai
         GrZ7BHWSVCmQB+yMwkTjH6/0a4ryj1dNeWaRvvQA3ym+qqysi2ffO/m4GM/Dd41iuf
         PSMo5eCIJS4T1xS/6Y7JFojeadW8cSxHhetV7yQUeqbLZSDj57nkfF5qonaPLm+RA/
         NFkO5HcmSHr8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 524BDCBF854; Sun, 19 Jun 2022 17:47:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Sun, 19 Jun 2022 17:47:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215576-62941-9N0y2qOTjd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

--- Comment #18 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to wavexx from comment #17)
> Well I hope it's not going to get lost _in_ the bug tracker ;)

To quote
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html:

Very few subsystems use a bug tracker, and only some of those rely on
bugzilla.kernel.org.

> At the moment I'd be happy if some maintainer simply made the commit. For=
 a
> one line change I'd rather not start cloning yet another repo...

With a bit of luck that will work. But if you don't hear anything within the
next few days, you really want to send it by mail. A simple mail with a pat=
ch
like the one you applied here might do the trick with a bit of luck.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
