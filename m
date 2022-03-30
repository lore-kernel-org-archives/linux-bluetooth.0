Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE31FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 13:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346472AbiC3Nwe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 09:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346496AbiC3Nw3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 09:52:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E12137028
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 06:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1FDFECE1D4E
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 13:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BE28C340EC
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 13:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648648238;
        bh=0XbFvCNvxVEuiGqtnZQfW87ALordRI9cvJe3/d+2XcM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qP91hBzrHeceqruxamAZKt96NAq8eyNmR+LONjWjzbNXU7QjNHnoHs+TrcxWAzFrj
         u8DytK0NC5waA8a16gnoi7y85indyRddBv24v4RNy/irMTD2EtbWHo0/CIt+JbSwYq
         2j5y3HPABQBnmrILQ+krECbTAqW1q2xT3JWCSHxkNBXDKsiNFugf3zgC8fAhNvQqm5
         2Ia7XQ3CD0U5BJkZ9ZfVcFO3LFxWZV10j1T66KkIIwAPvMiZKt0XbaftKY0gFDSXlo
         nWH8NMEVnQjYe2h65C64LjjN58bcq0oV3tW4r5oRkvTfgCqzOvC3vnQBVbTQRKRZsz
         CZwj7HnWyymog==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 44421C05FCE; Wed, 30 Mar 2022 13:50:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215776] Unable to reconnect Bluetooth keyboard after
 disconnection
Date:   Wed, 30 Mar 2022 13:50:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215776-62941-wve2h6ql35@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215776-62941@https.bugzilla.kernel.org/>
References: <bug-215776-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215776

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Please try something fresh, e.g. 5.17.1.

There's been a ton of commits in the BT stack after 5.13. This kernel is
extremely outdated.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
