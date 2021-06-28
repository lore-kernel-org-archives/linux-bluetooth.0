Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C09C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 10:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7875761954
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 10:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhF1Kto (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 06:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232586AbhF1Ktm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 06:49:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1A8E361C6E
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 10:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624877237;
        bh=5FHtNZBQIPr7FQ0Gs1eReL3Ct+dWF2/OdzHct0MZRoQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jTrkC4MJII7iBuGlhO0PJHiBgAnWPyFEft65bB2XYJTowGYe2rlGHaIYW9pIzmoUv
         2tgPYMu74hoREhepKoKPHVndG36PMMxXABHAvI53fs4k8/kOJZcbOdddz68yHBTDoC
         qpEUsmKpEyQWYW+TcUjSjphR0WqnYvNrUJQTmFE1XylU79H39bVq9wqsnGrqz+Gako
         /yhmSqlRBbjBCi9G87rp0S1v+3LLgF4oZyMkjLN3Xvuh1ks+SK5b/PCG407IovC5MX
         MQThVTliRkVtohY9HawsYtlax2Rbh8EVaVye8jISYkTChXH7aEfJuuTACJA8akgltb
         gyBGVlXo3WhXw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203753] Bluetooth: hci0: advertising data len corrected
Date:   Mon, 28 Jun 2021 10:47:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: maxhaase@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203753-62941-Kw1VIwoPJW@https.bugzilla.kernel.org/>
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

Max (maxhaase@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |maxhaase@gmail.com

--- Comment #9 from Max (maxhaase@gmail.com) ---
Fedora 34:

jun 28 12:07:56 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:07:56 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:07:57 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:07:57 tomato bluetoothd[1167]: src/profile.c:ext_connect() Hands-=
Free
Voice gateway failed connect to 18:CE:B2:47:EB:B5: Connection refused (111)
jun 28 12:07:57 tomato bluetoothd[1167]:
profiles/audio/avdtp.c:avdtp_connect_cb() connect to 18:CE:B2:47:EB:B5:
Connection refused (111)
jun 28 12:07:58 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:07:58 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:07:59 tomato bluetoothd[1167]:
profiles/audio/avdtp.c:avdtp_connect_cb() connect to 18:CE:B2:47:EB:B5:
Connection refused (111)
jun 28 12:08:00 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:01 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:02 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:02 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:04 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:05 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:06 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:06 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:07 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:09 tomato bluetoothd[1167]: src/profile.c:record_cb() Unable to
get Hands-Free Voice gateway SDP record: Host is down
jun 28 12:08:15 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:15 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:16 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:16 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:17 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12
jun 28 12:08:18 tomato kernel: Bluetooth: hci0: advertising data len correc=
ted
28 -> 12

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
