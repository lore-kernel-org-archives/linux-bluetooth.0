Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E621EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Dec 2021 00:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354068AbhLBAL7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354268AbhLBALw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 19:11:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61712C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 16:08:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AB5A4CE2138
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 00:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC4EBC53FAD
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 00:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403704;
        bh=mjSmj20N/hLxnl5f3JNkNhY90SvDEAt5PHSJlks7DDo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FRAw7/dFL46RnQUcveSGD7wjnhbta0S4sKRT/zbZ9ZZMN19GZZGpywvJFzmZThMRX
         QykddopBLPmq2pQ9YCpfTOBC7pgZV78hvnNW3hhlCKlBEEsRyCyGItoZ0jfX7gm4FD
         5diFNIcILCxbOeIKaNU5BtX5p4W6vuCq791ok0Ci8d5UV0/PRifRant9K1Yi0CnoWC
         5ATwsPjxsbzuUBdiE4wbM4uKdLuh7TfI/+Era5vVUAexPaoX4+eDVqeQyIfCYk63Oz
         L56pbtCJ3ZimmqmIvUryGRRjFJQZ9R1F+heKGHwGar6x2bCo3ljXLuXco+gaOdAapD
         e9bUlvmQ9kH+Q==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id BF22260F46; Thu,  2 Dec 2021 00:08:24 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] Memory leaks show up a while after usung Edimax Wi-Fi
 N150 Bluetooth4.0 USB Adapter (rtl8723be)
Date:   Thu, 02 Dec 2021 00:08:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215197-62941-OPnkQG9ZKe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215197-62941@https.bugzilla.kernel.org/>
References: <bug-215197-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215197

--- Comment #3 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 299829
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299829&action=3Dedit
kernel netconsole.log (5.16-rc3, AMD FX-8370)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
