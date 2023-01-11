Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAEFC5479D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 21:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjAKVTr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Jan 2023 16:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjAKVTn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Jan 2023 16:19:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C3E19C0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 13:19:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6C1CB81D77
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 21:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99CF2C433F1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 21:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673471980;
        bh=SJMgqOJk/toTjuliDHOjEOe/UhCJXNKl3PYHyoZ6qCw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SCIj+Dqxas4Jz9NmfW4db8hxy+GmAC+sNdZKSR3gosEMEFqFU1N0nn8J4BK04l/t9
         ViJ9nBpHxPVGQMHujb7I8HPdx9ma0lBlSjM543lAdmsBNaW5Es7HbzY386zQBLoTbr
         IeYwGEqlKxwxEKZLQIOdtP/Bd0iawLdAmIc0CWJyCJQxvop7Bxj0ISLYBCD8rnXZTN
         syFSZSayFQow7DeK6nI9xcGo3bGySdATL4SlUJ5590I7nZ71D5JP+VmSpxWGnhLmRY
         9XEN0Y0Ihg7A0DocgL5Om0L3NB5TRCEcY/rBrPs2xaL0pLtvm+BsMTeuqYIAHS6fXe
         qBGCTcUIgdyew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 86147C43142; Wed, 11 Jan 2023 21:19:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date:   Wed, 11 Jan 2023 21:19:40 +0000
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
Message-ID: <bug-204589-62941-LZVMkH8F3V@https.bugzilla.kernel.org/>
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

--- Comment #10 from queeup (queeup@zoho.com) ---
Created attachment 303580
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303580&action=3Dedit
journalctl -fu bluetooth > journalctl-bluetooth.log

print out of fedora silverblue 36 bluetooth service debug

journalctl -fu bluetooth > journalctl-bluetooth.log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
