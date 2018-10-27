Return-Path: <SRS0=uhHz=NH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E8C46475
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Oct 2018 04:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6D5207DD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Oct 2018 04:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6D5207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeJ0MxQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Oct 2018 08:53:16 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:55224 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbeJ0MxQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Oct 2018 08:53:16 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B96682C35E
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Oct 2018 04:13:38 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id B78992B101; Sat, 27 Oct 2018 04:13:38 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 198699] Kernel regularly logs: Bluetooth: hci0: last event is
 not cmd complete (0x0f)
Date:   Sat, 27 Oct 2018 04:13:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: snorkellingcactus@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-198699-62941-bnn6c1qyig@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198699-62941@https.bugzilla.kernel.org/>
References: <bug-198699-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=198699

--- Comment #17 from Nadal Gonzalo García Zavala (snorkellingcactus@gmail.com) ---
dmesg
https://paste.pound-python.org/raw/Z0A2xHsgA3ePo8rmIL7L/

lspci -vvv
https://paste.pound-python.org/raw/9mPWBx1BJfar6yROQOVu/

lsmod
https://paste.pound-python.org/raw/TASuig0MdPwOmWiEUWeh/

sha256sum /lib/firmware/rtl_bt/rtl8723d_*
https://paste.pound-python.org/raw/XkFQ6c6f9HpqmUhCEJOn/

uname -a
https://paste.pound-python.org/raw/y7YgUPIhCHGnnUipGG9q/

-- 
You are receiving this mail because:
You are the assignee for the bug.
