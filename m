Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB6C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Dec 2022 15:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiLLP4O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Dec 2022 10:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiLLPz7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Dec 2022 10:55:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E8513CC6
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 07:55:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21373B80DAD
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 15:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB24CC433F2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670860553;
        bh=M/hAH46RO7qij6no0upm+ejuPJMwjS+GSw0DdDQSkVo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TaixT6rq+A/HcXQm/yf5RAnliHsrzE2gazLE2UqYHi2MsM2mYDy9zLoIxz5AUkVeg
         eZ48B0sO27AXZbybQ/oXzNf/+BYbwXCq27RoKUeF4ExgF7j9KqBFvMFhca8NLDPCm1
         fx4fkGDDMXIzsA/UuaM/F8BwtylKp5rN4ViN17QjleO31l2LeBmisP4FkFaKZpWU+n
         WrCZ4c6skEuSgxNaeNxMSZbizAbFZo8Uu04gqd6eKgtog4v3LiGkzKKWkslgS3GKyB
         t+VujbYej0aZYWxOuoLQR4BS0vRCPF+jLAjM3riiO/I2hiY1+845DgeZtvBRw/+AKc
         Kq0V4100WeBYg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CC130C43141; Mon, 12 Dec 2022 15:55:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 12 Dec 2022 15:55:50 +0000
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
Message-ID: <bug-60824-62941-UA72DLtEGp@https.bugzilla.kernel.org/>
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

--- Comment #262 from Swyter (swyterzone@gmail.com) ---
Quick heads up, the patch thingie that adds further dmesg logging for
diagnostics has seemingly ended up in 5.10 and 5.15, and 6.0 (which is the
version that originally broke it) now additionally adds that and the removed
quirk. Cool beans.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
