Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60257C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 06:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiBOGrr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 01:47:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiBOGrn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 01:47:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB2FE0B9
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 22:47:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75FB2B800C1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 06:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BD85C340F3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 06:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644907651;
        bh=AfrRsX7OylnwbY++hi1vvnOux5DZ7FWDtg7X3vubwMs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YRHiJwB+mIse+9Kvitz3Z2cm+AcgptOn/297IK1DqGWvY2k4tPG7vHOoHRDpzmqJj
         ut2GThwtLzovMuHBUayceB8mgwWA1rEigDHRqED4+X6kGZ+/xutIbU3/cClas7XQPh
         2aMwo5z8CkGC9DNVbFHcazENI6+fCaFJeZ7RCPvavgs8A/78Avk+OfrnUWISC0AMGV
         D8eL0FFSGg/0G0Y7xPSi46afHUB6TjFNh46f22GxZbByYUvmN5kQvJoHcqbTZOl3DH
         lHnV0XZVwA1v6qVcSzh2bvf3zN1qvr6t9hXz0JAd6voj1J9+zgRt4l7I6bdyFlcn+9
         0s9QPZjwWUiAw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 21DB4CAC6E2; Tue, 15 Feb 2022 06:47:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215594] Unable to transfer big files to Nokia N9 and Jolla
 phone
Date:   Tue, 15 Feb 2022 06:47:30 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215594-62941-vDTaWFvAjX@https.bugzilla.kernel.org/>
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

--- Comment #9 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Created attachment 300461
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300461&action=3Dedit
Output of `/usr/libexec/bluetooth/obexd -dn`

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
