Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4044AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Mar 2021 23:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0082764F2B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Mar 2021 23:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836004AbhCBXCL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Mar 2021 18:02:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1581198AbhCBSlV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Mar 2021 13:41:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6316D64F43
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Mar 2021 18:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614710439;
        bh=cV+sc8eVMj0pvQW7eN+KyFWwnbGMwdgSfq0CyKT31RY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DiGyPUvUy7zElYxzKD/EGrUzmRX7iQvrG5DSanxLDpc1qudXrM9fxpoVimyLze7Pz
         HBrn9GJlKCGn0VMgHOX7AjZqyIk97Gm1etla6fJZ3+E9TPM1JRgyxCplZ8BKptEsmk
         OSj2ccRvvEuVOTyhX5OLoL2SMeVoc30bpKhrAjvPbF6EMJUx7aG9Pgwo9fbvx4AjFo
         RqiirHT0b6Fj0YVtVnQ4eATvB/QXfIFxbHf+DwLCTlhst+R5qgnUnglc2GZj25P6zW
         PWz/jtS7Qq0dDcg1LPZ2w1WdNE2pvX2wu1EvdjLMQR0beDQVlqA9oxjKoXwNFi80bZ
         k/IVHeFVLHUqA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210681] kernel: Bluetooth: hci0: don't support firmware rome
 0x31010000
Date:   Tue, 02 Mar 2021 18:40:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: gobinda.joy@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210681-62941-3ZQzIy3jet@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210681-62941@https.bugzilla.kernel.org/>
References: <bug-210681-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210681

--- Comment #52 from Gobinda Joy (gobinda.joy@gmail.com) ---
(In reply to Max Fedotov from comment #49)
> Fedora 33 5.10.18-200 fixed.

Confirmed.

Fixed in Fedora Kernel 5.10.18-200.fc33.x86_64

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
