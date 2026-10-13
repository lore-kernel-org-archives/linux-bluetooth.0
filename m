Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE647045E
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862945; cv=none; b=Eu/hxG20WwTzeO+v0q0Tgy0uDPgHjWmhTtxre9P+EM0DD6oZMx24+7EupCzGo5EC2qs92I0BTVFjYtK6/cLvnOBH3GwfZasyIM6MsveM3dlPBOWyYbtLu9+zwZcRTT8jgAG4wAlukRQAcN6KZp8Vw+llrA0xTtNm/VzTae6eyio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862945; c=relaxed/simple;
	bh=r+0rEvl16tl5MFS7IvaIWOTr/Pw7YJ+JGqq+rLFp9v0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vGhRPBK2BBi6YXSlwRFF7DBqsOS5c0KyqWBd/EorjpMfXl7aAW4hKhDPAqHOlU3UHmHPHoi6aTf3lHP1/yKpfsnZyhtr0P6mFBSZEkKpQzVanmTehc1+mle3YU5V6aF/sdDw6xHTWBgKkyTDYsq76SuxmvkwVcmCrv8uC+2Uszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSTvWEGG; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSTvWEGG"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so1796288eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 20:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862943; x=1792467743; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FcWhYyMaObwSepUpV7jMJrwtLJljkaTCoJTBVFoTJKo=;
        b=SSTvWEGGy+9t+x43ncKuQSN+1W/Mmf6qGJgTVIcQWn3hBDHT6eaWSx/kKyU1HvwGLO
         GbW0rzpiuIHU+5wG1ohOfQIvFH1paE6VUtcHd8IC+XQjrK0SA/Hf0u2U6waAhP95FiI/
         8nEbfsS4cihUFXupVXEDofG6ZW+9YHxgERFl2z15e23f5EOB72eLKEW0BUXOWsEMBbbb
         GU8t+mK+jEEpwPDAbnR4CbAq7BlquaYuoFkgDaiok5gHS0feosILKNW7GVGfMuRpLnOP
         xCd2CU3l4eYrBG5rzRvuAaEDV2B2aqJk+G023onWsVpZXVesNOeSVva3cvBSFt5QU5fa
         jDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862943; x=1792467743;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FcWhYyMaObwSepUpV7jMJrwtLJljkaTCoJTBVFoTJKo=;
        b=f9pBDCmf97hw7bI5fxU7tC6Yyr+2wzY/E2dbNnhtSk7NJOb+cWf4ubZUvACX1H6owr
         f/v0IJ9urtQ3DFjbz0yxo5KVQHOVBo6ZxaOl7yWej9VDs7+pTDdPYPxASnzDwaDCnWeM
         oBIfjkE57+F/OJbK88YgcbkspBiVtBicDGU+6ys48dsidIjV6BDpr3XVJhLWviqLnNLd
         WC6nkOnAGkpDJ05iST9AGZJxUaHuW2PBwZbXLay6C8umAa3DC2NA/+murO9OjauW5Uqv
         3o+FXs1d7sWzdtmDfLj7x8dLT8zH0FmGxHua74wg2ifCfMw3ueumqutP9P/YeqHXr84j
         tWBA==
X-Gm-Message-State: AFq9FYI1bIR+v0b7JP28NcWR397ONBxic133Mprmz3skYjR9HJy4FjZ5
	GMB03LMCzxWCwufv2atdmRgZEQMKZYJl9uDg3KMbeD7jYfgKsW4VC0lh
X-Gm-Gg: AYBFou3l1GCbmCyVWo4Hh6gSDgWnlTPHeUuhuS6LHeKg0YEjgPftgHYJHcKHKINTuOv
	kabrmh+mk9r8/9EcN6+Q1ScaZD5NolMtpVvzxsCVJGgym/pfNxAI0Cv7wSARn4aij2uZVIA2rR2
	XFeB8N1Hu+L3XX7qhmKL2Z/3fnwv3x4GGW75CTmhjlO2sIdh1HeJ/SRLH+Y32x1+LGJUlBEyLgP
	jGjDf4c7vnA5teY3bFVnlcoMr/2JUULNJ9yKkK1i0f/PwB3vPhfvu8URmpSeRrFY5WuUYgsrRLi
	ILdqBsslWxjk3KeL86+OZOMIWEEDtfiPK3JFtvdF9pvnw7l+B3XEqrgusFG9wzsHhiP9M5zzrfe
	ma6TZd+/g+0TwWoH1BMLlQ+WK1nVmDUTVtUmMRiQiJ6mjKWIX5T0x9xRphbtFP5aId9Axkxn6y0
	vAw70LE5tI4EOy9diPZhPyL/P4ZdJrMxiLMNdVZQFDKtld2VHwWBvoh5vr23JH+W6aV7tVEwipW
	ir7L7PrN5sE+/8MIyxpZCyHjlirMzyPzuEw9+xvEO3jNZ1Xprc2HxS5ZcZLec85Me5Swp+qlg==
