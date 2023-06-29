Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76C6EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 14:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjF2OPE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 10:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjF2OO7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 10:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C36D10F8
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 07:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF07661546
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 14:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F822C433C9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688048097;
        bh=YEIhAKTWDGmeap4u16nGsO/kMCZej7xpX7PlZgc+Sw0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JwbhfUcPejiLiFX8AgtZmCFsbabQbfNPVoX+E9TZQFzSkHdoxkM3uUeB1+zsDgstX
         ekjhdToSDaVvyzFGgVuVxFVd4G8OFlLpd3p8PVLzoanjnrwL2cEmwnY0Brv5I9oezY
         s8oW99OK23l2ZsgbkhPGmUxVsnwSePK++B2dPODwBO8iyVRZiKDTGOs1dKyXNGPZJQ
         EQu2rZgTQXnXZs/zzmMN/licyStBgAGng2/D33IgFtVbNFfj1iN6/IZWSaZFOhw6+x
         s7wAUl58Wtq7bKXiO2UTsOTRUPOvwXufeEbdeENpLN6YY4VnQjZxkfv6nErdRXQWyv
         SnalGfZR42OSA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0E28CC4332E; Thu, 29 Jun 2023 14:14:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217581] Bluetooth L2CAP use-after-free
Date:   Thu, 29 Jun 2023 14:14:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mohamed-yassine.jebabli@witbe.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217581-62941-TvWCoD2kJb@https.bugzilla.kernel.org/>
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

--- Comment #9 from Mohamed Yassine JEBABLI (mohamed-yassine.jebabli@witbe.=
net) ---
With the same application in user space and the same scenario, I have the s=
ame
crash behavior that occurs right after establishing the connection with the
master, but the causes are different: "underflow; use-after-free" and "addi=
tion
on 0; use-after-free"

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
