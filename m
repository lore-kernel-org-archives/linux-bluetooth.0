Return-Path: <SRS0=+Qjd=DS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F0EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Oct 2020 06:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCDA2087D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Oct 2020 06:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgJKGvj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Oct 2020 02:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgJKGvj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Oct 2020 02:51:39 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208965] not working bluetooth mouse low energy rtl8822ce
Date:   Sun, 11 Oct 2020 06:51:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: komar.jonathan@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-208965-62941-it8N50fG2X@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208965-62941@https.bugzilla.kernel.org/>
References: <bug-208965-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208965

--- Comment #4 from Jonathan L. Komar (komar.jonathan@gmail.com) ---
Huawei Matebook 13 2020 AMD running the 5.8.13-zen1-2-zen kernel on Arch Linux.
Same problem. I added myself to the mailing list.

RTL8822CE 802.11ac PCIe Wireless Network Adapter

-- 
You are receiving this mail because:
You are the assignee for the bug.
