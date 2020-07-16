Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA4CC433E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 23:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CCE20760
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 23:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGPX1M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgGPX1L (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 19:27:11 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208591] connecting to bluetooth Samsung earbuds freezes the
 system (kubuntu 20.04) with 5.8rc kernels. Hard reset needed.
Date:   Thu, 16 Jul 2020 23:27:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mkleinsoft@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-208591-62941-Bg0tSL0c9o@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208591-62941@https.bugzilla.kernel.org/>
References: <bug-208591-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208591

--- Comment #3 from Marian Klein (mkleinsoft@gmail.com) ---
For completeness.
1) I could connect to my phone Galaxy A50 5G via bluetooth before trying to
connect to Earbuds. (see attached pic)
2) Bluetooth Widget in plasma shows Ear buds connected, but system is frozen
anyway.
3) I can move cursor with touchpad, but it does not react to clicks after
attempted connect.  The only way to get out of this situation is to restart
laptop.

-- 
You are receiving this mail because:
You are the assignee for the bug.
