Return-Path: <SRS0=9Smc=RV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FFAC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 16:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761712087E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 16:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCRQIX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:08:23 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:43524 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbfCRQIW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Mar 2019 12:08:22 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 17F292900B
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2019 16:08:22 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 0E5C929222; Mon, 18 Mar 2019 16:08:22 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 199873] Bluetooth 3.0 mouses are automatically disconnected
 after connected
Date:   Mon, 18 Mar 2019 16:08:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: phil+kernbugz@fifi.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-199873-62941-tZ5xID5zOR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199873-62941@https.bugzilla.kernel.org/>
References: <bug-199873-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=199873

--- Comment #7 from Philippe Troin (phil+kernbugz@fifi.org) ---
(In reply to Kai-Heng Feng from comment #5)
> Do you folks use gnome-control-center to pair?

I certainly did use gnome-control-center.
I've just tried again with Fedora 29 (gnome-control-center-3.30.3-1.fc29.x86_64
+ bluez-5.50-3.fc29.x86_64) and out of five remove, add, force reconnect) I
only received a single failure.
/usr/share/gnome-bluetooth/pin-code-database.xml does not seem to have any
tweak applying to this mouse.

-- 
You are receiving this mail because:
You are the assignee for the bug.
