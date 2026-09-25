Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFDE503BCC
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379649; cv=none; b=f5M4k/EDNb6R2gvYXStAx1Jn35gHpH9I9RNpdnhH/wdOpwcAtpSAxK8mCkvStW6J4itjGbmzZNRDb+2T+7wzgrtPBkjRAleSQj+u4LiEEfgVowUrxKmu3OT2mBnbiVb5w5u9EPmkE1SzpJigR1nhrk7Y5jtX59CXyKSSQlZXDU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379649; c=relaxed/simple;
	bh=RzREx1Uxjk3hzRbbgnHTrePp4jkBwQXN3E9MvrjrNO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuEIFkyT/SDJy6U86pOzMtE6l12w2yxUGuioaw6YAimU918IwVG5zqQxztMtTkNO6jPb2L5u6TQq4yzi8w4B9rVvk7EU3lkbnp/R4Qu5GExJycoaoI0v/DIjmVNrCwN+q/moSPn0B26rBU8DOPSvCBZiphSQjoSTTAhLQKpSYEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuDEAwM/; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuDEAwM/"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-39b2ad83680so282255a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 16:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790379647; x=1790984447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BQ5wuRbRUfsgbPAtkKgj0SL1PaDXyp6OqvLbZ3GzU4Y=;
        b=nuDEAwM/F6OtAwajUjOzGhV+CtoerhKYDFbVrQUqdF4ofpovvFsCveSUYBGQq4IbU+
         LlADnfQySD0H7kEx2XsYHIQx1b5Ak3B2j/XgwGsn5Kdmb3MXiqIkZ2Px7v6x8kQHVLna
         Nj2HbWUFSnS7SKteL8fR5lFic/6Nxp4brAvi6nibKvgwvcIs+40sLOr4rC50OcFMbvw2
         G1BDrO7yLqTHoa2IOYnMrphcCuN2kQlmaEFkPG6X38WtTckoYfXPEQpsB42A8gAVkfXK
         4VSB+bxYBwa9hjoOEtVxFG3wFpnSLFogbMwJohZ6+xr2gDMLOMObQuqUJ6TroYBU2ot5
         mSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379647; x=1790984447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BQ5wuRbRUfsgbPAtkKgj0SL1PaDXyp6OqvLbZ3GzU4Y=;
        b=cVLhxLNr4yKUUKKyJRvksNOSFaT9WywJ2753CjQZh/AucFNNZGhointcyoL5jVhFNa
         sXfAfNig942cfadme2gtDJD7ccnpGUHA/6rDgmki8qCEBdIRo1uIgXE/gG56Iz/HUnPn
         sCbODEcVGx5cnGCSSbRY0e3vsCmG78OwCYu2Y03Y6fqumjfZD9Mti/UKHQVOO4GowiLg
         WnTYuC9IbCDPsjYzmQB6y8RXMSiJmHISvNOwXraJQtt+ku35dgWAi16ZXZcc7JFDYAgx
         fSOUy+Bv71P1sLGuN9C4syn4XtyAHaDCqBCGecOgdIoRXxHURQqT1kPbFY9vhFI1SXBg
         T2PQ==
X-Gm-Message-State: AFuF++lvaZQNlSkcurLZ0TnOOJ2byzU2KI1rTXwB35la2G8pVF6gwNOr
	OmL84NBxvUJEnM+4FbpOsYta7fYbQnnyQBJKTwemeuO8YQ5YkhAJzND2mn2yeSP6NLFmyQ==
X-Gm-Gg: AYBFou2Zi4BXavaeVnb0Z/ZAtol3tEZwkoDRAc/2MLNCr3UPgJN48/fTq7x/i4CCfKC
	WFVFL1EEkia+sopTL06vDDKp1fl+H5nZ3GtNRTf70dznp/+AoUAXAYJNOcJRHiv9kZr09qMTk11
	giNt3Tq28beImmSGMfz2BBgv6yVh6hxlXUolAedEFhr1ozG895HcqoRuSGXRooLJZy1W8eLfkqz
	CkZD6EKkRXYb96b5ZkK8/MqAOtFxyJubFFZeOhrHfAH0bWUKHB9YHVImIJuQ4iKGUVVxGUmr95U
	4aM0sW/buLhvaYtPRNi8QerEU40qAgeowqwXbmencElauT30qrd745auDRZBH4WWO+fQFjV3DBs
	kGGnOZUklCgGMcM+GRPuOYXQPOcM0QlD6sFHEZ1o+aR+feUyXpsUTVF2b7/kcSfdZcMXZpSANNV
	I4bvv8UvUgQteQeyt7wRLLXvwOLNkF+nmXLZtLgAbVO1tHU/ahPqb6Xl89QLkmoaO1KP5gNPk5M
	Q+csS8rF6M=
