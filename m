Return-Path: <SRS0=3vvc=RY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D49C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D5921873
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 09:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfCUJ3l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:29:41 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:47820 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727870AbfCUJ3l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Mar 2019 05:29:41 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id F249E29C6D
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Mar 2019 09:29:39 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id E2CBC29F82; Thu, 21 Mar 2019 09:29:39 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 139041] QCA Bluetooth [0cf3:e007] failed to initialize if
 Bluez's "[Policy] AutoEnable=true" was set
Date:   Thu, 21 Mar 2019 09:29:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kai.heng.feng@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-139041-62941-og7W6LLQzq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-139041-62941@https.bugzilla.kernel.org/>
References: <bug-139041-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=139041

--- Comment #4 from Kai-Heng Feng (kai.heng.feng@canonical.com) ---
Fixed by this commit:
commit c7e163fe282f34efdf77fb09b333529de97a6a10
Author: Ethan Hsieh <ethan.hsieh@canonical.com>
Date:   Fri Oct 7 12:06:42 2016 +0800

    Bluetooth: btusb: Fix atheros firmware download error

    Move usb_autopm_get_interface() ahead of setup_on_usb() to prevent
    device from sending usb control message in usb suspend mode.

    The error message is as below:

    [   83.944103] btusb 1-2:1.1: usb_suspend_interface: status 0
    [   83.944107] btusb 1-2:1.0: usb_suspend_interface: status 0
    [   83.960132] usb 1-2: usb auto-suspend, wakeup 0
    [   83.976156] usb 1-2: usb_suspend_device: status 0
    [   83.976162] usb 1-2: usb_suspend_both: status 0
    [  298.689106] Bluetooth: hci0
    [  298.689399] Bluetooth: hci0: Failed to access otp area (-113)

    Signed-off-by: Ethan Hsieh <ethan.hsieh@canonical.com>
    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

-- 
You are receiving this mail because:
You are the assignee for the bug.