X-Received: by 2002:a05:693c:87c8:20b0:358:90dd:78d with SMTP id 5a478bee46e88-35890dd07bemr11938388eec.19.1791862943383;
        Mon, 12 Oct 2026 20:42:23 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35268677eec.29.2026.10.12.20.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:42:22 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/9] HID: Hardening report validation and unnumbered report
 handling
Date: Mon, 12 Oct 2026 20:42:16 -0700
Message-Id: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJiozWoC/yXMwQrCMAyA4VcZORtYK3PFVxEPMY1bxlhHWocw9
 u5WPX6H/98hi6lkuDY7mGyaNS0V7tQAj7QMghqrwbf+4lrncdSInEzQZE1WcKNZI5WaYWAKXTy
 HjqmHOlhNnvr+zW/3v/PrMQmX7xGO4wMYWcr+fgAAAA==
X-Change-ID: 20261012-hid-core-report-validation-8ca85d385ca7
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, 
 Frank Praznik <frank.praznik@oh.rr.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Even Xu <even.xu@intel.com>, 
 Xinpeng Sun <xinpeng.sun@intel.com>, 
 Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Shashikirana H K <shashikiranah@chromium.org>
X-Mailer: b4 0.17-dev-e56a4

This series improves validation and consistency across HID core,
transport drivers, and individual device drivers for numbered and
unnumbered reports.

Bluetooth HIDP and HID core report retrieval handling are updated to
properly respect the kernel convention where raw report request buffers
reserve the first byte for the report ID, using 0 for unnumbered
reports.

Report descriptors mixing numbered and unnumbered reports within the
same report enumeration are rejected in accordance with the HID
specification.

Report ID verification for successful report retrieval transfers is
centralized in the HID core, with a new device quirk to accommodate
buggy firmware (such as the ASUS ROG Flow Z13 touchpad). Redundant
report ID checks are removed across the I2C-HID, Goodix SPI, Intel
QuickI2C, multitouch, and PlayStation drivers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (9):
      Bluetooth: HIDP: Fix GET_REPORT and SET_REPORT for unnumbered reports
      HID: core: Fix GET_REPORT input processing for unnumbered reports
      HID: core: Reject mixing numbered and unnumbered reports
      HID: core: Validate GET_REPORT report ID centrally
      HID: i2c-hid: Drop redundant report ID validation
      HID: goodix-spi: Drop redundant report ID validation
      HID: intel-thc-hid: Drop redundant report ID validation in quicki2c
      HID: multitouch: Drop redundant report ID validation in mt_get_feature
      HID: playstation: Drop redundant report ID validation in ps_get_report

 drivers/hid/hid-core.c                             | 26 ++++++++++++++++--
 drivers/hid/hid-goodix-spi.c                       |  5 ----
 drivers/hid/hid-multitouch.c                       | 32 ----------------------
 drivers/hid/hid-playstation.c                      |  5 ----
 drivers/hid/hid-quirks.c                           |  2 ++
 drivers/hid/i2c-hid/i2c-hid-core.c                 |  7 -----
 .../intel-quicki2c/quicki2c-protocol.c             |  6 ++--
 include/linux/hid.h                                |  2 ++
 net/bluetooth/hidp/core.c                          | 29 ++++++++++++++++----
 9 files changed, 53 insertions(+), 61 deletions(-)
---
base-commit: b018686719706a781c45a874ed51374a2dc4b767
change-id: 20261012-hid-core-report-validation-8ca85d385ca7

Thanks.

-- 
Dmitry

