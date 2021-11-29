Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3374CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Nov 2021 21:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhK2V6B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:58:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44522 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhK2V4A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Nov 2021 16:56:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 338AFB81630
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 21:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC42FC53FC7
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 21:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638222759;
        bh=PHzQHaSCzRjcUhhN/POvR/Ovw1yGqP5tlZAWLzRCEFQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S21J5i3rI/Vd7ki8/giT4bGS+e1vCQn+A4Ya99WWen+v4CYW+evnHLckLkJa2zQ+0
         qSDuHOER5ZXDA+DSiq6I6k+uYkpdXSUQiubafCTGZKohuRyaFwzjRHetTtCRA8g8l8
         sTxD+e8NaX7sxaXlheF/UTypq7LqCbHcwWcdeXj/OJaxQAvqV21/WkLdGTr0O8hw/l
         suMMvu7WCFoJHK/BtszhjGsPEHMKXSmKM2CIc2XdqgRzwXL9h0aDms9GV4/MLB6YIg
         nzkVXwVl6wdrBm4O5Ghi2vVolxkhrLinYVKKDXqaZjULech9y0MdkJKdA+8bgt9eAd
         ut0rnPBcl4WZQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id CAA2260F26; Mon, 29 Nov 2021 21:52:39 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 29 Nov 2021 21:52:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tech@reachthetribes.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-T4iRghout2@https.bugzilla.kernel.org/>
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

--- Comment #4 from George Olson (tech@reachthetribes.org) ---
bluetooth card information - only read by system with 5.14.14 kernel
> lsusb | grep -i bluetooth
Bus 003 Device 004: ID 8087:0026 Intel Corp. AX201 Bluetooth

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
