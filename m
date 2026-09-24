Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8533E7BCC
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289059; cv=none; b=YPdNTIev7URxTRI5y22Xv6waLPh5IF/3RrzsRGw4f17X4XoTzr5MhLYMnjy30U7umXc59myqrOhbfEzSmbfr4Xyt9H2+jzDQiBKF+9bh+c0CW9zGJnTI2nZjw01hosnzjjlHCWN5u1s/cGmgX47YxTBV+9yHBE5HTNYetyh9OW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289059; c=relaxed/simple;
	bh=DoRY6GDo0WMR1vk8rhAB+iZB7n08lI81K2NPCZ5WzRU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L7RH8i+OEyHO4VtOXX2NjHiMGcT2lt92Vouvd2ddUlcqgoOy5R6ihX6v4Jd7sfG4/P0ABVTlipkCbKbdNIQpgmgyi6+X/6YMsKp9+GRGHjLpvrwTsn9isiR3cUlTbET/rqEecJ7BcJxHn0T7mGaC8snIpqT/jst5zQbLtYX1zbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGN2ZkBO; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGN2ZkBO"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-9809f3af20cso130530241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289057; x=1790893857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xHk7awzXPF+x8JoEEoVoEbC0m+Go8hFrKJgU7lRWiJ8=;
        b=qGN2ZkBOjQ5YMXokOPxuDW8xKacJxQONAwAQ0XJMol3lkDAeSuUEozc8Rn0/cpPvQp
         NHJKZeE/b2VuU6cDc3cPmePk+C7gJcmjdjmOyNbC3NjQ/IlS4Eyekm+bRRPIFj4vsGcT
         dOLpXv2m6MeO2ZN80ZRAtxFAae9vwo57GBzJ92AZNGfA3QM/y/VnPROHDHfsXrhxgYTp
         +dO/SjyjRG70oPa/0zPofuVD2kHT6e6wq0/qH6Vt0ayIt1qn34q+3h1f41EwJIpco8NX
         vHii8DnkvzzbxV3HI+BnbWp8CFOxCz7dD9MwBoAgvRnDo45I+nPmv8X+vuNeOlLu4dxQ
         OGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289057; x=1790893857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xHk7awzXPF+x8JoEEoVoEbC0m+Go8hFrKJgU7lRWiJ8=;
        b=wMm8VrRaFJCEmQzR9gedST8S7C/fZgqye9+w0fQ59q1JMARCxfKOZ/l/lY7cNccJ/S
         UFmPCvcx4mUq3HVJrXVTNPvlCw4q52K7hPNJ2zxWo0Qq+6nZV4qS+rvRXe90pxVGco/8
         N3+0YBkWCJAbNDKRhtDWWxDjYnSTw38UrGlK9FsuvPvpOO7JRB2nB/EEEx5S4Pad1tqd
         0z269uF62fXqKN/kahcprJN9XJ7U9Ygl2YLBY7wLlh30zkt3cOJcUb8VM3BW0EeHXlxM
         RngFKhuji1jNjRZkA7nIOrcK3s0R4JpKkg/x+5fiIkPwz43Nhr4t1+7mcMj2/8HWSFkM
         Tr0w==
X-Gm-Message-State: AFuF++kfEe6/LakEDZHBrTlMFJFj4nYsVnYEPk3V5Wsh8COcRQPcHh/E
	5kv9RoimvmMzKiEIIfRKmjHUGpklIacuGQnSrgy3L+uuDkWmRfYD7Mo47OXXrUZSUnmSuA==
X-Gm-Gg: AYBFou3dfEU1vwtMWltvoTYQb79bxS2zs7f7f8bXc710Sf9ViPg362Pg6GqJAUSC2KK
	nUshZ5+BA9wcoOjQxD2seh14D5xG2dg+wttZBTGaO/JHWfcV81M5RjuLdmmhM72ISi3z3hcyisI
	xch4DJUriYjoc/YKCvCNYi1WB+GhAab5SjN02pPzvKOpHjNRwxt4yrEUmSZky3BZAOaNhsKsAPf
	2bpi9Febsl9XD64a91rmaNFDjrpM7o1KVLm4BjfRjLC1+2GbC/QKPJ0TlNvE7ZhiQjB2++oR4w6
	vWJzhSDppt8lm0Dv4eXPqmA5iN/rhoSFCqajbC9XQ1KLnZBS0wUBjf5F5rLnRTecxjOm0r2KZeJ
	+cg/+0val3WrY/MZ4kdgMaIcDzhHNsSs27KhYd+r3QUVmL7WXpx04vbGxSFGyh43XBOOiinRs9+
	V1Y7itzSOWhvCzpqx0KQWVAXFkUNT/kjnCMLGZ0CVwYulHG4A166jShuMy+eRTLmKJcK2soQWpf
	Uaq2e34yuUmyy9cdc38bwD396XOj8bi2Czmnu7I45GXOSHlMPyx3qoXBTz5/vQR
