Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652D1C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Jun 2023 10:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFEKSN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Jun 2023 06:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjFEKSL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Jun 2023 06:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54658F4
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jun 2023 03:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA13861321
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jun 2023 10:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38AAFC4339C
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jun 2023 10:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685960289;
        bh=w5NxOi8XxE2IyXu96LytEMez2hSvJXcQT4dL2zDbqPg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bKimhekiE8mcoYYMhFGt1e+tpCK7SIaMJqCpUztGXOm/d7Oo3R0qy/ZPNGLzjRVKb
         BYgk9MqydAg5Sqfgmv9r+sTbkpZH7Jj2ddOOOJf/SPu4jkbLySsuKQPKzoh1RyPVRu
         wiUoGwbUx5MWhAgaw4u4mK+OBMwBugdmeOHR9OsmEzroKqV+BZjTrIKw9f76TaSIBZ
         VLZapCJMgWWtzNJ2r0pYhssaNV0SnoFldeU2sONY6UH1FzOaZH3IALHZgkuKF3sW8G
         t8mVdM8YODEl1WkW1FL9eNHaqvSfIaIVdtsmXe+G4HPK0X0iVbs/ny6xbtH8VXupG4
         xP+lv2XiTggAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1AD85C43141; Mon,  5 Jun 2023 10:18:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 200007] HP Elite Presenter Mouse support
Date:   Mon, 05 Jun 2023 10:18:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: DenisAC@tutanota.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-200007-62941-JFR8b0r44m@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200007-62941@https.bugzilla.kernel.org/>
References: <bug-200007-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D200007

--- Comment #4 from Denis AC (DenisAC@tutanota.de) ---
Thanks for the solution!=20
Now, say if I were to show this to a friend who doesn't know much about Lin=
ux..
could I tell him to just copy&paste the lines starting with "diff" in the
terminal and that would work? :D

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
