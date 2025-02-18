Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1482417FD
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881611; cv=none; b=t8dGHNMZwDaVmbty0HmmUfw2jwneICo3FdMIAiEJiTGAE/vOE/oZrR0zvS+pY4jPwsE4WAuEohAWQgHoxpeubUq2kcIRxzcBVur5kKdgLPGyBwEtp5KMaIjmCwezOlRa5c1Etw5R+tWWyIJ35gysBSpIp7VPAiuh1cofGMWuBBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881611; c=relaxed/simple;
	bh=wodwks66WX7+n13NJu/4ejpNuWiF1yIxYN8qPZVyXKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvvQt1Pxgks2gM0i9R0kILFLAVWtI7XgWwmMqe0w5fRafyRzQON6Awb8YKsqnVhzzQSOABIslLklKZUJJNvmTCLvw9qK+CTCKB+Pdr/zFcHdYZtsk8LMmCxN3EKV5cdchWAf8s9XsODIMBxRee7Bvbt/+Mpli+GUfWUN4XhoVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEaN3j3+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEaN3j3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739881610; x=1771417610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wodwks66WX7+n13NJu/4ejpNuWiF1yIxYN8qPZVyXKY=;
  b=CEaN3j3+1hpCI5/cf8o4K1z1kHJv2RKoO+90AOkhmDxZ0dc5XArOpSPu
   +SQ/VnFPbBTZGNRTiiE7LF2olqWxlg09caxzSjcAp9HUILYJw+gizFT8O
   bSXWVdKEo36sH77QJRgSYhPJ4ob1g+kQdQAQEow+4cmqWcc1d5EVcWTQd
   z+BdBn0Xe/vVdiqHoX3Fr73YqDaCsPv9sArlH8EfkiJl4091qUr8woxme
   XyPRQ0cEVmICT2yhFPcGJ+yxB9sRH1noeHCEoZ28JFsAno5lY/LDlTcZM
   JY+8mJfYhF5IcGyqXNE6bD0J21F9XIUcsExM08HBVs5c5NjGLiXTmHwUw
   w==;
X-CSE-ConnectionGUID: PZHNZ/FUSU6zq3ZzNBYF2Q==
X-CSE-MsgGUID: G+/FY3LqS6GaOy7Q6SMG2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63049871"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="63049871"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 04:26:50 -0800
X-CSE-ConnectionGUID: 5kS4OKJKS62WnFs5/bh6zg==
X-CSE-MsgGUID: iNmyHb43ST2eY2IbCzo3CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="151574721"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 18 Feb 2025 04:26:47 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 4/4] Bluetooth: btintel_pcie: Trigger device coredump on exception
Date: Tue, 18 Feb 2025 17:56:20 +0530
Message-ID: <20250218122620.762523-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218122620.762523-1-kiran.k@intel.com>
References: <20250218122620.762523-1-kiran.k@intel.com>
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
 drivers/bluetooth/btintel_pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 0f04603105a3..761811de56f3 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -60,6 +60,7 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 #define BTINTEL_PCIE_MAGIC_NUM	0xA5A5A5A5
 
 #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
+#define BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT		0x1E61
 
 /* Alive interrupt context */
 enum {
@@ -1217,6 +1218,7 @@ static void btintel_pcie_do_firmware_dump(struct btintel_pcie_data *data, u16 tr
 static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
 {
 	bt_dev_err(data->hdev, "Received hw exception interrupt");
+	btintel_pcie_do_firmware_dump(data, BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT);
 	if (test_and_set_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags))
 		return;
 	queue_work(data->workqueue, &data->hwexp_work);
-- 
2.43.0

