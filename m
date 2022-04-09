Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5276C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Apr 2022 22:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiDIWIl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Apr 2022 18:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiDIWIl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Apr 2022 18:08:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1788330
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Apr 2022 15:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8851F60DED
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Apr 2022 22:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAC10C385B7
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Apr 2022 22:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649541992;
        bh=fTfTWgdBS66Vz1O1Jr4P6Tm6zPxLF6vQdgYzpTInrws=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nKya+uZbZ5h17Iht4f+pReMkrUohJOkGFS2xxTkzg1FUQB/4DSnkgwlrug2LGxntg
         1A0lio4TwHvbDHVVPk6/ejQFktnqzZKw7KUt0/BT/BtGRDymMHpmC+JJwb5H880ctz
         eylxM64NAN7rocSFN0ciucXwWp9iTyLQzfS95WZMteekwVKql+jsn+1tenWebZoFc4
         EAIj10rxNAPzaGWBN1dkxIiz/yChqaQGcpDp/sFd8ap9D1tDh+rw2dEDqqzIdUo+Xc
         jSGWJY7xq1seJCV7XRvR6AQB0VJLsFGf+BVc1sbfHobwDLYafck2lGpTaYbgCXqEg3
         brBZdEbLLCDmg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DB6BFC05FD2; Sat,  9 Apr 2022 22:06:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Sat, 09 Apr 2022 22:06:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sergiotca@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-rTuyGPDKry@https.bugzilla.kernel.org/>
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

--- Comment #34 from Sergio Torres (sergiotca@gmail.com) ---
I believe I might be experiencing the same issue with my GIGABYTE B450 AORUS
PRO WIFI under Manajaro:

uname -r
>5.16.14-1-MANJARO

lsusb | grep -i bluetooth
>Bus 001 Device 002: ID 8087:0aa7 Intel Corp. Wireless-AC 3168 Bluetooth

sudo lsmod | grep bt
>btusb                  65536  0
>btrtl                  28672  1 btusb
>btbcm                  24576  1 btusb
>btintel                45056  1 btusb
>bluetooth             770048  43 btrtl,btintel,btbcm,bnep,btusb,rfcomm

sudo dmesg | grep -i bluetooth=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
                  >[    4.296518] Bluetooth: Core ver 2.22
>[    4.296529] NET: Registered PF_BLUETOOTH protocol family
>[    4.296530] Bluetooth: HCI device and connection manager initialized
>[    4.296532] Bluetooth: HCI socket layer initialized
>[    4.296533] Bluetooth: L2CAP socket layer initialized
>[    4.296535] Bluetooth: SCO socket layer initialized
>[    4.334693] Bluetooth: hci0: Legacy ROM 2.x revision 5.0 build 25 week =
20
>2015
>[    4.334695] Bluetooth: hci0: Intel device is already patched. patch num=
: 3c
>[    4.405834] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>[    4.405835] Bluetooth: BNEP filters: protocol multicast
>[    4.405837] Bluetooth: BNEP socket layer initialized
>[   16.384308] Bluetooth: RFCOMM TTY layer initialized
>[   16.384314] Bluetooth: RFCOMM socket layer initialized
>[   16.384317] Bluetooth: RFCOMM ver 1.11
>[   18.557782] Bluetooth: hci0: command 0x0c24 tx timeout
>[   20.691116] Bluetooth: hci0: command 0x0c52 tx timeout

Using rmmod btusb and modprobe btusb solves the issue for the rest of the
session.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
