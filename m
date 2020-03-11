Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9345EC10F27
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 12:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F7920873
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 12:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgCKMS5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729286AbgCKMS4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 08:18:56 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 196621] bluez-5.46: unit/test-gatt segfaults when running tests
Date:   Wed, 11 Mar 2020 12:18:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pachoramos1@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-196621-62941-awcV0txWkU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-196621-62941@https.bugzilla.kernel.org/>
References: <bug-196621-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=196621

--- Comment #8 from Pacho Ramos (pachoramos1@gmail.com) ---
Per
http://www.linuxfromscratch.org/blfs/view/svn/general/bluez.html

it seems only for tests :)

-- 
You are receiving this mail because:
You are the assignee for the bug.
