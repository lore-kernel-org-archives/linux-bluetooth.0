Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46CBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Mar 2022 13:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbiCZN5R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Mar 2022 09:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiCZN5Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Mar 2022 09:57:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2037C26E6
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 06:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF6D5B8093C
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 13:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E2BEC340F3
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648302937;
        bh=T6wexI+Uk3HiWnoMzFzW5vFnLg4IqtL4QXu2WdAw5u0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LLuEw2q33eDb8F+7YkEiCM7zh1V/fXT1xTtlTvRwrzsy6hyIT9epf1HFdO8BcXWvS
         21gyYIAkMGj1S9sEO3GBq9NcaroOCvGXiiwZrWCyc4dKWrfk9jswMyeWFYjBODMpSH
         WVQs09n6DoRJocqNzodaSmXfMx9ri/5g9FxHu6GGH2u13Oe8HeWlbnD011BUmG+v/r
         wC8d8RrP1Rr7fZPVS4YVY9ZYxhnnmZ88lFFDEi4TSgCBBswqKQcmcD08WVHdg4w7lV
         5a0htvE16/zKX+2mT726msha8etrq/QGCrYFWa5GodzzSQRvBYTBd3cCIUjv9DHCHO
         2l4lnwXxdP04g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8C985C05FD4; Sat, 26 Mar 2022 13:55:37 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215746] rfcomm: WARNING: possible circular locking dependency
 detected: rfcomm_sk_state_change <-> rfcomm_run
Date:   Sat, 26 Mar 2022 13:55:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: travneff@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-215746-62941-RprW0JILFX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215746-62941@https.bugzilla.kernel.org/>
References: <bug-215746-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215746

Andrew (travneff@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |travneff@gmail.com

--- Comment #1 from Andrew (travneff@gmail.com) ---
Created attachment 300618
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300618&action=3Dedit
full dmesg log with the warning

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
