Received: from mail-ua2-f31.google.com (mail-ua2-f31.google.com [74.125.226.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E353A39F
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191926; cv=none; b=W8lCnweGtCAiZsqAA7XYFlxtsEzGe0Enx7N6IExbNz9yrzaukbALyW78g4habOMwfxsfTAH+3fcfBAloweFiQ3x5sheLeFTWqVpySHPzClabkl4Bb0yrTXxXOOygoceQI25JuzIJIZ4J1XTBFvb+E1Fbm5fXZO4akZ081dS7A6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191926; c=relaxed/simple;
	bh=pErLeEFCQ7spLzy92c3ZYyKutHtK+q1gib9MnHq066Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FlxFlt5WglHEO5AdLRj+v0L2AY3b/No91BZb7refHLtr5q93Drb9xVTTx7NQ0JJVuZaluQzxvSC3qXTgpOJynqpwpBWHwTUcMb8spMoGQdlwVC7H84Qm1VIyNja/kVv0onAhUfP53gAYaCz+hYljv5uToNkRWiEMmKgBixQZnoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fo3LuV+V; arc=none smtp.client-ip=74.125.226.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo3LuV+V"
Received: by mail-ua2-f31.google.com with SMTP id a1e0cc1a2514c-97e96e461feso470135241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191924; x=1790796724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8LnevY8NJOx9zzuvIdBVmoCcdYav4oPrc7QaKZmK6A8=;
        b=Fo3LuV+VUwYliF7pSrCBdsEA14io3yBcfSnyTvKX1zgI7pLnRpPwlvkIEJ9gJx1RdO
         D96iFam6BE4Fb3FfBigWHxVAdtWbCW75AXHQ7B3ncbVDZkSdZHBZlJ/p1W2F4DQcqX1S
         cEM9JhzGik3C+h2gr2vkfeNaESMDWbgGlj6nVX6pqXwIe0wFRMn3rByeOeVjOtBJQ0FP
         F9yI6Xk6z25CwnmyTcgNBLU1Y/Vz+Vzy/e4c5m/6HTBGMC3cdFVk1Cr/yQMXEMytDG97
         iOxOu8NFbwNTWBxxTZEz5eBdOhd1QZSBdxT0pIu6sm4l90VQSQFJVJWcE55ok7OdpAZD
         DK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191924; x=1790796724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8LnevY8NJOx9zzuvIdBVmoCcdYav4oPrc7QaKZmK6A8=;
        b=VvRpom6b3KmurrRA2Ghk27ZJBeyTAoQiCCr8+SGYQiAKcnelRA01x5oNQ2PLMYalN8
         ce+lwPGBfsIPh1slVo0rm6gz112/qqrJ4m+BGYycO59fuLcD+7mzhomNao7leq0l0aNq
         NyQ1SviJ2m2xUe6ITVXY2Lh1BE1f6JiDgLBeVr9Cl425BcfWU1Nz0PgFywOkg8fXlUEX
         0jAAfOyWrCAVZAd8xM9BGiNLijUxnAaxWnokPC4EnYcalHSXKmAEEQ13mVm3+JSHMEDn
         RmrLjpgCMAu7ysNDIuoqMiemJGBNPXQ+QcXu/0J746SBUDJWxiS9kz6/jADV1jBX3K1g
         T2FQ==
X-Gm-Message-State: AFuF++nRSI2t/bJce+B4Ie2ToJyjmeF0xnd8QP+0IF3Otjn2RLF0kdmd
	YJsb59UHHn6kDngYEVOfRdijIMVY4O50BT5+WNXgh7M85re1q9+TXuo2BSvmhspy98yx1A==
X-Gm-Gg: AYBFou0HGiEf4BK8FdDzYtdX8wB94e8oieC3AdiKeGUI7LurtgPxQH6JGkcZng0yIet
	/W6XGgz5NY9s8DHx5/E8hiLB4swOL9fiY3dpGgnhdIFhIpKHY+ZeKjRN16EbJEeJtGLLA8RuR/w
	DPaRmg4vTDVYTcICSTF34h+21/UQAfP7q4U73QuMl81qO088MKo2UmpT0cDK7w0nmu/LrTO17WO
	yzMeqF3zhfpPw/35rsDTY12+dns3yJER6FIdS4QfpF3peCtx91RfVztVz8+fWdPufSotjFY6Ywy
	gZXIZH59ZTf3cL1KAbqI7SGJwF33pRqLeHzcz0jOSZH52NI/rButSDZOIjKPq3K15NX2VRU4pvI
	AsRwWHzE5lZu5UzHsTsosV1ZLVvCm+o/us9y/2lFn4OeE7ergzWRJYN3znX2TfBkaRQdwlXhsMW
	Z1Ngn/LuQcDlHAA9jiUzgt78NxLd5pJU2Ach+NupaZKj8LEy/O/w9fOlcGU4od+Kq2JKZNq8xEA
	R9/4lv9kdrIJQZB8ZVxuUMO2fby8iD+i2F9OUsvRPDa5YTBhbGkkvLvj37RWqi5
X-Received: by 2002:a05:6102:f0b:b0:7aa:7769:34e with SMTP id ada2fe7eead31-7af1c58fa74mr215367137.4.1790191923917;
        Wed, 23 Sep 2026 12:32:03 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9851691693asm4666266241.2.2026.09.23.12.32.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:32:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/7] Add HID over GATT functional tests
Date: Wed, 23 Sep 2026 15:31:50 -0400
Message-ID: <20260923193157.249636-1-luiz.dentz@gmail.com>
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

Luiz Augusto von Dentz (7):
  client/gatt: Fix setting descriptor value from scripts
  client/mgmt: Print Connection Subrate event
  emulator: Default to the latest BR/EDR+LE version
  client/scripts: Add HoG device scripts
  doc: Add functional-hog documentation
  test: functional: add HoG tests
  test: functional: limit the workers by the memory available

 Makefile.am                      |   8 +-
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
 test/functional/conftest.py      |  46 ++++++
 test/functional/test_hog.py      | 252 +++++++++++++++++++++++++++++++
 13 files changed, 722 insertions(+), 12 deletions(-)
 create mode 100644 client/scripts/hog-device-sci.bt
 create mode 100644 client/scripts/hog-device.bt
 create mode 100644 doc/functional-hog.rst
 create mode 100644 test/functional/test_hog.py

-- 
2.55.0

