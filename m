Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FD2C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Apr 2023 15:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDVP7Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Apr 2023 11:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDVP7P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Apr 2023 11:59:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974131705
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Apr 2023 08:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 337DD614B4
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Apr 2023 15:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83938C433A1
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Apr 2023 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682179153;
        bh=yvkaNmgl/EJBS1//AvwRU2R77vTrSYBZwdXB1tFE84w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GHQs3B9x7Xiupo5sWRiD4qcCk66sqejK9CaJEXIaxhre0XRgzX2ojCE2CRc13nAsN
         VxALU7GwSm7o9x+wJKtmMSOcZ9HAtIfUH9wSC1221cxrDzkHMVQXludJbtSKC3vERo
         dUmnrbBn56KgtpqZY46c/xqRcUYj/FEfNKQ/5PvpfuHad7WCsQp4ZqHLVLMpKRrTgo
         1m361/4yqY+eUKOp+X04xbDOQrs4ewReL5iM/lACDFyHEasSAYpoiICrR2Z2WzMylC
         Eu9Zd5UGDK69V5Ug7PI3yN+6xJ/j5lSxSxgrKHYJimGTTFuvn2vrByXXUnN6Fu7gd6
         5OnP71RaykgMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5D564C072A6; Sat, 22 Apr 2023 15:59:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203535] Bluetooth: command tx timeout with Intel Corporation
 Wireless 7260 in A2DP mode
Date:   Sat, 22 Apr 2023 15:59:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wiredknight375@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-203535-62941-aajSv3Ztmj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203535-62941@https.bugzilla.kernel.org/>
References: <bug-203535-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D203535

--- Comment #15 from Rijnhard Hessel (wiredknight375@gmail.com) ---
Can confirm WiFi was also on on my end. Intel WiFi though.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
