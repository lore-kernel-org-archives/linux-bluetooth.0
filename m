Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A44CF473
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407442; cv=none; b=Y5+UPpgTZh4lgPhhNWTNBE7Vf82Mf/Z721OhB3Xq5SwdwzlxCNdCw0x3Rjx7actN1XzqaWdLU1hia9NuyovdKeklip1VPq5GPmrUrUjpLxFswLnPvF76JMfdUDE6Fc9UUBJOBodPzZ6pAIJ1U8jV4eautR/Qq+YiyrR1QkaWSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407442; c=relaxed/simple;
	bh=qtAxsku3Gd0KNtKluqq5urM28L2QUJ3j1d/8dX+xm4I=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D60Lz4vVeDFq5nfRuaHiMYcyxAaNLJTMuAl3yw8V3bw05YN2OKre//HSGyf+Ry7BV11YrFEh3FxELBuMyl/n0uGQpSQY8Ifc56rVWyiALbBgVNuXsJ2nlx3SvrKYfRK6P8UTmUNXriyomxJWYaLso5LIHChlvkSj6AeRRqTgLWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIRqysyc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIRqysyc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBAB8C2BCFC
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 10:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792407441;
	bh=qtAxsku3Gd0KNtKluqq5urM28L2QUJ3j1d/8dX+xm4I=;
	h=From:To:Subject:Date:From;
	b=fIRqysycA7hoUqUCyID/s1rsZTCvkwFFBy6cgaw8uKSOiYSKIUpSKR82X2l5qgcDU
	 QrsxEkFptyAX08QPJI94Y3YsPq1gxN2874z2SeBnnXZZlo+PwhyQCoOjskyE1fObsS
	 fpvsDkb8uVO/kfEDIPXm9CAzZYuq7yDmjcUZbO9QTH7na62+xDNfZAI5v+VzDrkicC
	 z2ixwn1YsIBrsFN68diU3YMKeCPAuCUaNRti1b+nODX6dgKdAes02/oj9/yFvf/VzI
	 rzlUpAPS2I0IEbIrfjenO2LoOBdF/N+AlRBlUOtPFVJ9rge9vngFM2zrwKtMae05yG
	 XWXYPVTZ1qTqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 99BB8C41612; Mon, 19 Oct 2026 10:57:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222151] New: MT7925 (0489:e111): BT firmware 20260813113236
 (linux-firmware 50e034a2) breaks HFP calls and fails WMT init; 20260605184935
 works
Date: Mon, 19 Oct 2026 10:57:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: purpleritza@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-222151-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222151

            Bug ID: 222151
           Summary: MT7925 (0489:e111): BT firmware 20260813113236
                    (linux-firmware 50e034a2) breaks HFP calls and fails
                    WMT init; 20260605184935 works
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: purpleritza@gmail.com
        Regression: No

Hardware / software
  Laptop:    Lenovo Legion 5 Pro 16AFR10
  Bluetooth: MediaTek MT7925, USB 0489:e111 (btusb/btmtk)
  Headset:   Bose NC 700 HP (HFP/A2DP)
  Distro:    Arch Linux, bluez 5.87, wireplumber 0.5.15, pipewire 1.6.8
  Kernels:   7.1.8, 7.2.9, 7.2.10 (Arch)

