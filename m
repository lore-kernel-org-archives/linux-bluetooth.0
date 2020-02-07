Return-Path: <SRS0=kXS7=33=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E514C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 17:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22394222C2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 17:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGRYc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgBGRYc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Feb 2020 12:24:32 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 07 Feb 2020 17:24:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Abhishekkumartux@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-3AWh9blbdD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

--- Comment #52 from akamazing (Abhishekkumartux@gmail.com) ---
(In reply to Fernando Carvalho from comment #51)
Fernando,
You are a genius. Thanks for replying, I was struggling with this. Adding
"options btusb fixups=0x0800000:0x000004:0x0a12:0x0001:0x8891" to
/etc/modprobe.d/csr-bluetoothbongle.conf and regenerating the initramfs solved
the problem for me.

Cheers,
Abhi.
> Created attachment 287227 [details]
> attachment-31457-0.html
> 
> Hi.
> 
> Try addin the module flags:
> 
> echo "options btusb fixups=0x0800000:0x000004:0x0a12:0x0001:0x8891" >
> /etc/modprobe.d/csr-bluetoothbongle.conf
> 
> Syslog should show something like:
> 
> btusb: New fixups. Device: 0x0a12:0x0001/0x8891. Rule 1/1 (5 terms):
> 0x0a12:0x0001/0x8891
> btusb: driver flags: initial => 0x0000000000000004
> btusb: driver flags: masked  => 0x0000000000800000
> 
> Regards.
> 
> # Fernando Pires de Carvalho
> # pires.carvalho@gmail.com

-- 
You are receiving this mail because:
You are the assignee for the bug.
