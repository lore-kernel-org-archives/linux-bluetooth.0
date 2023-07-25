Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB47EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGYSoM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGYSoL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 14:44:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B081819AD
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 11:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45F0161880
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 18:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4622C433CA
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 18:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690310649;
        bh=8yNygyUm2QQLznDm5It4xtnhbBKjoPgUSs2ygIQ5JQs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CLjRKjfEAYJFGGqibyOsH06kZ4vMtPcItrMZkmihdgrXTLTx/+PlZczB2rIqBYovX
         KA0an17jpufNt7KtR9SpzZil+95aLeIKzMruBRh6Ehy/StgY3bCKrB8OCkRKmwK0e9
         /zLG1zbMrJvTXU1iMFB0ojUdYCZJS3My5eR0JCi47XndT6Tk4YCR6Mu9q03XbNPFiu
         08Lg3Fy9q3jM2zn+Ns2GCAakRqeI+CGe+jwA4LNg/C0l6QsJKyp+R0Mo/zcbAlyGwD
         4oO9EZKegAALzIaykkvQwe9eeRmw02afjkhMJ5v0QbSFZr/KjvOGgJfcXK7Zkgf1FS
         0TkRYWzsyMOLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 87607C53BCD; Tue, 25 Jul 2023 18:44:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date:   Tue, 25 Jul 2023 18:44:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bavay@slf.ch
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217023-62941-7RUgwuAhaW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217023-62941@https.bugzilla.kernel.org/>
References: <bug-217023-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

--- Comment #7 from Mathias Bavay (bavay@slf.ch) ---
I am out of the office from Saturday 14.07.2023 until Monday 07.08.2023. Pl=
ease
consider sending your email again when I will be back at the office.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
