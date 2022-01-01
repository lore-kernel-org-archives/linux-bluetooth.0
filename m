Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E56C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Jan 2022 21:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiAAVBX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Jan 2022 16:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiAAVBX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Jan 2022 16:01:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88A2C061574
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 13:01:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67BA960C01
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 21:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3313C36AF4
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 21:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641070879;
        bh=fTFVjarysFrajYsdJPkBF15+kPfy1yUJAXdfAJsHjRE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FUvY7Y1QMIIsJuqYrmAZjaU1wdPP3N/rQGyZ2QzlYj3vD4DginTFHbwJWk1sWtOJ5
         gjJqgHT5IGkUqUJPTw/1uAgeLIlxfC9/CCg+gYtRClR/dghZ1VWMs1DuU33uScHIsZ
         3npTZPKmw0zttukDeLRqqvWdOOI5MWZGgaHNHZzZJpaLv9Vb6/cQN4t+jX3dKfwje5
         KyZJ+VVHDkiGKjUVTgo2MoIfjf1UyUeS7NBNcP1Q+YD50zDJebLzBuuAZC2ShFR5jH
         k5iMh956UzW6oUMe2AsU3k9SMH0BP8lTGhEWBMKxsa7A/iq2F/WX+BnkQyHFHy+RLm
         I9rkKc7FrwzDA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C39F7C004D8; Sat,  1 Jan 2022 21:01:19 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 01 Jan 2022 21:01:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guimarcalsilva@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-60824-62941-UeuxyhzVSO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #213 from guimarcalsilva@gmail.com ---
Created attachment 300200
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300200&action=3Dedit
Adapter on a VM works just fine - btmon log

Adapter on a VM works just fine, but not on a real system - btmon log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
