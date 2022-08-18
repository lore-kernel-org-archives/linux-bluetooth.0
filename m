Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7858C00140
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Aug 2022 15:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbiHRPDa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Aug 2022 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344009AbiHRPD0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Aug 2022 11:03:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A4E2DD6
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Aug 2022 08:03:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 236ACB821E5
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Aug 2022 15:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA3E3C4314E
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Aug 2022 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660834997;
        bh=6zEIb/RNN5wBBhHl+DVplL5omB6p43mMQeze/RDgGvY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FdsPrwjsi3k5OcDaDd+XjjCTR0poOuIPOBq3+UvVTnrtwpTL3t+ZPfLVGSdbIeYb3
         NYe49KNHV90rSQzrMQV6++M7xv+MRkR7oy/TprRG3wy9IGfsg2mLE5dRgpsBfXrFPI
         YjGL2WEX2FtG204L5Ca/XNMU1b4Zj+u2ivZ/RM2Fo0ZET1m1AMNEhjFpl6ZDA/SYbr
         VfYgxRE3CjijlFTno2YQ+Ue7dJm4t0LwDvXNYc6Be7FKOJe7kq+96XAmBzyn3Oo34U
         OSpKbS9WG7Lv1Nw3vW7k7RdvCdRM5gjmxXA3F1yXKFrFRwx6vH+SJl07njbdXGeJJD
         1KyTidOUebmGA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AC62FC433E9; Thu, 18 Aug 2022 15:03:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Thu, 18 Aug 2022 15:03:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pieroavola@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-Y9bJcQO9WS@https.bugzilla.kernel.org/>
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

--- Comment #40 from Piero Avola (pieroavola@gmail.com) ---
The problem persists in 5.19

# dmesg | grep -i bluetooth
> [    2.433304] Bluetooth: Core ver 2.22
> [    2.433317] NET: Registered PF_BLUETOOTH protocol family
> [    2.433318] Bluetooth: HCI device and connection manager initialized
> [    2.433322] Bluetooth: HCI socket layer initialized
> [    2.433324] Bluetooth: L2CAP socket layer initialized
> [    2.433326] Bluetooth: SCO socket layer initialized
> [    3.625145] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    3.625147] Bluetooth: BNEP filters: protocol multicast
> [    3.625149] Bluetooth: BNEP socket layer initialized
> [    4.720010] Bluetooth: hci0: Reading Intel version command failed (-11=
0)
> [    4.720011] Bluetooth: hci0: command 0xfc05 tx timeout

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
