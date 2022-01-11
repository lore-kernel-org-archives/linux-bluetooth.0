Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7AEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jan 2022 17:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344130AbiAKRUR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jan 2022 12:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbiAKRUN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jan 2022 12:20:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A0FC061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jan 2022 09:20:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0FE8616AE
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jan 2022 17:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33E91C36B01
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jan 2022 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641921612;
        bh=XEkWMLY0NI1sLfBLDWPDu/+MStKrZUeZuJ7c8gQqj88=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=agIcLiJtXWKVrvxtRfrpMaLIqYuHD65BGMxZoz/F2+CbCrs3MweHBCCXYIv1aCyK/
         Q3uRrLZnzrWCH7UzNUGwzXkhGffgldGX0TdDm491gYT8/WdwkFEtsewMOWzEiP9MiN
         DPH6ibqseQP05NmWisKF5NNkjKO8wey68a8Gb9ECtaBAkeyxjw8P1fIT6eStEMn+FO
         GeilppjFNtbq9yFZyi/g1OPDTP2+tyGHX8M4iby9AgsWpkPB7PlJ+hqejKqOSmIqJK
         rEaGejMqjm41K4zO9ni61RxmFi9TETc17JTgIk5gb8N8JWRn47CMGx7OcVNRWjWGe8
         6Z4MR9MsD34cA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1EC83CAC6E5; Tue, 11 Jan 2022 17:20:12 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date:   Tue, 11 Jan 2022 17:20:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: heavy@ungoverned.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204589-62941-pQgOilymTQ@https.bugzilla.kernel.org/>
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

heavy@ungoverned.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |heavy@ungoverned.org

--- Comment #6 from heavy@ungoverned.org ---
I had been experiencing this same issue with a Magic Trackpad 2 on the past
several releases of Fedora. My workaround was simply to plug in my trackpad
with a USB cable. After upgrading to Fedora 35, I tried using bluetooth aga=
in
and it seemed to be working fine for a week or so, but it is back to
disconnecting regularly, so I've switched back to a wired approach.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
