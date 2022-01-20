Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910C0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jan 2022 01:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbiATBWN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 20:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345225AbiATBWM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 20:22:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64257C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jan 2022 17:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21443B81A7F
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 01:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E16C8C004E1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 01:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642641729;
        bh=KQ9grkH65Gj0g5nQRdTGiA1sd5D8KRQoZQtRew7Gu3U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ub6RjIzoleQ6LRUv6kO0eHmP0UPkBr7jstWK1aYZHQGbnI+ageggsOjULMQA6FCDl
         ORIauTLjnt2rJYkxGrEyntKpfceNrY/sO8sWbp4pliOlmn8KnE0Jt/IOaVeZurbW7q
         GUOY/Q4No9vETMYdvJFgY4sTQsjjyz5vHBZj7OWNOwjZMjcNs44cBXBPLJrlXek4Tb
         R2leHWEwfwZrW9QPHTPkybYUNSu1JP66hqdANix7SuBZ/V2lheWpcxbbfk3tSkDjzA
         qfIYLL4CcbkFnd0PPrY9EnLPgc1UIOPMt6F9n5u3ZLKsL2yDY3JEazNlj3lZtZCVVP
         Xv/K25+zkrITQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C65FFCC13AE; Thu, 20 Jan 2022 01:22:09 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Thu, 20 Jan 2022 01:22:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: hui.wang@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215347-62941-tEdfvAZ5XI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215347-62941@https.bugzilla.kernel.org/>
References: <bug-215347-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215347

--- Comment #13 from Hui Wang (hui.wang@canonical.com) ---
Since the problem is fixed in the latest kernel. close this bug now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
