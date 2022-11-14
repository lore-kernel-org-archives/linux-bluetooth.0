Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46661C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Nov 2022 06:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiKNGcn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 01:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiKNGcm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 01:32:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B190115A27
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 22:32:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55C5460DE1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 06:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A52BCC433D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 06:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668407560;
        bh=uuk3zJvcnHglL4FonF5xKwhtRN1t62E6aj+C+4CgJGs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=axu5eI64sDBm68Mwno27t5FDXUvEldzBeEA8V/+8x3H0ccDvNefoqVCS85VZZl4zW
         sj2eHhjHwBlisW9Ueq7nasPrIsywUKtk1Vwn1r49I1QXHmejInW0TQB060xgSOu64n
         SSVM19NZHSOiGJaMQHq7N7Z09HZGpjYH5FHtS8W8MrY2rgkvstMjWjfL8wN+tQ9Zeo
         UGzHaLPbezJaYY6f6Rx1rSxcKVl1QCn2F2IznOWA3VsUUQ20qBgaFpRF3upVXkZSpf
         U40mV8hNiHJDMv7aZ3IFfzIjYCWmRo0vrz2Saj5S+1FeKqigLMUJBpLhUCAsMNHDV0
         Wc7wN+TLqXeUw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 87D62C433E7; Mon, 14 Nov 2022 06:32:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Mon, 14 Nov 2022 06:32:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: frc.gabriel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216686-62941-DshpU8N9mO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216686-62941@https.bugzilla.kernel.org/>
References: <bug-216686-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216686

--- Comment #14 from frc.gabriel@gmail.com ---
I noticed these messages after a some minutes:

```
[  350.120656] note: kworker/u33:1[860] exited with preempt_count 1
[ 1873.559221] wlp3s0: deauthenticating from e4:bf:fa:cc:15:70 by local cho=
ice
(Reason: 3=3DDEAUTH_LEAVING)
[ 1877.096203] PM: suspend entry (deep)
[ 1877.106898] Filesystems sync: 0.010 seconds
[ 1879.113564] Bluetooth: hci0: Opcode 0x c1a failed: -110
[ 1881.129302] Bluetooth: hci0: Opcode 0x2042 failed: -110
[ 1881.129327] Bluetooth: hci0: Unable to disable scanning: -110
[ 1883.145290] Bluetooth: hci0: Opcode 0x 406 failed: -110
[ 1885.161292] Bluetooth: hci0: Opcode 0x c01 failed: -110
[ 1887.177319] Bluetooth: hci0: Opcode 0x2042 failed: -110
[ 1887.177330] Bluetooth: hci0: Unable to disable scanning: -110
[ 1887.177335] Bluetooth: hci0: disable scanning failed: -110
[ 1887.177337] Bluetooth: hci0: start background scanning failed: -110
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
