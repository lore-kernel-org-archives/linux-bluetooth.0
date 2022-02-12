Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B21C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Feb 2022 06:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiBLGeg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 01:34:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiBLGef (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 01:34:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB02275CB
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 22:34:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC14260AB0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 06:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4549FC340F0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 06:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644647672;
        bh=IA56ShLKZtQfkcWPMXVBb148DzXL3H7NK0VQJfEPUi8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VYTgr8mxzASjqoxjhG3gNFyI1We/yIu0/YASej8K+s5D9jNZNB+B0uVhUmo+oFxtB
         F2WqhqQLeC9x5qGJm7E1lOxye780MUs8AymYtb9sIIOBsJO0ctDziAyKaGPs4w9AMm
         gIqsJadBowgvezEjI2+EUwAYZSWWVSJC2wO5VFNt7X1yI/+IkWFFyEXRD6dZn7I2kW
         yiCCTnWxduuDJux8isPqvGrVT/7NbQka8XerGcGsf5VHLsFGguDgZzGkjehfQAyoy9
         2WY/qVOv70Yi/4cQg+OjDtsJYRsfE1rHQwfDExUZHbEGqMYuGtJyAdtmYEJj78wbd8
         TwOgjodKJeP8A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 19AD4C05FCE; Sat, 12 Feb 2022 06:34:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215594] Unable to transfer big files to Nokia N9 and Jolla
 phone
Date:   Sat, 12 Feb 2022 06:34:31 +0000
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
Message-ID: <bug-215594-62941-Wg5uMlVu18@https.bugzilla.kernel.org/>
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

--- Comment #2 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Thank you for looking into this.

> So the transfer apparently didn't even start, with what system are you
> traying to communicate to?

Nokia N9 (MeeGo/Harmattan)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
