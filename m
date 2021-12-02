Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EB4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Dec 2021 00:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354058AbhLBAHq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:07:46 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41628 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354109AbhLBAHc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 19:07:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7636ACE2080
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 00:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9433FC56747
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 00:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403447;
        bh=qrC848GX0djs8DVWAYUTiTDt3yWy3c+K3/QQGyOjTSM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VFBYL06z6ghYDqY0yteh07M/mPxPnSTnfczVibST4s+gH9uvCue50kOi4JJbEK4Dc
         iN5bHdkdkS14zQjduaYXeEoGzFq7t47KKCjFbn74DDE4e1JO4Gyd3iVpwPiviuJq1T
         DDYzsWhtKAAzhLLE/x13/A2jYYh8faVrXdjevrVof2dgGbV2W8PPnb+D2qMiwwyYOX
         iSgZA3+hsLQG6Wf58VCZEiHK6Nhd1xK6WZsjdGFY1FNhQUFTiHgvPPxC0aCSLSw6VK
         XuRzKugk80GmaNCwtDeFf6NzLjwb4uvnaa80/ur0I1JEEUE+ywni+fAXV0WTiyvJw6
         YubaIXeNIA/PA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 6818F60F46; Thu,  2 Dec 2021 00:04:07 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] Memory leaks show up a while after usung Edimax Wi-Fi
 N150 Bluetooth4.0 USB Adapter (rtl8723be)
Date:   Thu, 02 Dec 2021 00:04:07 +0000
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
Message-ID: <bug-215197-62941-w4UpB96tNo@https.bugzilla.kernel.org/>
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

--- Comment #1 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 299825
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299825&action=3Dedit
kernel -config (5.16-rc3, AMD FX-8370)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
