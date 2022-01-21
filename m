Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DFEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 17:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbiAURuQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 12:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382023AbiAURsp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 12:48:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82F5C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 09:48:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09FDE61B00
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 17:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 752E5C340E1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 17:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642787321;
        bh=tz59ud175vLCm5+eB56ix7HS3Aondy/fB7pL/qrNdJ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MrmeXQXzTCiZg0XDN3jPsLnUVVmxLlfof6LpKJudyb2PLcv6sh3GKL10iukoDJyR1
         qhSxEtQSsaQujEhBooW8KbjA22B4/sZpagS/0r67MaMFtzLpeKM/OKyruoVql1LgXt
         wO3npeCVr0mixgYlGYQh9Y+SmUBdL+F5MdMfC8ILPedtp5MpZwH6Z30JUUoaxsJ5Xp
         eupZPnU3g9vcNW5VUT9us2+jxDAQxcEMql9TrzXm/ky86oIqztUYntNKCssiHPLMPx
         8YUzU9E1O9bDHMO8R/SQZMKCGYfLZttSyYil07VqSPpv6k8mJqPay3+UU4G1nHqv56
         XY6tBxlQEIuYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 576C3CC13A7; Fri, 21 Jan 2022 17:48:41 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215497] NULL pointer deref in klist_next triggered by Bluetooth
 HCI_Disconnection_Complete event
Date:   Fri, 21 Jan 2022 17:48:41 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Networking
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: soenke.huster@eknoes.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: stephen@networkplumber.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215497-62941-os9yNT08RK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215497-62941@https.bugzilla.kernel.org/>
References: <bug-215497-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215497

--- Comment #4 from S=C3=B6nke Huster (soenke.huster@eknoes.de) ---
Submitted a patch to linux-bluetooth:
https://lore.kernel.org/linux-bluetooth/20220121173622.192744-1-soenke.hust=
er@eknoes.de/T/#u

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=
