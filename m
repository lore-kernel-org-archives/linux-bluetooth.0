Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B11C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 15:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380346AbiAYPP2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 10:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581782AbiAYPNJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 10:13:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7308C061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 07:13:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 449CF6167A
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 15:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A967FC340EB
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643123582;
        bh=yY27VdGY8btfWOQ3TqEPQyu7lfzISaDlCECSOJg+mgs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oSHmIS2OA7u1Y9yxAt9cwxaR0XBG+bjhgAmqAOC5ppv1PHp/4JylSKYTYqN6vnCQv
         iM8a13fd0UGJRqHwpzdVORJqUfn68Kl0f8lVV/H89rE79hUUz1QjoE/3DT9wsf75FD
         QcWOTJq1Wd3FacnJ6aID647lQGmjMYAX9u5vhpHJFrryU/89FveAFEEDe0M6Erf5BC
         TACeoB8TsQq+Xohz0jECgQ0irBeSQUS7LcfP2kA3ZdarBf4J1FK3PBU5dBu/BXnHhP
         QwRPyLbG6iOKuauiwvo2U1Dg3ijpNJ/bBRD9g//Vf4v/ir6wtO42twgcBzBL8peBan
         /BPEHRqN2vUOg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8CAE7CC13B1; Tue, 25 Jan 2022 15:13:02 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Tue, 25 Jan 2022 15:13:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215528-62941-5SIWrDBdf0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215528-62941@https.bugzilla.kernel.org/>
References: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

--- Comment #9 from Artem S. Tashkinov (aros@gmx.com) ---
After deauthorizing and unpairing and then connecting them manually, the er=
rors
stopped.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
