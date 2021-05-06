Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76441C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 15:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3933B61166
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 15:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhEFPFW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 May 2021 11:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234759AbhEFPFU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 May 2021 11:05:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F3078610D2
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 May 2021 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620313462;
        bh=+FjPS0tcUkx5ODyZG4BlF/5oaBjadl6i12zfWw39QTA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hRbHnVBJXTX65wsYhbSaqypHNr2QBxwq19ZIb5PlNtrGcGy0ZITzsJvA1QC+vYlpd
         FUSiAnMxVAP/RBWIDD+0cvB5Jhg2izSLP/798+SlYPSzK8k1J4B9kjwnPKWzlLrw1Z
         CAuhW42t0hX8whYKrJGrLyytkgzTKmcnPtoLNlqznhBI0PUGKQA5iiKGYp9cxcLpb0
         mhWy6wdyk13QAdyIG/fL/GcouglkykcSFeKm9pj1LmNPQgcyoDMKm6WmNOq+Utu29J
         GqZxbzBb3f8RSakNY9QkB+fgqxZrcC4LhI5xGCz6K1OvCLzGpjND5rZ0GcWU9yP9Sa
         eKG6o2xCVHR/w==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 212965] WARNING: possible circular locking dependency detected,
 bluetoothd/547 is trying to acquire lock: ffff9f6854610078
 (&hdev->lock){+.+.}-{3:3}, at: hci_conn_get_phy+0x18/0x150 [bluetooth]
Date:   Thu, 06 May 2021 15:04:21 +0000
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
Message-ID: <bug-212965-62941-1Y1AIxVcH6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-212965-62941@https.bugzilla.kernel.org/>
References: <bug-212965-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D212965

--- Comment #1 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 296673
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D296673&action=3Dedit
kernel .config (5.12.1, AMD FX-8370)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
