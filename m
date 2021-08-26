Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4580FC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 12:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B8760FE7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 12:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbhHZMLz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234332AbhHZMLy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Aug 2021 08:11:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6886E60FC1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 12:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629979867;
        bh=WW1WUYv2UCTnAiR6kMpapCP3LibHMPDjMo8kYZJA9TQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qn1gHqLWdPFw/u2llQb27b+hYaGVnuwrX0MwWKknW6raF7Xe5jW9zADr/MoN7yqQo
         Fsm3OfB1P8yEapfxxf47h0PMFQnaTxpExNPfl0Zk9k+37VGocQpFQKb5oMapPhyam9
         T1fMCN37qXvlw64L8wue3hXw6ArwdL2wUR4whwpzSZucugWK4hLu+EfXKC1oxfAbbZ
         ZqBi1JUjmA8I2QMJ1QQKVdkmby0HCH+2/Qf9J+LGwthheIHQrS4e+OxuB0P2+Emr7U
         tKHa4xUpZdRxvBQWzUoKLJi4uEoNtxZFcp9KcTdCcG7OYYSsslXbrXcf5nQqzd4+Yx
         sLeupzd7QHu1w==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214111] rtl8761b usb bluetooth doesn't work following reboot
 until unplug/replug
Date:   Thu, 26 Aug 2021 12:11:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rodomar705@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-214111-62941-69mVbseu5W@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214111-62941@https.bugzilla.kernel.org/>
References: <bug-214111-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214111

Marco (rodomar705@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rodomar705@protonmail.com

--- Comment #1 from Marco (rodomar705@protonmail.com) ---
Can confirm the same issue personally, but for me it's even worse since this
firmware doesen't reconnect 9/10 a previously associated device. I've tried=
 an
updated version for this adapter (2020/12, from the folder name contained in
it) specific for linux from XMPOW:

https://mpow.s3-us-west-1.amazonaws.com/mpow_BH519A_driver+for+Linux.7z

And replaced _fw.bin and _config.bin, but nothing changed.

Then I've found this post on github:

https://gist.github.com/peteristhegreat/b48da772167f86f43decbd34edbd0849

After ordering by date on Microsoft Catalog for "realtek bluetooth", and a
dozen downloads, I've finally found a package that contained the firmware
version for this rtl8761b, this specific package:
https://www.catalog.update.microsoft.com/ScopedViewInline.aspx?updateid=3Db=
103336e-5da4-4b03-ad04-7224d591aadd,
download link:
http://download.windowsupdate.com/d/msdownload/update/driver/drvs/2021/05/c=
a0e770c-6a5d-4de0-b37a-f4b91cccd8c3_7778831d2b9d721cf94d5a8d8c0676ff1b96c87=
4.cab

This has a date of 26/04/2021, and after extracting
rtl8761b_mp_chip_bt40_fw_asic_rom_patch_new.dll and renaming the same file =
to
rtl8761b_fw.bin and replacing the file contained in /lib/firmware/rtl_bt/ a=
nd
deleting the rtl8761b_config.bin file (AFAIK, Windows packages from Realtek
doesn't come with a config file, but besides an error in kernel the _bin is
sufficient) my adapter works wonderfully. No issues on reconnecting, no iss=
ues
after reboot, the adapter works correctly.

Instead of forcing users to randomly download Windows drivers from the web =
in
home to find a working and updated version for this device, can Realtek add=
 the
firmware and kept in sync with the Windows version as it does do with the
others bluetooth devices supported in kernel? Any way to contact them?

Anyway, for the people who have this issue, try the version linked above.

Marco.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
