Return-Path: <SRS0=0zex=D6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E6BC388F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Oct 2020 22:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9F220BED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Oct 2020 22:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbgJWWBA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Oct 2020 18:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752808AbgJWWA7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Oct 2020 18:00:59 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208965] not working bluetooth mouse low energy rtl8822ce
Date:   Fri, 23 Oct 2020 22:00:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: julian@blk9.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-208965-62941-WoBp9AaVly@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208965-62941@https.bugzilla.kernel.org/>
References: <bug-208965-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208965

--- Comment #9 from julian@blk9.net ---
I've patched my kernel to add the missing USB identifier and that seem to have
solved the issue. I can now properly pair with a bluetooth mouse.

My dmesg now shows firmware files being loaded for the device:

[    5.909847] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c
lmp_ver=0
a lmp_subver=8822
[    5.912751] Bluetooth: hci0: RTL: rom_version status=0 version=3
[    5.912754] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
[    5.918147] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
[    5.918282] Bluetooth: hci0: RTL: cfg_sz 6, total sz 31422

What's the right way to go about this ? Should I submit my patch upstream ?

-- 
You are receiving this mail because:
You are the assignee for the bug.
