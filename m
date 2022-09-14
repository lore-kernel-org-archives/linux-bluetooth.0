Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C59ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Sep 2022 13:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiINNNm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Sep 2022 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiINNNk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Sep 2022 09:13:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4097350071
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 06:13:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5823B81B41
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 13:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94048C433D7
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663161216;
        bh=1y8E1hMEtC/YqCpFniMBPcv1vnG05A4hrtUsbCUpkJ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OgP3nbjK4agXA8416VDHTKhqyH+o2bDXWPiTjht4QaAjhwzlJkcMdJrzZnKI8TgP5
         sW81wKCKmPu0UEqj0c8t5hkBBnH+dB2AJ1T4pajDoLLmnkBGphim3kS2+EzIoTh3YM
         nv0hIDlJGLoi15MIHEhkd8qjlT6HbS/5HkOw4HnBi5KkQVY6Is951u9i9fHJYoawEL
         +LesPsfQ6EyE8yR0r9kKij0Dqv37usfPlNZ4iq2Y5IA/d+/rCxkdCS6pJ7jIKMqpWb
         Gq3yKP9HoytzUkKA53Jyg99LTJUCL6hcezHRQW4eyEECOjVQlZZhIvoSv1G06Qa7VR
         wlkUillBHUCGA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 855B0C433E7; Wed, 14 Sep 2022 13:13:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] Memory leaks show up when using Edimax Wi-Fi N150
 Bluetooth/Wireless USB Adapter (RTL8XXXU)
Date:   Wed, 14 Sep 2022 13:13:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: network-wireless
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-215197-62941-fEdLwOCmUZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215197-62941@https.bugzilla.kernel.org/>
References: <bug-215197-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215197

Erhard F. (erhard_f@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #299829|0                           |1
        is obsolete|                            |

--- Comment #7 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 301809
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301809&action=3Dedit
kernel dmesg (6.0-r43, AMD FX-8370)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
