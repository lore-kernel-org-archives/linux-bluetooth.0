Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76F2ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 13:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiJaNLh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJaNLf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 09:11:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E599BDFD8
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 06:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8239A6121A
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 13:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E23F2C43142
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667221892;
        bh=PmfizRn5IwTI3yjohSDLN4fRzO7O1uM8KEM1q90lv5g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GPfSP9tSeomusXxKvCCMDwfD3vqTDxZ+3Y+3IIaNBShkIdls+AD5v5Mq3xBi4MFjj
         TxippR+BAzPobApQ3zGOjD9RxYxQPJ9C3S7kclAEtb4QltKTEud3Lotp5Vq6HxfoS7
         rAIjc4b0W0Un0jlGoBDRVHzC6N9k4JkUlEuc6PxgreJ6YX8XMxICXA12mDHUxfBM/6
         OI1mujXaY8b7I3Xf9gD7wFGNM0f8P5sm10DUw28gI4+Ns22quC/DdkwPBAaPWDL27u
         eBceOtS4LchGx5izLL2rTubDBEsvxrTZHysBKwAr2hPIxrEUsC1noFkFASTGvO1m65
         AgnSHvrvvyGAA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D26ECC433E7; Mon, 31 Oct 2022 13:11:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 31 Oct 2022 13:11:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-llyPzBUfE2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #253 from justanormaltinkerermihir@duck.com ---
It just outputs this:

< HCI Command: ogf 0x03, ocf 0x005a, plen 0


and dmesg shows this: [  921.174808] Bluetooth: hci0: command 0x0c5a tx tim=
eout

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
