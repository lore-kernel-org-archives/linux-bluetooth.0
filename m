Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8B3C1F31
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602338; cv=none; b=R79Qt7XZp0g3PbK4M4vG6YjQ+KzgqyR4NqKrZDYxc2DvvjZzFt6Y8k7aG/sLcMGQlL1mK2ZDZBQWtNBPJCxQFMvdlgNsa0XV+nJb+nOt99xlcxJWLYu3SaDK3Vq5IJr8TgiPTflGEEh9V6Oua6106x8YJ1+5GAbAyBBfG84jDcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602338; c=relaxed/simple;
	bh=y2+z2tcRgHCayPQhbQYha1SAO0N59bDnnDJNsbmLTP4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=liizGJJxlo3YuXq6IcFF36FvWFhmxRo+CpUvRteDJ++rfuTdlZWuIlI7haPzXkjjitmFFsD2Qj1czUs5Px2ME0M974GDZPcXVV6ZwxUsuSlzdBg1uto76HCqs7+lgUNZiEHDeRiQDr8daU3UvmLjfi+tzuwJfIO/Nc51689ecbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KC1dV7hu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC1dV7hu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49fd4e9e1f6so237395e9.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 20:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791602333; x=1792207133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JOwxQUStVxow2E3vGaa1SOF2WKO9sirLhRCiSFdWLsc=;
        b=KC1dV7huRr5D2ltlXALMh4iHsJZHiyihulYcEa//aOr4iX3kkwIVKTGG3aroDufzo3
         n7FDbDBXaGNNwrAIuwQ0lgRBxNtKoJ1MoMQHhqx7+xhtFvstApggu43cAlfmIKjMb9JZ
         PwnDhrDleKEKnGCWjSW9qunwCTriwcSIIj7sDtaJeeRubNbJwhYF9zRDa6fgTzUbFdMm
         O9JpG0eEdGqbp61yC6ct1/y0jw6S72d29cWjwqzRqfVpHDY3zb0qLeqMB84CtE9ewtzl
         G/rDie16062G1rA120SicHd4fXAWr390pC8BMHh5XpCIvE/bjI/K+ELDQkAkREumI8u6
         5Efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602333; x=1792207133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JOwxQUStVxow2E3vGaa1SOF2WKO9sirLhRCiSFdWLsc=;
        b=mS+sCz5ZyVyNokKNmqejYsk1LU14hi9AKVnyerkBHnXlm/f7rJc3uFBI+Su94H+cTG
         UYuX4KuCqap+lv7vlbzCNBm7Y/Ic/XuBoDy/QD1DfEkMHm4+fzeHU9sZATj/vJSIyNnu
         UygSePKj7v5Cq+El1IxCUBbtfefqA+2YEW0eGe2mVxsU37wVvWMfni04WU+mpUY8uHfi
         R2+wpMU6+ofPT6cv2ZdiBOJjYejIhEV5ZS4wvnNlj+M+8SwSI+QzrIQvVPv73h+gPjXp
         Wb9yr0AonGa6Ow0AfHQpYlc23LWVzFpOEOf14o+hd06aQD9owIAggP1tEpJ+GheswzL+
         AHBA==
X-Gm-Message-State: AFq9FYKgjs89MQEWsQBIYyHpjAX7bL4XuBZZVxE14JRvjZnO4LZCvDZD
	QTrkUViBMWbiTyv960v0o5zxr1F/ws0kxX2ysrIoqHIvIlpWSORpx97qoe+b1FZIS3Y=
