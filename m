Return-Path: <SRS0=9HFX=YG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205A1C4360C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Oct 2019 17:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31BA206B7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Oct 2019 17:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfJMRZI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Oct 2019 13:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbfJMRZI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Oct 2019 13:25:08 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 13 Oct 2019 17:25:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pires.carvalho@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-60824-62941-2ucqJcwTe3@https.bugzilla.kernel.org/>
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

--- Comment #41 from Fernando Carvalho (pires.carvalho@gmail.com) ---
Created attachment 285489
  --> https://bugzilla.kernel.org/attachment.cgi?id=285489&action=edit
btusb.c: Module parameter to control multiple fixup

(In reply to Sergey Kondakov from comment #39)
> ...
> their own. A more reasonable approach would be passing
> model=vendorID:productID:<"model"> space-separated (to allow several
> dongles) override pairs with each having a bunch of quirk-hacks associated
> (as snd-hda-intel) on it, quirks=vendorID:productID:<comma separated list of
> all quirks> space-separated pairs (as usbcore/usbhid) or both.
> ...

Hi,

Yes, the feedback I had from the list was similar (my bad for following after
the existing code :).
Your suggestion was the most constructive though, so I implemented it that way.
I'm uploading the patch that I'm using to play around with the fixups.
I'm still trying to find out the best combination for my adapter and it may be
useful to others in the same quest.

PS: The syntax is a bit different from above:
Syntax:
fixups=<force_hex>[:<disable_hex>[:<vendor_hex>[:<model_hex>[:<bcdDevice>]]]]"
PPS: Maybe I'll try a new upstream patch if/when I solve some instability it
still has.

Thanks.

-- 
You are receiving this mail because:
You are the assignee for the bug.
