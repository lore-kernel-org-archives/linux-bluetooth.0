Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5241DC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Oct 2022 17:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJOR7l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Oct 2022 13:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJOR7k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Oct 2022 13:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0375B13CFD
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 10:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB84D60F2A
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 17:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 527B5C4315D
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 17:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665856777;
        bh=2QWBzlLgS2Amb3Ja9EuQIKXswrnzjFmda2TSV9HQjY4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eqGxw37sshF+e8gMJ3eJCGZN8wzXZ4Gus2F19Kek58Bv0LLjAsM1lUFomukwjq+eh
         LBKWdzbjdmRP2B81iGrk+ptC1nIXcqT7ERpFd/Pz3xLsIFbM+lllaj955feiuKonuN
         /ljZK10Qn4Xa3ReaGNGVDOoQyMbM/isGOLtS2k6HXIyngYmXkcy7FrzYdWikKeEdrf
         6nMjOqH0lQAroZOXYYE/YxTQCtyGMaw0UQNS9l3TQOneONL4+h6ZdSTQK9CSZNezM2
         1zg1GOEzbCFpXPdCzjH24cCd30YP+4oZInt4bm7R7c+z1Ci1pEpl6HgTVd9a0eSXUe
         oi7gpwuIqQ0zQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 453BBC433E7; Sat, 15 Oct 2022 17:59:37 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 15 Oct 2022 17:59:34 +0000
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
Message-ID: <bug-60824-62941-d0Ku4hCSGh@https.bugzilla.kernel.org/>
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

--- Comment #235 from Swyter (swyterzone@gmail.com) ---
I can confirm someone messed up and broke my submitted patch. I'm on the Li=
nux
kernel 5.15.73 and `btmon` shows that the Bluetooth stack is asking to set =
the
event filter *again*, when the added quick should make sure it doesn't; loc=
king
up the dongle.

< HCI Command: Set Event Filter (0x03|0x0005) plen 1=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                                                         #23
[hci0] 5.316838
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                                                                          =
#24
> [hci0] 5.319751
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)
=3D Close Index: 00:1A:7D:xx:xx:xx

Well done. On Linux kernel 6.0 I can't even get the cloned dongle to show u=
p on
`btmon`. So things are doubly messed up and even more unstable.

Who's going to fix this? I have other stuff to do. =C2=AF\_(=E3=83=84)_/=C2=
=AF

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
