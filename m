Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F022C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 12:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347562AbiCUM4w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbiCUM4v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 08:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFE45D650
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 05:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A78060C7C
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 12:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEFCAC340E8
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647867325;
        bh=fF2raIQLlQg33tky4CUDTTuWaiyNPZ1zLDK2jCG9udk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GwU/4LlsuqpYG3Sp4ItUqI/txDTCZ9WGRqnKcpch5Lrx2xKOvGnXoWglVNvr6ATM5
         L4hJ4emtHJxC8JlPnsqcNIcL5oHODb7GaU4JzOMdkGBl8fpZ37zY67+urRcw4mP3D7
         awiCHZSxNknQTABQuzUruoBWVqSxJ4ntbJSVi39vDywCRRygw+x1vgWq4krIj+EBrU
         16nXQ5C9sdqsDKIPabMvuoY4asjgqSyZ3SF+OtbtiEEbTrHRYy2yjVDGCEDByFKC4E
         HALtj+z3YKJQzFdqpaGt9msiuTnOSYpeisJAuLnRH6cNTZgXv/RLQRVw8EmLLqd0X8
         EUef5SizXbliA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C948FC05F98; Mon, 21 Mar 2022 12:55:25 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215713] New (useless?) warning messages from BlueTooth in
 kernel 5.17
Date:   Mon, 21 Mar 2022 12:55:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_regression
Message-ID: <bug-215713-62941-xX7UfSTkR8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215713-62941@https.bugzilla.kernel.org/>
References: <bug-215713-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215713

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
