Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5069EEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 06:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjGLGyK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 02:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGLGyI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 02:54:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E074DC
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 23:54:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D655E616D8
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 06:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38D95C433C8
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 06:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689144847;
        bh=k0zL5JL7x8+2zJJJXIaO6d9RgwR6CVBfc2QlQ4f1QpI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nlM3nl3ghEbnR06Q0ioe/h/M1ACNeAxsPaPboE4vRkYYa+Hu145CGtGHWw1/yLel7
         y7savivF821vRi9w9ll/2qZuCevL5ebM36nUzaJKTa9+P0JyfuWxwxFfhQN7ID+O/+
         A3AtG2+RqO21u6MCrLiiZTHGrk02a4mVmbff6jjfnxubSbPeL9p6afIszxzw9tX5Ey
         xhbvp2T2XDs0JCm7y1u2afT53PGezojUTda1+6prUMI24aBz3MIBlgOUh4tJAS8HS3
         9ERxHR5B6OWHPfOc8jAotIIpk07XaTKH6Y3tfRcRYb/ggTh5u0gB3BWY5+QTDvai/5
         AONCct3E+KS5A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 15059C4332E; Wed, 12 Jul 2023 06:54:07 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217663] Bluetooth GPS modules profile unavailable
Date:   Wed, 12 Jul 2023 06:54:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dicetrash@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217663-62941-FXlfelPH6k@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217663-62941@https.bugzilla.kernel.org/>
References: <bug-217663-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217663

--- Comment #1 from Dice Wasser (dicetrash@gmail.com) ---
As seen in
https://btprodspecificationrefs.blob.core.windows.net/assigned-numbers/Assi=
gned%20Number%20Types/Assigned_Numbers.pdf#3.3.3
bluetooth assigned numbers it is part of 3.3 SDP Service Class and Profile
Identifiers
See Bluetooth Core Specification [Vol 3] Part B, Section 5.1.2
as a serial port,

I would expect that connecting to it would create a /dev/tty serial port

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
