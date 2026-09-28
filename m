Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C37B4D1780
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616776; cv=none; b=ApcAQjtpeHPMaXIqO4E74ifH9ws0AdmqkYvya2SYWmnZCUrP/I8xDGjTIiGcdswZ3Ln9NYfm+mH2rSqFFuUAO83u9unrD4jPFzm6ZQKrgQaOfRw31KSRaoSN0LP7IHri2akb56PLBCKYq3/FBLGCm8lgyGf1hY4bzL2DY0kvRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616776; c=relaxed/simple;
	bh=eH+pcJiVQW458ZM27KfQbf0qnRAuGsQ5f95oi8We4o8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E1i12aWSiYhz2zh6crgWwFe4PkvzpBUslKfSSvhLddnYl3MAiUtG1RWy4oSCxu1i7Ny7Okr2Och4YiEdIQFKDNohmzf5VNhgGqAqcUtz8bHvoUEKAVujc1ggs50Nrlx0H9WcXYW4fhvxHEuGXQOphKyOulypB9K54g1Vc9NFnYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=an7ME+j9; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an7ME+j9"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e97e2c7b3so1815747241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616773; x=1791221573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JHL8RWlcYDzJCOHpnoCSy7hiUjJd6VzyKLtKO5nB3UQ=;
        b=an7ME+j9GRhf2nfMdxgLYyqUa2jYvahKfI2Br7/3tXElySrQPk4GOvFz0q582UxCTb
         oB09lL9GZrcZT5cLsryP+3Ye1maKI0DynyYeGB930GGxRLapIeAKXKQm6t+/NSAxvWUI
         SJc4xYhFSwLTeH0AewbcoEXbqDHWpt5YCMLhm19YVSoi4SAfS4GTPe2TNTU63hnrquFF
         WCZZeSlvFJJqzrZqpD7rsG2gnk1/uRewRXQfZ9vnOr98s5Hyy9m0l809kM9l3dDmUrEx
         QjN+xVgfPBLM1owHEIUuWhyyMrUIfGLK0IGSD4I65QIlnImtmiX7fZjvDx0mYdYJFErT
         Bsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616773; x=1791221573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JHL8RWlcYDzJCOHpnoCSy7hiUjJd6VzyKLtKO5nB3UQ=;
        b=Q0ZF364SEC7XhCVjf3cpDt9pm98nXUQPHxTqYawwghb8CxAvZxO1kUO1l6t/daCiWa
         jU3l6C2sCwwdcewaF+bDsTOEdP62/g8Bk7COboUs5gAnLjVJ0+xCrB0EpFCkAcsP7c/2
         hIWcbSNkUUCYMNfFa7/Qt1/PcdTXv5wRzfUvwB5KqQu1lyqF1aNkkXqKKtZBXrVj0/l0
         C9iunUP+KBWoo/n5Tqdn6yG0T4wvYyYqCaNCwDd5Wq++xQ+jqEr+Fn+02VtDvzy50Pg/
         J31LKq/+YC8if9YRsITN3rixE1AaP8LRKZMjcSk95Tty94LLV/4xYdd0OKI54lM8c5aG
         iekQ==
X-Gm-Message-State: AFq9FYKgp2RPWx5tPfl1WWvdEh6vGb7SlMpw78YLkHZzn9WH4eIFzDk7
	GsgxibGYJXCYveMWe8LFVVpp+GSBAebUS23olZsQ2GSvlTwMjCawZheYsuyfN1grwrk=
X-Gm-Gg: AYBFou1nhphKqySYZkiKImX+wyqCUUO0CwL2uypM2Esw1TokvXQUclqZ9ZRVkF/pdsa
	ckvbGc5okJx/5cQCbn+kZj7fDLj+FJfsBVJUEuc1EfbXZQtKTUNfB4O0nja+dMParildfGrCP1x
	jy1uO/Y11dIHqdfaYc6z7b3VTAQJ4qxQ8MASNzOL6wGgjI81GT4phA5QedWV8zbncSpUwzqtnbk
	4h3rgV9iT9U0BTbNFaiGyT3yzoM7Z536FDHuiRWP5tpidZS2YhfJr4mIGpjqBV0aMaWpRcy1hOw
	DYU+/Mu2iSjPGZDb05Lt66OPgJo9RsVTzG2aTMjSiLPgRRg5UI9elVbeGKVjP1CvCthiioQTKCd
	oqhk5u8bajzjJB5y2+cGtk8Soplcbao1PR3YbzwWqUV6qNmWdxI3kCQ2mjoZieIj7NEK5GlzNb4
	oga2iMHtJTUyy5iJRfwM/RhOJ6kQkeOjqi374fWHGvrUNvvBuhLPv2j6JDSmA+rA0a3LiGNhGsI
	8c5FoMb59VErAACsya0hy4IdqtwKEtgFwX5/9Recfp5zKk0Fn6M19E8payFBddD
X-Received: by 2002:a05:6102:4188:b0:7a6:dfec:3643 with SMTP id ada2fe7eead31-7af1ebf3435mr5826012137.27.1790616773033;
        Mon, 28 Sep 2026 10:32:53 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.32.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:32:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 00/21] Add HoG functional tests and shared/hog
Date: Mon, 28 Sep 2026 13:32:19 -0400
Message-ID: <20260928173243.1073509-1-luiz.dentz@gmail.com>
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

Luiz Augusto von Dentz (21):
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
 58 files changed, 4106 insertions(+), 9203 deletions(-)
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

