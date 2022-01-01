Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EF0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Jan 2022 18:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiAASML (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Jan 2022 13:12:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48792 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiAASML (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Jan 2022 13:12:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79235B8091D
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 18:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 027A0C36AEE
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 18:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641060729;
        bh=sSm100NB893ANhLktq5bbddtcmmkLnDLrxrVL1lE7Is=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=js3kTrbcRFU7jSK0hXU2TRSfnR4e8O1W61qo1x/Bdqj5R/V2eFLDlQ0+Sl/v1pyz0
         UznE7AHCCakLwcZQWqSyeHvQa0MBTfnu4k8G3OG4eGvaiYtrTgA+kHSxakOI4WQ+K+
         QvW64+1WScKkFuccCOiBPqBeHAu/V99kNDF+QRS/0i/wr8TFoWSPkH7gdvU76yMAgg
         nbSVyhKq8d0wAo4lJ8BlbdLe4VILenPLiXqhXEpJQUbNmXybk6boS+hgJci5pi3/FZ
         zq/q0CQOnCXuCiqdliGMLPz2SYkm8XitTQ/KYoAPW6BxRrHRBIc4+lGFsMasPTn+OZ
         qq0y3ddRA5F2A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E7285C05FDB; Sat,  1 Jan 2022 18:12:08 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 01 Jan 2022 18:12:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-hwodtwJSBS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #210 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
pverda, if I understand you correctly you were using the dongle with:
"enable_autosuspend=3D0 reset=3D1" options to the btusb module before what =
happens
with newer kernels if you remove this workaround ?

Note that we are trying to get things to work with all these clones
automatically for everyone, without needing to set any module options. Peop=
le
should be able to just plug in the dongle and have it work.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
