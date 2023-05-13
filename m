Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1039CC77B7F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 May 2023 10:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjEMK75 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 May 2023 06:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjEMK74 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 May 2023 06:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA33598
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 May 2023 03:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61E3460EBB
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 May 2023 10:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E820C4339C
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 May 2023 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683975594;
        bh=25/Ku5OW6sXDNEiSQJX2dmaUBeNiWAJ648CQHKaS8U0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=J1YxYRKqjovisaxt6ppmQyUwclixxZOR7o2e1VWKy6iHkeM8vqskm9E5JLTYpp9p1
         i38RYoULRSpCDqix+1uyJ9kORHb2AqgXAdQg+789rfT7cFdZFk5QwHXDkVfCvvABjw
         wLnAvMwwQv6LiFbaEkKL8WwHnDpXGAlcmBi3Rwga/ddOj8kGlJLop4mxD5YlIBdpiV
         3Vrn8PEdgFvjLKSQvIQEsRRfRD31O2LVabcoCeDldu64CcvncKmWQvU6dpj4XUF0Ca
         o4Bz4esX7hDUSSrheScIt5aoNqG/E/OjzYrlTy4s2gv2fhvhPtSZiAIVk9LdLmC6pX
         swk78FbDWHN1w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 72D58C43144; Sat, 13 May 2023 10:59:54 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Sat, 13 May 2023 10:59:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-imOqOWTfyU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #11 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
So can anyone reliably reproduce this now? I ask, as I fear this might never
lead to anything unless we find the change where the problem started to hap=
pen
using a bisection.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
