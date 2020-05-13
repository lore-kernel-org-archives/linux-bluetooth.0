Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 16:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AEC20708
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 16:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbgEMQv6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 12:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55619 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbgEMQv6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 12:51:58 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 207629] BISECTED Bluetooth: hci0: command 0x2042 tx timeout -
 suspend fails - Dell XPS 9300
Date:   Wed, 13 May 2020 16:51:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: abhishekpandit@chromium.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207629-62941-tY6652KYm0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207629-62941@https.bugzilla.kernel.org/>
References: <bug-207629-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207629

--- Comment #14 from Abhishek Pandit-Subedi (abhishekpandit@chromium.org) ---
Ok -- this one is not a systemic problem as I predicted. This looks to be the
controller not responding to a specific command. In the logs below, the
controller is responding to everything except for 0x2042 and even that is
intermittent (responds to some 0x2042 but not others).

So this is increasingly starting to look like a controller firmware problem.
Looks like the Dell XPS 9300 uses an Intel AX wifi+bt chipset. You're using
firmware from 2019 and there's been several updates in the past few months.

Could you try a newer firmware to see if this is still happening? The latest
update was in April:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=c5ac1add86be7a90d0c573c957e37c610f3d7f25

If you can still repro it w/ new firmware, could you collect an hci trace when
it occurs?
`btmon -w <file location>` will collect the trace.

--
[  855.188312] PM: Preparing system for sleep (s2idle)
[  855.188792] hci0 opcode 0x0c1a plen 1
[  855.188793] skb len 4
[  855.188794] hci0 opcode 0x2042 plen 6
[  855.188795] skb len 9
[  855.188795] length 2
[  855.188799] hci0 cmd_cnt 1 cmd queued 2
[  855.188801] hci0 type 1 len 4
[  855.327410] hci0
[  855.327412] hci0 Event packet
[  855.327414] hci0 status 0x00
[  855.327415] hci0 opcode 0x0c1a
[  855.327416] opcode 0x0c1a status 0x00
[  855.327417] hci0 opcode 0x0c1a
[  855.327421] hci0 cmd_cnt 1 cmd queued 1
[  855.327422] hci0 type 1 len 9
[  855.352390] hci0
[  855.352391] hci0 Event packet
[  855.352392] hci0 status 0x00
[  855.352392] hci0 opcode 0x2042
[  855.352393] opcode 0x2042 status 0x00
[  855.352394] hci0 opcode 0x2042
[  855.352394] hci0: Request complete opcode=0x2042, status=0x0

# Notice that 0x2042 completes successfully

[  855.352407] hci0 opcode 0x0c05 plen 1
[  855.352408] skb len 4
[  855.352409] hci0 opcode 0x0c1a plen 1
[  855.352410] skb len 4
[  855.352411] hci0 opcode 0x2042 plen 6
[  855.352411] skb len 9
[  855.352412] hci0: LE passive scan with whitelist = 1
[  855.352412] hci0 opcode 0x2041 plen 8
[  855.352413] skb len 11
[  855.352413] hci0 opcode 0x2042 plen 6
[  855.352413] skb len 9
[  855.352414] length 5
[  855.352416] hci0 cmd_cnt 1 cmd queued 5
[  855.352417] hci0 type 1 len 4
[  855.353392] hci0
[  855.353392] hci0 Event packet
[  855.353394] hci0 opcode 0x0c05
[  855.353394] opcode 0x0c05 status 0x00
[  855.353395] hci0 opcode 0x0c05
[  855.353398] hci0 cmd_cnt 1 cmd queued 4
[  855.353398] hci0 type 1 len 4
[  855.354342] hci0
[  855.354343] hci0 Event packet
[  855.354343] hci0 status 0x00
[  855.354344] hci0 opcode 0x0c1a
[  855.354344] opcode 0x0c1a status 0x00
[  855.354345] hci0 opcode 0x0c1a
[  855.354346] hci0 cmd_cnt 1 cmd queued 3
[  855.354347] hci0 type 1 len 9
[  857.354012] hci0: Timed out waiting for suspend

# An early timeout in the suspend path

[  857.354014] hci0: Bit 5 is set
[  857.354096] hci0 opcode 0x0c05 plen 1
[  857.354098] skb len 4
[  857.354099] hci0 opcode 0x2042 plen 6
[  857.354099] skb len 9
[  857.354100] hci0: LE passive scan with whitelist = 1
[  857.354101] hci0 opcode 0x2041 plen 8
[  857.354101] skb len 11
[  857.354101] hci0 opcode 0x2042 plen 6
[  857.354102] skb len 9
[  857.354102] length 4
[  857.354107] hci0 cmd_cnt 0 cmd queued 6
[  857.385937] Bluetooth: hci0: command 0x2042 tx timeout
[  857.385938] Bluetooth: hci0: No way to reset. Ignoring and continuing

# Enabling passive scan failed

[  857.385941] hci0 cmd_cnt 1 cmd queued 6
[  857.385943] hci0 type 1 len 11
[  857.386342] hci0
[  857.386342] hci0 Event packet
[  857.386344] hci0 status 0x00
[  857.386344] hci0 opcode 0x2041
[  857.386345] opcode 0x2041 status 0x00
[  857.386345] hci0 opcode 0x2041
[  857.386347] hci0 cmd_cnt 1 cmd queued 5
[  857.386348] hci0 type 1 len 9
[  857.388421] hci0
[  857.388422] hci0 Event packet
[  857.388423] hci0 status 0x00
[  857.388424] hci0 opcode 0x2042
[  857.388425] opcode 0x2042 status 0x00
[  857.388425] hci0 opcode 0x2042
[  857.388428] hci0: Request complete opcode=0x2042, status=0x0

# 0x2042 completes successfully again

[  857.388431] hci0 cmd_cnt 1 cmd queued 4
[  857.388431] hci0 type 1 len 4
[  857.389383] hci0
[  857.389384] hci0 Event packet
[  857.389385] hci0 opcode 0x0c05
[  857.389386] opcode 0x0c05 status 0x00
[  857.389386] hci0 opcode 0x0c05
[  857.389389] hci0 cmd_cnt 1 cmd queued 3
[  857.389390] hci0 type 1 len 9
[  857.400353] hci0
[  857.400355] hci0 Event packet
[  857.400357] hci0 status 0x00
[  857.400358] hci0 opcode 0x2042
[  857.400359] opcode 0x2042 status 0x00
[  857.400359] hci0 opcode 0x2042
[  857.400363] hci0 cmd_cnt 1 cmd queued 2
[  857.400365] hci0 type 1 len 11
[  857.401330] hci0
[  857.401332] hci0 Event packet
[  857.401333] hci0 status 0x00
[  857.401334] hci0 opcode 0x2041
[  857.401334] opcode 0x2041 status 0x00
[  857.401335] hci0 opcode 0x2041
[  857.401337] hci0 cmd_cnt 1 cmd queued 1
[  857.401338] hci0 type 1 len 9
[  857.403349] hci0
[  857.403349] hci0 Event packet
[  857.403350] hci0 status 0x00
[  857.403351] hci0 opcode 0x2042
[  857.403351] opcode 0x2042 status 0x00
[  857.403352] hci0 opcode 0x2042
[  857.403353] hci0: Request complete opcode=0x2042, status=0x0
[  857.429909] PM: suspend exit

-- 
You are receiving this mail because:
You are the assignee for the bug.
