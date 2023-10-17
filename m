Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3643CCDB474
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Oct 2023 12:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjJQMSb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Oct 2023 08:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjJQMSO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Oct 2023 08:18:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08837193
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Oct 2023 05:18:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C8DCC433CD
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Oct 2023 12:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697545086;
        bh=0lA3RixOggXlXufjqQPN/gUJqBI6n6KxjRu4WSL83UI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lprx7SObOEKNm9tz2ZJeCWTu1V0APtxKNq5tVClI0ruUPB/6H5HDcB3pVR2zWNKwJ
         PXaX3NoCHI97oU8ZAs400yMY/0NSBQ2VwN+uB70ORTHvqsMhjOkdD/Lgf+Vy5hevjA
         wt8PXhTjKN/edP+NNuwks5ZwXReztJ+NRmw/3owd3KZ7Edv3xbtCTt49pyZY5tJCAh
         XS9x4KrHim4AQO6FJIqX4VmnczNC7LYPNNu1yGKhEdDJPxyYohph/+7Rg0hbUxcmRh
         4CZHc6GzKNltRhojB1f0EeJZM35AcA6V1h/TZG+upqAU2XKZnB02V+xHshizc565jb
         aQZ4zki+zRrIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8BE2BC53BC6; Tue, 17 Oct 2023 12:18:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Tue, 17 Oct 2023 12:18:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: demiancarvalho@pm.me
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-xLgzQ2ahY0@https.bugzilla.kernel.org/>
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

demiancarvalho@pm.me changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |demiancarvalho@pm.me

--- Comment #275 from demiancarvalho@pm.me ---
Hello! I am experiencing this bug with kernel version 6.5.7-xanmod1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
