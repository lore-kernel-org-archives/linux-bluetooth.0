Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1333D6D8
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964249; cv=none; b=HbzQ4/miS1H2ML9anF2OV5sHogBMuUdqvDdCcpY/n1QhUMRbza0heKMBhHkvCZgDWQl0z9DSKZirQMVYIGLy6NlOSll08UWvGzRh/2xzj1ETCX/sQfdggS5N0XFR0qbOVHCBXok4Mlm6iIYykI9M2uq9XL2hbXPHRgiVu3D60Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964249; c=relaxed/simple;
	bh=Z9h6fjZG3YaQ2kLMt73hzovxg5plFZQZHkK2ImFNAGE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sDltK0gZXXq/dJG5WGWmkEZKmI2qPixuPi4jF4aJRr3NaNvFE+Xp4UqRPKZCNcRaoWWbpZVzBwRFuQqmX2pgdQYZf6q8TeiBODVW8LhxNgvCn9Ur+20nKg48AbNoKlt+cK3fXMtUKZCBJUB07hpKJQQ6QLOOXJYoZHkTlbac9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ18MQqB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ18MQqB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07799C19424
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 23:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773964249;
	bh=Z9h6fjZG3YaQ2kLMt73hzovxg5plFZQZHkK2ImFNAGE=;
	h=From:To:Subject:Date:From;
	b=aJ18MQqBRn9Bi7YnbrbQv1ggvqryNazTidBnjU0LcGdtl0bA0rKU2q1hPmafUy92K
	 Cxl4eRGq7m99R+fp7y24LF9w41k3/Zxz5kXDf6Wn3ofAulRZJBlirF7X1QwWHjajgB
	 rhTd8ZCQN5UHH403TQEOTvmGrHFRVTYi/aC4f+TXSqCQZBQbLF735gIwUIJW58i9AB
	 lYe1ixgg5znrFKUYbml263TloExjbWYVMxszQDBVClZr4+XjyOLIrMN7ZP/8E96duj
	 +uNm6YIk0TLoIaeZ8fMo5+4lABvOni6Lc9V7P2tHnVaL37UE9CIStuCIRgjC2kMjOD
	 Ym5bSKtmvsZ8A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EB145C3279F; Thu, 19 Mar 2026 23:50:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221263] New: HID: Apple Magic Mouse 2 (BT 0x004C:0x0323)
 reports wrong battery percentage -- hidinput_query_battery_capacity() reads
 buf[1]    (status byte) instead of buf[2] (AbsoluteStateOfCharge)
Date: Thu, 19 Mar 2026 23:50:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wh6cyy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221263-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221263

            Bug ID: 221263
           Summary: HID: Apple Magic Mouse 2 (BT 0x004C:0x0323) reports
                    wrong battery percentage --
                    hidinput_query_battery_capacity() reads buf[1]
                    (status byte) instead of buf[2]
                    (AbsoluteStateOfCharge)
           Product: Drivers
           Version: 2.5
          Hardware: ARM
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: wh6cyy@gmail.com
        Regression: No

Hi,

  I am reporting a confirmed bug in the HID battery subsystem that causes t=
he
  Apple Magic Mouse 2 to permanently show 4% battery at boot when connected=
 via
  Bluetooth.  The root cause has been isolated to a hardcoded byte-index
  assumption in hidinput_query_battery_capacity() (drivers/hid/hid-input.c)
  that is incompatible with the Magic Mouse 2's multi-field report 0x90
structure.


  --- System information ---

    Kernel:   6.18.15-400.asahi.fc43.aarch64+16k (Asahi Linux on Apple Sili=
con)
    Device:   Apple Magic Mouse 2, "William's Magic Mouse #2"
    BT MAC:   D0:C0:50:CF:DF:F1
    HID IDs:  Bus=3D0x0005 (Bluetooth), Vendor=3D0x004C (Apple BT),
              Product=3D0x0323
    Driver:   hid-magicmouse (BT path)


  --- Observed vs. expected behaviour ---

    /sys/class/power_supply/hid-d0:c0:50:cf:df:f1-battery/capacity
    reports: 4

    macOS reports 94% for the same mouse simultaneously (confirmed ground
truth).
    Occasional spontaneous correct readings (~95%) are observed at boot bef=
