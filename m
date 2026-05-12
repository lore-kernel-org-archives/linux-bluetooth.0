Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34853246EC
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566852; cv=none; b=RlemWYYWkuOhKLl+gTOwHRlMpil6d7kSeDsty038G69m44aXPD3H6i2PqoRtFgmFvmyQ3A3lCc2MIxjXLz6Gx8ogoY6bLK7COnZhxjq7NA6+T9qSAe/H/Whkt6sR4K7KQRO4UwpM4dk4XsFE6ZRfiv7bK0qZz0azr524a2J383I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566852; c=relaxed/simple;
	bh=kE+Z6b7BBOPdOemJ7O9H++I2JntXEKk78FNoIjZQ/aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cp8W+S9vqy4iAuwib0qDwIARdNCq0fQSDSSor7yiX4D+AoVP/wfKV7PMtFoJX6VM5FtEupGbY1LrB9J3HLoA2zh0fg1GlrUbjIBvCVKXQTkfHmL3bds+sZWwLPCGh2/9zTEP1Y/zK17M3SQigVsA9dnFzpaK3WNcyoPfQkpZyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSDTF6Uz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSDTF6Uz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778566843; x=1810102843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kE+Z6b7BBOPdOemJ7O9H++I2JntXEKk78FNoIjZQ/aI=;
  b=HSDTF6UzbFpg0FBPUBm9aoWV3ehCs9WLLpLK8X4LOadTx5IhdD6VssFe
   VitlcARyLdJ+Y6t8gRUza5ld+rNA/BwwgcpibsOHOBFrEk0YBHMvNL+II
   spG2oLce8Cg3/bX+YFT1rkMdrwwY+xq1jf0SC9rKTh2/TraE31RdU5QT/
   Kt7JPan+iDJZzLq5KwSETfxiSQvtGHtYDPpiUGo225LAbhG+zszfFV5iZ
   gtZ07zRsQGTaiD0bm+0zpCPkdNxQCTdrs6lhO9mX7N33xvrR27MMAyu2v
   xJhvPMoshjglJancWdYi90T+z1vdkJ3c+cc7ujq5E/KrvQEkz0HY9R7/t
   w==;
X-CSE-ConnectionGUID: Jl88U5FoSI6MzQGvYIh+gQ==
X-CSE-MsgGUID: C/aCpWtnTmChbeUIL/1UDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79415720"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79415720"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 23:20:38 -0700
X-CSE-ConnectionGUID: wMZ3nyV+QU6bLCLi8mUCnw==
X-CSE-MsgGUID: fIBGcZW/S3yMnbq5wUc8qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="236829374"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by orviesa010.jf.intel.com with ESMTP; 11 May 2026 23:20:36 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v1] Bluetooth: btusb: Add support for Intel Lizard Peak2 (0x8087:0x0040)
Date: Tue, 12 May 2026 11:50:45 +0530
Message-ID: <20260512062045.1213631-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device from /sys/kernel/debug/usb/devices:

T:  Bus=09 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=0040 Rev= 0.00
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Signed-off-by: Ravindra <ravindra@intel.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 572091e601f9..3f012c2a014a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -484,6 +484,7 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x8087, 0x0037), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0038), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0039), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0040), .driver_info = BTUSB_INTEL_COMBINED }, /* Lizard Peak2 */
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_INTEL_NO_WBS_SUPPORT |
-- 
2.43.0

