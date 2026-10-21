Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792547798;
	b=2fwCrbpRZHCX0l1Y6xNADPaIWG07bftLT6ehHNSNuyI+WLQmfaN8VL6ax1QLBi21Y65O
	 AmInnwVYpGpA6lJg9kEvO5q5xQp+oRktZpvHAzmxJeIHEymdpKg/4/bkaUdsFj5XCGomp
	 tIYorUOqvSLjLsJZuJNNinCRPqgpmYPH86z8Wkgrw936Z+vHqvZriGsOrpLDLIzAdsmAK
	 ZwXhC8CLGYsjT6qcC1JynHwbPj7PoNGhW8+3bLT6thIG553l3u3RdGuHaQn4FuW+xC6tp
	 DGxLnm0ykanrnqG7pipkQ9ntcK7NjzIIba+YJyYhNj9opwPEQvsPMbTkUmNMCPc59+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547798;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:Content-Type:Content-Transfer-Encoding:X-Bugzilla-URL:
	 Auto-Submitted:MIME-Version;
	bh=3AM56UV90D1P+o142GrSQPn0fniuO0F59788sGhE77I=;
	b=L1MxZ2jVJYlX+ZQznv4DWsyFj4OQ+63O5tRj890ZDyiiHVNLrD+LJRbKktLZJ1i17eo3
	 mBYGJzSPZLAm/KNCFiQUxDjWprI1UgeNdWLYGhtrmwEIpdKdIXR18IHiPpQCcpl7ohegG
	 D12x+tzd+Rkd2d+CzhTkVQwNX1b0pku7rMlz+JAnDydNMMMpCt89MmdhTnfBiaODEBl7H
	 hY4+f8qlHqHOlCPHQF+mW1lUWgmNxvwsiso8iwaoDjRFlV6GDwCEVkytSx4ywdTR6qaEu
	 GRPVyLhNjmBuo5t8uec5ESa3u+HnTqs97z5rmoM9FqrphHzL/Ngylb5TNCRuswJEb7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k8FjK1jL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA5A606A319
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Wed, 21 Oct 2026 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k8FjK1jL
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809025771
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792547797; cv=none; b=tK5fAA6lZvgImTrnSXN+mORyoAfHP5UGGE5u2udhQLnX48sn4bPSPG0NsKdNzOIT5sDk56wY6G4ROYmq558E/80yvD09N4JquBR2KJUR0BZ6G2rvRLIWoj3D/uH71hKMAi8LaS8PkU7vhP2MkGW2Oc7pT/lPWSgU+HpIZ9kewGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792547797; c=relaxed/simple;
	bh=dPw+cwBaKMvJ5sZYqmi4JOhiToR8w5GhWWfL+4Wa46Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MP7ci4Yy0HY/W2FAxLA9PgLCK2/yA3mJy3B7W8Wd0LNgOLmQBAEO903ldAKTXLnQMmmF+Mf/SikBC5ZPh5eesBoIWNn6R6C6DO18jBfFOWhIi+IhQafKLLKT9M9nomgRwtXA9s5CvzO/nxzM4nkXZ0ueuAAUsExb6YC1tN5vueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8FjK1jL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 314D0C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 01:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792547797;
	bh=dPw+cwBaKMvJ5sZYqmi4JOhiToR8w5GhWWfL+4Wa46Y=;
	h=From:To:Subject:Date:From;
	b=k8FjK1jL388thueaycscCytELRXlaJYOzafmLd29I3KtZHVaALiuzzvBb0lRnZPOo
	 X+M1P/CjVaicMqXzTJS0NbNSowGLiQDo1ROK+RNkU9DmKToqwA37cwQryqLCaeI27Z
	 6OZOuHYn1JthGuMvVKvguN+PbX4lqDcD/R0V9BJ3N+c9GZntuXiN7kSMj7EwX5lu84
	 LdCyNZxM+kd7HjIHd4qL5H4MYXRvBNxn0KdOc6NcojgOngxYElev1LbnBO48taDxYF
	 vLmpcqnhQGV77NlybDqolq3FlNkeLvlo+BUns9zoGErH+IDMbgJjUsmh5l5O0fHYVY
	 xWv5wx09RcrpA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 09DB1C3279F; Wed, 21 Oct 2026 01:56:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222164] New: MT7902 Bluetooth: firmware coredump after ~10h
 uptime, then "subsys reset fail" and permanent USB disconnect
