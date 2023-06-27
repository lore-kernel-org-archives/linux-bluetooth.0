Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8CFEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 13:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjF0NIV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 09:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjF0NIU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 09:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C917173E
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 06:08:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F74D6118A
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 13:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EE45C433C8
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687871298;
        bh=NBFagf3DPHAL/H323d3BXotfBuhP35LC1NjKnnGJ2ys=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MO7x7w4BJSKP/UXj1+DpEjzdZxM3zNbTfW5jeX1gyv59u/GaZ2LzOi8+91Tk9C8k6
         kmaAMM907xqC7/a96q7mt8We0GaztG9ctYhz4NxO9y5/nnFwpmjVFsg2BU84RusKuj
         w3jLbDLRFya1WjgN5dm2OCES8BLUCHH/ofUlwNkihn8MC9pEBiRURjpHW2g9lwpI38
         MarvDZ0zOrCf/Q78EQd7k8NMphGre5gSZxR02WJyuNuJ/xpoeS0I5qXA7dqPOLj5/e
         y0L+fQT7POCAElF2uPP1M6ip6QFVaCn4f6vX41FpTESxtAlUZxkHfrvL/SI7zZh14p
         A/KQs9+c2/McA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 63B17C4332E; Tue, 27 Jun 2023 13:08:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217581] Bluetooth L2CAP use-after-free
Date:   Tue, 27 Jun 2023 13:08:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: bagasdotme@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217581-62941-rxR4XF8UeS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217581-62941@https.bugzilla.kernel.org/>
References: <bug-217581-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217581

Bagas Sanjaya (bagasdotme@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bagasdotme@gmail.com

--- Comment #4 from Bagas Sanjaya (bagasdotme@gmail.com) ---
(In reply to Mohamed Yassine JEBABLI from comment #0)
> In reconnect slave mode, I start direct advertising. After establishing t=
he
> connection with the central device, we begin ATT exchanges over the L2CAP
> socket, and then I receive a disconnect with L2CAP traces. This issue is
> observed across different kernel versions such as 5.17, 6.2, 6.3, 6.3.7, =
etc.
>=20

Do you have this issue on v5.15?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
