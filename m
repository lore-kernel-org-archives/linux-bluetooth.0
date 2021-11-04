Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C42EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 11:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CAB6120F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 11:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhKDLMj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231365AbhKDLMi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Nov 2021 07:12:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AF9CF611C9
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Nov 2021 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636024200;
        bh=inxcjaPkVcj1sp+tcFTar+PKynq9upmLqqDhuaxPf+s=;
        h=From:To:Subject:Date:From;
        b=jZ/D6NQYsn5xkvvGSD2yr5gIOxhaEdmppR3F7Lbyd3ITgsYeHLMMLOtzd8IIWQsY5
         38pVlNQeTvfXmNuLOvwGMcnUFFLrKteWylvICJmILu2XDDkQc0w7f41PGAaaeMOyCP
         SsQ+cggo1wyJs1WcQV/CyoGQH2+yC7UH7HuQUvK85XxCLT+2EMcSa0syosjWXGpuZC
         chyIoaXuza0jyYsellpVZ88JhZhrUG1YsV10Aqxed0aUfz6qoq6b9JASnsb08j2U9G
         3sKlNgD5DXsT+wNSsCPw9KuQ3mM96UHxpJNH7uDOwg10EGvLml/ZDskfLNJgmOVgGF
         RCY5sxFsWkWew==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214943] New: Issue Microphone Bluetooth is not detect
Date:   Thu, 04 Nov 2021 11:10:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sergio@iskynet.es
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214943-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214943

            Bug ID: 214943
           Summary: Issue Microphone Bluetooth is not detect
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.11.0.-38-generic
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: sergio@iskynet.es
        Regression: No

SUMMARY
I have a bluetooth headset connect to my PC.=20

It is connect ok. I can listen audio but the microphone is not detect by KD=
E.
On the other hand, the browsers detecting the microphone but it don't work =
it.

--------------------------------------

$pactl list | grep -i bluetooth=20
        Nombre: module-bluetooth-policy
                module.description =3D "Policy module to make using bluetoo=
th
devices out-of-the-box easier"
        Nombre: module-bluetooth-discover
                module.description =3D "Detect available Bluetooth daemon a=
nd
load the corresponding discovery module"
                module.description =3D "Detect available BlueZ 5 Bluetooth =
audio
devices and load BlueZ 5 Bluetooth audio drivers"
                module.description =3D "BlueZ 5 Bluetooth audio sink and so=
urce"
        Descripci=C3=B3n: Mi Bluetooth Headset Basic
                bluetooth.protocol =3D "a2dp_sink"
                device.description =3D "Mi Bluetooth Headset Basic"
                device.bus =3D "bluetooth"
                bluez.alias =3D "Mi Bluetooth Headset Basic"
                device.icon_name =3D "audio-headset-bluetooth"
        Descripci=C3=B3n: Monitor of Mi Bluetooth Headset Basic
                device.description =3D "Monitor of Mi Bluetooth Headset Bas=
ic"
                device.bus =3D "bluetooth"
                bluez.alias =3D "Mi Bluetooth Headset Basic"
                device.icon_name =3D "audio-headset-bluetooth"
                device.description =3D "Mi Bluetooth Headset Basic"
                device.bus =3D "bluetooth"
                bluez.alias =3D "Mi Bluetooth Headset Basic"
                device.icon_name =3D "audio-headset-bluetooth"

--------------------------------------

$pacmd list-cards
index: 3
        name: <bluez_card.E8_EC_A3_1E_69_88>
        driver: <module-bluez5-device.c>
        owner module: 29
        properties:
                device.description =3D "Mi Bluetooth Headset Basic"
                device.string =3D "E8:EC:A3:1E:69:88"
                device.api =3D "bluez"
                device.class =3D "sound"
                device.bus =3D "bluetooth"
                device.form_factor =3D "headset"
                bluez.path =3D "/org/bluez/hci0/dev_E8_EC_A3_1E_69_88"
                bluez.class =3D "0x240404"
                bluez.alias =3D "Mi Bluetooth Headset Basic"
                device.icon_name =3D "audio-headset-bluetooth"
                device.intended_roles =3D "phone"
        profiles:
                headset_head_unit: Unidad de auriculares de diadema  (HSP/H=
FP)
(priority 30, available: unknown)
                a2dp_sink: Reproducci=C3=B3n de alta fidelidad (destino A2D=
P)
(priority 40, available: unknown)
                off: Apagado (priority 0, available: yes)
        active profile: <a2dp_sink>
        sinks:
                bluez_sink.E8_EC_A3_1E_69_88.a2dp_sink/#6: Mi Bluetooth Hea=
dset
Basic
        sources:
                bluez_sink.E8_EC_A3_1E_69_88.a2dp_sink.monitor/#11: Monitor=
 of
Mi Bluetooth Headset Basic
        ports:
                headset-output: Auriculares (priority 0, latency offset 0 u=
sec,
available: unknown)
                        properties:

                headset-input: Auriculares (priority 0, latency offset 0 us=
ec,
available: unknown)
                        properties:

--------------------------------------


STEPS TO REPRODUCE
1. Connect device to PC with Bluetooth.

OBSERVED RESULT
It plays sound but the microphone does not work. The Microphone is not dete=
cted
in KDE Plasma.

EXPECTED RESULT
Audio playback and microphone detection

SOFTWARE/OS VERSIONS
Operating System: KDE neon 5.23
KDE Plasma Version: 5.23.2
KDE Frameworks Version: 5.87.0
Qt Version: 5.15.3
Kernel Version: 5.11.0-38-generic (64-bit)
Graphics Platform: X11
Processors: 12 =C3=97 Intel=C2=AE Core=E2=84=A2 i7-8750H CPU @ 2.20GHz
Memory: 15.5 GiB of RAM
Graphics Processor: NVIDIA GeForce RTX 2060/PCIe/SSE2


--------------------------------------

dmesg command get this information:

[ 9507.995592] Bluetooth: hci0: SCO packet for unknown connection handle 0
[ 9507.995599] Bluetooth: hci0: SCO packet for unknown connection handle 0
[ 9507.995601] Bluetooth: hci0: SCO packet for unknown connection handle 0
[ 9508.005618] Bluetooth: hci0: SCO packet for unknown connection handle 0
[ 9508.005621] Bluetooth: hci0: SCO packet for unknown connection handle 0
[ 9513.035725] Bluetooth: hci0: SCO packet for unknown connection handle 260
[ 9519.311014] Bluetooth: hci0: urb 00000000bb9f4530 submission failed (90)
[ 9519.311038] Bluetooth: hci0: sending frame failed (-90)
[ 9519.311051] Bluetooth: hci0: urb 00000000bb9f4530 submission failed (90)
[ 9519.311060] Bluetooth: hci0: sending frame failed (-90)
[ 9519.321578] Bluetooth: hci0: SCO packet for unknown connection handle 0
[ 9519.321583] Bluetooth: hci0: SCO packet for unknown connection handle 0
[ 9519.321584] Bluetooth: hci0: SCO packet for unknown connection handle 0
[ 9519.331592] Bluetooth: hci0: SCO packet for unknown connection handle 0
[ 9531.572022] Bluetooth: hci0: SCO packet for unknown connection handle 261
[ 9531.572036] Bluetooth: hci0: SCO packet for unknown connection handle 261

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
