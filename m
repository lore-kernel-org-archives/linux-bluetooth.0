Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30B3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 08:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiKVIAT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 03:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKVIAP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 03:00:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5372214D11
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 00:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0126B818E4
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 08:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A137C43158
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669104010;
        bh=TfLmS0NBAx6iJ4RWZCVpRslhy6/URnVjudTPGyhbL+Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M4C0PzmMdewYZsBGAZmHMSEIJPobwx5nwRQuwp+3gakHswdD3P3YVCipydowJQG8I
         WKBNjKceM4xkEyhQ7Ni/4w7Hg1DBdHaPS7Xxb5LrGbDIFqAP2huf5K3dgN7QuuLjXC
         sGcM2AvXC/27hn0158hr0HTSf68d0BNDutC3Zyi++cwfBZQKW1CmkvbJTBspp+J3be
         BaFQ/NCm7b2ZQ8lm0zBKERZ6gXc8qBR7gyoVBAXJePOZt/NirqQXBNYbaAQM5spkqE
         wS8yeWAwaYNffEVoA1X3fxJvW67A1jV6FxoX9BYFsrcbulAqu9e3INnLp9ym9E5a+2
         cjAVFqTOKivMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8D4B1C433E6; Tue, 22 Nov 2022 08:00:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Tue, 22 Nov 2022 08:00:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-bEco28QDv7@https.bugzilla.kernel.org/>
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

--- Comment #259 from Swyter (swyterzone@gmail.com) ---
Seems like @JustANormalTinkererMihir was missing a digit in the copy-paste;=
 the
correct ticket seems to be this one:
https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
