Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FA7CCA473
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jun 2022 10:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345987AbiFOKMz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbiFOKMs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jun 2022 06:12:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB1C13F87
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 03:12:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D010960C6B
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 10:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CE6CC36AF2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 10:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655287965;
        bh=1QUvHdzQS7063zB4YE/tzivDmMJUdH+4X7kJ1wJFEes=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cWQEd9+Mi5jqnl/mfrsDlajgXHcX9cT+J6tyCGquC2fqSpP1fVM6eOcZadEqvI2Jz
         N77/mdU4iAn+6Gam2fO548KEHeFajK/162pTsObV7SHriQ0G7aWc5ZpsGsTtvN+/gB
         nLeem3okwgn1+jtQyd/xtYX9mqKZX5Cpf9IC4jJ7N1ieYcsvNI5mKGFkBTW6bopijj
         S3mEOKgLbE0L5sFGOI3COx1Q4r+gWC0pgq4x5cdx4umrG7frlV0MsjX6nZkkYcbL1i
         dBVyCCNaAsWG05diBqckMa2zTlom668wuqo9C0qJs9qaIqSfJvr94NTflDveczjx61
         zsNlA4L/AD2lQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2B6F8CC13B4; Wed, 15 Jun 2022 10:12:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Wed, 15 Jun 2022 10:12:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jmennius@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-6otTn4D8R1@https.bugzilla.kernel.org/>
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

--- Comment #37 from Ievgen Popovych (jmennius@gmail.com) ---
So I was trying to reproduce, kept the trace running for a few days or more,
but then it never happened and I've stopped tracing.
Now it happened again, on Fedora kernel 5.17.11, when waking up from suspen=
d.
As I am looking though the logs there were total of 4 occurrences of "Readi=
ng
Intel version command failed", but I think only today I've noticed BT not
working and having to do the rmmod dance (few times to fix it).

> Jun 15 10:19:54 ievgen-xps kernel: Bluetooth: hci0: Opcode 0x c01 failed:
> -110
> Jun 15 10:19:54 ievgen-xps kernel: Bluetooth: hci0: command 0x0c01 tx tim=
eout
> Jun 15 10:19:56 ievgen-xps systemd-sleep[311042]: System returned from sl=
eep
> state.
> Jun 15 10:19:56 ievgen-xps bluetoothd[876]: Controller resume with wake e=
vent
> 0x0
> Jun 15 10:19:56 ievgen-xps kernel: Bluetooth: hci0: command 0x0c1a tx tim=
eout
> Jun 15 10:19:56 ievgen-xps kernel: Bluetooth: hci0: Opcode 0x c1a failed:
> -110
> Jun 15 10:19:56 ievgen-xps kernel: PM: suspend exit
> Jun 15 10:19:56 ievgen-xps systemd[1]: Starting systemd-rfkill.service -
> Load/Save RF Kill Switch Status...
> Jun 15 10:19:56 ievgen-xps systemd[1]: Stopped target bluetooth.target -
> Bluetooth Support.
> Jun 15 10:19:56 ievgen-xps systemd[1665]: Stopped target bluetooth.target=
 -
> Bluetooth.
> Jun 15 10:19:56 ievgen-xps systemd[1]: Started systemd-rfkill.service -
> Load/Save RF Kill Switch Status.
> Jun 15 10:19:56 ievgen-xps kernel: usb 1-4: new full-speed USB device num=
ber
> 39 using xhci_hcd
> Jun 15 10:19:56 ievgen-xps kernel: usb 1-4: New USB device found,
> idVendor=3D8087, idProduct=3D0029, bcdDevice=3D 0.01
> Jun 15 10:19:56 ievgen-xps kernel: usb 1-4: New USB device strings: Mfr=
=3D0,
> Product=3D0, SerialNumber=3D0
> Jun 15 10:19:56 ievgen-xps upowerd[902]: treating change event as add on
> /sys/devices/pci0000:00/0000:00:14.0/usb1/1-4
> Jun 15 10:19:56 ievgen-xps systemd[1]: Reached target bluetooth.target -
> Bluetooth Support.
> Jun 15 10:19:56 ievgen-xps systemd[1665]: Reached target bluetooth.target=
 -
> Bluetooth.
...
> Jun 15 10:19:58 ievgen-xps kernel: Bluetooth: hci0: command 0xfc05 tx tim=
eout
> Jun 15 10:19:58 ievgen-xps kernel: Bluetooth: hci0: Reading Intel version
> command failed (-110)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
