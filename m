Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C431326A
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147412; cv=none; b=tyxxBis7bb9W2ES4aGz4TacaM9nPGCJ30Mi1FWLQCvSyw7s/v3aAQq4chXxPmdnr5GXg+b0qUmGZTwB7dv4gEavu2D6HsATppYyoxw8JzSuQy3d57/UETwlSww7CInWsEU1/QrIUjQc9YIdYGEAKwEVIfsxlZLKnUiWNiQr1a9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147412; c=relaxed/simple;
	bh=DJ54oOTq/X4jKM2JEuRuLr4ebvINwBUB/gkZxgEHM3Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CVIiGR2UXWkXUPS8KwrztrMq1ihhgdiw+Yr4Fau9hjGoNZaxnylWHe90/b/p1k3ZmgTS+9IDtfF1m+z/A/rp0cL663SbHa4IaDQV7wM9ecNHBHKokGuz/nIV/1Q0cCzygbbkNYsb0KbdmBZ2+5/TwTAUQoaM6KHr1EPeDABfiXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVuFRWBa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVuFRWBa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCC0AC2BCC6
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782147411;
	bh=DJ54oOTq/X4jKM2JEuRuLr4ebvINwBUB/gkZxgEHM3Q=;
	h=From:To:Subject:Date:From;
	b=XVuFRWBawp4lk2MjiK1nVpTrf1BCjOGJUo3Ffe2bo2YA9o5yd0cNHZJSKDptkQUp0
	 Jm3Ta538LB82rw8dAj1vIGJ9Ev+7zmzXIZkSlG62i7zOT77IHxf8k5coO6TVifCBuv
	 PQPzq12n3QiPDyLP9sTeEXzz1yFmajBHEQSmf9iL/6Oyc8D9aMn7DKu3eyD48TfinM
	 k16TvsZzIR1iepUXXspdWeMKnqbYm6rzpPzLyGSfhX5fgNC+LDbFkM+cE64tTekrd9
	 4cU4bJW+BZdJmoH9DsZyHZZFlXfXZo5MirTjLHr6WE4vyp8yIpGY0/1q38hNUJ7sFn
	 jzaWMkkENHiiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B4C1AC4160E; Mon, 22 Jun 2026 16:56:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221681] New: hid_magicmouse: Bluetooth battery reporting stuck
 at 4% for Apple Magic Trackpad (USB-C) on Linux 7.0.0.22-generic
Date: Mon, 22 Jun 2026 16:56:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pageau.hunter.c@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221681-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221681

            Bug ID: 221681
           Summary: hid_magicmouse: Bluetooth battery reporting stuck at
                    4% for Apple Magic Trackpad (USB-C) on Linux
                    7.0.0.22-generic
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pageau.hunter.c@gmail.com
        Regression: No

The hid_magicmouse driver incorrectly reports battery level as 4% for the
Apple Magic Trackpad (USB-C) when connected over Bluetooth.
The value appears to be a hardcoded default =E2=80=94 it never updates, and=
 no
battery-related activity appears in dmesg after the device connects.

This is distinct from the Magic Trackpad 2 USB battery fix merged before
Linux 7.0-rc3. That fix does not appear to cover the Bluetooth path.

DEVICE
  Model:   Apple Inc. Magic Trackpad (USB-C)
  Serial:  d0:c0:50:b8:66:86
  Connect: Bluetooth HID v3.19 (UUID 0x1124, classic BT, not BLE)

KERNEL
  7.0.0-22-generic (Ubuntu 26.04 LTS)
  Driver: hid_magicmouse
  Module:
/lib/modules/7.0.0-22-generic/kernel/drivers/hid/hid-magicmouse.ko.zst
  srcversion: CB57FC5C3E5315DB93BD466

SYMPTOMS
  /sys/class/power_supply/hid-d0:c0:50:b8:66:86-battery/capacity: 4
  upower reports: percentage 4%, warning-level: critical, state: discharging
  upower updated timestamp is current (not stale/1970 epoch)

  dmesg on connect shows NO battery-related output from magicmouse driver:

    [129671.910588] hid-generic 0005:004C:0324.004E: unknown main item tag =
0x0
    [129671.910684] input: Hunter's Magic Trackpad Mouse as
/devices/virtual/misc/uhid/0005:004C:0324.004E/input/input164
    [129671.910779] input: Hunter's Magic Trackpad as
/devices/virtual/misc/uhid/0005:004C:0324.004E/input/input165
    [129671.910822] hid-generic 0005:004C:0324.004E: input,hidraw7: BLUETOO=
TH
HID v3.19 Mouse [Hunter's Magic Trackpad] on 88:63:df:8a:6c:87
    [129672.078299] magicmouse 0005:004C:0324.004E: unknown main item tag 0=
x0
    [129672.078384] input: Apple Inc. Magic Trackpad as
/devices/virtual/misc/uhid/0005:004C:0324.004E/input/input166
    [129672.078443] magicmouse 0005:004C:0324.004E: input,hidraw7: BLUETOOTH
HID v3.19 Mouse [Hunter's Magic Trackpad] on 88:63:df:8a:6c:87

  No "battery" string appears anywhere in dmesg output filtered for
  magic|magicmouse|hid_magic|hid|bluetooth|battery.

POWER SUPPLY UEVENT
  POWER_SUPPLY_NAME=3Dhid-d0:c0:50:b8:66:86-battery
  POWER_SUPPLY_TYPE=3DBattery
  POWER_SUPPLY_STATUS=3DDischarging
  POWER_SUPPLY_PRESENT=3D1
  POWER_SUPPLY_ONLINE=3D1
  POWER_SUPPLY_CAPACITY=3D4

NOTES
  - The device is rechargeable and was not actually at 4% (trackpad functio=
ns
    normally with no low-battery behavior)
  - bluetoothctl does not show a Battery Percentage line, which is expected
    for HID-over-BT classic devices (not a regression)
  - /sys/kernel/debug/hid/0005:004C:0324.004E/rdesc was not accessible
  - lsmod confirms hid_magicmouse is loaded and bound to the device

EXPECTED
  Battery level is polled from device and reported accurately in
  /sys/class/power_supply/.../capacity

ACTUAL
  Capacity stuck at 4% from connect time, never updated. Driver emits no
  battery-related log output.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
