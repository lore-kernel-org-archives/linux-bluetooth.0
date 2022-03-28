Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421BBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Mar 2022 16:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbiC1QFS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Mar 2022 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240930AbiC1QFO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Mar 2022 12:05:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8C02DDF
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 09:03:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6B5C61353
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 16:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B918C34100
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648483412;
        bh=5OaXmlSbHrwtq9u0ye/Qb4iEvTB8OmDu1hffziPsDdY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NrwYd3UwiBVu5CWiXAi7Z1TjQ656A6Th9RF1QDdcmNlmuRYoVM6d0NxKwK+R1+xYc
         DTL0XuciZij8GfOsBvBQXa6GfVvtr/zqeGfjp9mAkjWETNx5T2ZI/vjIQlD/Fu1jRt
         9aSO/6+86hi3QyCX7Jj6LtN88SF0nCa4Gi7QKv3/d1SItjlXE4ZTBZQ5uU/7gacj45
         MHybZVf/LM+4rzBkp1sBvBKHvzEGaHvMIpopxR7fVtOVQw9WtqNpj9qgLi/EZn1efB
         9juVVV8yq76uN5ucT4eE7iqUxOfLQCHnDLyW3o5EeKRx4QtWnjvIG069SV+YQcSail
         RtbGxocKFt1WA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 01C87C05FD2; Mon, 28 Mar 2022 16:03:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214111] rtl8761b usb bluetooth doesn't work following reboot
 until unplug/replug
Date:   Mon, 28 Mar 2022 16:03:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bryanhoop@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-214111-62941-c6VQ9tcOeA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214111-62941@https.bugzilla.kernel.org/>
References: <bug-214111-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214111

bryanhoop@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|5.14.14                     |5.16.16

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
