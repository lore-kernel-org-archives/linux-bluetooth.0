Return-Path: <SRS0=CXZ/=PT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C54EC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FDF20874
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 13:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfAKNbV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:31:21 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:49692 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728853AbfAKNbV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jan 2019 08:31:21 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3DBFF29A68
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jan 2019 13:31:21 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 3C2B829BFA; Fri, 11 Jan 2019 13:31:21 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202213] bluez trunk tests fail with GCC 9 (or with
 -fsanitize=address with GCC 9)
Date:   Fri, 11 Jan 2019 13:31:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202213-62941-kehKOyxycO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202213-62941@https.bugzilla.kernel.org/>
References: <bug-202213-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202213

--- Comment #9 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Martin Liška from comment #8)
> But similar happens in following failing tests with -fsanitize=address:
> 
> FAIL: unit/test-avdtp
> FAIL: unit/test-avctp
> FAIL: unit/test-avrcp
> FAIL: unit/test-hfp
> FAIL: unit/test-gatt
> FAIL: unit/test-hog
> 
> can you please prepare a patch where you'll factor out macros like
> #define raw_pdu(args...) into a header file?
> 
> Thanks.

Im fixing that, though it is not possible to have it in a common header because
the PDUs are different in each case.

Btw, does define_test_de_attr really needs to be changed? There is no
intermediate variable like in define_test so the variable should not go out of
scope since it is static.

-- 
You are receiving this mail because:
You are the assignee for the bug.
