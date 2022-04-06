Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B903C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 11:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiDFLze (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 07:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiDFLzL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 07:55:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03011519D77
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 00:19:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3A24B81FF0
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 07:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EFFEC385A8
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 07:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649229537;
        bh=zfFMsRC27dBcLVtkj15IB4rgrnZjraFQkHJjNtpHqvs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HEY+qemst3Oz6N8gvTa54aAWA6FkSWFP28g+1zIXyesRr3XI5EEJzffCwmsroXLQu
         jUp3TZ4zYPZv0SQqLzU6TGfGChi0NurLH51SoJ+I1eCPniTchIVPMiJqV88wdrVEKc
         WQXedNiTA5tCuNoQ88Uoglv1PU4imK0O8Mahzlei+bT7ycw6lUP/uRNDjlkBIKGbVC
         T4IB5ByvWNVUR3jb2feuus4tjhW2l7m24w1qJJYaNtkgrO5jixyL8Rln1XUB6mRU7X
         MQRPG28pRNSSiWr7SXHiqHV1OpT70tV3LEkKw8fpQHnwuh3yRGvZ7IvdYtn8JUBFvR
         1PEr3wGG7/FLA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 36DEAC05FE2; Wed,  6 Apr 2022 07:18:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Wed, 06 Apr 2022 07:18:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: brice@waegenei.re
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-gFzCY8jshA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #32 from Brice Waegeneire (brice@waegenei.re) ---
I have the same problem with Linux 5.17 and an Intel AX210:


# dmesg | tail -n5
> [132429.090891] Bluetooth: hci0: command 0xfc05 tx timeout
> [136438.549331] usbcore: deregistering interface driver btusb
> [136442.981006] usbcore: registered new interface driver btusb
> [136444.998477] Bluetooth: hci0: command 0xfc05 tx timeout
> [136444.998480] Bluetooth: hci0: Reading Intel version command failed (-1=
10)


$ uname -a
> Linux safou 5.17.1 #1 SMP PREEMPT 1 x86_64 GNU/Linux


$ lsusb | grep -i bluetooth
> Bus 001 Device 008: ID 8087:0032 Intel Corp. AX210 Bluetooth


If you need more information I'm at your disposal.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
