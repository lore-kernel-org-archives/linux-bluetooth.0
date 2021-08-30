Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0DBC432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 16:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8B060F5B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 16:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhH3QCb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 12:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237542AbhH3QCb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 12:02:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8E20660F5B
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630339297;
        bh=7iN1GtglIyv0KawJ+Q2uWQCHi2Nz4iGbnEsw0DR+pf4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eDLP6+JBDhE4K3hhjDCcfHqQeGuuwQoLMbXx6HZuVQGzXhoc19xxXdAdkaGb1uQUa
         DNFtM0sKfMAxnJoPdsK8FN0WgfEiS188lYD3VPReBoiKfaeJgyQAxmfB5Qr8fC6g9G
         uOGZTGOura6IxRVbrFR6H1S+xa9lpqwqjceGkVj+TEtC1/O//yq6detgNKM7pujEYK
         E7k3hmABLCs+qSDAfZdtCof8PnsyGflHKInWOxLRIqLwixtTwSZUpIhVQQtXwkerap
         wx9Jn8GbCHrOpWAI8YKJ1HcaRLgj8j95eEmtjrbPTZR84y0EJvsz3ijYMlZ/hXqdVX
         3ZpzrRURXci5Q==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214111] rtl8761b usb bluetooth doesn't work following reboot
 until unplug/replug
Date:   Mon, 30 Aug 2021 16:01:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bryanhoop@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214111-62941-YjvxCy5ki2@https.bugzilla.kernel.org/>
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

--- Comment #5 from bryanhoop@gmail.com ---
(In reply to Marco from comment #1)
> Can confirm the same issue personally, but for me it's even worse since t=
his
> firmware doesen't reconnect 9/10 a previously associated device. I've tri=
ed
> an updated version for this adapter (2020/12, from the folder name contai=
ned
> in it) specific for linux from XMPOW:
>=20
> https://mpow.s3-us-west-1.amazonaws.com/mpow_BH519A_driver+for+Linux.7z
>=20
> And replaced _fw.bin and _config.bin, but nothing changed.
>=20
> Then I've found this post on github:
>=20
> https://gist.github.com/peteristhegreat/b48da772167f86f43decbd34edbd0849
>=20
> After ordering by date on Microsoft Catalog for "realtek bluetooth", and a
> dozen downloads, I've finally found a package that contained the firmware
> version for this rtl8761b, this specific package:
> https://www.catalog.update.microsoft.com/ScopedViewInline.
> aspx?updateid=3Db103336e-5da4-4b03-ad04-7224d591aadd, download link:
> http://download.windowsupdate.com/d/msdownload/update/driver/drvs/2021/05/
> ca0e770c-6a5d-4de0-b37a-
> f4b91cccd8c3_7778831d2b9d721cf94d5a8d8c0676ff1b96c874.cab
>=20
> This has a date of 26/04/2021, and after extracting
> rtl8761b_mp_chip_bt40_fw_asic_rom_patch_new.dll and renaming the same file
> to rtl8761b_fw.bin and replacing the file contained in /lib/firmware/rtl_=
bt/
> and deleting the rtl8761b_config.bin file (AFAIK, Windows packages from
> Realtek doesn't come with a config file, but besides an error in kernel t=
he
> _bin is sufficient) my adapter works wonderfully. No issues on reconnecti=
ng,
> no issues after reboot, the adapter works correctly.
>=20
> Instead of forcing users to randomly download Windows drivers from the web
> in home to find a working and updated version for this device, can Realtek
> add the firmware and kept in sync with the Windows version as it does do
> with the others bluetooth devices supported in kernel? Any way to contact
> them?
>=20
> Anyway, for the people who have this issue, try the version linked above.
>=20
> Marco.


Thanks for these steps Marco. This gives some hope that a fixed firmware wi=
ll
eventually be upstreamed on Linux.

I replaced the fw with the MS version in your link and everything is mostly
working now. The major problem I ran into with the updated firmware was aud=
io
dropouts using the A2DP AAC codec, but I switched over to SBC-XQ (even high=
er
bandwidth, funnily enough) by editing
/usr/share/pipewire/media-session.d/bluez-monitor.conf and it's working
flawlessly now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
