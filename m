Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8189C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 22:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E0364EDC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 22:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBZWpu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 17:45:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhBZWpu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 17:45:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2B12464F17
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 22:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614379509;
        bh=+Gh9acfV2iG/8kZ/jfS6pYSLTV0El7VHpfG5wZEqY/E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mWBAdgxqEj3XSfvCGexRi48K3E+a70zd6cOKB87xVjKb0Hj4zoztvj6Q5M8yrVA42
         CGPvrweTSXIc2QH55d6JqsA3adEwg0xV6QyC2dhllWnaqtvYUcluEcPvZP+vYWs2FL
         Qxx5HuEq/kh3hjWgBf71+k5DQuq9RBnqkggSb6QOoXG66/g3TUtTxJoYnijkjGjdYA
         64v1VHzXpPZBVRMpPEUN8sP5t7PXJiytsJZ0hBdBOLctXz4ZyCMiTy1tU51LoKFTFN
         XS95vbwRDisIZE0E6yqyxwoCtnHRxcoDAmUvZn9kDKmryj+ifIzyM072kzhVsDp5rp
         Fs94StLHS7KjQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203753] Bluetooth: hci0: advertising data len corrected
Date:   Fri, 26 Feb 2021 22:45:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: priit@ww.ee
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203753-62941-mTKp9FHhOy@https.bugzilla.kernel.org/>
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

Priit O. (priit@ww.ee) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |priit@ww.ee

--- Comment #6 from Priit O. (priit@ww.ee) ---
uname -a : Linux Zen 5.10.15-1-MANJARO #1 SMP PREEMPT Wed Feb 10 10:42:47 U=
TC
2021 x86_64 GNU/Linux

$ dmesg -W
[106376.949553] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106378.833756] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106379.909741] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106380.195521] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106380.346552] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106380.528606] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106380.685527] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106380.843539] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106381.118745] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106381.449509] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106382.544736] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106382.978739] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106385.310497] bt_err_ratelimited: 4 callbacks suppressed
[106385.310499] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106385.800722] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106387.169452] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106387.810468] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106388.250687] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106388.739449] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106389.175451] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106389.948625] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106390.103438] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106390.441649] Bluetooth: hci0: advertising data len corrected 31 -> 16
[106390.599420] Bluetooth: hci0: advertising data len corrected 31 -> 16

it just continiously spams this, several messages in a second.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
