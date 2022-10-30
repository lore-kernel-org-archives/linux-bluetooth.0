Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9779AFA373D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Oct 2022 11:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJ3Lnj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Lng (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Oct 2022 07:43:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3620E1
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 04:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 12E18CE0AF2
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 11:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A268C433D7
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667130212;
        bh=dQ9PA94FPvh5WGkcvlfxgy7+v/9t3T+NK5m4xx91Ppw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pqqCoHeWhxCHEHNft6oU5s2gNp5I8ByRDU3nj2Gcfx8d3K/rSqk/q0xJssZloUseD
         Vt+/Umg01zgHvqSTf4TPzRCaYnYbxsvEy/wozS5FgAajoPwEj77UaLrN0RFisIijmL
         qbLo4cr8sXIKoISgu8TSEtLBWJKrayAcdlVVDjZWBM1HPqqEiMiIy4rs7pLDQpFVcc
         2yejwhUBHtPWCC6L9Py/A/TLJY2iQTDy5Hy0hoDczmOf/3U6zH0jepEbKwx2n7+djC
         ppgf/Ehz9mdRRjVWXJamsdrLv05y7ylPAuE0GMStd1mHbDeE1362UJCgK6iwQZQA63
         Qk49lO17lJrIQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2C624C433E4; Sun, 30 Oct 2022 11:43:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 30 Oct 2022 11:43:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-mpRcojRpM3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #246 from justanormaltinkerermihir@duck.com ---
It seems that patch 3/3 fails to apply due to the line  static bool
enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SYNC); not being th=
ere is
the kernel.org 6.0.6 kernel adding that line makes all the patches apply and
the module compiles. I have merged all the patches, I can confirm that chan=
ges
were made to the btusb.c and other files after applying the first patch. The
error still remains the same after recompilation

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
