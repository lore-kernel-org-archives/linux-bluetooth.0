Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4D6C19F2D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 04:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiHKEBr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 00:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHKEBq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 00:01:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C88683BF2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 21:01:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12C9861280
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 04:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74C0DC433B5
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 04:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660190504;
        bh=y8fijCWizdIGh5E61MdVC6p+dAYeA5BWskPHntHW3Vs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rMiQXstPfOroMZm9fXniuxi1BRERQuirDtAgUrO8jxd4aduJRb73xlYNMu78PE+Kd
         4Ws2hVZT6u+jswOaBY45SXUYJm9STQIOpSwzkpKxUxAu60V5eQwUTsYGtF44p6ScRi
         dZDU4J98t0d1v8/Up6Rkug6RRryEiLdoRsXuqj2QBdEZXyK0ihnDaxP1BcTFcmD/Q4
         AX85E9vD2gj0x+iINPpPf/96irpkwqildaWBOkNc2dXL/eA3o5cN+mPH13395EH01d
         tIG3iaFddm4kkydFhJZDCLo+coLqkccqgz3MjJwLO/XZWxRYHulQhjgytof88FKCjw
         6mFpmWghXLR3A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 607A7C433E9; Thu, 11 Aug 2022 04:01:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216352] [BISECTED] 250 ms system suspend performance regression
Date:   Thu, 11 Aug 2022 04:01:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lenb@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216352-62941-7n0vaXC2QU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216352-62941@https.bugzilla.kernel.org/>
References: <bug-216352-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216352

--- Comment #2 from Len Brown (lenb@kernel.org) ---
Created attachment 301549
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301549&action=3Dedit
sleepgraph 5.19.0: 686 ms suspend

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
