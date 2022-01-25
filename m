Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7862C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 15:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351970AbiAYPJH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 10:09:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59494 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581348AbiAYPGc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 10:06:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF51461653
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 15:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56B8FC340E8
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 15:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643123186;
        bh=5pQFrQLFWizahKo3ZSH24uEk1QI+VaXKWyXtpkjwulo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MVYsmvj3xT9ybqNSlNroQTHEQOgVMdSYl5VvGGgF/ZwTGF09qAdU8AmDAsbC3nPKf
         +xAA4wByvbbomxn5LrUX7nbkbIA4I05KrirSoA0tI/ntdwvUVhTwpsfLJlWe7Kr11J
         Hkg9mGNeJyzQX1o1iSnXHhqjb6tgXw8OGi2tSvDYApRzYoTNtdB6T/211yWjWZCq3y
         0gtlo0o8Ik+BGganCoqDaJh+ijx7QcdA+QvX1JHPzXPmeFLoG1i9sGaM6FjP3v7cPu
         o4caoA8aA1qXfCUiG2bo28FPtOYRm5TVfwMmpTXtcOKoLKlpgaFpnzxyU+p1EEm2+w
         liWkpbOW7xG5Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3E43CCC13B1; Tue, 25 Jan 2022 15:06:26 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Tue, 25 Jan 2022 15:06:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215528-62941-pC2UrlcudU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215528-62941@https.bugzilla.kernel.org/>
References: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

--- Comment #8 from Artem S. Tashkinov (aros@gmx.com) ---
Here's another batch of errors when my BT headphones connected before they =
have
been formally authorized:

Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 48
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 48
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 48
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 257
Bluetooth: hci0: SCO packet for unknown connection handle 257
Bluetooth: hci0: SCO packet for unknown connection handle 257

What a bloody mess.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
