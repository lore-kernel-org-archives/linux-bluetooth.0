Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B66C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 03:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFBD610A7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 03:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhHMDjp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Aug 2021 23:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233750AbhHMDjo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Aug 2021 23:39:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B6286610EA
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 03:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628825958;
        bh=XKVK9AKBvPi8sk476ZPFsT2fj8lv1PbkQEoXwEzTNM8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QI2zet7z5ceGiPD98SqF6Z12FHITD/b6JJvWbd9o9hdlq3kheVBqgqGEBBE9vIgoo
         1lSdVtm11lG418iUzCcBmqnZBaH+Ere8A7JDXIYCSAOSQ5SMCDE9ZeHzu4cWFRhgis
         Qa2GuQKS0wnx93m6WwaZFBOTtcSrAf0QyoFvy8ZxGy9NOfuzEojCx2D5iGC6Xtdr5O
         NLAtbGT1iC4jsPPT8Q6N1h7o1Pfcc1xop7KR4YNbrKivzeSqiBTNf/7kwVQiGTi6im
         tJTBIp5rYeWJXofoEXVRIgHs+3fwyX3lW1Z7TJhJxDijz1Gm2J51EQbWynfCcwbi38
         1x53rt2MTLaTA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 13 Aug 2021 03:39:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yrds96@protonmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-I4WYIklXI1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #193 from Yuri Santos (yrds96@protonmail.com) ---
I did new tests (In reply to Swyter from comment #191)
> Good to hear. The force-suspend-for-everyone patch has landed on linux-ne=
xt:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/
> ?id=3Df4292e2faf522f899b642d2040a2edbcbd455b9f
>=20
> So that only leaves the `HCI_FLT_CLEAR_ALL` thing to do, so far. Maybe
> someone else wants to tackle this one. I don't mind, but sending
> not-so-thoroughly tested patches for things I can't verify directly is a =
bit
> eh.
>=20
> @Jay, does it work fine with just the first patch? That's important.
>=20
> Also please post your `hciconfig -a` *or* 'Read Local Version Information'
> packet from your `btmon -w my.log` as shown here:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D60824#c119
>=20
> We're interested in the HCI Version / Revision and LMP Version / Subversi=
on
> fields, which don't appear in your lsusb dumps, and show what really makes
> your dongle unique.
>=20
> Thanks a lot, guys.

I did new tests but unfortunately doesn't work yet, but give better results
since my last test few months ago, look my logs from btmon -w and lsusb -v:

https://gist.github.com/Yrds/6eca36c188c822bab33ef99630dace5b

I can do more tests with new incoming patches.

Thank you for the patches, it improved a lot.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
