Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02A49B1EF
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264804; cv=none; b=rd0jYMaUb4pmpanGiLdb2vVHE8PA6XqU3MMtcJoEX7WrNEDu0mCujVxYyMlqwRuJ9WaNefLDSJBQbU/9VZ5t2UxcHB98HWJPpYyZlYg2VmiW/ow/xpxEm8wavkF0Ru3bn9zw4/mRzuuXeakAfTfGruY119nzhHQ8QSzKmHXr/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264804; c=relaxed/simple;
	bh=zZWOs3/h3jq4/Xg0RnwDKkZjx61foWMDpBK4PvpxcNA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QIi5Dp3en1fAcw7o2GkgCHHrmZRpJrhFK9Dk/gbLAnYw6WS6W0SsUTQ5AaCv34Cl5bR/v7chYnKkSE+ks3SIMsP9nSHLPqo8BE36KD7MfctBjbnE93cRdmzRMqQYYjdDLJvShC9Tw38+M0zEcPL8gKSsqqJ23hEIahcECXS7+yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOA3tgbw; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOA3tgbw"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c72bfebso732466241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264802; x=1790869602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3kPSwAbPvIhFhlzrBsIybs4fNQgZyvgiX3m74z9GB4g=;
        b=gOA3tgbwJB85dVLUzC7rowUqm2e2zqlazE8aontV1IleUkCrXQhBSOeRlUWX7H0c0w
         wT6B0ccr5QHzMiez1im/HxfdipdPj4ywBzA7nn8a9t3HPgsVTvXleGSMfMqEKGCODIb+
         lxJtlInMAlr6eabUZ/ERkssd30zqaoWcgQ6HlUaWj9xUwXIo++rK1ejQqmKHs9Yn7+7/
         hh4m5GFcJvTKGNu6KxY/eL9nrTMTTzhI2ix4hZQOVvnecoKONFJb6ndw0Sh7qkb1qK4x
         Djj4QYPeaZYShSbrXEbQToRB9F4KhCA0pb29zK3VRZ/oiXwSkQZcU31MPUCuw41U7n6E
         9+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264802; x=1790869602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3kPSwAbPvIhFhlzrBsIybs4fNQgZyvgiX3m74z9GB4g=;
        b=UK6aF9ddrdrfWE/ZdXsZaCmQOtIakv2ePSGDMZna2Uv8AMGoLbzJ4GhZsP+MXuGpgw
         caTdiNq8/HAH29GytKORtJr04b8xeGmgcr6vGHF32lekBntK0IN3Xt3f4uqPP17AErtR
         COnpEqo0oo4KJRNHbA5XPJskvd3kmB6QXDB/E6WreExO6DH4AJUoAUbbHDK57ejpu6sR
         zTxSTxlrU3WUBdKfRMaEEM2SrOe3asf5I2s6D5lRV2GzMfL6SScRksCtDNGoRgEUnKdp
         vr3Wut6sDUJRKu05Ap86ClyMUCYDOD/TNeuC48DLhvnz5GZGMcPljEoB82rSsl/4bNrY
         h4kw==
X-Gm-Message-State: AFuF++nez+fjndOiCTveFDc+132aSFylx015JP3Hr7vGwCIzSVYs1AZ9
	5TZf3P49dg1FgVlzVrkgJTloAgwevsU/dCjcz9mN537Vtf7zrm3+3j5S0D8ebUQ7xrM4iQ==
X-Gm-Gg: AYBFou1xb7B+CQrFQI+Yh1Zt76f/DYFw/CovrfSxpi5ICWFC+2OK/wMtMNoBtOY27oQ
	u2WqcbnulBFH4L6/VX764xIW9GhQwMjzh6qMhYmGxXotWcuxcKxrhbdpxPPigVT/A1MIiqc8krX
	MNkoHxgihl2gHoX6Uwwee9oEPcSyyBx/NL3VyqbILHroK1KbIVlUoy5RpCwarmsnHYGda1d8IZn
	mRY+rOfQmfyFzh0Xl84jgmbzgbCc8/1CSJUeVtkITnOD7y+9X2z6Wz8FpPUJohuUAzrTJHZ7p4V
	IW3FtdRP1z5s3BFrnSECvefBMbDajlHxE/THS4dE1ddUHdDwIb+rCKs9Nl//o5VfKaJ3EFOqJJO
	vrg+UUAi0I+9RefAoooohtzzhWsKlV/VhhHYudlRewXC+Gmbd+4XhS15kvnt9ckIakNIWN7h5wU
	fuKO81a4k8s1Q+k4JE4NyrhbFBVcG0/SifFjVIBwmE3Ug6G4+uF6eJHFoR3OAiUHi08mXjIfHG0
	3IV+JGHnCm37YroMOiVMjV9X+lJKLOO31NjGqkcyHzVMcNI/tei2rInqIvjqW48
