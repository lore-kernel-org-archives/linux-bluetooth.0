Return-Path: <SRS0=g45L=XO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514D8C4CEC4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Sep 2019 14:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211B9218AF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Sep 2019 14:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389612AbfISOpg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389041AbfISOpg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Sep 2019 10:45:36 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 200039] BT advertising packet wakes up the system from S3 and
 suspend-to-idle
Date:   Thu, 19 Sep 2019 14:45:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario_limonciello@dell.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-200039-62941-HbkXSf8m7m@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200039-62941@https.bugzilla.kernel.org/>
References: <bug-200039-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=200039

--- Comment #39 from Mario Limonciello (mario_limonciello@dell.com) ---
So the idea would be you don't auto-suspend the btusb device and then as a
result the btusb device can't wake up?  I think the potential problem there is
that the BT controller would stay powered over s2idle which should keep the USB
active, and potentially prevent the SOC from reaching it's deepest state.

-- 
You are receiving this mail because:
You are the assignee for the bug.
