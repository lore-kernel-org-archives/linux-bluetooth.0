Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C98C432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 19:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C533961041
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 19:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbhHaT1H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240678AbhHaT1H (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 15:27:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9F9B861053
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 19:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630437971;
        bh=KW0LbaqD3fwWNzxzAWdIN/tB1mjUMQT4bBBlPBQPNzM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QefsapyfhQN8LxRTzAeyUCNyM/RDipIDjkRFBz3MMYnrSbOZGSY9qS+JdKMB/Jv3G
         vVWayo1IrG6LtHVdGliVNZ8TF9uiV8VyQU8cispqq0BNMlJpME3AGCmCurrpjUd4Ce
         wFGn+etmyQE3u6AwLRI8Al7o4eFSB8Xv2dS0dPBVlvcGiUqYQYeVh2q/87Ypivatuf
         dNO3ZKWVHxroxhGVK/SdrAYBjSSlIpag/3BkwshC4V1Ii1HtQSO11uhM0jkYRAlaL5
         v1cJEcH5M1L+aXFDrNUUcdi9JpdsfH2rIBYO/XBh+2AAONlUnJAAbyxJY+8SHfcG5c
         3Otl+m3BE37Qw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214111] rtl8761b usb bluetooth doesn't work following reboot
 until unplug/replug
Date:   Tue, 31 Aug 2021 19:26:11 +0000
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
Message-ID: <bug-214111-62941-8nEasj0yYy@https.bugzilla.kernel.org/>
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

--- Comment #6 from Marco (rodomar705@protonmail.com) ---
(In reply to bryanhoop from comment #5)
> ...
>
> Thanks for these steps Marco. This gives some hope that a fixed firmware
> will eventually be upstreamed on Linux.

There is still hope, especially since there is already kernel support for t=
he
chipset itself, just the firmware is problematic apparently, and it's even
harder since there is no real date timestamp on the firmware itself, so you
can't even know if the driver with a higher version number contains an actu=
al
updated firmware or not; I hope it does, at least :P=20

> I replaced the fw with the MS version in your link and everything is most=
ly
> working now. The major problem I ran into with the updated firmware was
> audio dropouts using the A2DP AAC codec, but I switched over to SBC-XQ (e=
ven
> higher bandwidth, funnily enough) by editing
> /usr/share/pipewire/media-session.d/bluez-monitor.conf and it's working
> flawlessly now.
According to a similar chip from the Realtek site
(https://www.realtek.com/en/products/communications-network-ics/item/rtl876=
3b)
mentioned in the github thread linked above, the supported codec are AAC and
SBC, so in theory it should work, but AFAIK bluetooth audio on Linux is a
little bit of a lottery, unfortunately.

Glad to see it works now :)

I still hope that Realtek will give us proper firmware support, though.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
