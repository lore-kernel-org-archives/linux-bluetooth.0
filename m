Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4594E35AC3E
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026699; cv=none; b=j9S6kd+wOcQU6bVwFZDOw3XwOIfHXj4ZRXBa0q5J98kcNLW+pBdEFTmU2xu16W8kAW7MAdBYx18qa3l6zplb9vVFBAJzzE/90pFduCpbwz+imwXFMiWk2wHYeDr/1cQyxSbyPCRaqtYNei54YWqkinEbWHQ9rY8F3vvSXVPp+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026699; c=relaxed/simple;
	bh=CtFRpTExfPE8g2GDl2/TtYgg58AZvhQ7f6EKGqSMWVc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dw90vWwTPOKKve14J8DAbp44CAcMUGwY6CnPr69p4p5Qt1l81zrLesQcw2g3PJKtUKjwt4DLZEKwe16mAasoUB0EHn3XKRCSzajZYOCACdYsSOQ1ThIrb8wDSGkyMrOJ4Z3KiR24piYDbOLT3zf5gAcLx/LscLqHoLmHFTt7fV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Z29Y45S7; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Z29Y45S7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784026697;
	bh=ulJdzUOLI54kx0kFTmEqhxREI87Jl9gA0DSvLZHySIY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Z29Y45S7F90lH4qLRcw4dxSqvqid51riMdgBCoekC+ve2wr0gTA1C7L1DQCJKSCGz
	 lnc8aVSzyP2RG4vEOs4B4gzkIXpgQgCCft5H3jnswmYKo37ULyoXu3XbxZ0Iwybgfm
	 cBjRsgLoYyE6dvQ2T5yhxHcym6Z/Gf+vpfM4KFys=
Received: from github.com (hubbernetes-node-102c291.ac4-iad.github.net [10.52.177.52])
	by smtp.github.com (Postfix) with ESMTPA id 6138B9411EC
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 03:58:17 -0700 (PDT)
Date: Tue, 14 Jul 2026 03:58:17 -0700
From: uos-eng <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1127291/000000-6de9c5@github.com>
Subject: [bluez/bluez] 6de9c5: adapter: Trigger profile connection on inbound
 dev...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1127291
  Home:   https://github.com/bluez/bluez
  Commit: 6de9c5fd15cc9d1d3543a23a2ffc09cfacc3941b
      https://github.com/bluez/bluez/commit/6de9c5fd15cc9d1d3543a23a2ffc09cfacc3941b
  Author: Chengyi Zhao <chengyi.zhao@qq.com>
  Date:   2026-07-14 (Tue, 14 Jul 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Trigger profile connection on inbound device connection

When a bonded device initiates an inbound ACL connection before the
host sends an outbound one (e.g., after resume the remote wins the
race), BlueZ accepts the ACL link via connected_callback() but does
not establish AVDTP/AVCTP profiles. The remote's subsequent L2CAP
connect for PSM 25 fails with "security block" because the link is
not yet encrypted, and the kernel does not retry. The ACL link stays
up with no audio.

Fix: in connected_callback(), call btd_device_connect_services() for
bonded inbound devices. This initiates outbound profile connections
from the host side. Unlike inbound L2CAP, outbound L2CAP is queued
by the kernel until encryption completes, so it survives the race.
Safe when the host already won: the function returns -EBUSY if
dev->connect or dev->pending is set.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
