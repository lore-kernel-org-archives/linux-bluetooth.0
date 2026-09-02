Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B175305667;
	Wed,  2 Sep 2026 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355877; cv=none; b=b9AXMtH0mzwGYysGKElWEOZqqkR/MinVVqlAdFaYC4RNCoauApO3iXCo3U3vG7DIbsMaAJlC4L1Nv3Col0OcWXj8zS+JKdPDuM0LrabulAc2iJNo6qXTF1g5IHwoQsz9359b6vg4yVRrNllTiOMoZeBl0KpuJJODPnOo9RtsQzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355877; c=relaxed/simple;
	bh=/c+S2te0hjiZJLYvNg/Z2huBUMLVF8ia7h2ehvoxeiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRKBlp9q/bMMeCAFBm3LV/bFaeqKEjpJiCj5JHdUobaIBnQVndJRyfh6a6IoauREW1Mlsw4QgcGfOOBs5npr8/AjPawN2Ler0LEEsCeg4QBfo/fI/E83+78JqBh59iZmUW8lLF7BkYl1KhxKqvu4Qmew4C4SFY1ZjcWUZZbe0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCTSUhSf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCTSUhSf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788355875; x=1819891875;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/c+S2te0hjiZJLYvNg/Z2huBUMLVF8ia7h2ehvoxeiY=;
  b=RCTSUhSf8ODf/SImwAogeCna97HW2lQAQZPWBoQKd87yz/TfAaqNJsyD
   0Ux1MplfYbSYOQpMqwZPGS/iduHeiFnPMfBeTFOc6jLiHO0ZsIS3wBfXU
   nTzYLfVYlxSgvI6SpM2bIP0qNf3WaaqqHWPfAEhw0xHnprj3M9PmWraAE
   dPJNnebin5E2LOcVzqchyMH3IZEzcS6nPl5DCJjRQtn2+oyzW0h9+hZef
   Uxh5X7cXW8SwYGC4D1etmHnccp4WshPRxT74Du07Nm+AhXoIkJBvlyJCl
   41nna9iNWag65x1O/R0Uk1uhqYWqu81MqBXaSwgibKRn6Ttsy42BJLjsM
   A==;
X-CSE-ConnectionGUID: RyDl41ijQh6muoqA+sEXeQ==
X-CSE-MsgGUID: e8+PneIrTtWhRMzsR/j3Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="89023072"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="89023072"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:31:05 -0700
X-CSE-ConnectionGUID: fe6vJ3GeRIOmOP2J/IdLsw==
X-CSE-MsgGUID: 3sloRlTNS+6qx5fARNQOrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273577919"
Received: from unknown (HELO WEBAPTLH152.iind.intel.com) ([10.66.230.227])
  by orviesa005.jf.intel.com with ESMTP; 02 Sep 2026 06:31:03 -0700
From: Catherine L <catherine.l@intel.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kiran.k@intel.com,
	Catherine L <catherine.l@intel.com>
Subject: [PATCH v2] Bluetooth: btusb: Add support for Intel Otter Peak2 (OrP2)
Date: Wed,  2 Sep 2026 19:00:37 +0000
Message-ID: <20260902190037.259487-1-catherine.l@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Catherine L <catherine.l@intel.com>
---
Changes in v2:
 - Fixed review comments of v1 and changed name format.
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03039ceaa77d..3e9db818a740 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -488,6 +488,7 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x8087, 0x0037), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0038), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0039), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0043), .driver_info = BTUSB_INTEL_COMBINED }, /* Otter Peak 2 */
 	{ USB_DEVICE(0x8087, 0x0040), .driver_info = BTUSB_INTEL_COMBINED }, /* Lizard Peak 2 */
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
-- 
2.43.0

