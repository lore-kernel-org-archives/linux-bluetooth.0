Return-Path: <SRS0=tgYb=OD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24840C43441
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Nov 2018 22:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7E32087E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Nov 2018 22:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7E32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbeKYJdW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Nov 2018 04:33:22 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:39234 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbeKYJdW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Nov 2018 04:33:22 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id E09A3289FC
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Nov 2018 22:43:50 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id B805C28AAC; Sat, 24 Nov 2018 22:43:50 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 201247] Intel Bluetooth device 8087:0025 not recognized on
 ThinkPad E585
Date:   Sat, 24 Nov 2018 22:43:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arcooke@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-201247-62941-RqBWJk4RaH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-201247-62941@https.bugzilla.kernel.org/>
References: <bug-201247-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=201247

--- Comment #3 from Adam Cooke (arcooke@gmail.com) ---
(In reply to Samantha McVey from comment #2)
> Adam,
> Maybe this is similar to the issue I had with my Lenovo A485. Both Realtek
> 8822BE and Intel 9260's bluetooth were not detected. If you put your laptop
> to sleep and then wake it up again, does it see the bluetooth with lsusb?

Hi Samantha, 

Yes, that is exactly what happens.  

Fresh boot:

adam@adam-thinkpad:~$ sudo lsusb
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 003: ID 04f2:b604 Chicony Electronics Co., Ltd 
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Suspend, then wake:

adam@adam-thinkpad:~$ sudo lsusb
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 003: ID 04f2:b604 Chicony Electronics Co., Ltd 
Bus 003 Device 004: ID 8087:0025 Intel Corp. 
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub


8087:0025 suddenly appears after wake.  Wifi works the entire time, however.

This message that my bluetooth adapter being powered off also appears in my
bluetooth devices in KDE after waking from suspend (it is not there on fresh
boot). 

https://i.imgur.com/OAgdxuj.png

-- 
You are receiving this mail because:
You are the assignee for the bug.
