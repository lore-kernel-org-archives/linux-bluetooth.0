Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD51C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 21:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E417A20659
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 21:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgEMVzU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 17:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbgEMVzU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 17:55:20 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 207629] BISECTED Bluetooth: hci0: command 0x2042 tx timeout -
 suspend fails - Dell XPS 9300, Dell XPS 7390, Dell Inspiron 7386, Intel
 NUC7JYB
Date:   Wed, 13 May 2020 21:55:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lenb@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-207629-62941-yBv79olj3u@https.bugzilla.kernel.org/>
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

Len Brown (lenb@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|BISECTED Bluetooth: hci0:   |BISECTED Bluetooth: hci0:
                   |command 0x2042 tx timeout - |command 0x2042 tx timeout -
                   |suspend fails - Dell XPS    |suspend fails - Dell XPS
                   |9300                        |9300, Dell XPS 7390, Dell
                   |                            |Inspiron 7386, Intel
                   |                            |NUC7JYB

--- Comment #15 from Len Brown (lenb@kernel.org) ---
This same Linux Bluetooth regression is seen on additional platforms:

man:Dell Inc. | plat:XPS 13 7390 | cpu:Intel(R) Core(TM) i5-10210U CPU @
1.60GHz | bios:1.5.1 | biosdate:03/09/2020

man:Dell Inc. | plat:Inspiron 7386 | cpu:Intel(R) Core(TM) i7-8565U CPU @
1.80GHz | bios:1.2.0 | biosdate:12/05/2018

man:Intel Corporation | plat:NUC7JYB | cpu:Intel(R) Celeron(R) J4005 CPU @
2.00GHz | bios:JYGLKCPX.86A.0053.2019.1015.1510 | biosdate:10/15/2019

Their failure rates are slighly higher than the Dell 9300:

5.7.0-rc4+      otcpl-dell-7386-whl     freeze-x3547    3261    91.94%
5.7.0-rc4+      otcpl-nuc-kbl           freeze-x3207    2821    87.96%
5.7.0-rc4+      otcpl-dell-7390-cmlu    freeze-x2879    2275    79.02%
5.7.0-rc4+      lenb-Dell-XPS-13-9300   freeze-x2426    1429    58.90%

-- 
You are receiving this mail because:
You are the assignee for the bug.
