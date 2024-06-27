Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC86D179641
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492737; cv=none; b=t+4X+uqe1jNj0wfyVwwtb8xmw9a5YEVouNObx8cN1CO2ogpo1LBMMWkgDJCMLsqac/P0Ivf/fHl6rVBOpyZE2TgPxOn81ueoWer6tozJ3dNj7tRUfYUkiu2+qdTyu0LwSSYmE5xdTSWYy3sf+xIs0z6nmzdKd5slNYOG0Se1MAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492737; c=relaxed/simple;
	bh=T0fANAcU3NxLCzJNUpdcQ5jRDOE/asf0hxUgKzevETc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n2cV9ir3VreIf50AVcfkvFJzDvtpggwzolMVIpQDQrKK2bO3giTcKuO1Yp+wk48wJGRryh939pTw75/gmXAkX+7rLKNQ5glvKcnOobGr42Rnts725VERoylaV4Of8aYdb/m53TWdjI/m2Q+hBJjUnDSm9hXxPxpzJtlTB1K26n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0w4C+NA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0w4C+NA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719492735; x=1751028735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T0fANAcU3NxLCzJNUpdcQ5jRDOE/asf0hxUgKzevETc=;
  b=c0w4C+NAKU5+OSDbh9r/P/bZBkvH+H/f791tnnCCk0KTqtje3JvUcFSk
   JOsXT67G2E5npUpdig4R1mz+/7I61WNbj38zl189hxUPcRNG78imq1UBM
   istgGrFvXFmgFaCvtWjgc9p11d58QwnzMpVEmlMskM+0acN8dQjSSzFEw
   MagVNwc7SXyp1Ay8u4mHycy3dAAtJsPzrj1KwmAOW/yEYnHzVHAI99SGM
   0oaOT5QLnEtkTjnfUAR11hIdLiOLewj66QcAwS3K5ge4ZwJsm8y+5UARf
   hyC5l9Rk6YTVbzrcE0KQdkJD/XWvH/x3yihTcv8QcKVjEUe8eA3rQr0Gz
   Q==;
X-CSE-ConnectionGUID: CY6cAWKuSPqtvSNOCSuKRA==
X-CSE-MsgGUID: hbwkOYpfQJ2VHikaGpJJ6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16744095"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16744095"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 05:52:14 -0700
X-CSE-ConnectionGUID: 7FdLMYaKQayDKTn5NAKPdw==
X-CSE-MsgGUID: w+MM4+AySIeZgrHapxvwqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44191054"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa006.fm.intel.com with ESMTP; 27 Jun 2024 05:52:12 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>,
	Tsigan,
	Vladislav <vladislav.tsigan@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Fix the sfi name for BlazarU
Date: Thu, 27 Jun 2024 18:36:39 +0530
Message-Id: <20240627130639.2744811-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use INTEL_HW_VARIANT() instead of CNVi Id to decide to load Intermediate
Loader (IML) image. Fix the driver loading incorrect firmware for
BlazarU product.

dmesg:
.....
[146.111834] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[146.111839] Bluetooth: hci0: Bootloader timestamp 2022.18 buildtype 1 build 16362
[146.111848] Bluetooth: hci0: No support for _PRR ACPI method
[146.112204] Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-0291-0291-iml.sfi (-2)

Fixes: a5495fe62d9f ("Bluetooth: btintel: Add firmware ID to firmware name")
Reported-by: Tsigan, Vladislav <vladislav.tsigan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 2dfe049d863e..54bfe2ffe1d2 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2148,7 +2148,7 @@ static void btintel_get_fw_name_tlv(const struct intel_version_tlv *ver,
 	/* Only Blazar  product supports downloading of intermediate loader
 	 * image
 	 */
-	if ((ver->cnvi_top & 0xfff) >= BTINTEL_CNVI_BLAZARI) {
+	if (INTEL_HW_VARIANT(ver->cnvi_bt) >= 0x1e) {
 		u8 zero[BTINTEL_FWID_MAXLEN];
 
 		if (ver->img_type == BTINTEL_IMG_BOOTLOADER) {
@@ -2240,7 +2240,7 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 		 * firmware image which doesn't exist. Lets compare the version
 		 * of IML image
 		 */
-		if ((ver->cnvi_top & 0xfff) >= BTINTEL_CNVI_BLAZARI)
+		if (INTEL_HW_VARIANT(ver->cnvi_bt) >= 0x1e)
 			btintel_get_iml_tlv(ver, fwname, sizeof(fwname), "sfi");
 		else
 			btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
-- 
2.40.1

