Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADE2673AA
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258174; cv=none; b=jUSeIPK4YY0ZVJINaLOlEjIgCvk+2Mz2/7vG93a+BtpXcOHZ9ZpuPh63aBV6+uCaZ87LHTYBWEdM9rrzs5Yw9YZ6pWUsN71aFkHNmKRnCqHW9pwllEofDx7JaneYGxJEsYV+X0Kc2ZFXI6C3cGdr90frwkubm0MQ8gqwbYwts/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258174; c=relaxed/simple;
	bh=JIHSqVj2uBLBMviuc7dpANILoriZD5BkRfbACr4Mg48=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EQTNpqAVqwM1aRvd55EICPsSWwTkqrPhX9bgx4kaBwQfkWzAMVEwrCBZIyJvtIO+2pUn9dWOsMbBe+rIWmcJ2amyM16f1T9Wrnr8D5wDD0QhgAowVHDeWqwyMGFljVKJKxWobhSw5JfHzkXeDzKlnH3TwKgxQE9CTp4Rn/CAUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6N3KlDw; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6N3KlDw"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-785692e59a4so1087783137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790258172; x=1790862972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mCPEAUXGiz6cbWBJSVm8BP79HYLb7Afh8BZPkZfGzyY=;
        b=e6N3KlDwAeri/PUtPauM0tUpsO45TNg/rP7+GL9aLHIqyWqJJcVT2Va8i8SYFIavwt
         Yie0ijxkaQDsWzSGambcEE1lAsk0ny/L/tNM3ZxImp8bcbNxCsvRDj61xA1LH2OVQyG3
         Id33lF7FhIU7zjOaedFTss0QbQ5idgZ00D2O5zTHWZ+LeqX0CUXAg2LsGMFsDFiBUV++
         4bt/G+6INt4yyiVkepcm/Sug+oAkXDfVAszPndIcLm8M92F/bmiA1l98Sb0kkrbrHpaX
         0hT+ffOHcoaAZjNEtLDlL6wSCIEWnnRDjWNTuLRZPKF8RgwGYwNij/dc4NZ89Oc5gdWf
         z+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258172; x=1790862972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mCPEAUXGiz6cbWBJSVm8BP79HYLb7Afh8BZPkZfGzyY=;
        b=JhQRxorovo4+dFpJlW9oU/AGPhlm2bsIsplR4CosO4GDKKax9TlKo80Bdaa0u/z3JL
         rKjCEmISFsat6GrKUuMsICkkU/ZCafbShoAgBz42sn4zR1Y+1zp8my8y1jeW06G5jmqo
         dmuF1UU67jTwx3/98owzsAfffs7PkirhM4Jij6qa/vCVOQ9gedbyT0GEgMsuna1j7NcF
         gwBurcjFgfAVQCLl98f4+WO37ev/KYt2r0dpgfadNbJiPVvYtwE4RYBKLA+q+PbAZrs0
         jEV2MDDisu8cqA/8Y/cIQfZ2R+hry2OMQxUSNsmFHTxzvrIuM0OuyHo2lRoroXUlarnK
         jZ/w==
X-Gm-Message-State: AFuF++nVUAySBH4wh4lwmmhGObzmwvE+DpShgJiZKz0vLJBkdCFt7SId
	c50NHqJOrNz2mwXHIWDkcbHiSgDl3DrKxRx4TSBPKLvgxgqcVz0dJcjTLvyChs8tqZY1AQ==
X-Gm-Gg: AYBFou0TzsHxx+nzrBoTqN5WMwUcJ+4yh8g/kkg9z00prTiT4HOXkwFX9qqeNXKykuu
	+v1CLtnwycF/vVEHlq57w8oxhPuUn2f3yz34WkIWzCn5kMlcQmKTkBoX9zjHd1/wWJkjT1uG+kS
	z78zmV5EdIUhtEM2+FA911uQMJoc9N+gXFGFHJw6uNuD8m8QvGETXdPeuZFa8sW/wUtObijnQ9n
	wZUjWL9qT2aPcETlMa6WV0yiM9gN272GTFZZRHrhVBDVAu85Y8GMGnUSuTog6HPFjSccxRypYQn
	TcTcRy4EVcUBpZptHBhbPwsbDAd6ref5lG3H+OtOxNHle55fNxaj2b9Pdj3WnfSUhu+yeHAR7/J
	7Eu+4yXii5uZwAH8iFzajD88K9Gm4/TLYpcGgi4FytJVCGeu4gfGfX0AjFZf1Bk2KMmNDjmmBae
	w01OvdAMIpNQ8ztodQ1yewAfKU14Ozxb9y9qvcTn+ivn0BYC+g8Qlfyos+ZwTyHBTvJHtpD8nyz
	5RlLYCGXSTg/cD/jxiitaiWZD4HpzC5UBwByG05Vk1ZmlT6dMo6eyiErO/teDvc
X-Received: by 2002:a05:6102:6883:b0:7a7:19aa:8a83 with SMTP id ada2fe7eead31-7af1ecf279bmr1413629137.30.1790258171921;
        Thu, 24 Sep 2026 06:56:11 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7af8bdcde81sm1493194137.10.2026.09.24.06.56.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:56:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/8] Add HID over GATT functional tests
Date: Thu, 24 Sep 2026 09:55:53 -0400
Message-ID: <20260924135601.330277-1-luiz.dentz@gmail.com>
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

Luiz Augusto von Dentz (8):
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
 test/functional/conftest.py      |  46 ++++++
 test/functional/test_hog.py      | 252 +++++++++++++++++++++++++++++++
 14 files changed, 785 insertions(+), 39 deletions(-)
 create mode 100644 client/scripts/hog-device-sci.bt
 create mode 100644 client/scripts/hog-device.bt
 create mode 100644 doc/functional-hog.rst
 create mode 100644 test/functional/test_hog.py

-- 
2.55.0

