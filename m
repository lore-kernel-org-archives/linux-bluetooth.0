Return-Path: <SRS0=ZvEB=DA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D6DC2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Sep 2020 09:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C6B235FD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Sep 2020 09:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIWJlR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Sep 2020 05:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgIWJlR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Sep 2020 05:41:17 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 198919] Xbox (One) Wireless Controller won't connect
Date:   Wed, 23 Sep 2020 09:41:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: hurikhan77+bko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-198919-62941-ZMY1AV5AH4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198919-62941@https.bugzilla.kernel.org/>
References: <bug-198919-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=198919

Kai Krakow (hurikhan77+bko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hurikhan77+bko@gmail.com

--- Comment #6 from Kai Krakow (hurikhan77+bko@gmail.com) ---
Yeah, it seems to get worse with every 5.4 LTS update. Worked almost flawless
about some months ago (despite taking something from 30-60s to successfully
connect). But I don't see a correlation to any commits. But now, it's almost
impossible to connect successfully, it usually disconnects after a 1-2 minutes
(coincidentally just when entering a game).

I usually also see messages like this:

During use of the controller (probably around disconnect time):
[ 5304.480502] Bluetooth: Unexpected continuation frame (len 52)

When plugging the BT dongle:
[ 5241.926752] Bluetooth: hci0: unexpected event for opcode 0x0000

While it's in a loop of constantly connecting and disconnecting:
[ 1120.736530] Bluetooth: hci0: hardware error 0x58
[ 1120.923550] debugfs: File 'le_min_key_size' in directory 'hci0' already
present!
[ 1120.923555] debugfs: File 'le_max_key_size' in directory 'hci0' already
present!
[ 1120.923557] debugfs: File 'force_bredr_smp' in directory 'hci0' already
present!

Other BT devices seem to just work fine tho I don't use a lot of them and only
occasionally. It seems that the Xbox One S firmware does something strange in
the BT protocol. It also needs either ERTM disabled to connect. Alternatively,
one can apply this patch to be able to use ERTM:

https://github.com/kakra/linux/commit/c8b24d83f227a7fecfa9420d6756074e8f9b542c

I'm also feeling there's some internal state getting messed up within the
controller on each BT pairing: Results are not really reproducible. I managed
to get it to work flawlessly one time (stable connection despite 20-30s connect
handshake time), then purged my Bluetooth config from /var/lib, re-paired the
controller and now it's a mess - still with the same kernel version.

-- 
You are receiving this mail because:
You are the assignee for the bug.
