Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C206BC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 20:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A936460EE4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 20:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhHWUgj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231569AbhHWUgi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Aug 2021 16:36:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 864CC61357
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Aug 2021 20:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629750955;
        bh=vKyZ4e5Y1WJZppBcSCYc76WSraVrI9iaue5nixOgQ3w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JJBbZnyKVUGGqF0sLfeWwp/DTKqnB/Ddm0E85wKI7E1M93k5EW75Qi9wWpJIjAIF2
         Mxwwrspxbf1FUUTYhAyJjJOUHSOV8drx25qFE2h3KDT/cZM/kSW6VQjU7LXZSZ5ssC
         4duNCPrc61CfEApVoLOLdLIBwa5yB4ihh3m/2YcYOSF4bhR8229bZVHUnTNrubQhxK
         sfV3i0sMQUhFQbwoqJA2jAhdS0mVR9JRf/R+flHg3M2KNb/XDYO+ViDmXUNXMiZAAT
         dYP6gR8nbUdJIF2N66TP9AzHWupufNT6vvvaekWuo1CGb6gdnuIFdQvTFSt5P+yYJH
         RwV+kYRjSYRGg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214103] HCI_CHANNEL_USER sockets leave device running after
 exit
Date:   Mon, 23 Aug 2021 20:35:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tedd.an@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-214103-62941-kP65vuzgvl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214103-62941@https.bugzilla.kernel.org/>
References: <bug-214103-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214103

Tedd An (tedd.an@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tedd.an@intel.com

--- Comment #1 from Tedd An (tedd.an@intel.com) ---
If the Bluetooth daemon is running, try it after stop/disable the daemon.

If the bluetoothd is required, there is a "AutoEnable" option in
/etc/bluetooth/main.conf. Change the value to false, and restart the daemon.

It will prevent the HCI interface from enabling after socket close.

Regards,
Tedd

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
