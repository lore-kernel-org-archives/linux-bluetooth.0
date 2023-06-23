Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573C9EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 14:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjFWOX4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 10:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjFWOXz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 10:23:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608492689
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 07:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C808B61A70
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 14:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DB58C433CB
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 14:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687530233;
        bh=8gTktplvcTsFYr+Z850AL+0Ma9EnWBOByHsfOFbJhF8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HkpYEfFANhGA89c7+obP5kaJWIG66XJdFylGJzIFq8kc9fe2jK6pdy7iMgN12dg+/
         qFYMW+gok4/IxoxMj1cwB6SKnyZl754Ypa8KYiy5LwwIvtamQmUqd8LiyIyNbIrwKQ
         D6hBx/naphfUDZiNjzAU1bBLp/oZ2nkNcY+j9cox629clZ0gPO6v9b38dnJ/Lxkujm
         /kb4ePBzbpDvcNZwaDJbf0xOAjGe3BmUWyt1NbxTcQtHmHmt34F7C9AXyYMBoSHOby
         Di3o1+g9MptobRZrdPL/QyDl9+6m51mS7T5sqiCAEtQfUfzUifAbIl8VQkPOJJKamp
         CKBEO4Nusaxcg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 13380C53BD3; Fri, 23 Jun 2023 14:23:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date:   Fri, 23 Jun 2023 14:23:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: scherbakov.al@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204589-62941-9vJr5ELD1H@https.bugzilla.kernel.org/>
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

--- Comment #15 from scherbakov_al (scherbakov.al@gmail.com) ---
I found this answer from Vudentz on github :

Looks like it is a link layer issue as the connection just times out when we
attempt to exit sniff mode:

HCI Event: Disconnect Complete (0x05) plen 4 #18605 [hci0] 358.578948
Status: Success (0x00)
Handle: 256
Reason: Connection Timeout (0x08)

Perhaps the device doesn't like that we are exitting sniff mode on our own =
or
something like that.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
