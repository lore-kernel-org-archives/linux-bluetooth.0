Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBE1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Nov 2022 06:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiKNGJw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 01:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiKNGJu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 01:09:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83DE3
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 22:09:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4B113CE0E10
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 06:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76441C433C1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 06:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668406186;
        bh=a9RJgeSCVzg7WQt+kUFo28NMQ+2oxZz9OQJ2XBzCBlU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Webwzspn/bIFDpA2wbX0EVExpIJocOeaYdI50TNUdIk246aCOnvWlxrsQXG+TN1YR
         pHyPf0MlyV/2c2A0whpdUtbrbt00HWqHJQd+QDG7iPOIBoN/VrzZVDJtYrj6Kw53rF
         nSd35wwXp8yFGIgAlzp8SCyUOXvjBPcSNHD9xsVwO54SoQRgARyWAteNVswSUrs5k6
         oB7N1ScyZNKIlZUOH25h8cAInF2yfv2ZJHeWSOOOl5KmkpkLQz831iNFVXk6Eq2eom
         mCEYTnzTu/1Cb2OPEXM2BLfaP0/vIR1zLO699RbY7wXHqStLBIogb78Q75AImL6uBi
         RsJV/CURxzwAA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 66EF8C433E7; Mon, 14 Nov 2022 06:09:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Mon, 14 Nov 2022 06:09:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: frc.gabriel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216686-62941-WXqGCIAFXn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216686-62941@https.bugzilla.kernel.org/>
References: <bug-216686-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216686

--- Comment #13 from frc.gabriel@gmail.com ---
Created attachment 303172
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303172&action=3Dedit
btmon file when the computer crashed running kernel from bluetooth-next mas=
ter
branch HEAD

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