X-Received: by 2002:a05:6102:508e:b0:7a3:833c:49a4 with SMTP id ada2fe7eead31-7af1eff6910mr1786595137.26.1790289056631;
        Thu, 24 Sep 2026 15:30:56 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.30.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:30:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 00/20] Add HoG functional tests and shared/hog
Date: Thu, 24 Sep 2026 18:30:25 -0400
Message-ID: <20260924223046.605543-1-luiz.dentz@gmail.com>
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
 - with SCI support, requesting SCI Fast mode with the HID Control
   Point, as specified by HOGP.TS 4.6.1, followed by the connection
   rate with mgmt.conn-subrate, and receiving the notification of HID
   SCI Mode from the HID device confirming the mode has been changed

The tests are documented in doc/functional-hog.rst.

The input plugin is also moved away from GAttrib: the new src/shared/hog
implements HID over GATT on top of bt_gatt_client and gatt_db, as a
drop-in replacement of profiles/input/hog-lib, which is removed along
with the GAttrib based Battery, Device Information and Scan Parameters
implementations only used by it, these services being handled by their
own plugins. src/shared/hog supports HID SCI, requesting a mode with
the HID Control Point and enabling the notifications of HID SCI Mode.

With that GAttrib has no users left in bluetoothd, which now creates
the bt_att of the connection directly, so GAttrib is removed along with
the deprecated gatttool, its only other user.

unit/test-hog is ported to src/shared/hog, with the test cases renamed
after HOGP.TS p13 and the missing ones for the Report Host added, except
HID ISO which is not supported, including the HID SCI test cases
HGWF/BV-08-C to BV-11-C.

To support this:

 - bluetoothctl can now set descriptor values from scripts, prints the
   MGMT Connection Subrate event, and no longer crashes when the auto
   agent is canceled
 - btvirt defaults to the latest BR/EDR+LE version (6.2), so Shorter
   Connection Intervals are supported by the emulated controllers,
   with the new -C/--core option to emulate older versions
 - the tester can expect a PDU with no response, e.g. Write Command
 - unit/test-uhid tests the replies to Get Report, including through
   hidraw when run as root, which requires CONFIG_HIDRAW now added to
   the tester kernel config

Also, with -n auto, the number of functional test workers is now
limited by the memory available instead of one per CPU, since running
out of memory with so many VM instances made tests fail at random, and
check-functional uses -n auto by default (override with
CHECK_FUNCTIONAL_JOBS).

v4:
 - Fix a use-after-free in bluetoothd introduced by "shared/gatt-client:
   Fix calling destroy after unregistering notify", when enabling
   notifications with StartNotify fails, and hold a reference to the
   client while calling destroy
 - Drop "attrib: Fix unregistering notifications registered with
   bt_gatt_client", as GAttrib is now removed
 - client/gatt: fix use-after-free on invalid values set from scripts,
   uninitialized bytes when parsing values with consecutive separators,
   and reject negative values
 - Add "client/agent: Fix crash on Cancel with no pending request",
   reported by TestFunctional with v3
 - Add src/shared/hog, replacing hog-lib in the input plugin, and port
   unit/test-hog to it with HOGP.TS p13 test cases, including HID SCI
 - Change the HID SCI mode with the HID Control Point in the functional
   test, HID SCI Mode being Read and Notify only as specified
 - Fix the size of the reply to Get Report with a Report ID in
   shared/uhid, and add unit/test-uhid Get Report tests along with
   CONFIG_HIDRAW in the tester kernel config
 - Add "device: Use bt_att instead of GAttrib" and "attrib: Remove
   GAttrib and gatttool"
 - Honour PYTEST_XDIST_AUTO_NUM_WORKERS and the CPU affinity when
   limiting the functional test workers

v3:
 - Add "shared/gatt-client: Fix calling destroy after unregistering
   notify", fixing the heap-use-after-free in report_notify_destroy
   still reported by TestFunctional on the HoG tests with v2: once
   unregistered, the destroy callback of the notification was still
   called later if the write of the CCC disabling it was pending, after
   HoG had freed its reports.

v2:
 - Add "attrib: Fix unregistering notifications registered with
   bt_gatt_client", fixing the heap-use-after-free in
   report_notify_destroy reported by TestFunctional on the HoG tests:
   g_attrib_unregister did not unregister the notifications registered
   with bt_gatt_client, so their destroy callback was called after
   HoG had freed its reports.

