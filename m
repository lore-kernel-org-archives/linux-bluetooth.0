Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB44C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Dec 2021 08:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhLMIfX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Dec 2021 03:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhLMIfW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Dec 2021 03:35:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B400C06173F
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 00:35:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87F82CE0DE3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 08:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8D08C341CA
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 08:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639384518;
        bh=gmvOuHyWQtiEWHkUrnRUlDjtEooDsb9zwzKzZgEVS70=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ujasIg+7aHp/PFvj1CtvMjuhFmR0hTb+vaZja7tdx8r3gjaB5k7Pckd0hot/uh119
         Q1YoRo7whYrggBzIg3wlgdAFOttXnmnMZINsalSLyPYl9DQ/nR2/mSMC/4z7a9qUPh
         TjzuHk91ILjc78hOUcNJoQ7yGq612O8dgv2E60fB4m00BPquhLvjZAUvdeefLxvUZn
         n9alpr9O8s0fLKLkhiXRyLj5OfA/yIu6DsQdsLZCZx8BPKlKZ1zpkGC1ZuNy721t/5
         6nXSdTQKhWganVMNRE+7Nqn/ACKTjVsJPcx5pylHK06yUSVEcs4mm1FuNcGLHf9O8V
         V2QiwwtdqinhA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 9CB52610F7; Mon, 13 Dec 2021 08:35:18 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 13 Dec 2021 08:35:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tiwai@suse.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-z16cWLWIT2@https.bugzilla.kernel.org/>
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

--- Comment #20 from Takashi Iwai (tiwai@suse.de) ---
As mentioned in comment 13, the entry with 8087:0026 looks superfluous, mig=
ht
be rather harmless, and should be dropped.  The issue with 8087:0026 is lik=
ely
a different problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
