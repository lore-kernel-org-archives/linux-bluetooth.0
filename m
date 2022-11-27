Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5414AC43217
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Nov 2022 18:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiK0SS3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Nov 2022 13:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0SS2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Nov 2022 13:18:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DB6BC0B
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Nov 2022 10:18:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A448B80B2F
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Nov 2022 18:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33F04C43470
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Nov 2022 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669573103;
        bh=3mfsdQx1F2gVCHYPhXcX4d27M6q4nvi15qQAqkojj0I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DEatcK2S3ukDMMLnRMJeHZE6m+pko9auJvNe/Iq4W1F6Ncgqp4i61+TVJwnPn0JPT
         A8a2bd32Sv8kWgBakMq5eXq0Mcrpa+fqOUq8pR+BLisskfdj5gXkKb3RcW562yKKnC
         dv6GDitG1f6k9dNyQEwXMsGS2ymtfCKpXJBiOIiq3599nmv/0VMgZzuoh4nPb0kauP
         rO1wtMaEjrRJg8XXt3cY3t9pZhY0gi4R09eIYlkwD7ctUxL5CaPFuD/dnHrnw1H7yE
         nA2gu0Uxu2zyq+qtQ5+gsaPFANivoMhx1mUe01gzzWC/RUttjrjFGfLKF30dYijNJX
         FhASUqkGiRckQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1D1FBC433EA; Sun, 27 Nov 2022 18:18:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215189] hci0: unexpected event for opcode 0xfc2f
Date:   Sun, 27 Nov 2022 18:18:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wiredknight375@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215189-62941-TJlhIXW7TE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215189-62941@https.bugzilla.kernel.org/>
References: <bug-215189-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215189

Rijnhard Hessel (wiredknight375@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |wiredknight375@gmail.com

--- Comment #3 from Rijnhard Hessel (wiredknight375@gmail.com) ---
Forgive me if this isn't related but also seeing the same message with

Bus 001 Device 003: ID 8087:07dc Intel Corp. Bluetooth wireless interface

System:
  Host: HESSEL-MSI-MINT Kernel: 5.15.0-53-generic x86_64 bits: 64
    Desktop: Cinnamon 5.4.12 Distro: Linux Mint 21 Vanessa
Machine:
  Type: Desktop System: Micro-Star product: GE70 2PC v: REV:1.0
    serial: <superuser required>
  Mobo: Micro-Star model: MS-1759 v: REV:0.B serial: <superuser required>
    UEFI: American Megatrends v: E1759IMS.62D date: 04/13/2015

Also the side track also seeing a lot of other issues around powering on the
adapter after a suspend resume cycle (quite a few over the web, on launchpad
etc)

so was wondering if it could be related.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
