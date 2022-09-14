Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E963ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Sep 2022 13:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiINNLr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Sep 2022 09:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiINNLo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Sep 2022 09:11:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41414F3A6
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 06:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B40AB81B34
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 13:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6FF9C433C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663161091;
        bh=1ec4U+uZzC2P1IRs9RPgy5pZLJ/5Xisn0e/AE2b3nYo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PR4QnUDC/2R0dwnfNO8miwgBoMvhHooxkZLx0A1lbdsnmJ20nFtkd7g4EIJuOjlHF
         Es8lsjKlG1CAoXQY3IfKTevyAvGvXgGpvxDh33z3GTd/3uZVXutIddxCbZi5XQPz94
         T0PzzqLmM+8oK3xwyBre1TnG2lvmdFPDTVKO6/lc+6SGHMotW8LmvrwdpjaLvI8Q1O
         9rbloZkOrMn8sGWfpetss5n/hfhxJ/hGNmUR6SX9ML9AH7NJ4YcVaScE+6zYgmahHi
         3oJbL2mxdEcHhoHdjmq2gCyaQkVsnF8eA7htzRrfYHs5xGmwqUU3t7hLSeeKWWYf8D
         ub3sa0hBq4AtA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C7029C433E6; Wed, 14 Sep 2022 13:11:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] Memory leaks show up when using Edimax Wi-Fi N150
 Bluetooth/Wireless USB Adapter (RTL8XXXU)
Date:   Wed, 14 Sep 2022 13:11:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: network-wireless
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215197-62941-9QoHDk1Mek@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215197-62941@https.bugzilla.kernel.org/>
References: <bug-215197-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215197

--- Comment #5 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 301807
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301807&action=3Dedit
kmemleak output (6.0-rc4, AMD FX-8370)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
