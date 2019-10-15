Return-Path: <SRS0=CF20=YI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79867ECE59D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Oct 2019 21:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F51720873
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Oct 2019 21:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbfJOVAD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Oct 2019 17:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387762AbfJOVAD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Oct 2019 17:00:03 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Tue, 15 Oct 2019 21:00:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gabriel_scf@hotmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-B6MdvS8AHF@https.bugzilla.kernel.org/>
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

GABE (gabriel_scf@hotmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |gabriel_scf@hotmail.com

--- Comment #42 from GABE (gabriel_scf@hotmail.com) ---
I'm also having this problem with a generic chinese USB dongle. This specific
model is the only BT 4.0 dongle available in my city, found at many stores.


```
@lsusb -v
  ...
  idVendor           0x0a12 Cambridge Silicon Radio, Ltd
  idProduct          0x0001 Bluetooth Dongle (HCI mode)
  bcdDevice           25.20
  ...
```


Everything works, execept that when I try to connect to the headset after
pairing, bluetoothd hangs indefinitely, and I'm then unable to `modprobe -r
btusb` because the device is now busy. Pulseaudio will never list that audio
device.

I applied both patches shown here and nothing changes, except btusb crashes
into a neat coredump which I can see in dmesg.
I would like to hardcode my `bcdDevice` to that patched `if` conditional but
how to convert `bcdDevice=25.20` into something like `0x0000`?


$uname -r
5.3.0-arch1-1-ARCH

-- 
You are receiving this mail because:
You are the assignee for the bug.
