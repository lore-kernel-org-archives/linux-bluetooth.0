Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024E8C5479D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 21:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjAKVRS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Jan 2023 16:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjAKVRO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Jan 2023 16:17:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F408B57
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 13:15:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 962ADB81D71
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 21:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A85DC433F2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 21:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673471751;
        bh=oPx44VLz9UY2q8HyOJ7UWHKjBe13rBhbX47S3iDIS/0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Vv7G8SuFy8W1y43E3pHUWBoKJHT3cOiwJfRCKcgubNh6rGmviLWNHMkEM5PN8HTco
         PbmaQhOhISugo6ecWOp006eCdPblGmuyDxNEW4IjWjIg2RoXu67u5LNIP83CIHjPxW
         Th3kRPXdwTD1hDXup0vKgp7R4RsgnIRWbwEjGPIcX56UyECH1DC+PeA7y5MsknJFOT
         pdBSDpUW45KuZoZGTuY38QeAr9xzfWgKu22OjdNv0Q2xncyPu3baaNJ8PFnHipvf4b
         QI4prU9PI08EdOUjy+OLDHu6x/66rCCmUvS0zLpJikJxg4l9EYYY/DOYcDeO/zhxJu
         3F53EwiGUj3zg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2EF9CC43143; Wed, 11 Jan 2023 21:15:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date:   Wed, 11 Jan 2023 21:15:50 +0000
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
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-204589-62941-bwJMHZfmBp@https.bugzilla.kernel.org/>
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

queeup (queeup@zoho.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |queeup@zoho.com

--- Comment #9 from queeup (queeup@zoho.com) ---
Created attachment 303579
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303579&action=3Dedit
my systems dmesg.log

This is fedora silverblue 36 dmesg. Last lines have some disconnect info

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
