Return-Path: <SRS0=OFBO=AG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F30CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 07:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27492076E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 07:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390182AbgFYHee convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgFYHee (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jun 2020 03:34:34 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 25 Jun 2020 07:34:32 +0000
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
Message-ID: <bug-60824-62941-wqPXN7xyYD@https.bugzilla.kernel.org/>
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

--- Comment #90 from Swyter (swyterzone@gmail.com) ---
Because it's what I know, plain and simple. It's what I have been using and
it's what I've been comfortable recommending. As long as they are HCI logs and
*they exist* it doesn't matter the format, doing `btmon -w my.log` is much
nicer than `hcidump -X`, that's for sure, so thanks for that. I'm learning as I
go, I figured that if no one was stepping up I might as well give it a try.
Seems like a good way of submitting a first patch and learning a few things.
¯\_(ツ)_/¯

I took a look at your DS4 logs. I would take similar captures on Windows to
compare, maybe the role switch isn't really needed. If you could link your
Windows drivers here it may also be useful, maybe the dongle needs to be
configured with vendor commands before using it. **Update**: Tested DS4 pairing
myself with BlueZ and no, the `Accept Connection Request` packet doesn't show
up and it connects normally, the spec says that this isn't non-fatal, and in
this case the one erroring out due to timeout and disconnecting is the DS4, so
that's something to keep in mind.

From what I see, HCI_OP_ACCEPT_CONN_REQ seems to be called by the SCO layer in
sco_conn_defer_accept():
https://github.com/torvalds/linux/blob/cb8e59cc87201af93dfbb6c3dccc8fcad72a09c2/net/bluetooth/sco.c#L741
Or alternatively from here, I believe:
https://github.com/torvalds/linux/blob/cb8e59cc87201af93dfbb6c3dccc8fcad72a09c2/net/bluetooth/hci_event.c#L2742

It's a wild guess, but it may be sound-related.

--

Another thing to keep in mind is that the bluez-utils package has a nifty
`bccmd` tool for CSR devices (a clone of a proprietary tool, actually) that is
able to get and set most of the internal firmware properties and detect the
chip type, in theory. It doesn't work for me, though. I'm guessing there's an
alternative way of accessing the vendor commands via USB, or the interface has
changed since then.

But at least worth a shot on your end. Maybe you guys have more luck doing
`bccmd chiprev`.

-- 
You are receiving this mail because:
You are the assignee for the bug.
