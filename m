Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43931C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 18:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D0061101
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 18:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344274AbhIGTA1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237636AbhIGTA1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 15:00:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E0D9B61101
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Sep 2021 18:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631041160;
        bh=OapY5dBAVnZfE9gTTi5Y4YvKGLp8PuEnAJh+OMu9KN8=;
        h=From:To:Subject:Date:From;
        b=G9qSToJ6A8o+7+8/odC3XgnCJYUypEMcuFUZiNriEKiIDaaSEEFXqek1PM9PMRx/C
         F0WC5hO52Qd3vDHD79DNrh5musV+1vhQwWDXh0Dm4Zb5U2XVNhBbVH6PieAtG1fPgU
         KdQDJx9yWCQ2oTUmjNn4Hot34S4Fetpzevs/XKDfU6mzt3qwkBZozPwc59MbPUZ1j9
         z4aNxSbAzBgfGu1F4N+le79UpyvweGTlt0dmm9l4eo4z0jAjMi2uNUL/dEWqJJKZQo
         gyV60Y4114Kb9vKM6P48dopyOFES8D6dWdj+IEI7vTTDWtQlZmldb0r9V/3CI3d8Ju
         G7hfnaf7CgNIg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214345] New: Bluetooth does not work, which worked earlier
Date:   Tue, 07 Sep 2021 18:59:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: kiran.telukunta@indiayouth.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214345-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214345

            Bug ID: 214345
           Summary: Bluetooth does not work, which worked earlier
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.13.9-100.fc33.x86_64, 5.13.10-100.fc33.x86_64,
                    5.13.12-100.fc33.x86_64
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: kiran.telukunta@indiayouth.info
        Regression: No

I have following model of bluetooth dongle:


Bus 005 Device 004: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Don=
gle
(HCI mode)

and produces following failed mode status:

sudo systemctl status bluetooth
=E2=97=8F bluetooth.service - Bluetooth service
     Loaded: loaded (/usr/lib/systemd/system/bluetooth.service; enabled; ve=
ndor
preset: enabled)
     Active: active (running) since Tue 2021-09-07 20:34:23 CEST; 16min ago
       Docs: man:bluetoothd(8)
   Main PID: 1023 (bluetoothd)
     Status: "Running"
      Tasks: 1 (limit: 38343)
     Memory: 2.2M
        CPU: 27ms
     CGroup: /system.slice/bluetooth.service
             =E2=94=94=E2=94=801023 /usr/libexec/bluetooth/bluetoothd

Sep 07 20:34:23 saraswathi bluetoothd[1023]: Failed to set mode: Blocked
through rfkill (0x12) <<<<<<<<<<<<<<-----------------------
Sep 07 20:34:48 saraswathi bluetoothd[1023]: Endpoint registered: sender=3D=
:1.214
path=3D/MediaEndpoint/A2DPSource/VENDOR/LDAC
Sep 07 20:34:48 saraswathi bluetoothd[1023]: Endpoint registered: sender=3D=
:1.214
path=3D/MediaEndpoint/A2DPSource/VENDOR/APTXHD
Sep 07 20:34:48 saraswathi bluetoothd[1023]: Endpoint registered: sender=3D=
:1.214
path=3D/MediaEndpoint/A2DPSource/VENDOR/APTX
Sep 07 20:34:48 saraswathi bluetoothd[1023]: Endpoint registered: sender=3D=
:1.214
path=3D/MediaEndpoint/A2DPSource/AAC
Sep 07 20:34:48 saraswathi bluetoothd[1023]: Endpoint registered: sender=3D=
:1.214
path=3D/MediaEndpoint/A2DPSource/SBC
Sep 07 20:34:48 saraswathi bluetoothd[1023]: Endpoint registered: sender=3D=
:1.214
path=3D/MediaEndpoint/A2DPSink/VENDOR/APTXHD
Sep 07 20:34:48 saraswathi bluetoothd[1023]: Endpoint registered: sender=3D=
:1.214
path=3D/MediaEndpoint/A2DPSink/VENDOR/APTX
Sep 07 20:34:48 saraswathi bluetoothd[1023]: Endpoint registered: sender=3D=
:1.214
path=3D/MediaEndpoint/A2DPSink/AAC
Sep 07 20:34:48 saraswathi bluetoothd[1023]: Endpoint registered: sender=3D=
:1.214
path=3D/MediaEndpoint/A2DPSink/SBC



The dongle is not getting connected in the following kernel versions:
5.13.9-100.fc33.x86_64
5.13.10-100.fc33.x86_64
5.13.12-100.fc33.x86_64

It worked couple of months before so it should be working in the kernel
kernel-5.13.6-0.=20

Let me know if you need any other information.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
