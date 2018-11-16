Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B912C43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 15:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFA22087C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 15:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFA22087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbeKQBar convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:30:47 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:51948 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728339AbeKQBaq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Nov 2018 20:30:46 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 2B2472C955
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 15:17:59 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 29C352CAF1; Fri, 16 Nov 2018 15:17:59 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 200039] BT advertising packet wakes up the system from S3 and
 suspend-to-idle
Date:   Fri, 16 Nov 2018 15:17:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: raghuram.hegde@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-200039-62941-SFYfma67vM@https.bugzilla.kernel.org/>
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

--- Comment #27 from Raghuram Hegde (raghuram.hegde@intel.com) ---
In Bluetooth 4.1(LE Privacy 1.1), the Private address Resolving List is
maintained in the Host. Address resolution is also done by the Host. 
This requires Host intervention every time an advertisement packet with an RPA
is received. 

In Bluetooth 4.2(LE Privacy 1.2), 
the Resolving List is maintained in the Controller. Since the Controller
resolves the private address, the Host does not need to wake up in devices
where the Host is implemented using a separate CPU. This lowers overall power
consumption.

Having said that, Intel controller does support LE Privacy v1.2 feature.
However Linux kernel need to enable to make use of the Link Layer privacy 
to avoid this kind of issues.

This is generic problem/behavior observed on other vendors BT controller as
well that does not support LE privacy 1.2 feature. 

We highly recommend to enable LE privacy 1.2 to solve the problem.

-- 
You are receiving this mail because:
You are the assignee for the bug.
