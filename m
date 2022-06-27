Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED03C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jun 2022 03:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiF0DOw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Jun 2022 23:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiF0DOv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Jun 2022 23:14:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BAF558A
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jun 2022 20:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 187EFB80EAB
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 03:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6E01C341D4
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 03:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656299687;
        bh=Q8B41qHDbywOq0VyiSVCNETR1ReNQXbBR00+D/upL/k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QQoAi7laQ+32jqy3I673C9TY/LTmlFBEEZMiGp7J7zvNN8VauSKkiIuWt83l0YPbB
         M5FSoIpFEdcP74g+MC+bh94AobnBvQtpf8IoP+jhZyJw4EpKJo5HB+M0CvVa62gVsh
         chT/S0NgnJhNlM1qgf2/Gt10tIdrOK/j8SaJx4ALzlYHx8bOQHQKP8p5lBIohJ+nTR
         ZtlgyC7xj0Yr/cr7RqcTg5URKTNHsxigDYvX3SqmNwztHh2KbiKqApTvh2kTInQFtM
         GYnVh6zSMTGyKLLW2tWyGdgvWsKtqZmy7/8NkvyCXY5TmR1gXR7t1Mp+Y2V7mx1HKC
         7BZFNW9t5TREQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B9066CC13AD; Mon, 27 Jun 2022 03:14:47 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Mon, 27 Jun 2022 03:14:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rui.zhang@intel.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component assigned_to product
Message-ID: <bug-215768-62941-WihItvzAC6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215768-62941@https.bugzilla.kernel.org/>
References: <bug-215768-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215768

Zhang Rui (rui.zhang@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rui.zhang@intel.com
          Component|Power-Sleep-Wake            |Bluetooth
           Assignee|acpi_power-sleep-wake@kerne |linux-bluetooth@vger.kernel
                   |l-bugs.osdl.org             |.org
            Product|ACPI                        |Drivers

--- Comment #31 from Zhang Rui (rui.zhang@intel.com) ---
reassign to bluetooth experts.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
