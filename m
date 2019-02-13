Return-Path: <SRS0=f53w=QU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3875C282C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Feb 2019 07:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E99222BA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Feb 2019 07:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbfBMHo4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:44:56 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:33486 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728713AbfBMHo4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Feb 2019 02:44:56 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 4518C2BC3C
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Feb 2019 07:44:55 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 394632BCDC; Wed, 13 Feb 2019 07:44:55 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202429] No Bluetooth Adapter on boot - Works after woken up
 from suspend/sleep - Intel Ac 9260
Date:   Wed, 13 Feb 2019 07:44:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: matt680209@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-202429-62941-bhiLSVRpKy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202429-62941@https.bugzilla.kernel.org/>
References: <bug-202429-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=202429

mattchen (matt680209@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |matt680209@gmail.com

--- Comment #2 from mattchen (matt680209@gmail.com) ---
Hi,

When you update the BT firmware, have you ever tried power off then power on
your laptop ?
Update BT firmware requires power off the BT device and power on again, not
just suspend or resume.

And did you take below two commit for your testing ?
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/intel/ibt-18-16-1.sfi?id=ae90c3bce108ac623bc0bae44a7b411e4fa42e7c
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/intel/ibt-18-16-1.ddc?id=d8e8163cf7c082bda83887adf246e866919682f9

-- 
You are receiving this mail because:
You are the assignee for the bug.
