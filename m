Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7820DC43334
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Jun 2022 16:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiFSQqf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 Jun 2022 12:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFSQqe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 Jun 2022 12:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E9D11B
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jun 2022 09:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBFA8611FD
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jun 2022 16:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55D9DC341D0
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jun 2022 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655657192;
        bh=7v1/7NKZy2tWqtwMDF/+3RZOrlnG+vpot6V8xybY9+w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dDBfKfQscqEpjVsGZestu138eZZwGovg3Ku8XvxZczS6qnS73EH+3UjH4KSIfptMH
         uyTl2bFj42LX8exW5tG2uPjtg0a37TeFBAhEQ5L2zqccrjxDHxTbz62VpFv14POwU5
         nqK4aPwLf3A76VM302iG5TYCr4p/F9brLpcf4A40GDRLRcd/3R1Qb37/JVlucKxNfV
         J+eInF4XIxpTJAtghM3q35Yuzh1sRvtswtKhA/yUhXERvM/EqtsMQJu/VqxpVfiMvy
         v+bdLXOvpgEjmdH6oAzfVBYKRsTseEtpM721Ul5zOzNsNHaclJs1OHpO4SO+yOKdb8
         gXGfAgi33yVmg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 442C5CC13B3; Sun, 19 Jun 2022 16:46:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Sun, 19 Jun 2022 16:46:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215576-62941-dVtmbbSb96@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

--- Comment #16 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to wavexx from comment #15)
> Created attachment 301217 [details]
> Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN to btmtk to fix mSBC

Thx. FWIW, this might easily get lost here. Would be really good if you cou=
ld
sent this to the bluetooth maintainers, ideally as a proper patch with
changelog and everything:


BLUETOOTH DRIVERS
M:      Marcel Holtmann <marcel@holtmann.org>
M:      Johan Hedberg <johan.hedberg@gmail.com>
M:      Luiz Augusto von Dentz <luiz.dentz@gmail.com>
L:      linux-bluetooth@vger.kernel.org
S:      Supported
W:      http://www.bluez.org/
T:      git
git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
T:      git
git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
F:      drivers/bluetooth/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
