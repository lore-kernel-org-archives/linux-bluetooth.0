Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A2FC5479D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 21:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjAKVXG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Jan 2023 16:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjAKVXE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Jan 2023 16:23:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA13633C
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 13:23:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AAE061E78
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 21:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B30B2C433F0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 21:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673472182;
        bh=WmjC19ZTHFhqPEag4/Gbp0R2WC1XbUaIbTiXZiQP8wY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Jt+GOcyXt1Qqqv/bWloybHha8Amucxkx3VADN8X1XSeY/hryQotsd5gwdzyKOrmGN
         EFk+hDyPeujhtTKkkQpu45pT6OjJKQYnELM4A0paAhnMvuIkVjQnRUK7tuERiHUa7X
         yxQxDbKEdgfL5ZrED8/CufVHpgihB4MWybhDLsYfdRvr6pIpVqN7SGDiwcWkWiqkFI
         dWVqGqMb8HEBGWo0xIMH7FRv9OuHOJjDjZaqZAi8d8mAvfKT/SM1zL5WwvM90fE24F
         NLr16ZQAI9Ss0GWVLYDEZr1E9tBbwxzNNY50e5A0PpBZMMT0ZFV2AOByiy9obn4pyL
         hYeie6X6mm1sw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9CBCBC43142; Wed, 11 Jan 2023 21:23:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date:   Wed, 11 Jan 2023 21:23:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: queeup@zoho.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-204589-62941-xf03YtzolV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204589-62941@https.bugzilla.kernel.org/>
References: <bug-204589-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D204589

--- Comment #11 from queeup (queeup@zoho.com) ---
Created attachment 303581
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303581&action=3Dedit
btmon -p 7 -i hci0 -w hcidump

This is BTSnoop file. Collected disconnection errors.

file hcidump=20
hcidump: BTSnoop version 1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
