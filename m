Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10D1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Jan 2022 15:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiAAPc4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Jan 2022 10:32:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60820 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiAAPc4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Jan 2022 10:32:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFEC960B17
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 15:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B8DCC36AF1
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641051175;
        bh=Q5tcz3wnx0WdSEmNO/w2cpz7PA94cDFIptBYCO2RE7s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=V+fG3bVtdZvMxD+sU7kZXrE5/go1rW5vU/xFx87Ez/p4PwQ5OoE3soPud5NtAZM/b
         +JwklPYPREwaV6fuWNQzxDuJkpoE1ePHaSQozn3VJzUX7WUBX3p/eA7gBli0KCedwP
         saajgP4oMS/kYuRsJI76fRmSkOD5gK2mh5New48JfQ13ZJsZLBjeBInjXIG6frJrF+
         s8C+OG6FGlEtocG8jX940EOhzEgwZxjBTHN1Dx0aScCBdETV0wSigQOkCuZMRVGq3f
         Yt6zzPb+hvgwTzBjHfYyh6t28RP2+bcAfHbno0bWXIWqgqvq7ZcneVwXDBsEv/zh1+
         v6UOKviscewHQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3BB62C05FDE; Sat,  1 Jan 2022 15:32:55 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 01 Jan 2022 15:32:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pverda@ziggo.nl
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-vh3srKdTvf@https.bugzilla.kernel.org/>
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

pverda@ziggo.nl changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pverda@ziggo.nl

--- Comment #208 from pverda@ziggo.nl ---
I have a bluetooth dongle that previously worked but stopped working after a
kernel upgrade (> 5.13.15). The dongle needs module options for btusb:
enable_autosuspend=3D0 reset=3D1. After the dongle stopped working the rele=
vant
error messages in the log file are:
Bluetooth: hci0: CSR: Failed to suspend the device for our Barrot 8041a02
receive-issue workaround
Bluetooth: hci0: setting interface failed (110)
This means that a suspend is causing the problem. Examining the code in btu=
sb.c
shows that there is now a single suspend for all CSR clones: "Because these=
 are
widespread problems we prefer generic solutions; so apply this initializati=
on
quirk to every controller that gets here, it should be harmless. The
alternative is to not work at all." The new code is were the error occurred=
. I
have restored the code from the btusb_setup_csr function with the original =
code
from btusb.c used in kernel 5.13.15 where only the Barrot chip gets this
initialization quirk. After recompiling this module the dongle works without
any problem. The generic solution is therefore not harmless for this
controller.

The information about this dongle is:

idVendor=3D0a12, idProduct=3D0001, bcdDevice=3D25.20
USB device strings: Mfr=3D0, Product=3D2, SerialNumber=3D0
Product: CSR8510 A10

hci0:   Type: Primary  Bus: USB
        BD Address: 00:1A:7D:DA:71:10  ACL MTU: 640:4  SCO MTU: 64:8
        UP RUNNING PSCAN=20
        RX bytes:11673690 acl:19123 sco:0 events:287 errors:0
        TX bytes:9022 acl:184 sco:0 commands:74 errors:0
        Features: 0xff 0xff 0x8f 0xfa 0xdb 0xff 0x5b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
        Link policy: RSWITCH HOLD SNIFF PARK=20
        Link mode: PERIPHERAL ACCEPT=20
        Name: 'DESKTOP'
        Class: 0x000950
        Service Classes: Unspecified
        Device Class: Invalid Device Class!
        HCI Version: 4.0 (0x6)  Revision: 0x3120
        LMP Version: 4.0 (0x6)  Subversion: 0x22bb
        Manufacturer: Cambridge Silicon Radio (10)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
