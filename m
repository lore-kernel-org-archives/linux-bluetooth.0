Return-Path: <SRS0=ORc3=EC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C489AC63777
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 16:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA4122263
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 16:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764215AbgJ0Pon convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Oct 2020 11:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1801059AbgJ0PiJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Oct 2020 11:38:09 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Tue, 27 Oct 2020 15:38:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matias@ufscar.br
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-xL54ta40gq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209745-62941@https.bugzilla.kernel.org/>
References: <bug-209745-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209745

--- Comment #6 from matias (matias@ufscar.br) ---
There are some additional reports of issues at
https://bugs.archlinux.org/task/68346, with Intel Corporation Wireless-AC 9560
adapter and the following Bluetooth devices:

* Logitech MX-Ergo

* HHKB Professional Hybrid bluetooth keyboard

-- 
You are receiving this mail because:
You are the assignee for the bug.
