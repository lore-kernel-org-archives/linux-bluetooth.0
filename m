Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D83EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 10:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjFUKUV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjFUKT5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 06:19:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD41DC
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 03:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECB67614C0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 10:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A625C433C8
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 10:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687342795;
        bh=bhT1K/vB2ZuR4gNbg//ukCD5UGTnJPUCrqJv4tdQun4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qLbP6pSu0A880feHITjr5b01cqWW9ZzH551pq39o9KDB4lH7MCy5AVq/9R/QKlNZG
         MArUelB1Nfp+uIY4ifsWgOOaAWuIYt9K/owO9wFhzlqh2iJG1A4j48mq+97tu7kTgx
         HeKqdTxLCnXkzcZ2o7y/LtLYUmv1xM2EtlRNJ2niKBOL0LNPROtmg/+jMh8fxGYXbI
         zKSwDgFc6ErYGZ8IEjHWsDvLbJ3/AD0/njU4iKFoBejd+cIiCDN/dZXJsUJR0d4Ynk
         V59f/FzMAk+HopuSSGU7i/3xFOVat3T/iCITR1ItzGWgzVyLXTCKV85EEU1Ep3oojX
         klMGhAPw9e6uw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 472CEC4332E; Wed, 21 Jun 2023 10:19:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217581] Bluetooth L2CAP use-after-free
Date:   Wed, 21 Jun 2023 10:19:55 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217581-62941-mib99nNwT0@https.bugzilla.kernel.org/>
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

--- Comment #1 from Mohamed Yassine JEBABLI (mohamed-yassine.jebabli@witbe.=
net) ---
Created attachment 304468
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304468&action=3Dedit
Kernel and btmon log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
