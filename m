Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Nov 2021 14:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbhKZOyf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Nov 2021 09:54:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:52738 "EHLO mail.kernel.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232963AbhKZOwf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Nov 2021 09:52:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2042160241
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Nov 2021 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637938162;
        bh=x3u0tELntWTnjsq9GcPau6C1Galwdew77RfArBGE/UA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U25BNITbvIOMwlVPiheiPuZpMGdNAE9P9RKaKznatyu0IfYPCPM0E5cZ2gSelmCH7
         gZd2p/ws2kzqtztAPySAqEpJREuZkFlLGDVuNOugXK7oQPlMcI8KoVBwGd+R6+nPEV
         hm6JKAqAKLcgAKM5354WaW2dZ2rCEIlnW4E6m4TSjCKm8aSaen/jVh6MF/hJXHRPQg
         zXCRLDDgPGPpn2A6AdQIodfgobSixt+mjXPDIqgOOl+1LG/e0uG3QPjDf1//K1+01r
         bTUjwGE5VJ762lXM7DYv8w3bf4xcUQGQXhrRudkPEVMxqpvjIxcXQnR5A29naRhjf4
         ux4aikCwj1fWQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 1CDF660F46; Fri, 26 Nov 2021 14:49:22 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Fri, 26 Nov 2021 14:49:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexander.konotop@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-213829-62941-J313Ir8WGw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213829-62941@https.bugzilla.kernel.org/>
References: <bug-213829-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213829

Alexander Konotop (alexander.konotop@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alexander.konotop@gmail.com

--- Comment #40 from Alexander Konotop (alexander.konotop@gmail.com) ---
I confirm that it's working with 5.15.5-arch1-1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
