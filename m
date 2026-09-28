Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483403839A9
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625649; cv=none; b=N2TU+2TXmckQYzP5RVZ/UK+Hgj0CxBsnMB67+igz17Gwk6PSEbL8zgrcbJkUr/MLHVbltBN19flFDBrwdRd5yEFWdRGq8qQjj5xvPJZbbUJvtsnXBqpLIm+gnP8zJtVsCfM7DP5qVS186KuCxFqANG3yjeznwdoJ5zt6nza5sig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625649; c=relaxed/simple;
	bh=B6HBWSUpwbbziKmlshWoiCxE2QZuPoA2gBgIKJijrFQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FZr+DMbkAjqeH4JS9SwZ7E2Tm/a3dDwdK5Ye3C3vuKGEtKcalNMAFW64ypFpO4FsTUs08hHIIv4zxxTXCj+aClyWiILXdDG8jUHlngE70s2nHvV35oV8GmlPiAG8yDvoPm84gD9D/100awxln65VsekDFAvAkFfXmldUdEuWRFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLa8FLKL; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLa8FLKL"
Received: by mail-vs2-f38.google.com with SMTP id ada2fe7eead31-7b2eb9b9809so1735542137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625646; x=1791230446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jjDdK7vuVEHF2DvuVIKeFEAX1DAAMDp2186FKu6jMsk=;
        b=TLa8FLKLD1DXVZCc1dTMNK8ABq5DUZ9+zbOXxMIxtdf49oPaHtxGvoQ9hlbdB7h3PF
         M/e54W2h8w3sWXx5qtra18xq3s9abSdyl0p3xoQmAtXj4Im8sUxpC0dF9kbijipF3a0n
         wyLQOOA0jgxOq8R3iD542BL1iLE6H7yJZ1YYYn1UXbIVVWhhu3SvxUNwtC9Z+Q5tQJMb
         l1O7GYmWkLaskESHNn8dW5Cl2WYYavNq4IwEZIW07CgBb+e6eZPpB+WYgym3ElpvO3rF
         9vbC+JOs/cq1RkA/M41vRRkdSfdSK6BawtpXFRqDHBNZTFuvIvz4S4Ey9nq+/JBUoQqN
         Sm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625646; x=1791230446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jjDdK7vuVEHF2DvuVIKeFEAX1DAAMDp2186FKu6jMsk=;
        b=Zcr+woezNCKLOxpqz8F0pTKy4qBdyyAec4VKp8CdS2dil/g0sFenoiFKHoUL0IYGnN
         jOYjR9hPhMGbTa2OaU/ujK1Ic1r1aW3Z/nYwHELFxvc9h6vhbZd503nLjmNdBEiP1p7B
         5iy9W2EjAET0ulcBBBmSqYV0TnpjhnWPJs6AvLyGiLQFXyQH0B19lfSgpyYCds/psrOd
         EAbVAlnqMZrDasJIQsSU6ueV0PT0CXSQ12qwTvQ7MwDGLySyEIqObvwJY4HYdLONfaMZ
         bP7wmnZp9r0Nw/CSu8vTVykcTeDNzAmBOyLNFU1fTXy16l/BM4jU+DbxBs6t1dC7VWx+
         tNMg==
X-Gm-Message-State: AFq9FYInXtuFbr3oTtFa0765R0CkHjn4FZRnkXH930xXLbk5afhFOngO
	DvmjbePeGeZqNDVzatremLF2jSy165WyXBA/SwBxac6CS8BKDyWMWvaawgX3G28bprA=
X-Gm-Gg: AYBFou0LmKJfndZdqyjQueqLUHsHeT4gDuZS0dzYDd8+GpoNvQ07PCavsP9Knw66+QL
	wtnez1Yu8QFFvR9tmgUXRjfWQH9L+3pzMmo6wNXFR25kZ9yC4clZHtwcbyYmnrN2Fxz+NIc80vL
	nhnarzOuYb+j0rIT+AC1+Y3iFYOU8SucZWI1tZB9xurYntkSN6+J8ZUm6VRTljECkQcKWca/kKr
	stlD9wLusQj9zlDuoDo7wyNUaQGcr9xBUs+wqvP2XFtF7aUGNJbhmsnAecdRdNZD5MfqucrsAJy
	kIAi6O0kzeOmUi9w+bjPnm4KJtMqVzCBAbmqLrghZodhzcf1T2r3RQy/eIAlpxvE6Wld6AoYcw2
	qQpi0B0pQZSA5WnRasUKt4IjP8fjl19ZsmROQCiT73+SeUNsOAvR8ymgu7TmOyh8gIgb01MNH9A
	Lt/0QwUNzsAPV8ieyaTmmUR9EEVOKC1NyMKu7/zzWrtk67F/kLTSu11Om+BC0vxmvsPZmCQXYaI
	OdsvnxLA0w9IyGl6jNlLWXDMIW47MKs1eAOjJDtlWGPzGNUILkKn5oPkyceOkZjq4pUq4i1m74=
