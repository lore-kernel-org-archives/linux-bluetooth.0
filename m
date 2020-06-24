Return-Path: <SRS0=JtDF=AF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BABC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 21:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF84207E8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 21:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404455AbgFXVhj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403996AbgFXVhh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jun 2020 17:37:37 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 24 Jun 2020 21:37:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: virtuousfox@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-60824-62941-poLA38TPSy@https.bugzilla.kernel.org/>
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

--- Comment #85 from Sergey Kondakov (virtuousfox@gmail.com) ---
Created attachment 289871
  --> https://bugzilla.kernel.org/attachment.cgi?id=289871&action=edit
CSR_ds4_fail.btsnoop

(In reply to Swyter from comment #80)
> Hi, Andrés. Thanks for testing v1! I just submitted a revised v2 after
> following the recommendations of Marcel Holtmann and finding a better way of
> classifying them by type:
> 
> https://patchwork.kernel.org/patch/11622161/
> 
> 
> In your case, and as it says after iProduct in your lsusb -v dump, yours
> should be a legit Cambridge Silicon Radio CSR8510 A10 chip and detected as
> such.
> 
> Those have the HCI_QUIRK_BROKEN_STORED_LINK_KEY bug.
> 
> Same as my dongle. Give v2 a go. :)

Tried it for my DS4. Unfortunately the result is the same as when I tried to
hardcode my ID: gamepad thinks that it's paired but system does not register
it. I've fiddled about with `btmon` and it seems that everything goes wrong at:
HCI Event: Role Change (0x12) plen 8
        Status: Role Switch Failed (0x35)
        Role: Slave (0x01)

You may read full dump with `btmon -r <file>`

`dmesg --color=always | grep -i CSR` says:
[   11.516062] Bluetooth: hci0: CSR: New controller detected; bcdDevice=0x8891,
HCI manufacturer=10, HCI rev=0x811, LMP subver=0x811
[   11.516065] Bluetooth: hci0: CSR: Modern CSR controller type detected

-- 
You are receiving this mail because:
You are the assignee for the bug.
