Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EABC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Dec 2021 00:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354051AbhLBAHx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhLBAHq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 19:07:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E2DC061756
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 16:04:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59707B82194
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 00:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 050F9C53FCC
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 00:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403462;
        bh=c8vgqJ3Q0bov1SxKUe6FZOddV1aEX6PBUQ2ziPwrfjw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pqPOuXR2VPQLOpWIWKEZ4ULmISetMNlqJan4tPxYao2Gecc0nJB0A7sTbq9wh4gLM
         OZFhdhRL2FnJjElFjI0fpxr3RpjAWJexCLx3dzQH+P0oi50SDpdh3IS6XJb4Gf2CnJ
         WMlCMCb31ucUThmUmmwglU3QM3CddmEQpYNf1iKedGuF+PM+IW0UNh3Rk+opwQe1q0
         dFl1epwJKhuwlS3uybJSzzQbJsUTddiI/sIWo1e4+RMa4SJv33Qat4ryoZYggHjqBz
         oxHwAh9Hz8076AHW46bP55ex26R2QJzRvT5UUnEnXCrxBuiMcsR1+Fqt0t8+Jwuk36
         pKm8B98SYm3mw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id EA56460F46; Thu,  2 Dec 2021 00:04:21 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] Memory leaks show up a while after usung Edimax Wi-Fi
 N150 Bluetooth4.0 USB Adapter (rtl8723be)
Date:   Thu, 02 Dec 2021 00:04:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.description
Message-ID: <bug-215197-62941-canKjiIHV0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215197-62941@https.bugzilla.kernel.org/>
References: <bug-215197-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215197

Erhard F. (erhard_f@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #299825|kernel -config (5.16-rc3,   |kernel .config (5.16-rc3,
        description|AMD FX-8370)                |AMD FX-8370)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
