Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CB3C83F2C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244212AbjIEQXI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354229AbjIEKMp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 06:12:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E1E18D
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 03:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1E196CE10C5
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6529BC433C8
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693908758;
        bh=Y7sjwIONEEOsflEHXrC9tVF4LYgqSj3jFxiIvrcU/Os=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FrfnskKT8ZQUY6RHL2gR3lvrlci/J/spMXXQTqlE0I2sES1qtJ7EkB+5GpAFqU5Kz
         DYBYWrHH5EAVvnCcitig2UsACMcGQXirBhVc1QTTiPHc/dSy9RIga2T8dMSM6dEcDz
         HcfUpczq+ovOAZrP8vBgHchWYUyBSZC3LUMssQIugG4NMhOtSMa2yaZn2fUTN08DFw
         sJiZu98vtatlLVBBvVmSqsKsQoBYEvUtQBWpaYKkwZYgqSg0pUGhfZD3+yxcscPse6
         4BFQvjcRgcj5y93zFinm/nbZhZ4neGSd6HL+qRsF78t7N2BLNbF4KIlGeNA3o4hw7n
         1lhk3G1Krnpew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 511E1C53BD0; Tue,  5 Sep 2023 10:12:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] Lot of "hci0 sco packet for unknown connection handle"
Date:   Tue, 05 Sep 2023 10:12:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-80791-62941-Yr9MZo5nKn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
In 6.4 the message is slightly different:

Aug 28 11:13:15 hp kernel: Bluetooth: hci0: ACL packet for unknown connecti=
on
handle 3837

| wc -l -> 25 for August 28 alone.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
