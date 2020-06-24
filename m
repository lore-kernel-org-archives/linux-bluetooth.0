Return-Path: <SRS0=JtDF=AF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3696C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 18:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969972082F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 18:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406056AbgFXSmv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405581AbgFXSmu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jun 2020 14:42:50 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 24 Jun 2020 18:42:48 +0000
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
Message-ID: <bug-60824-62941-hRAZebhSeD@https.bugzilla.kernel.org/>
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

--- Comment #84 from Swyter (swyterzone@gmail.com) ---
Interesting. Sounds like another quirk for that specific model that was hidden
until now; they don't support the Read Default Erroneous Data Reporting
command.

Let's try something, continuing with the same patches as before, change this in
net/bluetooth/hci_core.c:

>       if (hdev->commands[18] & 0x04)
>               hci_req_add(req, HCI_OP_READ_DEF_ERR_DATA_REPORTING, 0, NULL);

...to this:
>       if (false)
>               hci_req_add(req, HCI_OP_READ_DEF_ERR_DATA_REPORTING, 0, NULL);

...and see if the log moves a bit, maybe that fixes it. Who knows? Save the log
somewhere.


Chances are that the last change wasn't enough. So additionally, after that
change this in net/bluetooth/hci_core.c:
>       /* Set erroneous data reporting if supported to the wideband speech
>        * setting value
>        */
>       if (hdev->commands[18] & 0x08) {

...to this:
>       /* Set erroneous data reporting if supported to the wideband speech
>        * setting value
>        */
>       if (false) {


Technically with that Linux should ignore the wideband error thingy altogether.
Sounds like we need a HCI_QUIRK_WIDEBAND_SPEECH_NOT_SUPPORTED. The opposite of
the HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED that already exists.

Anyway, good progress. This is a different bug. ¯\_(ツ)_/¯

-- 
You are receiving this mail because:
You are the assignee for the bug.
