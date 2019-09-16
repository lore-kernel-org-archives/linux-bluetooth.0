Return-Path: <SRS0=loPc=XL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058EFC49ED7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 11:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC70A214AF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 11:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfIPLM0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfIPLM0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Sep 2019 07:12:26 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 16 Sep 2019 11:12:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: raestloz@posteo.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-SDN1ChY7h6@https.bugzilla.kernel.org/>
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

--- Comment #40 from raestloz@posteo.net ---
Windows 10 doesn't exhibit the same issues with the exact same dongle, so I
believe what they do is ignore the feature issues presented by dongles outright

I personally don't think it's good to do that, there's a reason standards
exist, so perhaps a better way is to move bluetooth driver out of kernel so
fixing the driver to account for device quirks doesn't mean recompiling the
entire kernel?

-- 
You are receiving this mail because:
You are the assignee for the bug.
