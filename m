Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF30C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 18:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357400AbiBNST3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:19:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiBNST2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 13:19:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF3D580D8
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 10:19:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A93E60AFF
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 18:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAEB6C340E9
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644862759;
        bh=GDUcyXk2UdLJcjF2nP4pVn5UTyqU1/vwMFcZQhQv0YM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=noxJT2LlB61QWzEV1jHbgsRD0TwDvm2c9Qy5nHt5NnqkObeqThcNGXpIqLa3qffut
         ujhNem2HZyLliyuDeX7e0QeOZftdKfMxkavmq554G9QOiXaBcSBz1rKg5nvUs/Nulb
         jtYTGSDGRnCEnFQlh/RJSV6Vjrpeth7x9jeVxp+JVaJrZwJvTS67Q30LI/2Sp5YiYQ
         PZaY6Iw7hQTLVh5YKV0myjcQU8PBTf+w0QMDrTI9HotWt5pFXLkWGebfteLj+5UVZq
         T+YnYN7Lsy6M55rt/TZRrq8t+Ae+x++SD6cMF0g9R6V3rdPFBhA/tIBHTyA/YH7YSS
         3KH2ZuZesEguw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A4603C05FF5; Mon, 14 Feb 2022 18:19:19 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215594] Unable to transfer big files to Nokia N9 and Jolla
 phone
Date:   Mon, 14 Feb 2022 18:19:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215594-62941-mKVZfydwol@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215594-62941@https.bugzilla.kernel.org/>
References: <bug-215594-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215594

--- Comment #8 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Paul Menzel from comment #6)
> Thank you for looking into this. Did you test with MeeGo/Harmattan or
> Sailfish OS?
>=20
> Also, it wouldn=E2=80=99t make a difference, as Linux=E2=80=99 no-regress=
ion-policy
> requires, that the everything keeps working with the existing user space.

How about getting some logs from obexd then? Stop obexd.service and start w=
ith
obexd/src/obexd -dn

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
