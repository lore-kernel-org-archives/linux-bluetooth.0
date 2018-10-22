Return-Path: <SRS0=GZqV=NC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476F4ECDE44
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Oct 2018 00:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8FB20869
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Oct 2018 00:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8FB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeJVI32 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Oct 2018 04:29:28 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:39020 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726813AbeJVI32 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Oct 2018 04:29:28 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id CE2D928536
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Oct 2018 00:13:18 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id BC2982874F; Mon, 22 Oct 2018 00:13:18 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 201479] Dell WK717 keyboard causes crashes of Bluetooth daemon
 5.50
Date:   Mon, 22 Oct 2018 00:13:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dieter.vanderfaeillie@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-201479-62941-UcWhDys2dZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-201479-62941@https.bugzilla.kernel.org/>
References: <bug-201479-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=201479

--- Comment #2 from Dieter (dieter.vanderfaeillie@gmail.com) ---
The problem seems to be resolved, apparently the new Bluetooth panel in the
Juno release still has issues. I paired the keyboard using the bluetoothctl
command. 
(see: https://wiki.archlinux.org/index.php/bluetooth)

I think the Juno settings is not asking for a pairing code.

Sorry for bothering the mailing list!

-- 
You are receiving this mail because:
You are the assignee for the bug.
