Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D75C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 20:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B001C214DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 20:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfAJUFb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:05:31 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:43840 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbfAJUFa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 15:05:30 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 16C7B29DC4
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jan 2019 20:05:30 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 0AA0329DE4; Thu, 10 Jan 2019 20:05:30 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202213] bluez trunk tests fail with GCC 9 (or with
 -fsanitize=address with GCC 9)
Date:   Thu, 10 Jan 2019 20:05:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stefan.seyfried@googlemail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202213-62941-YuQVZrmgzM@https.bugzilla.kernel.org/>
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

--- Comment #4 from Stefan Seyfried (stefan.seyfried@googlemail.com) ---
With gcc9 (finally found a way to use it in OBS :-), it asserts:

abuild@strolchi:~/rpmbuild/BUILD/bluez-5.50> cat unit/test-sdp.log
bluetoothd[3066]: Bluetooth daemon 5.50
len: 7 raw_size: 14 cont_len: 0
**
ERROR:unit/test-sdp.c:258:client_handler: assertion failed: ((size_t) len ==
rsp_pdu->raw_size + rsp_pdu->cont_len)
FAIL unit/test-sdp (exit status: 134)

I added a printf before the assert (and shifted it down one line)

-- 
You are receiving this mail because:
You are the assignee for the bug.
