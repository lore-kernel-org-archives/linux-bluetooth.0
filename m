Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397BCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Nov 2021 21:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhK2WAQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:00:16 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48506 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhK2V6Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Nov 2021 16:58:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 34AE4CE1689
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 21:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6693AC53FCF
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 21:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638222895;
        bh=f9fW/TUtmi6KVIGhdNPwQ2/qO31NRmMHtJzPRtSpAcU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XPwxQFxMR5iuOGhYp5Ci8dxd3ot4RDYL44h6l9d8kJ4b7jojys8HH4wosa4v/lBbP
         mZKPcssE01W+8cZnZgXhplbUGprrIDmm++Tm/wY0qkXRJYEHS+vMAUuZx0Ms0Pe8wT
         uDZFDyA4cJtMplwuS2cCQfBj/od/BIKSGnTKXQ0jKy9XW9CgwPH6R0CvsNrDsTlCHY
         K9UQrJRABRdEXdKl6R0LIWnicfLzMKEFMG/jIojMSRNSRjHD0m0MelqIpb/K+hjUw+
         eY80WYyP50PV0WWTDNKe7jQ+OApaKDss/og+WnTwkoMJ+nMfRXCJHONyuDB7AxAnKj
         NR23e4Gij0bMw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 54A5E60F26; Mon, 29 Nov 2021 21:54:55 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 29 Nov 2021 21:54:54 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215167-62941-k9gMK6UqEM@https.bugzilla.kernel.org/>
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

--- Comment #7 from George Olson (tech@reachthetribes.org) ---
Created attachment 299787
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299787&action=3Dedit
hwinfo on kernel 5.15.3 bluetooth fails

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
