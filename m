Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668730C60D;
	Wed,  2 Sep 2026 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788345275; cv=none; b=b34MjjdWuOTqgpF/QnZ9xmdF9j1fWNdoF6UUVfSRQMmqKPBHk/2xnA8YDk4Lpc9g0+O3VcAKLhLo0uFCeNFi/79saTrQ1VBkUXwpOE7yf98BwJCzSN+fay1Cl6mD58awf37UZhiSau7UGD4pqZZ3IUQ7XvEPkoslg+WjgyXWUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788345275; c=relaxed/simple;
	bh=18oZQmR/kmMaRRFOCosOyH7qtLoXrvrtb8xSru2qBdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDqVYKyYLmggaFiMoYcBU47cRfJA5L09Ku+rLV/bVvbcKPsOhfIhluVH+64jZVDZIZmyAA7SzsDteM1MvqbL++lj6MX5OjnZeOsFuwkCiaQLOGi/+iRagd151wz/ruztI4ITXOt6i27ms0na9Q8Ssuag4PKR6TDT96tck8bvXh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESFyo3j+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESFyo3j+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788345274; x=1819881274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=18oZQmR/kmMaRRFOCosOyH7qtLoXrvrtb8xSru2qBdI=;
  b=ESFyo3j+oWopRAjD4uf4uFLBfmsKspubvZF6t1y/e+zFg7+56CjnGQ3L
   u0WV29zqtbyFo2IUibJmQ07dIPA09mDoXxs8QF0seOqri2TO9nlRariZV
   GfGSD97Vnv/Jza8WVSOOalZqvkex+KZNg02uaQcCBNZV3huj9Vzl+ebZy
   4QdKpB71+nklt5JKCE7PRhvi6dq4kpo1X6vV7z7RgY5DFZmsaCthdxBOH
   M42m1BUiKyWhErOEf+crEv2lwuv4loKFE9nDxhSrsRtU+rIU6+zhIE2g9
   ZlS3rGv+jDQVobWVoST2P4TCn0UHLzh3sfkJJkb1g2+u3AMwQ8Ycwt52L
   g==;
X-CSE-ConnectionGUID: 7gnyp+i1S5C51028qlVu6w==
X-CSE-MsgGUID: LLWVV5llSciIoQJvV8z8EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106168260"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106168260"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 03:34:33 -0700
X-CSE-ConnectionGUID: hrB+eZ1GRyqVwJmNK+5MeQ==
X-CSE-MsgGUID: 6h3W4BXgTuix8lvxmZgHow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="267610627"
Received: from unknown (HELO WEBAPTLH152.iind.intel.com) ([10.66.230.227])
  by orviesa006.jf.intel.com with ESMTP; 02 Sep 2026 03:34:31 -0700
From: Catherine L <catherine.l@intel.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kiran.k@intel.com,
	"L, Catherine" <catherine.l@intel.com>,
	L
Subject: [PATCH v1] Bluetooth: btusb: Add support for Intel Otter Peak2 (OrP2)
Date: Wed,  2 Sep 2026 16:04:06 +0000
Message-ID: <20260902160407.257899-1-catherine.l@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "L, Catherine" <catherine.l@intel.com>

$ lsusb
Bus 003 Device 003: ID 8087:0043 Intel Corp.

$ cat /sys/kernel/debug/usb/devices
T:  Bus=03 Lev=01 Prnt=01 Port=09 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=0043 Rev= 0.00
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms

Signed-off-by: L, Catherine <catherine.l@intel.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03039ceaa77d..a4fdf6549127 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -488,6 +488,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x8087, 0x0037), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0038), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0039), .driver_info = BTUSB_INTEL_COMBINED },
+	/* Otter Peak2, Wildcat Lake */
+	{ USB_DEVICE(0x8087, 0x0043), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0040), .driver_info = BTUSB_INTEL_COMBINED }, /* Lizard Peak 2 */
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
-- 
2.43.0