X-Gm-Gg: AYBFou2j2lcEXmp7dUTaSn6WUIhfXBvLGHxtWPdabVOTquGA4GRZYy6H48REM8Kakyy
	T3OUldnHiW5YSwaJYAE1psQ0IlyWI9M0qEp4CZsUwSj1LWI6X287+4+MhL8QNXktkJqf9erqMm8
	XJfhz1aVHNgQ+Z/oyGad+IolwN8hmrtgVE8mkgAQBDVDNkB6Ri7BeNqUizdQuTOXEyXDkM4v9Un
	whg32pzibokcUoous64YY3xH0SYZBnkt7s0XVDR1u61lfA4etUP0hW188xZ/OofNYdumLkn69F/
	3zLUQi61gUjZED10+dSvZUIR6cjhHzrFZVxdM1bafDSNKt/nBIeTHoGSAI2EgnIS+Oa/FjOUoDm
	eYV+qtnr7JYAumHZju7Ry8EcXeS4U2c4MWHAmyQiAtB6fr/AV9kL7W/aBaNXBZ87q/ZgKCs69FS
	xY5n53z+18fpffoWbgi7D1KARz14GXVGUM/HJp/l+k0Hmgy9gX88CPC8NJuTfiMS1TkXoxSGou7
	HBCnJIFi01TKrfL/cNXr2ykItIG2/oJnE4TdD3wTnrGyhlchCz67iQ=
X-Received: by 2002:a05:600c:1912:b0:4a0:73b:a222 with SMTP id 5b1f17b1804b1-4a18e3ee97dmr64486325e9.0.1791602332871;
        Fri, 09 Oct 2026 20:18:52 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2caf4sm110270805e9.10.2026.10.09.20.18.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:18:52 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/3] mgmt-tester: Add simultaneous discovery stop tests
Date: Sat, 10 Oct 2026 05:18:48 +0200
Message-ID: <20261010031852.2842893-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests cover the kernel bug fixed by 96d006ae6445 ("Bluetooth:
hci_event: fix simultaneous discovery stuck in FINDING"): with
HCI_QUIRK_SIMULTANEOUS_DISCOVERY, an Inquiry Complete that arrives
between LE Set Scan Enable (disable) and its Command Complete leaves
discovery stuck, and Start Discovery is answered Busy. The fix is in
7.2-rc1, 7.1.5 and 6.18.40, and backports for 6.12.y, 6.6.y and 6.1.y
are on the stable list; on kernels without it the Late case fails.

Patch 1 lets a test send an HCI event from the emulator, patch 2 sets
the quirk through the kernel's existing debugfs entry, patch 3 adds the
two cases. Late forces the racy order; First is the normal-order
control. Where the debugfs entry is missing both are Not Run. Each
case takes about 13 s, most of it the kernel's LE scan timeout. The
emulated controller is LE 4.0, so the cases use legacy scanning; the
kernel ends extended scanning in the same le_set_scan_enable_complete().

Tested in qemu with 4 CPUs on bluetooth-next with and without the fix,
and on v6.12.112, v6.6.158 and v6.1.189 with and without a backport:
Late fails without the fix (no Discovering disabled before the probe,
Start Discovery answered Busy) and passes with it; First passes on all.
In full mgmt-tester runs every existing case has the same verdict as on
master, except two that time out intermittently with and without the
series: "Pairing Acceptor - SMP over BR/EDR 2" and "LL Privacy - Remove
Device 4 (Disable Adv)".

BlueZ's CI runs mgmt-tester on Bluetooth kernel patches posted to the
list, so once these cases are in, the Late case can catch a regression
of 96d006ae6445 there.

The series applies with or without "emulator: Free hooks in
btdev_destroy", sent separately.

Iaroslav Voitovych (3):
  emulator: Add btdev_send_event
  emulator/vhci: Add vhci_set_quirk_simultaneous_discovery
  mgmt-tester: Add simultaneous discovery stop tests

 emulator/btdev.c    |  11 ++
 emulator/btdev.h    |   3 +
 emulator/vhci.c     |  15 +-
 emulator/vhci.h     |   1 +
 tools/mgmt-tester.c | 395 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 423 insertions(+), 2 deletions(-)


base-commit: 7428ca2df9356363079db0f48412c20cbdb9471f
-- 
2.43.0

