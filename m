Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC6CC4361B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 14:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466AE207CC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 14:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407453AbgLLOol convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Dec 2020 09:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395522AbgLLOob (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Dec 2020 09:44:31 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 12 Dec 2020 14:43:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-2wmxq6Iogp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

Hans de Goede (jwrdegoede@fedoraproject.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jwrdegoede@fedoraproject.or
                   |                            |g

--- Comment #163 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
After seeing the:

"[v3] Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth
controllers"
https://patchwork.kernel.org/project/bluetooth/patch/6bce2c08-48f0-f49c-d70c-280475220550@gmail.com/

Patch land, I decided to give my own fake CSR dongles marked with "V5.0" on the
outside another try. After much experimenting I have managed to get muy
variant, which uses a "Barrot 8041a02" chip to work, the patches for this are
pending upstream here:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=d74e0ae7e03032b47b8631cc1e52a7ae1ce988c0
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=0671c0662383eefc272e107364cba7fe229dee44

The second patch contains the fix for the "Barrot 8041a02" chip, but if you
want to try this, you need to apply both since the first patch introduces a new
local variable which is used in the second.

Note this only fixes "v5.0" dongles with the Barrot chip.

Also important to note here is that frankly these clones are of very poor
quality. I guess most of you are getting these from aliexpress. If you look for
CSR8510 at aliexpress and then for offers saying "original csr8510" chip (and
the dongle will be marked csr 4.0, then you should be getting a dongle with a
real CSR chip for almost the same price and those work so much better it just
is not funny!

-- 
You are receiving this mail because:
You are the assignee for the bug.
