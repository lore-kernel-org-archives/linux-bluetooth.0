Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4D48C8D5
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574148; cv=none; b=sgahLTHmwVNAwVym9+i0ZaXcNlsSLecnFnwfwD0PjJzpTq/5v/T+giowsGb/nCt1CnpcvpBkJ7pBBqNEWGNBwycwZm4HwK9QYt1Pcqv1xBKVQbO4RaIXlo7Nd+FdYXK6rXbZc9o9s/t8RpF4fkfl6vlCMvpqekDEtF18HnJk2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574148; c=relaxed/simple;
	bh=kE+Z6b7BBOPdOemJ7O9H++I2JntXEKk78FNoIjZQ/aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jylc97YkoFtczl3mZMX0hIMUiS56elf6Da/J4pgvduScLdB6s4zoporcstz73KX3+Ial5dkAajlte/T3MtM7uksS3FTIgT3xahhMkM8f08uPTAWukk2pugardVv8clEXyqmHLH0W+qxtIGOKGW/qeEbXUtmvvD+TrfyHvA7NPQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3e58KOe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3e58KOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778574146; x=1810110146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kE+Z6b7BBOPdOemJ7O9H++I2JntXEKk78FNoIjZQ/aI=;
  b=F3e58KOeq6ktafTA7CSfp0BTQVeWlUwuoMxDI3iAhtlPgt/rp+bCmwxj
   6B91pwnAiP1YKHlW5WxkyVdgHbj1e86p92eEgVdccbBsv2NohVmjBwu+i
   UZo7zex+zMr9zgnKE4Iwb0O0wzqeyF5KLNVOg3y2ZJcZ7nmAfvSJum8DL
   I0sUFHx4FdahIT/CVnCf62EDoLMiUjBx4wQ1PkcB6wrA19iU6Jb0wKiEA
   jVliC5xBHNLGs6FM/QEK+KoHCX3FAh+JP0x3yA0DF9SXmcq4eddo3b+j1
   JPWJ0Jcq6tGGVm9I972Y/bSXdk4huLEWFN4QMb3AwMK2tSfspLbxAHhEo
   g==;
X-CSE-ConnectionGUID: cv3ZB6agQCaEMd2nE8oRcg==
X-CSE-MsgGUID: DmHuNOttSrecjpozNT5pIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79508188"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79508188"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:22:26 -0700
X-CSE-ConnectionGUID: D58ORHM8RMWu8u+BrcpB6A==
X-CSE-MsgGUID: //KDS/VBSR6WYQ0jbXdbHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="237640570"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by orviesa008.jf.intel.com with ESMTP; 12 May 2026 01:22:25 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v2] Bluetooth: btusb: Add support for Intel Lizard Peak 2 (0x8087:0x0040)
Date: Tue, 12 May 2026 13:52:56 +0530
Message-ID: <20260512082256.1214764-1-ravindra@intel.com>
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

