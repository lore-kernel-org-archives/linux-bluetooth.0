Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC7CA0FF8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349556AbjIEQWD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354187AbjIEKJY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 06:09:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C2890
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 03:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4B3EB8111D
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7525CC433C9
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693908558;
        bh=rIsdTDLlKifUUA3PuB9dYV9uVHWKxaaPixJBdALXcN8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oi1Lg4iIivVV0KHq0Is+g3BvNeH5ZI6Rpy31a5nQZSkoU6tmO4WQWBPFOTsoIDfgk
         KQ8kzvbI2oXmeZ0OVWzEPv74XJcrZ7ZnbTXP0q5jdFrYkUYLvC6FNMfWq2xhsr616j
         YrEdjcqHbFOZB9DtLimmXco3aWOJ26znnsQJ3sqYMSV+XMrOxPKjikBNLxwMMX/1IR
         CFQiyKTVblN/+fpUY+yDMkcRcW3pH6OTo0tJaGtca4DVofRemHFS2B27F/76uGKoUb
         b2lcQFxRSaJft8CB9zaCtqq+DLcDu8UCdEuNmWkgfPgtsavXDJQSIDfvlkOZoIBFvh
         YCHZVBln99W2g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6059EC53BD4; Tue,  5 Sep 2023 10:09:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] Lot of "hci0 sco packet for unknown connection handle"
Date:   Tue, 05 Sep 2023 10:09:18 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-80791-62941-JOj5HQfu9s@https.bugzilla.kernel.org/>
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

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
This is still relevant as of 6.4.14.

There's absolutely no need to log this message more than once or ever.

The kernel doesn't log TCP packets being dropped/lost/whatever.

There's no need to log bluetooth's packets either unless debugging has been
enabled.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
