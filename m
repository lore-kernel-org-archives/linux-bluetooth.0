Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EDAC2BB48
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 20:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE7F207A2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 20:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502886AbgLNUI3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Dec 2020 15:08:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbgLNUIX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Dec 2020 15:08:23 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210681] kernel: Bluetooth: hci0: don't support firmware rome
 0x31010000
Date:   Mon, 14 Dec 2020 20:07:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: antdev66@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210681-62941-kS2PmZ4TCx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210681-62941@https.bugzilla.kernel.org/>
References: <bug-210681-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210681

--- Comment #3 from anthony (antdev66@gmail.com) ---
The problem seems to be this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/bluetooth/btusb.c?h=v5.10&id=b40f58b973865ee98ead884d2bdc7880b896ddb8

"Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855 support"

Removing this commit solves the problem (for me).

---

My notebook is:
- Notebook X555LN (i7-4510U)
- Qualcomm Atheros QCA9565/AR9565 Wireless Network Adapter (rev 01)

Thanks

-- 
You are receiving this mail because:
You are the assignee for the bug.
