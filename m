Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB4FC43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 15:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73462086C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 15:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73462086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeKQBkk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:40:40 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:43492 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728169AbeKQBkj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Nov 2018 20:40:39 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 703942D2F3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 15:27:50 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 55BBA2D339; Fri, 16 Nov 2018 15:27:50 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 200039] BT advertising packet wakes up the system from S3 and
 suspend-to-idle
Date:   Fri, 16 Nov 2018 15:27:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Mario.Limonciello@dell.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-200039-62941-uADug79CM7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200039-62941@https.bugzilla.kernel.org/>
References: <bug-200039-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200039

--- Comment #28 from Mario.Limonciello@dell.com ---
?
?Hello,

I am currently out of office returning after US thanksgiving. Expect delayed
response.

-- 
You are receiving this mail because:
You are the assignee for the bug.
