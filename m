Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F976C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Oct 2022 19:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJUTkU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Oct 2022 15:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJUTkQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Oct 2022 15:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD6E2D1D8
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 12:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1ECE61F53
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 19:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45552C433C1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666381213;
        bh=V5GgbE8dCbZFH3Na6PaOmCC6VWT+rUMs3wOOylHVqH8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=c00vzcJIdZVZWSrQ7mZ8IDctBu0TgkJIB6X3MFvIkqjjTDIAXjHJqhswlD3Z8c7fn
         cJgpEngc9+SSn/ctR6N2RzJM7rVoOJQrkAHQ6q69OSATannFTtSnRkryK84FE/Y522
         utybRqkc3K8VA0e7IXbrzYC+/NbRyLrhsZHZGImfqHEeQfew3C0tjjyjr/1YEiTcE4
         WIjs/lfgQue1xCVr7X2pB9Ao3wOTovQqa0pLtxvL/TiiQejF7C+HMgM8NVUvieWCGf
         4U/CaE7wcl2ZVxQ7sKDBxLXeTdp9zxWI/1SzzapsB3w/dwjSuIGAu9Vw5XhwvNFb1U
         4PDuH30my17pQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3177FC433E4; Fri, 21 Oct 2022 19:40:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216580] Jabra Elite 75t (ear buds):Unable to connect and use
 (`hci0: Opcode 0x 401 failed: -16`)
Date:   Fri, 21 Oct 2022 19:40:12 +0000
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
Message-ID: <bug-216580-62941-sge7plh3Ky@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216580-62941@https.bugzilla.kernel.org/>
References: <bug-216580-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216580

--- Comment #6 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Paul Menzel from comment #5)
> Created attachment 303066 [details]
> `sudo btmon -w /dev/shm/20221021-linux-6.1-rc1+-ge35184f32151-with-patch.=
log`
>=20
> I tested this on a different system, Dell XPS 13 9360, with the Qualcomm
> Atheros Communications QCA1x4 Bluetooth 4.0 (0cf3:e300), and Debian
> sid/unstable with KDE Plasma 5.25/5.26 and *bluez* 5.65-1+b1. Please find
> the `btmon` output attached.

Well the patch above is intel specific and it probably does make any differ=
ence
for a Qualcomm controller and it doesn't seem there is any attempt to conne=
ct
to anything in this logs.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
