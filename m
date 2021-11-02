Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397A9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 20:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D60E60D42
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 20:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhKBUEk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 16:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230457AbhKBUEj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 16:04:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5E55E610FD
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Nov 2021 20:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635883324;
        bh=xb63q3cvPekFPlMao0yIv/OLHpophCrM1EgyCRApbng=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pzIWizO8XV6mjXSQmE5Ex+5muv/+d1g+2ueecg3kRnqmH9Pu286+hxuRJ7+4WmpHH
         kCFDh7ZhW4xlc4vMvgskpPPV6rCpAb/3POwMDDRvTx6EA3CMvuP7Yf9wG27sMyCDY7
         j/uigNZq3j+ZqJ4szvpj5JEaEicKC50bs449JFPzSb2ygb8l/1KRL/t0AJPzuHQgrg
         G7rlzw1gY9KzdJOL2K/2iS5C+MiU8qtOn2IW2DwTHFlH3D+gIag8p0G5JwTIBfBGGp
         hKQSVwRhzbrdByHnvfzv4sDc0GNo52iHtkG6INYVgWt/0aCqmiwDr7kcMzwynMSVm9
         Ni+SitcIsZrIw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Tue, 02 Nov 2021 20:02:03 +0000
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
Message-ID: <bug-213829-62941-u8S6tWQffW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213829-62941@https.bugzilla.kernel.org/>
References: <bug-213829-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213829

--- Comment #17 from Marco (rodomar705@protonmail.com) ---
(In reply to Marco from comment #16)
> After updating to 5.14.15, it got even worse, now it will literally drop =
the
> connection with my mouse after 10 seconds and it will stop responding to =
any
> command until a complete shutdown, all I get in the logs is a command
> timeout, it will literally stop responding to my host.
>=20
> [  358.869054] Bluetooth: hci0: command 0x0804 tx timeout
> [  361.045200] Bluetooth: hci0: command 0x041f tx timeout
> [  363.093133] Bluetooth: hci0: command 0x0406 tx timeout
>=20
> [ 1436.437038] Bluetooth: hci0: command 0x0c03 tx timeout
> [ 1444.437291] Bluetooth: hci0: HCI reset during shutdown failed
>=20
> This even after a cold start.
>=20
> Anyone with the same problem here?

This was fixed after a reinstall of linux-firmware, sorry, the problem afte=
r a
reboot is still there, though.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
