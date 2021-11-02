Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E41C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 13:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B419660EDF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 13:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhKBOAF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhKBN74 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 09:59:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BFBBD610FC
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Nov 2021 13:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635861441;
        bh=pG3eImyZN4IDIRJYChpt6Ek11mltKqo+AdS3i79LOKI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QEQHvetKbFlQwtq1wgNUlXZhEpSFJuqTzS1Y6jtdd5vUSrMAQXZArogNZzGvvdqEf
         jTsArpWtG+Wj8IR0TTHhU1XmMBor23k/gAVRknkR4JGf1vAOnxDLVDE6kMfQjiO//r
         jlJ2DAAsFREAdMC0kvfuG311UtG/V36fIxnmsQgZgPO9Jf/41lkLgUZAbNX5yDt93G
         FgapTMYLjr4WxXnP5+AZIt+y+OuWbO+8dw28Vpt03BQ1KstFQYptwXde92OB++834r
         7H3GFbA8TTHDiq6Z/Up3AHp4U1VEb2tp1HkphdumKZyAbuwgJ0JRIm/gAirUThySa8
         kuLvzDljw2c9w==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Tue, 02 Nov 2021 13:57:20 +0000
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
Message-ID: <bug-213829-62941-shLBmCAg2N@https.bugzilla.kernel.org/>
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

--- Comment #16 from Marco (rodomar705@protonmail.com) ---
After updating to 5.14.15, it got even worse, now it will literally drop the
connection with my mouse after 10 seconds and it will stop responding to any
command until a complete shutdown, all I get in the logs is a command timeo=
ut,
it will literally stop responding to my host.

[  358.869054] Bluetooth: hci0: command 0x0804 tx timeout
[  361.045200] Bluetooth: hci0: command 0x041f tx timeout
[  363.093133] Bluetooth: hci0: command 0x0406 tx timeout

[ 1436.437038] Bluetooth: hci0: command 0x0c03 tx timeout
[ 1444.437291] Bluetooth: hci0: HCI reset during shutdown failed

This even after a cold start.

Anyone with the same problem here?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
