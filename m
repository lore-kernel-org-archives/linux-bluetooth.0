Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701C8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 08:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiBIIve (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 03:51:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiBIIvd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 03:51:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A42E019D01
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 00:51:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBD4961956
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 08:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4580EC340F8
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 08:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644396528;
        bh=l/QHMM4RnWbZMN5ovcuJK4yMCCPDKczrdXYgcw5QyFI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DGtRQEouO0jlQuNwzRVEODYmiyTj7NmwAv0q5V4NwgUe18iKU6sJ3HDkvVDhFLEd+
         JG6Iaf4fa8tF2kp8vAjqs1dkILW4tRD4psgFHrRvRGzDE+g2DgipqunK8YG7W5rZst
         T/duLxlHIsmNKXwrgvg3FqoNzRszBCHPiI1FTckMBGG8qBpyShmOc0e++KAxFoqdeb
         UhsA/gjhGr+hlQ/LUd2thNuYxTRp+9BugTbDt5jEwFSxKbSSBZP2PbrDCuQbLzWp3K
         TpEiyg3LYyxiwR974ogJl/uFyNZ50iUcyq6s82tTHT9m1+9ETxC/c1VuUizcwEgIJ7
         5ajbuMSIpgA7Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3583EC05FD2; Wed,  9 Feb 2022 08:48:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Wed, 09 Feb 2022 08:48:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kvaster@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-BlKrIzA7RT@https.bugzilla.kernel.org/>
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

Viktor Kuzmin (kvaster@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kvaster@gmail.com

--- Comment #26 from Viktor Kuzmin (kvaster@gmail.com) ---
My hardware: Dell XPS 7590

Device ID 8087:0029 Intel Corp. AX200 Bluetooth

With linux kernel 5.16.7. By default sometimes bluetooth works and sometimes
after reboot or after suspend/resume I have:

Bluetooth: hci0: command 0xfc05 tx timeout

File: drivers/bluetooth/btusb.c
Function: btusb_qca_cmd_timeout

If I disable 'reset_gpio' or change 'msleep(200)' to 'msleep(500)' then
bluetooth is working and I have:

[   10.195266] Bluetooth: Core ver 2.22
[   10.197208] Bluetooth: HCI device and connection manager initialized
[   10.197211] Bluetooth: HCI socket layer initialized
[   10.197213] Bluetooth: L2CAP socket layer initialized
[   10.197216] Bluetooth: SCO socket layer initialized
[   10.309387] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[   10.309454] Bluetooth: hci0: Boot Address: 0x24800
[   10.309457] Bluetooth: hci0: Firmware Version: 125-46.21
[   10.309459] Bluetooth: hci0: Firmware already loaded
[   10.364049] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.364053] Bluetooth: BNEP filters: protocol multicast
[   10.364057] Bluetooth: BNEP socket layer initialized
[   10.370006] Bluetooth: hci0: Failed to read codec capabilities (-56)
[   10.371010] Bluetooth: hci0: Failed to read codec capabilities (-56)
[   10.372073] Bluetooth: hci0: Failed to read codec capabilities (-56)
[   10.373040] Bluetooth: hci0: Failed to read codec capabilities (-56)
[   10.374004] Bluetooth: hci0: Failed to read codec capabilities (-56)
[   10.375026] Bluetooth: hci0: Failed to read codec capabilities (-56)
[   10.376009] Bluetooth: hci0: Failed to read codec capabilities (-56)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
