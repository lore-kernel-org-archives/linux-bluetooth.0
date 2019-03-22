Return-Path: <SRS0=CqyX=RZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6291DC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 07:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D92120700
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 07:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfCVHZw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:25:52 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:60664 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbfCVHZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Mar 2019 03:25:52 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 6E48F2A594
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2019 07:25:51 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 62E8D2A599; Fri, 22 Mar 2019 07:25:51 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202999] New: The HID Parser has some bugs and limitations
Date:   Fri, 22 Mar 2019 07:25:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rzimmerm@logitech.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-202999-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202999

            Bug ID: 202999
           Summary: The HID Parser has some bugs and limitations
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.9
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: rzimmerm@logitech.com
        Regression: No

From hid-core.c:

        case HID_GLOBAL_ITEM_TAG_REPORT_SIZE:
                parser->global.report_size = item_udata(item);
                if (parser->global.report_size > 96) {
                        dbg_hid("invalid report_size %d\n",
                                        parser->global.report_size);
                        return -1;
                }
                return 0;

The 96 bits limit is arbitrary. For new categories of devices this can be a
limitation (in our case an array of structure larger than 12 bytes) I would
recommend either no limit (dynamic) or something like 64 * 8 bits.


        if (parser->global.logical_maximum < parser->global.logical_minimum) {
                dbg_hid("logical range invalid %d %d\n",
parser->global.logical_minimum, parser->global.logical_maximum);
                return -1;
        }

If the item is 32bit and the logical extent is (0 - 0xFFFFFFFF), the
logical_maximum will flip sign as it is a 32 bit signed variable and the
assertion will fail.

Those issue are not found on Windows/MacOS/iOS

-- 
You are receiving this mail because:
You are the assignee for the bug.
