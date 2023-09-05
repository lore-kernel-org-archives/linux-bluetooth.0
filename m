Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4159CA0FFB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjIEQWb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354210AbjIEKJs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 06:09:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8171F1B4
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 03:09:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41C38B81125
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA338C43140
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693908583;
        bh=QxINsx5ckFOCdm0tiCJE44xj5RUTKfMklRmktiqh/Js=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EflaKEk/2DmZ743mGFw1H26h8KZktGz8Ny0c7b7q4/90YRkOGJ5mP08qKYtk+T+ba
         011tJG38EevepwGbR0zpBJo4J5WKvDxFuYfkq1WQp11BauMX4UwGQZbguywMAgdt0j
         wTQFsp+KswRl+bPrI8iCcjUm4va04fq7J2m5kJAT5E61HYDTb86SxEC3T4rYA3v3qe
         ZgrKJQ9HOCfzLlw50fq4oWcP09IuGEtV+WCHbZ/F5va1nvKWbYvXnT3HZXRcGrV5iZ
         fmGUUZ3U2dstS7GjH4WTtr+ogFQE3kdNdaxkoP4MhJowXVPQ//+/yNPP0yaWt8ASJR
         tktLlEHqhOOww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DA9BBC53BD4; Tue,  5 Sep 2023 10:09:42 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] Lot of "hci0 sco packet for unknown connection handle"
Date:   Tue, 05 Sep 2023 10:09:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-80791-62941-D7ANwqsuVG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|3.0.35                      |GIT

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