ore
    the first sysfs read (see Race Condition section below), confirming the
    device transmits the correct value.

    UPower sysfs snapshot:

      POWER_SUPPLY_NAME=3Dhid-d0:c0:50:cf:df:f1-battery
      POWER_SUPPLY_TYPE=3DBattery
      POWER_SUPPLY_STATUS=3DDischarging
      POWER_SUPPLY_CAPACITY=3D4
      POWER_SUPPLY_SCOPE=3DDevice
      POWER_SUPPLY_MODEL_NAME=3DWilliam's Magic Mouse #2


  --- HID Report Descriptor (battery collection) ---

  Full raw descriptor (from hid-recorder):
    R: 135 05 01 09 02 a1 01 85 12 05 09 19 01 29 02 15 00 25 01 95 02 75 01
    81 02 95 01 75 06 81 03 05 01 09 01 a1 00 16 01 f8 26 ff 07 36 01 fb 46
    ff 04 65 13 55 0d 09 30 09 31 75 10 95 02 81 06 75 08 95 02 81 01 c0 06
    02 ff 09 55 85 55 15 00 26 ff 00 75 08 95 40 b1 a2 c0 06 00 ff 09 14 a1
    01 85 90 05 84 75 01 95 03 15 00 25 01 09 61 05 85 09 44 09 46 81 02 95
    05 81 01 75 08 95 01 15 00 26 ff 00 09 65 81 02 c0

  Battery Application Collection (report 0x90):

    85 90          -- Report ID 0x90
    05 84          -- Usage Page: Power Device (0x84)
    75 01 95 03    -- Report Size 1, Count 3
    15 00 25 01    -- Logical Min 0, Max 1
    09 61          -- Usage: PresentStatus (0x61)          [bit 0]
    05 85          -- Usage Page: Battery System (0x85)
    09 44          -- Usage: Charging (0x44)               [bit 1]
    09 46          -- Usage: Discharging (0x46)            [bit 2]
    81 02          -- Input (FIELD 0: 3 x 1-bit status)
    95 05 81 01    -- 5-bit padding
    75 08 95 01    -- Report Size 8, Count 1
    15 00 26 ff 00 -- Logical Min 0, Max 255
    09 65          -- Usage: AbsoluteStateOfCharge (0x65)
    81 02          -- Input (FIELD 1: 8-bit charge)
    c0             -- End Collection

  Raw buffer layout for report 0x90 (as seen by the kernel):

    buf[0] =3D 0x90  -- report ID
    buf[1] =3D 0x04  -- FIELD 0: status byte (bit2=3DDischarging=3D1, rest=
=3D0)
    buf[2] =3D 0x5F  -- FIELD 1: AbsoluteStateOfCharge =3D 95 decimal


  --- Bluetooth traffic capture (btmon) ---

  The kernel queries:  41 90  (GET_REPORT, INPUT type, report ID 0x90)

  The mouse consistently responds:  a1 90 04 5f

    a1 =3D BT HID DATA INPUT header
    90 =3D report ID
    04 =3D status byte =3D 0b00000100 (bit2=3DDischarging)
    5f =3D AbsoluteStateOfCharge =3D 95 decimal  =E2=86=90 matches macOS 94%

  The value 0x5f=3D95 is stable across every captured report.


  --- Root cause ---

  hidinput_query_battery_capacity() in drivers/hid/hid-input.c:

    ret =3D hidinput_scale_battery_capacity(dev, buf[1]);   /* BUG */

  It hardcodes buf[1] as the battery byte.  For reports where the battery
  field is the first (and only) data field, buf[1] is correct.  For report
  0x90 on the Magic Mouse 2, buf[1] is the status byte (0x04 =3D 4) and the
  AbsoluteStateOfCharge is at buf[2] (0x5F =3D 95).

  Arithmetic confirming the bug:

    Observed: buf[1] =3D 0x04 =3D 4 =E2=86=92 scale(4, 0, 100) =3D 4%  =E2=
=9C=93 matches sysfs
    Correct:  buf[2] =3D 0x5F =3D 95 =E2=86=92 scale(95, 0, 100) =3D 95%  =
=E2=9C=93 matches macOS

  The correct byte offset is deterministic from the descriptor:
    1 + (field->report_offset / 8) =3D 1 + (8/8) =3D 2  =E2=86=92  buf[2]

  The leading 1 accounts for the report-ID byte prepended by
hid_hw_raw_request().


  --- Race condition / intermittent correct readings ---

  hidinput_get_battery_property() has two paths:

    A. Query path (buggy): when battery_status !=3D HID_BATTERY_REPORTED, c=
alls
       hidinput_query_battery_capacity() =E2=86=92 reads buf[1] =3D 4 =E2=
=86=92 returns 4%.

    B. Event-driven path (correct): after the first spontaneous HID INPUT
       event for report 0x90 processes the AbsoluteStateOfCharge usage via
       hid_input_var_field() (which correctly bit-extracts each usage's val=
ue
       per the descriptor), hidinput_update_battery() caches 95 in
       dev->battery_capacity and sets battery_status =3D HID_BATTERY_REPORT=
ED.
       Subsequent sysfs reads return 95%.

  The race: if UPower reads sysfs before the first mouse input event (which=
 is
  typical at boot), path A fires =E2=86=92 4%.  If the user moves the mouse=
 before
  UPower reads =E2=86=92 path B fires first =E2=86=92 95%.

  This explains the "sometimes correct at boot" behaviour: it is a genuine
  race between UPower's enumeration and the first spontaneous HID report.


  --- Why magicmouse_fetch_battery() does not apply ---

  magicmouse_fetch_battery() checks is_usb_magicmouse2() which tests:
    vendor =3D=3D USB_VENDOR_ID_APPLE  /* 0x05AC */

  A BT-connected Magic Mouse 2 presents vendor=3D0x004C (Apple BT vendor ID=
),
  not 0x05AC.  is_usb_magicmouse2() returns false; the battery timer is nev=
er
  armed; all battery handling falls through to hid-input.c where the bug li=
ves.


  --- Proposed fix direction ---

  Option A (general fix): Store the AbsoluteStateOfCharge field's byte offs=
et
  at hidinput_configure_usage() time (e.g., in a new hdev->battery_field_of=
fset
  member) and use it in hidinput_query_battery_capacity() instead of the
  hardcoded 1.

  Option B (device-specific): Extend is_usb_magicmouse2() to also accept
  BT_VENDOR_ID_APPLE (0x004C), arming the existing battery timer for BT-path
  devices so magicmouse_fetch_battery() runs and primes battery_status befo=
re
  the first sysfs read, bypassing the hid-input.c query path entirely.

  I do not have a tested patch yet.  I am happy to test patches.

  Regards,
  Will

  --
  Kernel: 6.18.15-400.asahi.fc43.aarch64+16k
  Platform: Apple Silicon (Asahi Linux / Fedora 43)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
