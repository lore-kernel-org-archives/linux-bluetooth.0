Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B1C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Feb 2021 17:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB1964E4B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Feb 2021 17:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhBQR0W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Feb 2021 12:26:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhBQR0V (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Feb 2021 12:26:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 276E564E4A
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613582741;
        bh=ZWoYPyGjQoCTy031d3zKbKyY1TzxS2z3bACphiVhwlc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=msmoEYyrpujC/QpeJpEqdVJfpudBiGhZjShW/vet+4S7JHdLcK1tuYl8FLdf+eApo
         bv6VnpDKY2MYq7AI3qmyQ243+D1yOzcelfUihoVQ2KMFj54xXH9Ze8FXLs2TwV2hyI
         a53ZR/YLuxm+9mXIPRzX1DUG91lfgS1fCmDu+c1roFtfLvm9Gu+8HCYlnc6aFSAQUH
         JixEWXgs+jSBALOqVH3EmQ31B8tGdOlZGCmSu9Kkeypt1mar4+3GAF0dF3u5QdN4Hn
         gTPBuAcvmMf582X7YnF568Rbn/kxoiu6qlgirFavJGOhckzYD60boxccMB5r0fwnN2
         f9BhMINp2urmA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203753] Bluetooth: hci0: advertising data len corrected
Date:   Wed, 17 Feb 2021 17:25:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: m_pashka@mail.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203753-62941-gMuRhIqfgl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203753-62941@https.bugzilla.kernel.org/>
References: <bug-203753-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D203753

Pavel Mukhataev (m_pashka@mail.ru) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |m_pashka@mail.ru

--- Comment #5 from Pavel Mukhataev (m_pashka@mail.ru) ---
Observe the same issue on raspberry pi 4b (2G)

lsb_release -d: Raspbian GNU/Linux 10 (buster)
uname -a: Linux raspberrypi 5.10.16-v7l+ #1402 SMP Tue Feb 16 14:12:18 GMT =
2021
armv7l GNU/Linux
bluetoothd -v: 5.50
hciconfig hci0:=20
Type: Primary  Bus: UART
ACL MTU: 1021:8  SCO MTU: 64:1
UP RUNNING=20
RX bytes:8883 acl:74 sco:0 events:473 errors:0
TX bytes:4783 acl:74 sco:0 commands:251 errors:0

dmesg:
[   14.925896] Bluetooth: HCI device and connection manager initialized
[   14.925926] Bluetooth: HCI socket layer initialized
[   14.925948] Bluetooth: L2CAP socket layer initialized
[   14.925984] Bluetooth: SCO socket layer initialized
[   14.938333] Bluetooth: HCI UART driver ver 2.3
[   14.938356] Bluetooth: HCI UART protocol H4 registered
[   14.938471] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   14.938792] Bluetooth: HCI UART protocol Broadcom registered
[   15.121724] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   15.121733] Bluetooth: BNEP filters: protocol multicast
[   15.121746] Bluetooth: BNEP socket layer initialized
[ 4080.572228] Bluetooth: hci0: advertising data len corrected 28 -> 27

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
