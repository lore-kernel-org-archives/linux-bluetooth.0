Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A89C7618E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Apr 2023 07:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDUHcC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Apr 2023 03:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjDUHbu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Apr 2023 03:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8399EC4
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 00:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C4264E80
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 07:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B3DBC43326
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682062276;
        bh=9dMnsZYuhA7ziTLS3tyfckLYpua/+VLH6tMMrI08v5A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r23c1wGKX9OaQ17SeUoXKofFXzxfcU1xREPSXL96WceXRvozNz2nkAy/VTlRGysj3
         awhoagXnNB2Plmle30NfuPFqORnXhp0tIlfEFPTNbru1hLcdLvCeXCsg+Uku+gFpzA
         GLACwtTq2bFB3nzQJbwu3tFbWPpGsC69jyOJJvknUVgAYC2RR9zvIdmnExBnk3Vrra
         6N6QFOa5eTcLZzzcrW5vnKUUKmfARVjo+FEDCwKBsj7LrC8IgGxYMUISQjYr64LPBW
         G7uF+KKmjQ0YJauvQRvk6nTsFjkvDXvr6ygVa4hhjdJWbHlv0EXJSJGHkw66c/flBS
         SEgAAVy5dxAQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1CAFBC43141; Fri, 21 Apr 2023 07:31:16 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Fri, 21 Apr 2023 07:31:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pieroavola@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-h0esu9kZeq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #49 from Piero Avola (pieroavola@gmail.com) ---
I'm still encountering this problem with Kernel 6.2.11 (USB ID 8087:0029).

However I recently noticed that Bluetooth is almost always available when I
wait out the 5 seconds on the GRUB screen during boot. However when I
"prematurely" hit enter the bug is almost always there.

In general once Bluetooth is working and I only do a reboot rather than
disconnecting power for a while, it always stays available no matter how I
boot.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
