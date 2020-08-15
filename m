Return-Path: <SRS0=DQXy=BZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78ECC433E1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Aug 2020 00:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9541D2074D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Aug 2020 00:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHOAQH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 20:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgHOAQG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 20:16:06 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 15 Aug 2020 00:16:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vicpt@protonmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-9pWmSyLogr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

--- Comment #134 from vic (vicpt@protonmail.com) ---
(In reply to Swyter from comment #111)
> Just submitted v4 for kernel review. Its behavior should be identical to v3,
> it only contains a few minor technical changes and logic flow tweaks, to
> appease the BlueZ gods. Nothing new.
> ...
> https://patchwork.kernel.org/patch/11686157/

Just to correct my last comment #128. The patch indeed work.
First time I tried I didn't pay attention to the patch, I just applied the
patch. Then I built only the module (btusb) for my in use kernel version. For
obvious reasons it didn't work.

Today with more time I realized the stupidity I did, then I built the entire
kernel. Now after load the btusb module with the options "reset=1
enable_autosuspend=0" the dongle initiates and apparently works correctly.
I'm sorry for the misinformation on my last comment.

Thank you Swyter for your time on fixing this.

Hope to see the patch in mainline kernel soon.

-- 
You are receiving this mail because:
You are the assignee for the bug.
