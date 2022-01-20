Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD00C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jan 2022 15:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376495AbiATPJb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376489AbiATPJ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jan 2022 10:09:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C847C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 07:09:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23A30B81D75
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 15:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3300C340E2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642691363;
        bh=hudfsJYh1obmN4vSiiH6pQyF3vZ37piCa69DGRCJ0n4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a3yOHZepSnBnT732p5WiC5CRo22jhQHbhyZgtgOt2UMBBlbWyLz/s+F6rxnCmC//3
         yHWRigiJKUVu+q0CKqUB/fheJwjNlYElH7DnrOZRc4z5S1Vz4Hkb6vTdwtB6hDpw3t
         InT8XMs/nXKkzNcOKP+WKIuAlIDDLnU+Rjj6Qij4ho3bH++KGzU9d83Ct06kz80Qxb
         Sto9aBjkZ+uzETSSDDd8rp7Gx4Jdp04F6M+HmPRH0i7ijM3NzzkLVbqD0+bmOVF3HX
         ltiFKGKezJUxKQGDO1RWaFrcy4Q8gyYWB43DVrlnxDVa/vG0fj5I1w8T6dlVHo9MRH
         BmK32IpupKvig==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B3C14CC13AA; Thu, 20 Jan 2022 15:09:23 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215497] NULL pointer deref in klist_next triggered by Bluetooth
 HCI_Disconnection_Complete event
Date:   Thu, 20 Jan 2022 15:09:23 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Networking
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: soenke.huster@eknoes.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: stephen@networkplumber.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215497-62941-fMhDcBIetl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215497-62941@https.bugzilla.kernel.org/>
References: <bug-215497-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215497

--- Comment #3 from S=C3=B6nke Huster (soenke.huster@eknoes.de) ---
I think I found an underlying issue in driver-core, and submitted a patch:
https://lore.kernel.org/lkml/20220120150246.6216-1-soenke.huster@eknoes.de/=
T/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=
