Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B1C678D5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 15:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjCGPLU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 10:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjCGPKh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 10:10:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C208A85369
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 07:04:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 547D66145F
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 15:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB89FC433EF
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678201486;
        bh=qlURXxW07FiOLXspy7/vYaDb2ULQlemnjxe5rzGDCD4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AtO+Zt85KmxpRfVCNhJl+8kU4teOwi2Z4lAIWTBnsaErV5W1JUlSZEzDvn7EQh8uz
         NmzcNjlAFUNACNvp1c/OS/3U5jsUTr6LpfBO5xLU5IaGezcVgJM/XchzNZgtCCYkYS
         NGw+N9iTR2OayRGB0w8E8ymlsnlCGf6UC/1bbw9ttmmEgfUkZMhYhFTlyZmVqak+PM
         tEfZG/6fWrJBghyF7ds+PvhiLd5p2JYGMKRWfNsf33/ifqbVb0ZpooyjAyfIJWfQYj
         W1ONW1TagBzsVXQbRZbdQsuXqU8BHOKhC+bemq2raY/elO0Rke4rgzxhuaA+0EG428
         8HI0uKAhX+tfQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A9404C43141; Tue,  7 Mar 2023 15:04:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217150] Bluetooth USB Adapter that comes with Xbox One Wireless
 Controller stopped working on 6.3 rc1
Date:   Tue, 07 Mar 2023 15:04:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cmarobnjak@cock.email
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217150-62941-nTqnGbH6pR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217150-62941@https.bugzilla.kernel.org/>
References: <bug-217150-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217150

--- Comment #4 from Smokus (cmarobnjak@cock.email) ---
Created attachment 303896
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303896&action=3Dedit
6.3 rc1 dmesg

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
