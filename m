Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714BFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Nov 2022 05:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiKNFlD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 00:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbiKNFlC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 00:41:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E5415FF3
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 21:41:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DA3DB80D1B
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 05:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0944BC433D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 05:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668404459;
        bh=iZN52yc+ZG2mcd6bAfHWe2HpGsXv0rmvQC1sKHLDBHs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=thOmvysKKRzpdvoVSgtkK5WGhWR8StRZN6BIBBBpJU0a5xX5FH//dDKusOuJ/vu+I
         zt9zpKoqD/Vn5NTk/gjTjOjqbjbiHQBJ5heTcYL2PYtlT26Lk1IdkbB7ESSSqzTY3Q
         kkwFkU9kDWGhNhLHpcuMkGJtvJjQ3U7I362ffqCzYJUxpMs9PENucI3yn1Z8GJ6Czq
         0OpGR7/++THUEPTyCcUeBM0MHs32ESLMMLOiR+k80sA6UMB68hp3rqhd/mHLdCUTER
         Mm7h1uU6q0mN2Ao06CgoSaVdp7dtEnTbX2gjZQZZTt9o+qVVM+rbYbT0TManKJdCM+
         lJuUfxLv4GeBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EE776C433E6; Mon, 14 Nov 2022 05:40:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Mon, 14 Nov 2022 05:40:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: frc.gabriel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216686-62941-1SvMrlXzVh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216686-62941@https.bugzilla.kernel.org/>
References: <bug-216686-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216686

--- Comment #10 from frc.gabriel@gmail.com ---
Created attachment 303170
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303170&action=3Dedit
btmon file when the computer crashed running kernel from bluetooth-next

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
