Return-Path: <SRS0=JtDF=AF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0630FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 16:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7AE92082F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 16:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404769AbgFXQsd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404040AbgFXQsd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jun 2020 12:48:33 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 24 Jun 2020 16:48:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-e0nZ6hi1S8@https.bugzilla.kernel.org/>
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

--- Comment #82 from Swyter (swyterzone@gmail.com) ---
Hmm. That's interesting, so HCI reports that the chip manufacturer is fine;
Cambridge Silicon Radio (10), but then the following check fails and treats it
as counterfeit... Which (if I've done my research correctly) *isn't true*, your
dongle should be legit and suffering from the Stored Link Key bug, like mine,
which also never showed up in `bluetoothctl` before this. ¯\_(ツ)_/¯

If you could try changing this part:

> +     if (le16_to_cpu(rp->manufacturer) == 10 &&
> +         le16_to_cpu(rp->hci_rev) == le16_to_cpu(rp->lmp_subver)) {


...to this:

> +     if (le16_to_cpu(rp->manufacturer) == 10) {

...and find that it works for you, then we may be onto something. Until now all
the CSR chips I've found put the same little version numbers in both fields,
but it may not be as constant as I thought. Back to basics.


In any case doing `while true; do sudo hcidump -X; done` in a terminal window
that keeps running (you can stop it with Ctrl + C) even when your thingie is
disconnected, then trying to plug it in, and then copying the interesting parts
of that to GitHub Gist or some other paste place to link here may be useful. If
you are on Arch there's a handy bluez-utils-compat AUR package with these
utilities.

Some interesting keywords to look for in the logs, any errors are probably
useful, given some context:
- Error: Unsupported Feature or Parameter Value
- Stored Link Key

Thanks again for testing!

-- 
You are receiving this mail because:
You are the assignee for the bug.