Date: Wed, 21 Oct 2026 01:56:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hongweifei@cyue.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-222164-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222164

            Bug ID: 222164
           Summary: MT7902 Bluetooth: firmware coredump after ~10h uptime,
                    then "subsys reset fail" and permanent USB disconnect
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: hongweifei@cyue.net
        Regression: No

[1.] One line summary of the problem:

    MT7902 Bluetooth controller dies after ~10 hours of uptime with a firmw=
are
    coredump, then "Can't get device id, subsys reset fail", after which the
USB
    device becomes permanently unresponsive and only a reboot restores
Bluetooth.

[2.] Full description of the problem/report:

    On an ASUS Vivobook X1605VA (MediaTek MT7902: WiFi over PCIe, Bluetooth
over
    USB), the Bluetooth controller stops working after roughly 10 hours of
    uptime. Kernel log at the moment of failure:

        Bluetooth: hci0: Mediatek coredump end
        Bluetooth: hci0: Can't get device id, subsys reset fail.
        usb 1-10: device descriptor read/64, error -110
        usb 1-10: USB disconnect, device number 4

    After this, hci0 never reappears. None of the recovery methods in [6.]
bring
    it back; only a full reboot restores Bluetooth.

    The most interesting observation: the failure is highly time-consistent.
    Two independent occurrences, each from a clean boot:

        #1  2026-10-19 10:19:24 boot -> 2026-10-19 20:21:44 crash  (10h02m2=
0s)
        #2  2026-10-20 09:50:30 boot -> 2026-10-20 20:01:29 crash  (10h10m5=
9s)

    The difference between the two is only 519 seconds (8.7 minutes) out of=
 a
    ~10 hour period, i.e. within 1.5% of each other. This does not look lik=
e a
    random firmware fault; it looks like something counting up (a timer, a
    watchdog, a log buffer, or a leak crossing a threshold after fixed
activity).

    The machine is on 24/7 and was idle in both cases: no Bluetooth audio
    streaming, no active connections, paired keyboard and mouse both idle.

[3.] Keywords (modules, filesystems, etc):

    bluetooth, btusb, btmtk, mt7902, usb, xhci_hcd, devcoredump

[4.] Kernel information:

    Kernel: 7.2.8-9-omarchy (Arch-based; Omarchy 4.0.4)
    BlueZ: 5.87-2
    linux-firmware: 20260916-1
    btusb: version 0.8 (in-tree)

    Bluetooth firmware:
        HW/SW Version: 0x008a008a, Build Time: 20250826211444

    Hardware:
        PCI WiFi:  0000:02:00.0  MEDIATEK MT7902 802.11ax [14c3:7902]
        USB BT:    13d3:3579 (AzureWave / MediaTek), on usb1-10

    IMPORTANT VARIABLE: the WiFi half is running an OUT-OF-TREE driver
    (morrownr/mt76 build, module names mt7921e_git / mt7921_common_git /
    mt792x_lib_git) with disable_aspm=3D1, and the in-tree mt76 is blacklis=
ted
via
    /etc/modprobe.d/mt76_git.conf. This is a deliberate workaround for a
separate
    MT7902 WiFi TX-power bug (ACPI MTGS 0xFF treated as -1 dBm, capping TX =
at
    ~2 dBm). I have NOT yet tested whether the Bluetooth crash also occurs =
