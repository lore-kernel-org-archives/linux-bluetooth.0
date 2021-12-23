Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BBBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Dec 2021 13:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348681AbhLWNmj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Dec 2021 08:42:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59928 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348680AbhLWNmf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Dec 2021 08:42:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2026B61E67
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Dec 2021 13:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 787C1C36AEA
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Dec 2021 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640266954;
        bh=PAJhWXV5eFigvRv/VWPzhCw0Msll4fpCidnNWW6GLUs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Fz7d+vp1nOI8ju6pYtsCSOfe/DH2lxRIWA707wqscxwy+Dg8YhvLVrVeO4Ujf7Omj
         biZa89a31kjQzHBsu+gNiUkUi0siIIRBkgL3Irq9yNXgexb+gzl4BIO3b136N+Gcwj
         wWTi5d09wgCwALN6fqidQoOOxpo61fFIfVWD34LB5bPdFxMyiphGVj8QKGWWNchxU/
         pCacZqHcN60HyQUgZbSrg0fOVNgyYuU5BoaCoJ6Oag7RzTByps31VnI/ZtBYMgGk7m
         oFGwcYbHVixK5pWueVBSu4Evl3JMJWYEgA3T3erH615gz/TIcifbYZGztdclx5NpJh
         SgzCXGCaSA1gw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 45CC860E8C; Thu, 23 Dec 2021 13:42:34 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Thu, 23 Dec 2021 13:42:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: hui.wang@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215347-62941-acJPoaWYK0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215347-62941@https.bugzilla.kernel.org/>
References: <bug-215347-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215347

--- Comment #11 from Hui Wang (hui.wang@canonical.com) ---
Indeed, if kernel oops doesn't happen, this issue can't be reproduced with
bluetooth-next kernel anymore.

I will bisect kernel to find the fixing commit/commits for this bug, then c=
lose
this bug.

Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
