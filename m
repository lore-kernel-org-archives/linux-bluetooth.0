Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9715C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 13:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiCVNjv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiCVNjo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 09:39:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1F511C0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 06:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3429561566
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 13:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DA1FC340EE
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647956295;
        bh=Qh2KRi9BF3C477ftq3vS7JQJM+4W0dmt5J3I3LAQH0s=;
        h=From:To:Subject:Date:From;
        b=mInO3CeFZT+VFkOFR3x0id6CKRr1pICZ7uTt/um92r3rlcduvegYhjsHmOPH+DBav
         +FQAObkCAn88yjurvKw32earX3pELjqooWWGxl5mWEka1xSWodswY8QPqtdeyz0Y3T
         ke6+V97kga19BFlDSh1rAwfBvPfIH7aiG3CcTh5BhFoXMPYjuNRrXW36DmTaINY/Fg
         InzIi7AbbgwkYz3zMYh5csIdJR8ooe2uLR8kavJw6A2Z8YfTsmKpJkMdLR2wV6zqIu
         pMG/QfhBGtCls1mK1O6FkbyUwFX9c8DjtMksHSRB9RkIsEVAwEhtMbtVxz/L6CyXT8
         GX0Tm0uFa6SGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7E4DBC05FCE; Tue, 22 Mar 2022 13:38:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215725] New: Basilisk X Hyperspeed Bluetooth LE mouse fail to
 connect under 5.17 with Opcode 0x2043 failure
Date:   Tue, 22 Mar 2022 13:38:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: winstonwu91@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215725-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215725

            Bug ID: 215725
           Summary: Basilisk X Hyperspeed Bluetooth LE mouse fail to
                    connect under 5.17 with Opcode 0x2043 failure
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.17
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: winstonwu91@gmail.com
        Regression: No

I am using AX201 wireless card (lsusb shows Bus 001 Device 004: ID 8087:0026
Intel Corp. AX201 Bluetooth) and the mouse stopped working with bluetooth m=
ode
under 5.17. 5.16 does not have such problem.

dmesg:
[    2.341184] Bluetooth: Core ver 2.22
[    2.341206] Bluetooth: HCI device and connection manager initialized
[    2.341209] Bluetooth: HCI socket layer initialized
[    2.341210] Bluetooth: L2CAP socket layer initialized
[    2.341213] Bluetooth: SCO socket layer initialized
[    2.553340] Bluetooth: hci0: Found device firmware: intel/ibt-19-0-4.sfi
[    2.553425] Bluetooth: hci0: Boot Address: 0x24800
[    2.553427] Bluetooth: hci0: Firmware Version: 126-5.22
[    2.553428] Bluetooth: hci0: Firmware already loaded
[    2.589714] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    2.589716] Bluetooth: BNEP filters: protocol multicast
[    2.589719] Bluetooth: BNEP socket layer initialized
[    6.742276] Bluetooth: hci0: Opcode 0x2043 failed: -110
[    6.742288] Bluetooth: hci0: request failed to create LE connection: err
-110
[    6.872510] Bluetooth: hci0: ACL packet for unknown connection handle 35=
86
[    6.872587] Bluetooth: hci0: ACL packet for unknown connection handle 35=
86
[    6.872663] Bluetooth: hci0: ACL packet for unknown connection handle 35=
86
...(repeat)
[   21.535407] Bluetooth: RFCOMM TTY layer initialized
[   21.535414] Bluetooth: RFCOMM socket layer initialized
[   21.535418] Bluetooth: RFCOMM ver 1.11

journalctl -b -u bluetooth:

3=E6=9C=88 22 09:15:37 darenguodu systemd[1]: Starting Bluetooth service...
3=E6=9C=88 22 09:15:37 darenguodu bluetoothd[618]: Bluetooth daemon 5.64
3=E6=9C=88 22 09:15:37 darenguodu bluetoothd[618]: src/main.c:check_config(=
) Unknown
group Controller in /etc/bluetooth/main.conf
3=E6=9C=88 22 09:15:37 darenguodu systemd[1]: Started Bluetooth service.
3=E6=9C=88 22 09:15:37 darenguodu bluetoothd[618]: Starting SDP server
3=E6=9C=88 22 09:15:37 darenguodu bluetoothd[618]: Bluetooth management int=
erface 1.21
initialized
3=E6=9C=88 22 09:15:37 darenguodu bluetoothd[618]: Failed to set mode: Busy=
 (0x0a)
3=E6=9C=88 22 09:15:38 darenguodu bluetoothd[618]:
profiles/battery/battery.c:parse_battery_level() Trying to update an
unregistered battery
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Player registered: sende=
r=3D:1.56
path=3D/media_player0
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSource/ldac
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSink/aptx_hd
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSource/aptx_hd
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSink/aptx
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSource/aptx
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSource/aac
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSink/sbc
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSource/sbc
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSink/sbc_xq
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSource/sbc_xq
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSource/aptx_ll_1
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSource/aptx_ll_0
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSource/aptx_ll_duplex_1
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSource/aptx_ll_duplex_0
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSource/faststream
3=E6=9C=88 22 09:15:56 darenguodu bluetoothd[618]: Endpoint registered: sen=
der=3D:1.56
path=3D/MediaEndpoint/A2DPSource/faststream_duplex
3=E6=9C=88 22 09:16:03 darenguodu bluetoothd[618]: src/profile.c:record_cb(=
) Unable to
get Hands-Free Voice gateway SDP record: Host is down

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
