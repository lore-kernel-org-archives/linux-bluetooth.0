Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E77C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 13:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiAFNDT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 08:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238944AbiAFNDS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 08:03:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5405FC061245
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 05:03:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ECEBB820D7
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 13:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAE38C36B06
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 13:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641474196;
        bh=RyRPMXVl7AiNpSyjfjMTG/IxVj0Z+M8yegBmm7WGvtg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PDkLuu9SWMoSHb8xZDYnQyPHaj3tdqtLxe8PQ2uo6b5yRSJIl6NkiPgfYki+eleXE
         fIGDMnn/DAMqHYzwKUD9vSlgObmBY+30NrnaE6a02CvttYfcIpZrZzgRU4d85WIu6G
         gVEFGmv4xK1SlJopHzPPuG6t3+bOg0aNdgfis3T+VJeOhU4bgsbQC7zWnhURDUVn2C
         j79r4y2qZInVEKFJ5s56ZIl2OC/1Y9I/ywswZ+I6Cfh8fp2Geh2cCz/L4ap+x8gz9l
         XnFdsrZUbTHYJCoIV00+ubTZlrk3nww1u6EtlRqZ4pYdB/aGeWaO71Hahf26/HD+cW
         GRkjaCpKGtdgA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DB53CC05FDF; Thu,  6 Jan 2022 13:03:15 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Thu, 06 Jan 2022 13:03:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rodomar705@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213829-62941-0moqbCWgPu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213829-62941@https.bugzilla.kernel.org/>
References: <bug-213829-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213829

--- Comment #53 from Marco (rodomar705@protonmail.com) ---
(In reply to Apostolos B. from comment #52)
> > What kind of errors?
>=20
> Some like that:
>=20
> =CE=99=CE=B1=CE=BD 05 18:20:53 mainland bluetoothd[25908]: Loading LTKs t=
imed out for hci0
> =CE=99=CE=B1=CE=BD 05 18:20:53 mainland kernel: Bluetooth: hci0: command =
0x0c52 tx timeout
> =CE=99=CE=B1=CE=BD 05 18:20:55 mainland kernel: Bluetooth: hci0: command =
0x0c24 tx timeout
> =CE=99=CE=B1=CE=BD 05 18:20:57 mainland kernel: Bluetooth: hci0: command =
0x0c1a tx timeout
> =CE=99=CE=B1=CE=BD 05 18:20:59 mainland kernel: Bluetooth: hci0: command =
0x0405 tx timeout
> =CE=99=CE=B1=CE=BD 05 18:20:59 mainland kernel: Bluetooth: hci0: No way t=
o reset. Ignoring
> and continuing
> =CE=99=CE=B1=CE=BD 05 18:21:36 mainland kernel: Bluetooth: hci0: command =
0x0408 tx timeout
> =CE=99=CE=B1=CE=BD 05 18:21:36 mainland kernel: Bluetooth: hci0: No way t=
o reset. Ignoring
> and continuing
>=20
> I think those are the ones that are logged when i cant use the mouse any
> more and need to shutdown completely.
>=20
> Might be usb related since afai understand the bluetooth adapter is
> connected via USB.

Same issues as mine, are you on a Ryzen or Intel?

As far as I have previously debugged, I wasn't unable to pinpoint the cause,
since it was happening randomly also on a Realtek radio, so it was either t=
he
Bluetooth driver or an actual platform issue (but the external USB ports was
still working correctly, therefore I had never been able to find the root
cause).

Marco.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
