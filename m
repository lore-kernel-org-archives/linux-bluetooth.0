Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6417C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 15:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9DF564E22
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 15:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhBCPdF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234296AbhBCPck (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Feb 2021 10:32:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6E89A64F8C
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Feb 2021 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612366317;
        bh=VkYMJdE5p7Nc8XkxRXfGOPWSCp878d8OnQpWeyepgDk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r6l/k8tyadmeNVchuAdvkkciqH0fYcmyTXAKPRT09Ya/h+9AHBWqKlclrUY58GwKr
         fVn6fBmx0O9Wk4UISe3k9WWULBxE8uEZGAlRfzakj9uL4YmNbXA7kp+8fooDHn/gUP
         +upFOTyLl7ZUdtTAhFRYeB1FqJ8qbd27ELRbGYzkyQ2oV/E5Wud/y76OpBzFjqjDUF
         mFQGJzepUft5ahbvySBZCPA5nVxG3Z9bt/n4VTaBkHKyZ+9G52zrp1d3Q5pyHNy0hx
         quGFP7IQqtiMddoqHdCZT4dpZ0XAUyn9bMYMOSCz4oUFi3Hc0FeA9eb7BSa3O0Dzdu
         tO4z1505YdHWw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210141] Bluetooth device driven by rtw_8822ce is lost after
 suspend to RAM
Date:   Wed, 03 Feb 2021 15:31:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: raptopassion@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-210141-62941-MQvokLc4dC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210141-62941@https.bugzilla.kernel.org/>
References: <bug-210141-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210141

Marcos S=C3=A1nchez Provencio (raptopassion@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |raptopassion@gmail.com

--- Comment #3 from Marcos S=C3=A1nchez Provencio (raptopassion@gmail.com) =
---
I have the same problem on an HP Laptop 15s-fq1xxx (10B51EA#ABE) with ubuntu
20.04 hwe (5.8.0-41-generic)

Bluetooth does not survive suspend; it does survive hibernate, in case it is
any hint.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
