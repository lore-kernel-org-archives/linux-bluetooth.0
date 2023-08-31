Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886CFC83F32
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Aug 2023 13:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbjHaN0T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Aug 2023 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHaN0T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Aug 2023 09:26:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8842E55
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 06:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E4D6614F3
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 13:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0BC7C433C7
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693488368;
        bh=/sC36nCyJyOgSPsZAdBZRCXucWQLuh+cLk3rQhbX3IQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uCkFNsFQhlsqCPEuw2kD78g+MMpRGXUlzLgIEc12nc4LXraUhilW+HQXxv3VQBHTr
         cm3zalN2O7LoCB0g+sDsfG7U1n0IxgBuMJfhaVqB5Wn/Nm39Qti8zkikG+gQDRgvhq
         uhXzz2sGFRqTI4dov5xW3KUSIWxiUhzoBA9eHqzZSAJtTGraP9sEsKXWwRlRIRXq1R
         dyr9OHp6w4Po1mjuwLKjrI7r6FTd0Uo0ks9IgXkla8LzZqYpuNPvctpYoUbHO+riqi
         gdRuyakmQWFVsl/vqK2vVEgwJ+cJi/AA4mBMBCpKdwthbWTD33TMlm0+P33XhzuA9N
         AqB1wCCcxfWug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C7FF2C4332E; Thu, 31 Aug 2023 13:26:08 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217805] Qualcomm NFA725A on T14s AMD Gen3: Bluetooth: hci0:
 Failed to send headers (or body or access otp area)
Date:   Thu, 31 Aug 2023 13:26:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fanf42@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217805-62941-zvZngtQmsF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217805-62941@https.bugzilla.kernel.org/>
References: <bug-217805-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217805

--- Comment #2 from Fran=C3=A7ois Armand (fanf42@gmail.com) ---
For info, I find that subject: https://superuser.com/a/1451102

So I tried to disable bluetooth in bios, boot, re-enable bluetooth in bios.

With that, I was able to "unblock" the bluetooth adaptater in rfkill.=20


But I still didn't have any controler listed in `bluethoothctl list`.=20


I then tried to disable laptot battery ("power > servicing" option in bios)=
 to
see if a full cold restart does something.=20
It does: I've came back to the initial state, where the controler can't be
enabled at all.=20
I tried the disable-then-enable-bluetooth-in-bios trick, but that time it
doesn't do anything.=20

I also notice than early in boot, I have that message:

---
kernel: usb usb1-port3: connect-debounce failed
---

Which seems to be link to the bluetooth controler (I don't have the message
when bluetooth is disabled in bios).

So it looks like an hardware problem right?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