Luiz Augusto von Dentz (20):
  shared/gatt-client: Fix calling destroy after unregistering notify
  client/gatt: Fix setting descriptor value from scripts
  client/mgmt: Print Connection Subrate event
  emulator: Default to the latest BR/EDR+LE version
  client/scripts: Add HoG device scripts
  doc: Add functional-hog documentation
  test: functional: add HoG tests
  test: functional: limit the workers by the memory available
  client/agent: Fix crash on Cancel with no pending request
  shared/uhid: Fix size of Get Report reply with a Report ID
  shared/uhid: Keep reading when an event is not available
  shared/tester: Allow expecting a PDU with no response
  shared/hog: Add initial implementation
  unit/test-hog: Use shared/hog
  test: functional: change the HoG SCI mode with the HID Control Point
  input/hog: Use shared/hog
  doc: Add CONFIG_HIDRAW to the tester kernel config
  unit/test-uhid: Add Get Report tests
  device: Use bt_att instead of GAttrib
  attrib: Remove GAttrib and gatttool

 .gitignore                       |    2 -
 Makefile.am                      |   31 +-
 Makefile.plugins                 |    4 -
 Makefile.tools                   |   12 -
 attrib/gatt.c                    | 1150 +----------------
 attrib/gatt.h                    |   89 --
 attrib/gattrib.c                 |  473 -------
 attrib/gattrib.h                 |   65 -
 attrib/gatttool.c                |  612 ----------
 attrib/gatttool.h                |   17 -
 attrib/interactive.c             | 1020 ----------------
 attrib/utils.c                   |  110 --
 client/agent.c                   |   10 +-
 client/gatt.c                    |   39 +-
 client/mgmt.c                    |   31 +
 client/scripts/hog-device-sci.bt |   49 +
 client/scripts/hog-device.bt     |   38 +
 doc/functional-hog.rst           |  204 ++++
 doc/functional-testing.rst       |    1 +
 doc/test-functional.rst          |   29 +-
 doc/test-runner.rst              |    5 +
 doc/tester.config                |    1 +
 emulator/main.c                  |   55 +-
 emulator/server.c                |   15 +-
 emulator/server.h                |    2 +
 profiles/battery/bas.c           |  327 -----
 profiles/battery/bas.h           |   19 -
 profiles/deviceinfo/deviceinfo.c |    2 +-
 profiles/deviceinfo/dis.c        |  340 ------
 profiles/deviceinfo/dis.h        |   27 -
 profiles/input/hog-lib.c         | 1966 ------------------------------
 profiles/input/hog-lib.h         |   28 -
 profiles/input/hog.c             |   31 +-
 profiles/ranging/rap.c           |    1 -
 profiles/scanparam/scpp.c        |  342 ------
 profiles/scanparam/scpp.h        |   22 -
 src/adapter.c                    |    1 -
 src/device.c                     |   46 +-
 src/device.h                     |    1 -
 src/gatt-client.c                |    7 +-
 src/shared/gatt-client.c         |   21 +
 src/shared/hog.c                 | 1659 +++++++++++++++++++++++++
 src/shared/hog.h                 |   67 +
 src/shared/tester.c              |   19 +
 src/shared/uhid.c                |    7 +-
 test/functional/conftest.py      |   58 +
 test/functional/test_hog.py      |  269 ++++
 unit/test-gattrib.c              |  552 ---------
 unit/test-hog.c                  | 1431 ++++++++++++++++------
 unit/test-uhid.c                 |  272 +++++
 50 files changed, 3965 insertions(+), 7614 deletions(-)
 delete mode 100644 attrib/gattrib.c
 delete mode 100644 attrib/gattrib.h
 delete mode 100644 attrib/gatttool.c
 delete mode 100644 attrib/gatttool.h
 delete mode 100644 attrib/interactive.c
 delete mode 100644 attrib/utils.c
 create mode 100644 client/scripts/hog-device-sci.bt
 create mode 100644 client/scripts/hog-device.bt
 create mode 100644 doc/functional-hog.rst
 delete mode 100644 profiles/battery/bas.c
 delete mode 100644 profiles/battery/bas.h
 delete mode 100644 profiles/deviceinfo/dis.c
 delete mode 100644 profiles/deviceinfo/dis.h
 delete mode 100644 profiles/input/hog-lib.c
 delete mode 100644 profiles/input/hog-lib.h
 delete mode 100644 profiles/scanparam/scpp.c
 delete mode 100644 profiles/scanparam/scpp.h
 create mode 100644 src/shared/hog.c
 create mode 100644 src/shared/hog.h
 create mode 100644 test/functional/test_hog.py
 delete mode 100644 unit/test-gattrib.c

-- 
2.55.0