X-Received: by 2002:a05:6102:4b04:b0:7ab:1d32:fe30 with SMTP id ada2fe7eead31-7af1ebefd49mr4998263137.25.1790625645778;
        Mon, 28 Sep 2026 13:00:45 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.00.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:00:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 00/23] Add HoG functional tests and shared/hog
Date: Mon, 28 Sep 2026 16:00:06 -0400
Message-ID: <20260928200031.1209311-1-luiz.dentz@gmail.com>
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
own plugins. src/shared/hog uses a clone of the bt_gatt_client, so its
requests are tracked on their own, caches the static values in the
gatt_db so they are not read again when reconnecting, and creates the
uHID device once the client is idle. src/shared/hog supports HID SCI, requesting a mode with
the HID Control Point and enabling the notifications of HID SCI Mode.

With that GAttrib has no users left in bluetoothd, which now creates
the bt_att of the connection directly, so GAttrib is removed along with
the deprecated gatttool, its only other user, and then the attrib
directory, moving what bluetoothd still uses to src/shared/att and
src/device.

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

v6:
 - shared/hog: use a clone of the bt_gatt_client, freed when detaching,
   instead of tracking each request, cache HID Information, Report
   Reference, External Report Reference and HID SCI Information in the
   gatt_db, read the Report Map along with the other characteristics
   and create the uHID device once the client is idle
 - Add "shared/gatt-client: Fix calling idle callbacks again while
   notifying" and "shared/gatt-client: Add bt_gatt_client_is_idle"
 - unit/test-hog: drop HGCF/BV-02-C, as notifications are no longer
   disabled when detaching, the requests of the clone being cancelled
   when freed

v5:
 - Add "attrib: Remove directory", moving att_ecode2str to src/shared/att
   as bt_att_ecode2str, and struct gatt_primary and gatt_parse_record to
   src/device

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
 - Add Assisted-by tags

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

Luiz Augusto von Dentz (23):
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
  shared/gatt-client: Fix calling idle callbacks again while notifying
  shared/gatt-client: Add bt_gatt_client_is_idle
  shared/hog: Add initial implementation
  unit/test-hog: Use shared/hog
  test: functional: change the HoG SCI mode with the HID Control Point
  input/hog: Use shared/hog
  doc: Add CONFIG_HIDRAW to the tester kernel config
  unit/test-uhid: Add Get Report tests
  device: Use bt_att instead of GAttrib
  attrib: Remove GAttrib and gatttool
  attrib: Remove directory

 .gitignore                       |    2 -
 Makefile.am                      |   33 +-
 Makefile.plugins                 |    4 -
 Makefile.tools                   |   12 -
 attrib/att-database.h            |   30 -
 attrib/att.c                     | 1238 -------------------
 attrib/att.h                     |  186 ---
 attrib/gatt.c                    | 1249 -------------------
 attrib/gatt.h                    |  109 --
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
 profiles/battery/battery.c       |    3 +-
 profiles/deviceinfo/deviceinfo.c |    5 +-
 profiles/deviceinfo/dis.c        |  340 ------
 profiles/deviceinfo/dis.h        |   27 -
 profiles/input/hog-lib.c         | 1966 ------------------------------
 profiles/input/hog-lib.h         |   28 -
 profiles/input/hog.c             |   31 +-
 profiles/midi/midi.c             |    3 +-
 profiles/ranging/rap.c           |    2 -
 profiles/scanparam/scan.c        |    3 +-
 profiles/scanparam/scpp.c        |  342 ------
 profiles/scanparam/scpp.h        |   22 -
 src/adapter.c                    |    4 +-
 src/device.c                     |  122 +-
 src/device.h                     |   14 +-
 src/gatt-client.c                |    7 +-
 src/shared/att.c                 |   48 +
 src/shared/att.h                 |    2 +
 src/shared/gatt-client.c         |   41 +-
 src/shared/gatt-client.h         |    1 +
 src/shared/hog.c                 | 1563 ++++++++++++++++++++++++
 src/shared/hog.h                 |   67 +
 src/shared/tester.c              |   19 +
 src/shared/uhid.c                |    7 +-
 test/functional/conftest.py      |   58 +
 test/functional/test_hog.py      |  269 ++++
 unit/test-gattrib.c              |  552 ---------
 unit/test-hog.c                  | 1420 +++++++++++++++------
 unit/test-uhid.c                 |  272 +++++
 59 files changed, 4019 insertions(+), 9204 deletions(-)
 delete mode 100644 attrib/att-database.h
 delete mode 100644 attrib/att.c
 delete mode 100644 attrib/att.h
 delete mode 100644 attrib/gatt.c
 delete mode 100644 attrib/gatt.h
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

