Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91747C6FA99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCGWOG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCGWN7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:13:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0C225E39
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:13:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC88961590
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 22:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5830EC4339B
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 22:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678227235;
        bh=3aHhe66+0rJ5D1OhN3470hnAo2UuL/AmLuv5jUKBOnE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HfJs16BigAz3JSz80OFdxoYuXSG+zys/BO+6Lojvq0WkMwqrqFwdpM6jhMpQI/kyk
         9UE/yxRQCnJ5HRsmS4fWxkhEfcihozQqqL+Om0aOQnOcPfOEetgNNMse+N714jV2qc
         sqSMSQCYgxBVb9SOZuMoIsMv8xGNTRpXt81CDxC0lMVYHVDn1DWbbiDtGgUpS6VvVf
         X1NYnFkz1z+vZ6vuxfjGiCN7Es49axHwUVCwRyra2zKox97ahJw7QLzwH4tRvLTnpZ
         oGvtpGMNS+t2YYFFiSawsFsNhWN5icZ/zVwbGOE1vhpKWKTCIBpyVh2z9wVuBOCOg8
         Bc5BCnMlIFWOw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3A7F1C43143; Tue,  7 Mar 2023 22:13:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217150] Bluetooth USB Adapter that comes with Xbox One Wireless
 Controller stopped working on 6.3 rc1
Date:   Tue, 07 Mar 2023 22:13:55 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217150-62941-xHlzCzGhiR@https.bugzilla.kernel.org/>
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

--- Comment #10 from Smokus (cmarobnjak@cock.email) ---
Thanks for replying and explaining.
Sorry for confusion.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
