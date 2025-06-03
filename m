Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909D2A1D1
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944121; cv=none; b=ncMGBIT76yLrbew9mu15jhHotBbs5docAyhDGbWrAW/IQtIPWQCVgjpUph5krjVeG6zhcWOmg2DK1BUkR+diKCkURxprEVGeOhPjZ2n2BAthCUgjilffH3w3sAINA2zODD7vAEFxxGfmho3alNME3dR1smuwUvOxOlwp5I/7mXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944121; c=relaxed/simple;
	bh=QwMSW3hU/BK7apWth6DF3do2cmYZ49VxHT35xAV4lX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QG7HFiU1/Hl7omHM24zvVO9sHBJJEG+3tBAlPCUyCuRUNB6wnI8BPM4w+aKUNKFS0/XjtsT5BsFZTJbbUlbzvL4iMw3M3xYAV7Qjb/qs4mlczF1OlLajNr4vobX7zRQIA5iIUzcUOx0zVL0+zFOuBwD/BpdxUFhwYepX9oyKtdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqdI42Yk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqdI42Yk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748944119; x=1780480119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QwMSW3hU/BK7apWth6DF3do2cmYZ49VxHT35xAV4lX0=;
  b=aqdI42Yk30AtYErzZ/h8y5ANL3DrBGXA7acwPE7nllerX4Tdq01NCMqV
   22ZbwjRnWpDvyd8IQS+Iq9MQXjqpZobg1WBwkj9cxKbpa7z1Ho5gFBoi3
   XfNvTojTJTArj1+acgMfZrKQWOZREFE05b0sA2tXUwFRk2ewSmPCUKd17
   PDLlmfHHnbprhEyJoIVtKjzpj+m+c/TgPqIdMXT3MGy1PssfJn4QqSZcQ
   llEi87zdWqSt6CV1IhP98LuxA/nVgV99n0nr0ZD3jvMBD2PZoaZ/15h6d
   p+esmfK6aJGa2LTy4tW5VHMGF3UJB0b8OFjNc9hoQdtggBT2un4qdwmhL
   A==;
X-CSE-ConnectionGUID: XZK4ZApRQHKg9KDqcvAHcQ==
X-CSE-MsgGUID: ivBsfxzJSXePMV8Da3WN1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="61594851"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="61594851"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:48:27 -0700
X-CSE-ConnectionGUID: Aj11QaZfRd+uAijy4bEugg==
X-CSE-MsgGUID: 8i381pkqQH2LfGeYVfMAKw==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="175759077"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa002.jf.intel.com with ESMTP; 03 Jun 2025 02:48:25 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 1/3] Bluetooth: btintel_pcie: Fix driver not posting maximum rx buffers
Date: Tue,  3 Jun 2025 15:34:38 +0530
Message-ID: <20250603100440.600346-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver was posting only 6 rx buffers, despite the maximum rx buffers
being defined as 16. Having fewer RX buffers caused firmware exceptions
in HID use cases when events arrived in bursts.

Exception seen on android 6.12 kernel.

E Bluetooth: hci0: Received hw exception interrupt
E Bluetooth: hci0: Received gp1 mailbox interrupt
D Bluetooth: hci0: 00000000: ff 3e 87 80 03 01 01 01 03 01 0c 0d 02 1c 10 0e
D Bluetooth: hci0: 00000010: 01 00 05 14 66 b0 28 b0 c0 b0 28 b0 ac af 28 b0
D Bluetooth: hci0: 00000020: 14 f1 28 b0 00 00 00 00 fa 04 00 00 00 00 40 10
D Bluetooth: hci0: 00000030: 08 00 00 00 7a 7a 7a 7a 47 00 fb a0 10 00 00 00
D Bluetooth: hci0: 00000000: 10 01 0a
E Bluetooth: hci0: ---- Dump of debug registers —
E Bluetooth: hci0: boot stage: 0xe0fb0047
E Bluetooth: hci0: ipc status: 0x00000004
E Bluetooth: hci0: ipc control: 0x00000000
E Bluetooth: hci0: ipc sleep control: 0x00000000
E Bluetooth: hci0: mbox_1: 0x00badbad
E Bluetooth: hci0: mbox_2: 0x0000101c
E Bluetooth: hci0: mbox_3: 0x00000008
E Bluetooth: hci0: mbox_4: 0x7a7a7a7a

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
---
changes from v2->v3:
- No change

changes from v1->v2:
- Update commit message
- Add dmesg snipped related firmware exception

 drivers/bluetooth/btintel_pcie.c | 3 ++-
 drivers/bluetooth/btintel_pcie.h | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 50fe17f1e1d1..2c7731803c9f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -396,8 +396,9 @@ static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
 static int btintel_pcie_start_rx(struct btintel_pcie_data *data)
 {
 	int i, ret;
+	struct rxq *rxq = &data->rxq;
 
-	for (i = 0; i < BTINTEL_PCIE_RX_MAX_QUEUE; i++) {
+	for (i = 0; i < rxq->count; i++) {
 		ret = btintel_pcie_submit_rx(data);
 		if (ret)
 			return ret;
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 21b964b15c1c..5ddd6d7d8d45 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -177,9 +177,6 @@ enum {
 /* Doorbell vector for TFD */
 #define BTINTEL_PCIE_TX_DB_VEC	0
 
-/* Number of pending RX requests for downlink */
-#define BTINTEL_PCIE_RX_MAX_QUEUE	6
-
 /* Doorbell vector for FRBD */
 #define BTINTEL_PCIE_RX_DB_VEC	513
 
-- 
2.43.0

