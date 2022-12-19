Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2361C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Dec 2022 21:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiLSVGm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 16:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiLSVGl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 16:06:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DE02DF4
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 13:06:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0324661156
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 21:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52F09C433EF
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 21:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671483999;
        bh=bRpzEg/ChzUYvonZSvjCdTwZ9tQXpoHHYnKHA7NSrx8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BBy+/nolrcuLRYIMJIq+hp1EqVSBLWqR7RoTiFUkoI5BNK+IC4xqbqNXvQYqWJB9K
         CkeVdYFErY0/hM3XqSEChXpqdp3jYNp4aedTXfHP0gmLtvjSTi5nNaQsma3wG3D8B3
         DkiG9r70d3kp7A0O3gDB7iK7CkYhlKIawtPJ89WubNCkOjKAdoQdkzYWFDNh0AE3SJ
         8FBYc/AgfV2cVUcoSl1E4U0tqq6wj6pGgd+C1P7K+LuRQEz6/zoXf8Tx9xvSaBhPpE
         cB709+5WRz9LnrfP0s0L9nQFCJOyRPA+teBaWPM/44L134XjXKScewddVV4yUllthb
         tiKzFFAyxeeZQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3B3FAC43143; Mon, 19 Dec 2022 21:06:39 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Mon, 19 Dec 2022 21:06:39 +0000
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
Message-ID: <bug-216817-62941-XAUo2s4kss@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216817-62941@https.bugzilla.kernel.org/>
References: <bug-216817-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216817

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #4 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Looks like the command that is failing is HCI_OP_LE_READ_BUFFER_SIZE_V2:

#define HCI_OP_LE_READ_BUFFER_SIZE_V2   0x2060

Looks like the controller is marking as supported but in fact it doesn't:

        /* Use Read LE Buffer Size V2 if supported */
        if (hdev->commands[41] & 0x20)
                return __hci_cmd_sync_status(hdev,
                                             HCI_OP_LE_READ_BUFFER_SIZE_V2,
                                             0, NULL, HCI_CMD_TIMEOUT);

So either we introduce a quirk that must be set by the driver or we fallbac=
k to
HCI_OP_LE_READ_BUFFER_SIZE if HCI_OP_LE_READ_BUFFER_SIZE_V2 is not supporte=
d,
the later perhaps save us more time detecting this broken behavior since so=
me
manufacturers don't seem to even care to qualify their controllers.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
