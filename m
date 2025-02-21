Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC720F091
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148989; cv=none; b=RKJTMRYurvPqnaRtm7tNSHaP9sdgpGTIDPhBte3VE32jrfAChGvGVaZXj4iH2FKPj0eui3kLTKakE/ALjXrNRTCMp7xc5eaWZ+hJH2Ai5LxkPnrfaxRWNfNJHbrDKJbKV94dpMfX7+K/M9LaYXfqT10blc1HYZ6w/+LTfqn2yps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148989; c=relaxed/simple;
	bh=p7OImyWcVc7q5Y0WFqRTixdWjLyovMySXJnUU8U04Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyXVrD2yGYtix+J1JPZ4MvuaNrslZ3f/Q+D2tkQxZNPOm/GGD1ymUvsMLvDT/jmdDi7z0WYLVdaiGoc4OBaT/VkFJ+j2z59cfnkWrdxU3xhDz168S3yRY7zsEjtLz3Axvh01bts25QbAZ3/8K979UhvghdCup3bCf8layBQWQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lz7pOFPy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lz7pOFPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740148987; x=1771684987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p7OImyWcVc7q5Y0WFqRTixdWjLyovMySXJnUU8U04Wg=;
  b=Lz7pOFPyLV57YFbZiAeNS21o/1XM5In8y3iwM0/CMWrG25/ATYdBc7QE
   DFSCJkeQuS2hFpaRWJqGrGXaue5/m3aQvWdVaYHn1YEwYuQu7XWbby6MU
   NahPSK9TX55heZPjzyGTQTeL1Sga4klZQqsU7xecmC7CYRX2S11pE3QVu
   9XEabY6CCGN689Ft10SWVYOKnmKxWu4QHOUyFsY/ygWlGUaRZpcqkzIk/
   XtCWEHwp65Nq0v1ZRFJSYKO2QeGX94MGe2OHjfRhdv1DvrpbTT4K8iMH5
   Y934xWyU75K/i6Wv4XSWWH5AdkXa393RCauqPHWp69h/S6YB6yyl+U7yQ
   w==;
X-CSE-ConnectionGUID: yH8+ZD5ZTtegPsERrbHFDA==
X-CSE-MsgGUID: qcE08lz3S2m/1BxhwASj2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40159823"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="40159823"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:43:06 -0800
X-CSE-ConnectionGUID: v5VN3WUvTBCMv+5Ks+cpxw==
X-CSE-MsgGUID: 91O2A0dBShSLkGiAO4VrbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="115914726"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa010.fm.intel.com with ESMTP; 21 Feb 2025 06:43:05 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 4/4] Bluetooth: btintel_pcie: Trigger device coredump on exception
Date: Fri, 21 Feb 2025 20:12:45 +0530
Message-ID: <20250221144245.1012686-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221144245.1012686-1-kiran.k@intel.com>
References: <20250221144245.1012686-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver dumps device core dump on firmware exception.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
v1->v2:
No change.

 drivers/bluetooth/btintel_pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 3a46ad7ec0ee..7db3a2979c9b 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -60,6 +60,7 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 #define BTINTEL_PCIE_MAGIC_NUM	0xA5A5A5A5
 
 #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
+#define BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT		0x1E61
 
 /* Alive interrupt context */
 enum {
@@ -1225,6 +1226,7 @@ static void btintel_pcie_do_firmware_dump(struct btintel_pcie_data *data, u16 tr
 static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
 {
 	bt_dev_err(data->hdev, "Received hw exception interrupt");
+	btintel_pcie_do_firmware_dump(data, BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT);
 	if (test_and_set_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags))
 		return;
 	/* Unlike usb products, there will be no hardware event sent by
-- 
2.43.0

