Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72431C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Mar 2022 13:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347052AbiCON4L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiCON4K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Mar 2022 09:56:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788BD53E09
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 06:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31D7EB8163C
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 13:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED897C34101
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647352496;
        bh=vV9XMAwmXMNPpXcXqnNofuIOXN7IyQ7ZlBABDZj/4a8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=c6sR7efGBeTmwKO9vXKg98UbBfKbqEWJUK+dStoKXKavira/wNSoHg4EWci1Wbkt2
         BplfX4g4fCQY9lVnHLDvOzHkaC5ViFQIPoB4L1S84CefsvcPVdBx3prLwjDN5vyF5r
         fI06/zUCqNcvTsB4KA91F+jvbjU6B/Z5ZCXssHZuo+neLHgwCp/VWzzk+FEBV+4CO5
         uuX6C4OtFdLsGxS9ak/0h8dndJyMK0rEVHqY4sYzbF4I3i7xcCzjgelpqKPvsC0ZoG
         d37WiKH+YP/g53frLXGG7L+hnmWctPt2MauCwCa9D0UuHhRvgoL2cG8RLi2QWXkIOc
         PX6n+X+N2T30A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DB9F7CAC6E2; Tue, 15 Mar 2022 13:54:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Tue, 15 Mar 2022 13:54:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pieroavola@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-re962qHXVy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #30 from Piero Avola (pieroavola@gmail.com) ---
The problem still persists in 5.17-rc8. Bluetooth not working after boot and
the same errors as in the original report:

# dmesg | grep -i bluetooth
> [    4.588660] Bluetooth: hci0: command 0xfc05 tx timeout
> [    4.588666] Bluetooth: hci0: Reading Intel version command failed (-11=
0)

$ uname -r
> 5.17.0-rc8-1-mainline

$ lsusb | grep -i bluetooth
> Bus 001 Device 002: ID 8087:0029 Intel Corp. AX200 Bluetooth

However modprobe -r btusb && modprobe btusb seems to make bluetooth working
again.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
