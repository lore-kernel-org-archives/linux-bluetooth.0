Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70568C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 08:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5386161355
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 08:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhJSI4N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 04:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhJSI4M (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 04:56:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A874B6115A
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634633639;
        bh=OW/+gQPpqV+EZFT9dMEMbQ4I3CtM/xnQErO1lajB7MU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sqspsHb1FSl6wJdL24y29PqAPdw2aXl1iBGN+c2kmgPRgAbPFs/ZDT7iPloQVMEti
         d6G8iA6JbAR+gdC5PsQMCA4KVXrknylnmsup8R/1TfmIgh92OJYE2ug7f0gdN0iaqo
         Ng3kuFUxX0zaVfV7JRaLGZiR7/mobct7xVLRrYVMVrgo3LuziwxpOTp2o3TnAyfWms
         Axtz1Kim2Gw049WufOr4VfIzaGnlb3ZMQRDRWKYHqa624I5lsn+FC6ZiUqLQGan7xZ
         oqyCFfBF+v7hlwZia8RHjqosJsrG03vvhVdnToC0cR1qJ6bDZf7LrzeLghtYLiaZs8
         haBqP1RYC3BWw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214273] AX201 Bluetooth unusable after: Shutdown controller
 after workqueues are flushed or cancelled
Date:   Tue, 19 Oct 2021 08:53:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dmgpage@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-214273-62941-dstQfq6Bo5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214273-62941@https.bugzilla.kernel.org/>
References: <bug-214273-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214273

Dmitry (dmgpage@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dmgpage@gmail.com

--- Comment #1 from Dmitry (dmgpage@gmail.com) ---
I have exactly same issue on Pop Os

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
