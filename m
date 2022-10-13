Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09EFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Oct 2022 19:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJMTow (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 15:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJMTot (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 15:44:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BC819285
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 12:44:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 32920CE22FF
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 19:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62ECCC433D7
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665690284;
        bh=8lwV5Xqa5kCTcHuVYjRYmEuUTSYyMvCjwY4HiHQ13Mc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EUvf+Onl4Qo0xUDAvVDq1j4FqtabR5rvlR9MZqm1BnrVP35rqxmp3iHkp0/03uKGm
         UvFEFgpwZEGjtDt6GkReE34/dWPI+LKneSIYq16yP0uKvP+Hyc42LNSIu7hRzV2hVp
         +W8BgshnWhJ84e3YLmZiUKESTPVFahM7y0wbdHgxE8VM/VEVSmfIPsdrfVc8EJcGH6
         tniVYat7Sle9xX2PNzJ416jCjxWP1xNAa5uJJonI07M/DywBjffx81oSSIqcB/BZ/q
         6T85Qmp3YTGCZqK8w+H7ZZTSpMYicgn426n0YpdgbvPPaW1apWWl1pp9kiX4/ZScw2
         orSjZHLDT5mPQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 43E54C433E6; Thu, 13 Oct 2022 19:44:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216580] Jabra Elite 75t (ear buds):Unable to connect and use
 (`hci0: Opcode 0x 401 failed: -16`)
Date:   Thu, 13 Oct 2022 19:44:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216580-62941-mXpEmuDDsk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216580-62941@https.bugzilla.kernel.org/>
References: <bug-216580-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216580

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #3 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
This looks suspicious:

< HCI Command: Microsoft SW RF Kill (0x3f|0x003f) plen 0=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                        #844 [hci0] 226.575196
> HCI Event: Command Complete (0x0e) plen 4=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                                         #845 [hci0] 226.576116
      Microsoft SW RF Kill (0x3f|0x003f) ncmd 1
        Status: Success (0x00)

Which comes from:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tree/drivers/bluetooth/btintel.c#n2600

The problem is that after sending RFKILL we need to reset again in order for
the firmware to become operation again as explained bellow:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tree/drivers/bluetooth/btintel.c#n2361

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
