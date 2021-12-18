Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7865C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Dec 2021 06:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhLRGNz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Dec 2021 01:13:55 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35948 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhLRGNy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Dec 2021 01:13:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 27269CE0D9A
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Dec 2021 06:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59E22C36AE0
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Dec 2021 06:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639808031;
        bh=Ru/CvfbUyWGS2bUJXl58TcbXDSx6C6TtlJNU1oaDalY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lc9pHbEPv49Ferre1tIHF3LKEex0TlH+T4YNiUZ+Qs96C3rEq67FTnD2Ui31Pb6it
         x6p5ZOZWbEw2pN4CdGEz8seE6nJ5RZ4dNWNe54HVRNZOtCAp2ZrVidk+YnFOpwU84b
         JDJtDJtCJ7A0qaiazFDYC5JrsSP3woNOLAGXMevAvYUHeI7XvuUVUu1kpvopB3yX+/
         KP3bg1YROcSFlpQUgVisPw6XNdQh/QdKeVnH5yYoTbRajaFUJLeCoVGbxOOlvNtA5W
         X/bBm0vDkwiHwYePHkNSMdTcGaED/9ovbZ5rw04BG8Pt3hJodAba9wa+H6CZ8hcyK2
         xiPyzGrdsMipQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 4061A60F55; Sat, 18 Dec 2021 06:13:51 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Sat, 18 Dec 2021 06:13:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: hui.wang@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215347-62941-0NFtfLxHxL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215347-62941@https.bugzilla.kernel.org/>
References: <bug-215347-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215347

--- Comment #3 from Hui Wang (hui.wang@canonical.com) ---
Created attachment 300055
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300055&action=3Dedit
picture of gnome bluetooth setting

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