X-Received: by 2002:a17:90a:d883:b0:3a0:4146:295b with SMTP id 98e67ed59e1d1-3a0987255a0mr5811902a91.17.1790379647458;
        Fri, 25 Sep 2026 16:40:47 -0700 (PDT)
Received: from pandar.dancher.net ([2409:8a28:881:a300:decd:fb28:f50d:71a1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b94936ddsm6706966a91.7.2026.09.25.16.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:40:47 -0700 (PDT)
From: Cai Yu <caiyu7372@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] Bluetooth: hci_intel: support the CcP controller (X1 Fold Gen1)
Date: Sat, 26 Sep 2026 07:40:39 +0800
Message-ID: <20260925234043.707679-1-caiyu7372@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series makes hci_intel work with the Intel CcP controller as it is wired
on the ThinkPad X1 Fold Gen1 (Lakefield, ACPI INT33E4).  That controller is
described as a serdev child of an LPSS UART, so the line discipline path of
the driver can never be used for it and nothing binds to it with the current
kernel.

  1/4  fix four unconditional hu->tty dereferences in the LPM paths and in
       the baudrate helper, so the driver survives a tty-less controller.
       Independent of the rest, and a crash on any serdev-attached
       controller.
  2/4  accept the CcP hardware variant (0x14).  btintel.c already knows it
       (btintel_get_fw_name()), but hci_intel.c duplicates that lookup and
       rejects the controller before the firmware is requested.
  3/4  add the serdev driver: ACPI INT33E4 match, reset GPIO power cycle,
       boot delay and flow control handling.
  4/4  download the firmware at 921.6 kbaud instead of the operating speed.

On the X1 Fold Gen1 (20RKA000CD) the controller comes up as hci0, the Intel
firmware is downloaded on every boot, and both the HOG keyboard and audio
over Bluetooth work; without these changes the controller is not bound at all
and no hci0 device exists.  The reset pulse, boot delay and download speed
used here are the values measured on that machine.

The version posted here is the same change reorganized for mainline (a second
hci_uart_proto instead of module parameters, with those values hardcoded).  It
applies to and builds against master with no new warnings; I have not booted
this exact revision.

RFC note: 1/4 and 2/4 are plain fixes and I believe them to be correct on
their own.  3/4 adds a second hci_uart_proto and 4/4 hardcodes a download speed
for one bootloader revision; the series is marked RFC mainly to get feedback on
the shape of those two.  I am happy to rework 3/4 into a per-device flag in
hci_serdev.c or to drop 4/4 entirely, and 1/4 and 2/4 can be applied without the
rest.

Points I am not sure about and would appreciate feedback on:

 - 3/4 uses a second struct hci_uart_proto with oper_speed = 0 for the serdev
   path.  The generic baudrate change in hci_serdev.c runs before ->setup(),
   i.e. while the controller is still in bootloader mode.  It only answers at
   init_speed at that point (and right after the reset pulse it does not
   answer at all yet), so switching the host to oper_speed makes the setup
   fail with a -110 timeout on the version read.  A per-device "no early set
   baudrate" flag in hci_serdev.c (hci_bcm.c has that concept as
   no_early_set_baudrate) would work as well - I am happy to rework it that
   way if that is preferred.

 - 4/4 is a rate quirk of one bootloader: it stops acknowledging firmware
   fragments above 1 Mbaud (measurements in the commit message).  If a quirk
   table, a max-speed device property or a DMI match is preferred over
   hardcoding 921.6 kbaud for CcP, I can respin that patch.

 - I could not find a way for the platform driver and the serdev driver to
   share one probe: the platform device is an ACPI device for which the
   driver looks up the reset GPIO and the LPM/wakeup resources, while a
   serdev controller owns its reset GPIO itself.  hci_bcm supports both kinds
   with two probes as well.

Cai Yu (4):
  Bluetooth: hci_intel: fix tty-only assumptions in the LPM paths
  Bluetooth: hci_intel: add the CcP controller (hardware variant 0x14)
  Bluetooth: hci_intel: add serdev support for the CcP controller
  Bluetooth: hci_intel: download the CcP firmware at 921.6 kbaud

 drivers/bluetooth/hci_intel.c | 184 ++++++++++++++++++++++++++++++++--
 1 file changed, 177 insertions(+), 7 deletions(-)

