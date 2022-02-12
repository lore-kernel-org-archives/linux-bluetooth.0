Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5AFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Feb 2022 22:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiBLW0b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 17:26:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBLW0b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 17:26:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E960A84
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 14:26:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99AE2B808C8
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 22:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47356C340F0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 22:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644704783;
        bh=594NvYaW1KbC60ZHv4iUvWZY7p6wvGJeq+Nsd++6sFs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ELDs/qxyMXufIWZ3F1mtaKg0RRj9I3BLBQQ4RZ9KYQpeCtQnM3CmTM4Bsf6QeC0/7
         Ll/lY8IXiDPb231WpR/FtWKsiv/jJLEiY3/oTrrduV8xtGx33THxqYDdCgB0CxJ+en
         QxZ61rpY1CCgouaM6amxrqLPcHmFmqZADLGLrTB2GUxypC8wfW5MfnZ/WoTdNAU4JT
         4Ijc5l3gnXdGVE4jAlR8LCpemXdE8iCb/nQvJDbodfEYzeBeNVg8QayNv0KNjAo5l+
         gkIsrFcNgbrdDpK629PXiaiwoU0uPmRQUPbx/iuWlCSENzHpidwytyuEE+yaBcMx5m
         REpNfdTap+vtQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3198BC05FF5; Sat, 12 Feb 2022 22:26:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215594] Unable to transfer big files to Nokia N9 and Jolla
 phone
Date:   Sat, 12 Feb 2022 22:26:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215594-62941-xhTPhVputE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215594-62941@https.bugzilla.kernel.org/>
References: <bug-215594-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215594

--- Comment #6 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Thank you for looking into this. Did you test with MeeGo/Harmattan or Sailf=
ish
OS?

Also, it wouldn=E2=80=99t make a difference, as Linux=E2=80=99 no-regressio=
n-policy requires,
that the everything keeps working with the existing user space.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