Firmware
  Bad:  linux-firmware commit 50e034a2 ("mediatek MT7925: update bluetooth
        firmware to 20260813113236"),
        file mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin, build
20260813113236
  Good: commit 2d705393, build 20260605184935

  Arch package versions: linux-firmware-mediatek 20260916-1 (bad) vs 202608=
10-2
  (good). Between them the MT7925 WiFi blob also changed (commit 3c11e660,
  "update firmware for MT7925 WiFi device", same day). WiFi worked normally=
 on
  both; only Bluetooth broke.

Calls regression (good / bad / good / bad)

  Period                          BT build        Kernel             Calls
  ------------------------------  --------------  -----------------=20
---------------------------------
  until 2026-09-27 (first chip    20260605184935  7.1.x / 7.2.2      worked
    init with the new blob)
  2026-09-27 onward               20260813113236  7.2.2 - 7.2.8      headset
audio drops mid-call,
                                                                       mic =
lost
  2026-10-07 - 10-15              20260605184935  7.1.8, then 7.2.9  worked
    (daily calls for a week)
  2026-10-17 onward               20260813113236  7.2.10             headset
audio drops mid-call

  Userspace (wireplumber 0.5.15, pipewire 1.6.8) was the same in the last t=
wo
  rows. One data point not covered by the table: on 2026-10-07 the first ca=
lls
  after downgrading the firmware still failed, while that boot ran kernel 7=
.2.8
  with wireplumber 0.5.18 / pipewire 1.6.9. Calls worked once those were ro=
lled
  back too.

  Failure on the bad build (2026-10-19, kernel 7.2.10): the HFP transport d=
ies
  mid-call, both headset nodes fail at once, and the call app falls back to=
 the
  laptop microphone, so the remote side still hears me while I hear nothing:

12:02:56 wireplumber: pw.node: (bluez_input.78_2B_64_D2_1D_66.0-74) running=
 ->
error (Received error event)
12:02:56 wireplumber: pw.node: (bluez_output.78_2B_64_D2_1D_66.1-73) runnin=
g ->
error (Received error event)
12:02:56 wireplumber: spa.bluez5: Failure in Bluetooth audio transport
/org/bluez/hci1/dev_78_2B_64_D2_1D_66/fd46
12:02:57 bluetoothd: src/profile.c:ext_io_disconnected() Unable to get io d=
ata
for Hands-Free Voice gateway: getpeername: Transport endpoint is not connec=
ted
(107)

  bluetoothd reconnects A2DP signaling 8 s later (12:03:04), and A2DP strea=
ming
  is back after 74 s (12:04:10); the call audio over the headset is gone.

WMT init failure (only ever seen on the bad build)

  Counted per firmware load across 30 boots of the journal:

  BT build        Loads  WMT init failures
  --------------  -----  --------------------------
  20260605184935     71  0
  20260813113236     16  2 (2026-09-27, 2026-10-17)

Oct 17 19:53:29 kernel: Bluetooth: hci0: HW/SW Version: 0x00000000, Build T=
ime:
20260813113236
Oct 17 19:53:40 kernel: Bluetooth: hci0: Execution of wmt command timed out
Oct 17 19:53:40 kernel: Bluetooth: hci0: Failed to send wmt func ctrl (-110)
Oct 17 19:53:40 kernel: Bluetooth: hci1: HW/SW Version: 0x00000000, Build T=
ime:
20260813113236
Oct 17 19:53:42 kernel: Bluetooth: hci1: Device setup in 1751211 usecs

  The controller recovers by re-enumerating as hci1. I know WMT timeouts are
  reported on other MT7925 machines with older builds (bug 220237, Ubuntu LP
  2163428); on this machine they only occur with 20260813113236.

Related
  - Bug 221722: blanket HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN breaks mS=
BC
mic
    on MT7925 (0489:e111). The quirk is active on both builds here, so it d=
oes
    not explain the difference between them.
  - Bug 220237: MT7925 BT firmware load timeout (-110).
  - Bug 220682 (same USB ID, libmtp/mtp-probe probing the adapter): not
    applicable here. libmtp and libgphoto2 are not installed, mtp-probe nev=
er
    ran, and udev sets no media-device tags on the adapter.
  - bluetooth-next a6491451f8b8 "Bluetooth: mt7925: trigger reset on WMT
timeout".
  - "ACL/SCO packet for unknown connection handle 3837/3584" appears on both
    builds and doesn't correlate with the failures.

Workaround
  Pinning linux-firmware-mediatek 20260810-2 (BT build 20260605184935).

Happy to test a new firmware build or capture btmon traces of a failing cal=
l on
request.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
