Return-Path: <SRS0=obUF=UX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF98C43613
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jun 2019 14:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB6220674
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jun 2019 14:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfFXOnx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:43:53 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:33956 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbfFXOnx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jun 2019 10:43:53 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 80EAE28C08
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2019 14:43:52 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 7EE3328C10; Mon, 24 Jun 2019 14:43:52 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 24 Jun 2019 14:43:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: raestloz@posteo.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-cjl4PRsokB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=60824

raestloz@posteo.net changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |raestloz@posteo.net

--- Comment #29 from raestloz@posteo.net ---
I'm having the same problem here, kernel 4.20.17. 
btmon shows error at Delete Stored Link Key with hciconfig hci0 up, unsupported
feature

based on https://bugzilla.kernel.org/show_bug.cgi?id=103451 it seems that my
dongle is also a fake (mismatch between bcdDevice and LMP subversion), but with
bcdDevice 88.91, which isn't covered by the kernel (currently covers 1.00 and
1.34)

-- 
You are receiving this mail because:
You are the assignee for the bug.
