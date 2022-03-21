Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D957DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 16:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbiCUQre (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244598AbiCUQrd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 12:47:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5B816D8F5
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 09:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97731613F5
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 16:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07419C340E8
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647881167;
        bh=MQ6hRDOgC6pnWOnRp6UzKmZbbXf3cn/Salm9HflJzaY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kfRn6XQJSDZ3GC+PKjWNxa+ii7xrSyM29jg8kWAKt0zj/9yIVxnDIpu0U3ZfJ0fEa
         T3DGfCvgid/iuO4EFb1NK+2dffNNOjXYh94Ghh3Gb6V7UBZqTzsYGlJtHM+DnoYYKE
         Lf7EoQDwSvxFO7HWMXL4YbgWFaXKYCBxD7gd2hrIlgiZM5td736Hn78YzasCEmq0Eb
         gtZhpW+4VUmUcI5Y3RWTETHQaMT+IzQ/0nooe7XqLpopbSCLIkmexkGeS6I0CxSjN9
         BMSYu3QEvURskqfaX2ZIHGniS6Ku4dpReQ2VMGr1sQ+Mt3sbt01qDa/5UL5r8PkkGw
         Szk6ENmLZ5Idw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E6D3FC05FD5; Mon, 21 Mar 2022 16:46:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214111] rtl8761b usb bluetooth doesn't work following reboot
 until unplug/replug
Date:   Mon, 21 Mar 2022 16:46:06 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214111-62941-qShrkzM544@https.bugzilla.kernel.org/>
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

--- Comment #9 from Marco (rodomar705@protonmail.com) ---
(In reply to bryanhoop from comment #7)
> Unfortunately after the update to linux-firmware-20210919-125.fc34.noarch,
> it appears that the workaround is no longer working. Even with the updated
> firmware I still have to unplug/replug the dongle after startup to get
> bluetooth working.

Just realized right now, if you are using Arch, the firmware seems to be pa=
cked
in a xz archive on my system. It was still working here because for some re=
ason
the .bin probably is getting loaded before the .bin.xz file from the
distribution.

By the way, I've seen that a Realtek engineer has updated the firmware file=
 at
the end of last year, as of
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/commit/rtl_bt/rtl8761bu_fw.bin?id=3D45dc5f0b8e2f2d43312d22511cb26658b9ee2c=
80,
but the bug with that firmware still remains. I need to force disable and
enable the device.

I'll probably just get an adapter for a mPCIEx or M2 laptop to PCIEx and
install an already available Intel module that I got flotaing around at this
point, I doubt that this will ever be fixed on this hardware, unfortunately.

Marco.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
