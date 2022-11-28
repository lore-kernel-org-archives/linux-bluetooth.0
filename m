Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45D1C4321E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Nov 2022 16:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiK1Qbe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Nov 2022 11:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiK1Qbc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Nov 2022 11:31:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB67E1F9F9
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 08:31:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58274B80DFF
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 16:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05278C433C1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669653089;
        bh=uTdiVSlrlA1iZQS/NVLh1i5l70SXoODfbkG4USEtQJU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XNZ5QlgO3PMf1zoMZ0HjGt5bBkoKez6PLjrVftnKTNDV0rKSSYs8WQFlaY7rslG8v
         D8tddLybhpeCQCWIufWZWcB0BcVHKCNeu4F0+YL+FNUXVA52FrwsBoAgITql3ACdcO
         +f8+DTebSDMylgYIBQVExnKUGbdbqatgtS+Ar96O/IpjoUXtK8al9mlYtoytSUaOTz
         Cq91CeQ9vaTTbE5AUMkAICmz+dAWH8LQI1GFJudTGRFhf0HmI3Kzw+xcN+MSB512p0
         4G6HKOzoVEF8W8wmxIACEnpNmX1ZpBSs5UX7iIJO+DtEnnLC9qLI1UIhapK3l8Oyj5
         cqzBXjWC5AEOQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E07CAC433E7; Mon, 28 Nov 2022 16:31:28 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Mon, 28 Nov 2022 16:31:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216683-62941-mLiLoKGG0h@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

--- Comment #10 from JustANormalTinkererMihir (justanormaltinkerermihir@duc=
k.com) ---
Also please note btusb.enable_autosuspend=3D0 is a kernel parameter I have =
set
and the issue still occurs. It also occurs without it being set.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
