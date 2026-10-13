Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83B38C407
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883375; cv=none; b=GH3IuQ7kOkgciCkXVaUBw8FV1jg7ffGPzBbgOLy8nDFLJQIOzhEZTuk8nHTeE/Mo6RWmtWr6AZ9ttvbMMtM49BisXMmBKlMB1pHzkcoWQQh78nujAvlalqvCn5cag57fvcyZo9IrvAY3hucBmkwWKjW+Wpo4pPlv+O4fwmIIzeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883375; c=relaxed/simple;
	bh=ujs+E6U9ongdCIwzvmNJ3e1UblB+buG4fbuU+gthqE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LBTL2PuaH69CSigNSSqGpzM18/+yzOvZUNekfuz/7KYHYyguH4cKTAqyEfYKxa0NjvLuBZ2/2COH4fnrEQ+N+/88QxbChYVR5hsiztIFCR7Sr86GArY81QbPQoVmWed2v5956cHRxkGSnMYADOS8kzIRlrhOdiSwOsgtU13kMKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q73jeyMD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q73jeyMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791883373; x=1823419373;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ujs+E6U9ongdCIwzvmNJ3e1UblB+buG4fbuU+gthqE4=;
  b=Q73jeyMDFPEoFGDMW+2Lsb9txf5YTcSeGfKsWa2uuToh2k9OJPCHVF92
   LG0LRVq3ODQFNh7RRRzxidJjPIYGPdAYJDdss1Ve1kQaQBLrM5L/QhLbN
   UICAPBs9RqWyTBD5fbtr3qZbKJ80WaL6Tvk7WaK1CB9bod9J31lYNTVhH
   1rqbnuU7OUJyBEbJAq1uXiro3gl/45u4FhjwO22wlfDmP9PPiUavDVvrF
   DZqpbunP/Ey/bQF7TIcquwHid2m480MqZZ+Z8HZWeJZN7WEF29565k0p4
   z7XKdVzF8qpQ0ySq3a8TOxod114oRrdcUWUrV4hDriKsxLtqTLe1HrXDs
   w==;
X-CSE-ConnectionGUID: IFV7i7cKSP2YNhxBde/Prw==
X-CSE-MsgGUID: wco0pi50R1CofPDWtXy+ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="610498"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="610498"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:22:53 -0700
X-CSE-ConnectionGUID: Jd9ZVHkBThmwMVGZgW+yWg==
X-CSE-MsgGUID: V+eyC9mFSWO6IudIGiuyhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1440375"
Received: from unknown (HELO WEBAPTLH152.iind.intel.com) ([10.66.226.239])
  by fmviesa009.fm.intel.com with ESMTP; 13 Oct 2026 02:22:52 -0700
From: Catherine L <catherine.l@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Catherine L <catherine.l@intel.com>
Subject: [RESEND v1] Bluetooth: btusb: annotate Intel Otter Peak 2 USB ID
Date: Tue, 13 Oct 2026 14:51:28 +0530
Message-ID: <20261013092128.417705-1-catherine.l@intel.com>
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
index 71d8dccb29d3..92a78a7e6039 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -515,8 +515,9 @@ static const struct usb_device_id quirks_table[] = {
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

