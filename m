Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4654CECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Sep 2022 07:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiIIHS1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Sep 2022 03:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiIIHSI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Sep 2022 03:18:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCC8117412
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 00:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2503CB82372
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 07:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE303C43156
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 07:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662707871;
        bh=VtVlrKib+yQZKST6C/d+i9VuLSjqc+kmoapunGDf2Ks=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a14LFfazgPZCI3pM302suNuvujBf+iTOFQeQ37+MZ9aeK2zeuyvh/8Vfzsa2OulCO
         INzXUUfDiaZbq++hW4NdttXMveR5/RFVDqm3oYW3zQznpI1eJ2YWFSgepTg92UunN/
         hLVENaJDWe3Jskm8Bly4qy9vMCNCmfsK9OA0DJJSdj6n2a+KDHb6oXD75+UIemZ6ax
         jC5Qihk81azSyXBGBXcWZd7pXjtVuWFkmjZEXxIZJVbgrC8qR4JBxu63r5GP+3bqtc
         i/bCI1EsZbYhmTI9SHxUqBU/ZoY/luogGpNOHBmIa53XA9CJsYDIpB4StQjXahY9mi
         7Ygmbvju4L+XQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AE71CC433E7; Fri,  9 Sep 2022 07:17:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Fri, 09 Sep 2022 07:17:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mike@it-loops.com
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215768-62941-lLlNGKOQyO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215768-62941@https.bugzilla.kernel.org/>
References: <bug-215768-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215768

--- Comment #45 from Michael Guntsche (mike@it-loops.com) ---
Sorry I forgot to mention, I tried this with 5.19.8 and without the script =
my
notebook does not suspend correctly, well it does every now and then but it=
 is
not deterministic. With the script it always works.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
