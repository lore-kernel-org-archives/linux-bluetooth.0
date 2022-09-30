Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A1AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 09:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiI3J6v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiI3J6t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 05:58:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2F817F575
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 02:58:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4D7C6205F
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 09:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40A5CC433D6
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 09:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664531928;
        bh=j0c6U82b2hPyXIsHCKOB6ixK42tgsOt9HOkzp6EIl4Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lewUWV0C2Onp9ZossQaYTpv1PmhkKVzTi7xZRDxNnacahLAvvxyOGf64mVJuH92Yw
         mgzeexJob0VmVxoxN2qWoa2Rv7ZngGgRVeJUWS6bELuZyHchfdIvuZuqT3mZBjPy/D
         yGndaio8LnGXtudxfpmc/Fscw28xYEYW+3eJ0BrOD9N+BVUFAXiYamrGU5ZUjAloNI
         D/OOm/QPCZRlBrN6se7DtWXxpmHsvxWun34dtLEHmZ3RhEiaW4fM10ieZPyARZgb3j
         7WhrOj23tPCdIAWwJJHVXZxXTPqv8nt0XcniodM2b4Q0ZaobSrC8JVp/QUOM0Dy3Lv
         4YKpNNuAdnTKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 18A17C433E6; Fri, 30 Sep 2022 09:58:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216532] openSUSE Tumbleweed, AX210, bluetooth, connection fails
Date:   Fri, 30 Sep 2022 09:58:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216532-62941-uSe2WOFSWB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216532-62941@https.bugzilla.kernel.org/>
References: <bug-216532-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216532

--- Comment #4 from epistemepromeneur@free.fr ---
There is no dmesg log file in/var/log/ .

I put forward the problem.

It's not a problem with chipset intel AX210 (Bluetooth 5.3).

There is no problem between a Bluetooth 5.0 tablet (Blackview Tab 8) and a =
PC
equipped with Bluetooth 5.3.

There is a problem between a Bluetooth 4.2 smartphone (Samsung S7) and a PC
equipped with Bluetooth 5.3.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
