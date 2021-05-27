Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ADDC47089
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 20:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CDC613E9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 20:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhE0UPz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 May 2021 16:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235384AbhE0UPy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 May 2021 16:15:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3C74D613E9
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 May 2021 20:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622146461;
        bh=kLoItWplAK+7qeFGWqPuyVciJrrd7bYhNFXCTZwSJ54=;
        h=From:To:Subject:Date:From;
        b=MmVchkQvl9H4B2cQoo64hyhr0gYkArY08NP6m7zOXzD4Zp7HMQh30Neo1BM5GH+p8
         esPMrGCbhIVVpN6tSv0GCeHgM/ytIMwTgZYQ2sa/360UZqpXw9yWBfJ+32y2BsueAQ
         HWd0uLH+mlnHlcHYkAQ8Dr/a1yyf1EoYVcTTGz7LUsH9ZQ1xD17AvclvfU6ibfyLEj
         59VwzIrAMbbb2W9WyPOettnWXBVHFJUWl6RUMKelbP5gLTb9GGpJCgoMMdEkY0JpBe
         vLiDvZPxE4ilfCwu/KT/zblRXMBdQ9291lznhyOBfRIbrfy79u3xK1ZnhJExBkwORf
         g5xFZtuTvLCvg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213245] New: Logitech bluetooth mouse V270 doesn't wake up
 properly on move only on click/roll
Date:   Thu, 27 May 2021 20:14:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: przemo@firszt.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-213245-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213245

            Bug ID: 213245
           Summary: Logitech bluetooth mouse V270 doesn't wake up properly
                    on move only on click/roll
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.12.5
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: przemo@firszt.eu
        Regression: No

Logitech bluetooth mouse V270 connects without problems, all buttons work, =
but
left for a few seconds goes to sleep. Moved comes back to life for a split
second (cursor moves a bit, hcidump shows it goes sniff->active-<sniff). If=
 I
keep clicking or using the roll the mosue works. Olso works when I keep mov=
ing
it. hcidump:
 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 256 mode 0x02 interval 80
    Mode: Sniff <- mouse nit moved
> ACL data: handle 256 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 19]
      HIDP: Data: Input report <- mouse moves for a split second
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 256 mode 0x00 interval 0
    Mode: Active <- mouse moves for a split second
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 256 mode 0x02 interval 80
    Mode: Sniff <- back to sniff mode. cursor stays frozen unless I click or
use roll
Further moving doesn't generate anything in the hcidump log, unless I click=
 or
use roll.
Hardware is intel AX200, firmware loaded properly:
$ dmesg | grep iwlwifi
[    7.819489] iwlwifi 0000:48:00.0: enabling device (0000 -> 0002)
[    7.883697] iwlwifi 0000:48:00.0: api flags index 2 larger than supporte=
d by
driver
[    7.883716] iwlwifi 0000:48:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version:
89.3.35.37
[    7.883962] iwlwifi 0000:48:00.0: loaded firmware version 62.49eeb572.0
cc-a0-62.ucode op_mode iwlmvm
[    8.102109] iwlwifi 0000:48:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz,
REV=3D0x340
[    8.313725] iwlwifi 0000:48:00.0: base HW address: a4:42:3b:f9:38:fa
[    8.332830] iwlwifi 0000:48:00.0 wlp72s0: renamed from wlan0

The mouse works fine on other systems or on android phone. System info:
fedora:/home/przemo
$ rpm -qi bluez | grep Version
Version     : 5.58
fedora:/home/przemo
$ uname -a
Linux fedora 5.12.5-300.fc34.x86_64 #1 SMP Wed May 19 18:03:50 UTC 2021 x86=
_64
x86_64 x86_64 GNU/Linux

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
