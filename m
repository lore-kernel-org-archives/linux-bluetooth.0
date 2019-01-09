Return-Path: <SRS0=eb2H=PR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9B4C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 08:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23404214C6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 08:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfAIIJk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:09:40 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:45944 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728112AbfAIIJk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jan 2019 03:09:40 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C563228D96
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jan 2019 08:09:39 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id B9E0728E1D; Wed,  9 Jan 2019 08:09:39 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 201921] Bluetooth: hci0: RTL: rtl: unknown IC info, lmp subver
 a99e, hci rev 826c, hci ver 0008
Date:   Wed, 09 Jan 2019 08:09:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vasthusya@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-201921-62941-rdqyhOcMEi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-201921-62941@https.bugzilla.kernel.org/>
References: <bug-201921-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=201921

vasthusya@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |vasthusya@gmail.com

--- Comment #2 from vasthusya@gmail.com ---
(In reply to Cristian Aravena Romero from comment #1)
> Created attachment 280099 [details]
> dmesg 4.20.0-042000rc7-generic
> 
> I really do not know if the problem was definitively solved. Because
> Bluetooth devices now appear in GNOME.

It is still affecting me on vanilla 4.20 and 4.19.12.

I was able to modify drivers/bluetooth/btrtl.c to use rtl_bt/rtl8821c_fw.bin
firmware for this device.

-- 
You are receiving this mail because:
You are the assignee for the bug.
