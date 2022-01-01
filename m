Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D79AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Jan 2022 16:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiAAQKq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Jan 2022 11:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiAAQKq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Jan 2022 11:10:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E961FC061574
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 08:10:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CE7D60B96
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 16:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D23FEC36AEF
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 16:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641053444;
        bh=JEFuK7CX32ldRBeXuLuKTX89ItTjcE6BNCxD6idsOMk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ifmd3ocw/GYkMRVdc51De5qAX75OMJeSB1Bx03mJn2DgAmutVoZHSGQ+P1jrm34HB
         4O7xDOQWQst6P1e3zR/pKb+VfQF7V5VRAyl41TLZA2TYva5iSZergLry0gpcKw51XC
         cHMzPLrgXQfG9Nq4xackopWK0okYl/ta9PaUp5CLwpB/l6dwI5uafeQKVLgjwVmJ5b
         5ipPeAo0nVJjw5MyT6PxlL8vI679L/xrUta70EDa7MLmNTs+DR74sK8u27sPZ4r2J8
         A/rQiQegELZWTxiVY7WqQxiXvDDgJAPKmLlFsMT0NGW7mMFcteOW3e/TEO6GCnuA/y
         +Kz5Pkmau4mzQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C2DE4C05FDF; Sat,  1 Jan 2022 16:10:44 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 01 Jan 2022 16:10:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-bROcHRt7Hg@https.bugzilla.kernel.org/>
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

--- Comment #209 from Swyter (swyterzone@gmail.com) ---
Well, then your dongle is even more broken than the rest of the bunch. Beca=
use
a reset is something USB devices get all the time, and the benefits surpass=
 the
drawbacks. But good to know, we'll blacklist that one. No worries.

As you can probably guess it's hard to please everybody. We're volunteers, =
and
you are the only one who has complained since that patch got mainlined, so I
think it was still a good idea. We'll eventually get all these absolute tra=
sh
dongles working.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
