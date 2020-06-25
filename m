Return-Path: <SRS0=OFBO=AG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3482DC433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 14:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0854B207BB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 14:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405435AbgFYOrl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405367AbgFYOrl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jun 2020 10:47:41 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 207629] BISECTED Bluetooth: hci0: command 0x2042 tx timeout -
 suspend fails - Dell XPS 9300, Dell XPS 7390, Dell Inspiron 7386, Intel
 NUC7JYB
Date:   Thu, 25 Jun 2020 14:47:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: todd.e.brandt@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-207629-62941-eYSSTNxnYi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207629-62941@https.bugzilla.kernel.org/>
References: <bug-207629-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207629

Todd Brandt (todd.e.brandt@linux.intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |todd.e.brandt@linux.intel.c
                   |                            |om

--- Comment #23 from Todd Brandt (todd.e.brandt@linux.intel.com) ---
I tried running this patch over the 5.8.0-rc2 upstream kernel and there was no
appreciable difference in the occurrence of this error. I have 5 machines (in
addition to len's) that have been getting this error since 5.7.0-rc1.

KERNEL(w patch) HOST                    TESTS           FAILS
5.8.0-rc2+      otcpl-dell-7386-whl     freeze-x1141    1073    94.04%
5.8.0-rc2+      otcpl-cml-s-1           freeze-x1064    983     92.39%
5.8.0-rc2+      otcpl-dell-7390-cmlu    freeze-x1631    1419    87.00%
5.8.0-rc2+      otcpl-nuc-glk           freeze-x1083    929     85.78%
5.8.0-rc2+      otcpl-cml-s-2           freeze-x1172    869     74.15%

Without the patch on 5.8.0-rc1 I get this:

KERNEL(w/o patch) HOST                   TESTS          FAILS
5.8.0-rc1+      otcpl-dell-7386-whl      freeze-x2876   2698    93.81%
5.8.0-rc1+      otcpl-cml-s-1            freeze-x2359   2128    90.21%
5.8.0-rc1+      otcpl-dell-7390-cmlu     freeze-x3655   3268    89.41%
5.8.0-rc1+      otcpl-nuc-glk            freeze-x1089   911     83.65%
5.8.0-rc1+      otcpl-cml-s-2            freeze-x2748   1991    72.45%

Len you'll have to try it on your machine.

-- 
You are receiving this mail because:
You are the assignee for the bug.