with
    the stock in-tree WiFi driver. I mention it because it may be relevant,=
 and
I
    am willing to test with the in-tree driver if requested.

    Relevant modules loaded at crash time:
        btusb                0
        btmtk                1  btusb
        mt7921e_git          0
        mt7921_common_git    1  mt7921e_git
        mt792x_lib_git       2  mt7921e_git, mt7921_common_git

[5.] Most recent kernel version which did not have the bug:

    Unknown. I do not have logs from before these two occurrences, so I can=
not
    say whether this is a regression.

[6.] Output of Oops.. message (if applicable) with symbolic information:

    There is NO oops, KASAN report, lockdep splat, or any kernel warning in=
 the
    logs. This does not appear to be a kernel memory corruption in the driv=
er;
    the controller itself becomes unresponsive at the USB level.

    Recovery methods attempted while in the failed state, ALL of which fail=
ed:

      1. USB port re-enumeration:
           echo 1 > /sys/bus/usb/devices/usb1/1-0:1.0/usb1-port10/disable
           (sleep) ; echo 0 > .../disable
         -> no device comes back

      2. Driver reload:
           modprobe -r btusb btmtk ; modprobe btusb
         -> no hci0

      3. Combined: unload drivers -> port re-enumerate -> load drivers
         -> no hci0

      4. xHCI controller unbind/bind:
           echo 0000:00:14.0 > /sys/bus/pci/drivers/xhci_hcd/unbind
           echo 0000:00:14.0 > /sys/bus/pci/drivers/xhci_hcd/bind
         -> controller re-bound successfully and ALL OTHER USB devices on t=
he
            same controller re-enumerated normally (webcam, USB storage,
            keyboard), but the Bluetooth device did NOT come back. This
strongly
            suggests the BT controller is not merely in a bad driver state;=
 it
is
            not responding on the bus at all after the firmware crash.

    Only reboot restores it.

[7.] A small shell script or example program which triggers the bug:

    None. It appears to be time-based / idle-triggered; no user action
required.
    Uptime alone (about 10 hours) seems sufficient.

[8.] Environment:

    Arch Linux / Omarchy 4.0.4, Hyprland 0.56.2 (Wayland), kernel
7.2.8-9-omarchy.
    Laptop: ASUS Vivobook X1605VA, Intel Raptor Lake-P, Iris Xe graphics.

[9.] Other notes:

    No coredump payload was captured. /sys/class/devcoredump/disabled is 0
    (feature enabled) but the directory contains no devcd* entry. Either the
    default 5-minute devcd_timeout expired long before I inspected it, or t=
he
    dump never materialised because the device stopped responding mid-dump.=
 I
    will raise devcd_timeout and try to capture it on the next occurrence.

    Also note there is only a "Mediatek coredump end" line in the log, with=
 no
    matching "coredump start" line before it. I do not know if that is expe=
cted
    for this firmware.

    WiFi (the same MT7902 chip, PCIe side) continues to work fine through t=
he
    Bluetooth failure; the two halves appear independent here.

    The machine is on 24/7 and gets a clean boot daily, so this reproduces
    roughly every 10 hours. I am happy to run btmon captures, enable
    tracepoints, or collect firmware debug logs on request.

    Questions I would appreciate help with:
      - What could be time-based here? A watchdog/keepalive/counter in btmtk
for
        MT7902 that could trip after a fixed period?
      - Is this a known failure mode? I only found CVE-2024-56653
        ("btmtk: avoid UAF in btmtk_process_coredump"), which does not appe=
ar
to
        apply: that is a UAF in dump handling, there is no KASAN report her=
e,
and
        the fix long predates 7.2.
      - Should "subsys reset" be able to recover this? It reports "Can't get
        device id". Is there a btmtk recovery path that resets the controll=
er
        over USB without losing the device, or is full USB re-enumeration t=
he
        only option (and if so, why did it fail here)?
      - Anything specific I should capture next time?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
