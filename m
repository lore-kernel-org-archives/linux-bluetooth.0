Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FCEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Dec 2021 00:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354051AbhLBAL5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:11:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43124 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354226AbhLBALT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 19:11:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 07F8DCE1D72
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 00:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39DE7C53FCD
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 00:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403675;
        bh=dcw+PDlamRQbPG4TgbctGTbCMt/hCqaLbAkeLE2Z+pQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Fkf7LMEpuIYAnfgLuldvqizdNbv8rgErMpJHQwvYHfst3gFhSFVFHo0jHwZtdYOLB
         65WwVxKaI+IzoGSYLOO8jkFeWj7gSi5EVMa76v5FwR/1viq9JXOd3OjmkFIPnZNsGG
         dbLH2Qv76bJHF803etNOzEtzktdsp2fwjpln5+3PUTyEsEdJj7z/GZQ4dkmJG7+6rb
         h9agiLKi9RZOGCcLVGMWCbgXBIQpfowxINAEDfdthT40Yn/HNMGKA8yo4Xf7rwIQVj
         1R6Gh+3jPeXsQjfO4O3S984jUdIow+vOElvf1qYYce4xSMuiq9u0v8uV7e44S1y1EG
         X0LyfqpnZhYTw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 1AD4260E91; Thu,  2 Dec 2021 00:07:55 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] Memory leaks show up a while after usung Edimax Wi-Fi
 N150 Bluetooth4.0 USB Adapter (rtl8723be)
Date:   Thu, 02 Dec 2021 00:07:54 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215197-62941-u28Evc7ESY@https.bugzilla.kernel.org/>
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

--- Comment #2 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 299827
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299827&action=3Dedit
kernel dmesg (5.16-rc3, AMD FX-8370)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