X-Received: by 2002:a05:6102:510d:b0:7a7:198a:c2c3 with SMTP id ada2fe7eead31-7af1eff68b8mr1406739137.33.1790264801385;
        Thu, 24 Sep 2026 08:46:41 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5674f44sm7412428137.3.2026.09.24.08.46.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:46:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/9] Add HID over GATT functional tests
Date: Thu, 24 Sep 2026 11:46:22 -0400
Message-ID: <20260924154631.369299-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds functional tests for HID over GATT (HoG), with bluetoothctl
registering a HID Service acting as a keyboard, with and without
Shorter Connection Interval (SCI) support, using the new
client/scripts/hog-device*.bt scripts, and the HID host:

 - checking HID Information, HID SCI Mode and HID SCI Information over
   GATT with gatt.select-attribute/gatt.read
 - receiving a few Input Reports notified by the HID device
 - with SCI support, changing the SCI mode, followed by the connection
   rate with mgmt.conn-subrate, and receiving the notification from
   the HID device confirming the mode has been changed

The tests are documented in doc/functional-hog.rst.

To support them:

 - bluetoothctl can now set descriptor values from scripts, and prints
   the MGMT Connection Subrate event
 - btvirt defaults to the latest BR/EDR+LE version (6.2), so Shorter
   Connection Intervals are supported by the emulated controllers,
   with the new -C/--core option to emulate older versions

Also, with -n auto, the number of functional test workers is now
limited by the memory available instead of one per CPU, since running
out of memory with so many VM instances made tests fail at random, and
check-functional uses -n auto by default (override with
CHECK_FUNCTIONAL_JOBS).

v2:
 - Add "attrib: Fix unregistering notifications registered with
   bt_gatt_client", fixing the heap-use-after-free in
   report_notify_destroy reported by TestFunctional on the HoG tests:
   g_attrib_unregister did not unregister the notifications registered
   with bt_gatt_client, so their destroy callback was called after
   HoG had freed its reports.

v3:
 - Add "shared/gatt-client: Fix calling destroy after unregistering
   notify", fixing the heap-use-after-free in report_notify_destroy
   still reported by TestFunctional on the HoG tests with v2: once
   unregistered, the destroy callback of the notification was still
   called later if the write of the CCC disabling it was pending, after
   HoG had freed its reports.

Luiz Augusto von Dentz (9):
  shared/gatt-client: Fix calling destroy after unregistering notify
  attrib: Fix unregistering notifications registered with bt_gatt_client
  client/gatt: Fix setting descriptor value from scripts
  client/mgmt: Print Connection Subrate event
  emulator: Default to the latest BR/EDR+LE version
  client/scripts: Add HoG device scripts
  doc: Add functional-hog documentation
  test: functional: add HoG tests
  test: functional: limit the workers by the memory available

 Makefile.am                      |   8 +-
 attrib/gattrib.c                 |  90 +++++++----
 client/gatt.c                    |  25 ++-
 client/mgmt.c                    |  31 ++++
 client/scripts/hog-device-sci.bt |  49 ++++++
 client/scripts/hog-device.bt     |  38 +++++
 doc/functional-hog.rst           | 188 +++++++++++++++++++++++
 doc/functional-testing.rst       |   1 +
 doc/test-functional.rst          |  25 +++
 emulator/main.c                  |  54 ++++++-
 emulator/server.c                |  15 +-
 emulator/server.h                |   2 +
 src/shared/gatt-client.c         |   9 ++
 test/functional/conftest.py      |  46 ++++++
 test/functional/test_hog.py      | 252 +++++++++++++++++++++++++++++++
 15 files changed, 794 insertions(+), 39 deletions(-)
 create mode 100644 client/scripts/hog-device-sci.bt
 create mode 100644 client/scripts/hog-device.bt
 create mode 100644 doc/functional-hog.rst
 create mode 100644 test/functional/test_hog.py

-- 
2.55.0

