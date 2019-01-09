Return-Path: <SRS0=eb2H=PR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9200BC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 12:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599B8206BA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 12:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfAIMG0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:06:26 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:44880 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbfAIMGZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jan 2019 07:06:25 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C2D2028DAB
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jan 2019 12:06:24 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id B76C028E60; Wed,  9 Jan 2019 12:06:24 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202193] BUG: sleeping function called from invalid context at
 net/core/sock.c:2771 when trying to connect bluetooth headphones
Date:   Wed, 09 Jan 2019 12:06:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: emilio@crisal.io
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202193-62941-TVst27PLT7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202193-62941@https.bugzilla.kernel.org/>
References: <bug-202193-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202193

--- Comment #1 from Emilio Cobos Álvarez (:emilio) (emilio@crisal.io) ---
It is reproducible if I just disconnect and connect using bluetoothctl:

[ 6303.369709] BUG: sleeping function called from invalid context at
net/core/sock.c:2771
[ 6303.369715] in_atomic(): 1, irqs_disabled(): 0, pid: 30395, name: krfcommd
[ 6303.369717] INFO: lockdep is turned off.
[ 6303.369721] CPU: 4 PID: 30395 Comm: krfcommd Tainted: G        W  OE    
4.21.0-0.rc0.git1.1.fc30.x86_64 #1
[ 6303.369723] Hardware name: LENOVO 20ENCTO1WW/20ENCTO1WW, BIOS N1EET80W (1.53
) 09/14/2018
[ 6303.369725] Call Trace:
[ 6303.369732]  dump_stack+0x85/0xc0
[ 6303.369737]  ___might_sleep.cold.73+0xac/0xbc
[ 6303.369742]  lock_sock_nested+0x29/0xa0
[ 6303.369758]  bt_accept_enqueue+0x3f/0xb0 [bluetooth]
[ 6303.369766]  rfcomm_connect_ind+0x21b/0x260 [rfcomm]
[ 6303.369773]  rfcomm_run+0x1611/0x1820 [rfcomm]
[ 6303.369779]  ? do_wait_intr_irq+0xb0/0xb0
[ 6303.369785]  ? rfcomm_check_accept+0x90/0x90 [rfcomm]
[ 6303.369789]  kthread+0x120/0x140
[ 6303.369792]  ? kthread_create_on_node+0x60/0x60
[ 6303.369797]  ret_from_fork+0x3a/0x50
[ 6303.552483] input: 2C:41:A1:C6:01:C0 as /devices/virtual/input/input20

The headphones work though.

-- 
You are receiving this mail because:
You are the assignee for the bug.
