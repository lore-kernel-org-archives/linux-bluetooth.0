Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFF3A4F3B
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740592; cv=none; b=iZEF7kM6K5IuO9xgLNjclTF+VSXNACoQk8hwUvG+tPvnEsIl87Prqt+EVst0gS4AqOy1DgG+mj4wEvp6mab79HHUd9qTBbljSoqk59OFp0qsD3FMjHd2E3u79Z9NqIEG5e1u6tOPpQNZ+J7D0/RT26RGxQsGDAtpP1tOf7WDFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740592; c=relaxed/simple;
	bh=RaE8Lsz+rvZlv9kW1Aw3UwVUdDBxoO48Yb5nWb/ruDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUKdKxnd3eY4o/f1U0bZoF5yyG5+122ZzXP7UG7avPOCgnW98rWKkOTlKpX7osg7mr52h0Dhf1IJHZjFnopJkAe614BMKJF8MX0/i/UJmOMpaVw2jmhah7fvAV8TKxSamTOvrOKhfuFCNC/LHPRrBn0tWfMLlE6jgAG1GSs9Xt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vksa9VZ8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vksa9VZ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789740589; x=1821276589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RaE8Lsz+rvZlv9kW1Aw3UwVUdDBxoO48Yb5nWb/ruDA=;
  b=Vksa9VZ8Mqz2Lr0dOsiZeGtKc95u5Lglw7QDVnXxwnGpC8yy5nMX2fP3
   Kf5hMYwOtlaHTpRqbX4Bdpu7GgF2HQHcrmnRP0FiYSnCDmZpz+fU9rKUi
   m3/XJIyK1a7RTRc5uT2FgkXUCDe69aAleXCvu/gN7YtFzd8jTGn45KXJE
   TkKk905JIwRGBDMmXrq+pzWZtxAQkS3tC7kCkOgplPif6vzxRnP+X4Vit
   QR70aFO73scPWegZuB/1VeE2Ov+1nfu90zGX/FoxqMIGBIzvFmDXZocEn
   yzOqzFK0/yP5mPBG7liU+zL3pLYmUN9fILmHgKf6I4eFL6OdhZ5L6bRxy
   w==;
X-CSE-ConnectionGUID: AadcKPUxShC0/L/1+WWdjQ==
X-CSE-MsgGUID: wyfstmkSReGB9amERvHZkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="100912516"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="100912516"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 07:09:49 -0700
X-CSE-ConnectionGUID: 5TZCRHs+Tvm+E7+GdxQnsg==
X-CSE-MsgGUID: 4B22BvQlRtavu8uEu03Ikw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="268160265"
Received: from unknown (HELO WEBAPTLH152.iind.intel.com) ([10.66.226.239])
  by fmviesa009.fm.intel.com with ESMTP; 18 Sep 2026 07:09:47 -0700
From: Catherine L <catherine.l@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Catherine L <catherine.l@intel.com>
Subject: [PATCH v1] Bluetooth: btusb: annotate Intel Otter Peak 2 USB ID
Date: Fri, 18 Sep 2026 19:39:21 +0530
Message-ID: <20260918140921.39908-1-catherine.l@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move USB ID 0x0043 next to 0x0040 to keep the Intel entries in
numerical order, and annotate it as Otter Peak 2 (AX231) used on
Wildcat Lake.

Fixes: fe225f96a79c ("Bluetooth: btusb: Add support for Intel Otter Peak2 (OrP2)")
Signed-off-by: Catherine L <catherine.l@intel.com>
---
 drivers/bluetooth/btusb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index be47ac894b6c..0f0798639db8 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -512,8 +512,9 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x8087, 0x0037), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0038), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0039), .driver_info = BTUSB_INTEL_COMBINED },
-	{ USB_DEVICE(0x8087, 0x0043), .driver_info = BTUSB_INTEL_COMBINED }, /* Otter Peak 2 */
 	{ USB_DEVICE(0x8087, 0x0040), .driver_info = BTUSB_INTEL_COMBINED }, /* Lizard Peak 2 */
+	/* Otter Peak 2 (AX231), Wildcat Lake */
+	{ USB_DEVICE(0x8087, 0x0043), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_INTEL_NO_WBS_SUPPORT |
-- 
2.43.0

