Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B8DC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Dec 2022 12:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiLRM2g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Dec 2022 07:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiLRM2f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Dec 2022 07:28:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5817AB488
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Dec 2022 04:28:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EACE0B80939
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Dec 2022 12:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A78ACC433EF
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Dec 2022 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671366510;
        bh=8VTKWumlqvJQTFhOrTDJbEV+9OxSUrBA2Q6YZuC6Wt4=;
        h=From:To:Subject:Date:From;
        b=FkMAIg+k615v3+8oehrafEVkVUzq71T0gf1ws0YTmo4/nl4Rzox/jTRvNLeSNmGQj
         xfQd1PftrhFWYCVADEAuWldDuNTYoMsmVxWaDEAuXvbguXgpusndDVv2/dubnGzG1i
         ik5cfKDTy3P5InX6cqcqL7FktHT2rKtUnEOLXggbqvA/yDNuZtXFBzRXqKs8G/dMrv
         NryRU69vlsB+cWe4YoGuI5gnIIPcs/NIISMqbGF9L6baBDru1qFeHYMARMPZBN4uac
         2BG2i81lQvXjE4xfzqMTLQCthXSJf9At0/KAcoDhbg0IFtGcMBTugx960RyzrZVSQ5
         nXvrrIqpenV8g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8CDF2C43142; Sun, 18 Dec 2022 12:28:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216819] New: kernel detects Mediatek bluetooth as Lite-On and
 not working
Date:   Sun, 18 Dec 2022 12:28:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: baxooshi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216819-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216819

            Bug ID: 216819
           Summary: kernel detects Mediatek bluetooth as Lite-On and not
                    working
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.19.0-26-generic
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: baxooshi@gmail.com
        Regression: No

I have an Acer Aspire3 A315-59G laptop. It has Mediatek bluetooth and wifi.
wifi works good, even better than how it works on Windows. But the bluetooth
does not work.=20
I also tested it on fedora with kernel 6.0.7 and 6.0.12 and did not worked
either

systemctl status bluetooth.service
=E2=97=8F bluetooth.service - Bluetooth service
     Loaded: loaded (/lib/systemd/system/bluetooth.service; enabled; preset:
enabled)
     Active: active (running) since Sun 2022-12-18 13:19:40 +0330; 2h 14min=
 ago
       Docs: man:bluetoothd(8)
   Main PID: 964 (bluetoothd)
     Status: "Running"
      Tasks: 1 (limit: 28404)
     Memory: 1.8M
        CPU: 30ms
     CGroup: /system.slice/bluetooth.service
             =E2=94=94=E2=94=80964 /usr/lib/bluetooth/bluetoothd

Dec 18 13:19:40 ws systemd[1]: Starting Bluetooth service...
Dec 18 13:19:40 ws systemd[964]: ConfigurationDirectory 'bluetooth' already
exists but the mode is different. (File system: 755 ConfigurationDirectoryM=
ode:
555)
Dec 18 13:19:40 ws bluetoothd[964]: Bluetooth daemon 5.65
Dec 18 13:19:40 ws bluetoothd[964]: Starting SDP server
Dec 18 13:19:40 ws systemd[1]: Started Bluetooth service.
Dec 18 13:19:40 ws bluetoothd[964]: Bluetooth management interface 1.22
initialized



lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 0408:4033 Quanta Computer, Inc. ACER HD User Facing
Bus 001 Device 002: ID 1ea7:0064 SHARKOON Technologies GmbH 2.4GHz Wireless
rechargeable vertical mouse [More&Better]
Bus 001 Device 004: ID 04ca:3801 Lite-On Technology Corp. Wireless_Device
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Windows .inf file for that hardware
%Generic.DeviceDesc%            =3D MTKBT,=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
USB\VID_04CA&PID_3801&MI_00

rfkill list
0: acer-wireless: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: acer-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
2: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no
3: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
