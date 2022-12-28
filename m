Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131EAC4167B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Dec 2022 15:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiL1PS3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Dec 2022 10:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiL1PS0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Dec 2022 10:18:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F313F18
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Dec 2022 07:18:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 118F561555
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Dec 2022 15:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A561C433D2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Dec 2022 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672240702;
        bh=JmkznDTEYp+gDzfNgJAyBimg26SHncU5vOgFml9NVJ4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lNi/6IULzUpSTFg9dqvagT7ENckLNPdvmyiimfY5MbcV04rvSsNbIvIjphRu/UM2h
         4mBYJkaG82UIdgPQShojjn820MrCKUIfiaGIJXt9UbdBW1iPZugTddn0ddqSE9Ah7G
         Y0NJKG30KTnZT3Bmlw+0ny9nqIFU9gLr4JRiidJjQINOp+elld5jsiapTwgnPVS4tm
         fy0z41MYYxheq8Ni8RZoQF7cWhPvKdW8OE72JcEiSHV1/8rXqCdd2o+h5dWaPrtpOX
         c/GUmxlDHmivZ/dJpMFfi7nKt28+rwAAdHybfRGrdD/yADndNpbiL6blZo/CYOrM+X
         RNldauVxpsniA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 69984C43142; Wed, 28 Dec 2022 15:18:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Wed, 28 Dec 2022 15:18:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matoro_bugzilla_kernel@matoro.tk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-6T50syGGtj@https.bugzilla.kernel.org/>
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

matoro (matoro_bugzilla_kernel@matoro.tk) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |matoro_bugzilla_kernel@mato
                   |                            |ro.tk

--- Comment #44 from matoro (matoro_bugzilla_kernel@matoro.tk) ---
I am also observing this with an AX200.  I keep several old stable kernels,=
 so
for bisecting purposes I have found that:

6.0.12 is good
6.0.15 is bad
6.1.1 is bad

Hardware:
07:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
        Subsystem: Intel Corporation Wi-Fi 6 AX200NGW

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
