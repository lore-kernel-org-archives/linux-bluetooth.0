Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 13:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244390AbiEYNoi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 09:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiEYNog (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 09:44:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22DE6D4CD
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 06:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E413B81DA7
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 13:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B287C341C8
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653486273;
        bh=LuEpDBeoWyctO/QDazVxXkKavraxhYnlorElPm+TaDA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=j1aNPwuSVwB/1Jqqe9OqusvyWcSMIzPWtaq770ci8a7dJq/tfV0+S2GoIpdamagC4
         n+Hqa04IXhVqYEhbBMK6il6OlOzSDN+FdZF6uu/7846qVxjlYoBWgbn7F1bp/pKLQl
         0ByE5mZyGAqZk5BMHa7sOZ5qC6myAzL0Nn0+sqyUl4KARoAk28PByii9ncb/AGkJL4
         k6iRaeDmiGoRQilcvpwf6GUZtZBZrobJ3lQYLFd40N5q3DstArSmSsaBy4CuTHvWbI
         Ahnzkjot+fhbJof2b3HT3Y1ygp7OciSiT8MsgRxsKw41dnAdBfZW62Wi8o3ItocqCN
         4oPf7Ht19voWg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2AEABCC13B4; Wed, 25 May 2022 13:44:33 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Wed, 25 May 2022 13:44:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jmennius@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-OMm4E2smZY@https.bugzilla.kernel.org/>
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

--- Comment #36 from Ievgen Popovych (jmennius@gmail.com) ---
I was just looping suspend (mem_sleep deep) trying to reproduce with btmon
trace - no luck (13 times).

I've noticed that
> kernel: Bluetooth: hci0: command 0x0c01 tx timeout
> kernel: Bluetooth: hci0: Opcode 0x c01 failed: -110
and
> kernel: Bluetooth: hci0: command 0x0c1a tx timeout
> kernel: Bluetooth: hci0: Opcode 0x c1a failed: -110
occur when exiting suspend and BT is working fine.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
