Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA851C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 10:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiI3KCe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 06:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiI3KCQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 06:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C0F1ED21A
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 03:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9C276205F
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 10:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46491C433C1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 10:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664532107;
        bh=D063tozisPP7HZBfvZxk52LngT8IM0EppQr+eP88vsI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dBov4osSQNN8xFuSD9cKVNkb4q8Qc3NNU9yCMDMT9q2YdPMISFp3RJarn/HJA7SXB
         egmje1v0Pb4WNc+PIPs2WyawN3tjmgCQfAilQ0BmBGktjTJfPVcpV2sds0ZZQ9JjZh
         yejgznuJ0kKNJuBVmZKsRE9N5hFstGDcJYNihfaoprv7UcZuMTuPtTffC77mRpKY7g
         KciaKrIy0+ANqsHTCP/cxPNPlDlOVCDkBWc9jyQ74NgsFcz3qUvxM6PlrTinaZKa85
         6flb4WzvaTeoF1DE+IxrS8E0s3d4h6QcPt2sHcmVPcakPbjQZrNe7yG6sI7JUUbho0
         lEACMBtwoEXMA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 354E5C433E6; Fri, 30 Sep 2022 10:01:47 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216532] openSUSE Tumbleweed, AX210, bluetooth, connection fails
Date:   Fri, 30 Sep 2022 10:01:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216532-62941-gjUsdiO5WM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216532-62941@https.bugzilla.kernel.org/>
References: <bug-216532-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216532

--- Comment #7 from epistemepromeneur@free.fr ---
At the PC, I connect the smartphone

bluetoothctl connect 90:06:28:B6:B1:B6
Attempting to connect to 90:06:28:B6:B1:B6
Failed to connect: org.bluez.Error.Failed le-connection-abort-by-local

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
