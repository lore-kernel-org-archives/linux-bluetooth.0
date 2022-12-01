Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30DDC43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 11:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLALcC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 06:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiLALcB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 06:32:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0C353EF0
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 03:32:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79E7EB81F08
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 11:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FD0BC433B5
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 11:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669894318;
        bh=VwEVODXqAX3Gno6eOljnyjJ1N1VlRj5h50FW8La/DfA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qwp7St7CF9oQ8qkQr3sg9g+m7CieddoiyGW/3jPspiHkHz5w36bSckb4YawMedCyw
         MCmoXHfTMpmC4gHgLRPhBVgsOFJek5AuFs9/z4qVr6aszmCa/7EHg9TkSV52Xi807B
         SKYVD2Dm3Ocib3Z2xK5MHKD2yOPUIbhjX2z1TqvXKmQBmjV202nBhv3VBF8mSKUXOw
         5B3nFZJT1UPYlroozGQ+MEiLsJkuL6ZMUcal7oyWmmajD5VowjIMZRJv00nNfKwMfp
         Sm8mG2EpoQ5MHni7vU9FNapk855bliv7E+PqxUOlXGFHZ5gXZi27//9Aagsx+cgmUh
         mEO5dlMOS669Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2F640C433E6; Thu,  1 Dec 2022 11:31:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Thu, 01 Dec 2022 11:31:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: kernel@rotce.de
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216683-62941-oDFHFipbWt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

Daniel (kernel@rotce.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel@rotce.de

--- Comment #18 from Daniel (kernel@rotce.de) ---
I also need all four patches to make it work. However, after a sleep I get =
the
following in my dmesg output:

```
[32332.754468] Bluetooth: hci0: command 0x0405 tx timeout
```

After that I get the following repeating:

```
[36431.813695] Bluetooth: hci0: command 0x0c24 tx timeout
[36431.813705] Bluetooth: hci0: Opcode 0x c24 failed: -110
[36533.323814] Bluetooth: hci0: command 0x0408 tx timeout

```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
