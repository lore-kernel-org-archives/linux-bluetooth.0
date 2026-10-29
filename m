Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266423;
	b=JdPyP4HtQsEpaoMEWoGznHZCWn8sbv+cRkpyOWGR1QY3beG8AjHpvV8WX61orDdpaoZK
	 HpItR364g2Cev64dzYMfEClgp1g4PRCJ2nlw2/zO0KfxbeQYBDJrLPZPSeBez8bbCIHDS
	 JRxNOQmgudqS1eOH3b10OhB0M/JAMjSMyNKn7iBD/hIrPKljqlt9IVThWtJNKezQh+iFX
	 VlowVfGRmFW31VoyO1nfCKlk04234kl89BaDanvBcsBPjQUqT9OxID6elyUz7wWVxw/Y4
	 0x5DSN9U6X311GCAZC3wHAKk99utT8/sVuTDpfbKcgnbtcJqcHJ7OWfMZ5TRrOSYnDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266423;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o3KrOQZB4lxDpoTQU9Ewa+Dk/qk3N8eHRDNv9HUoHcM=;
	b=YmxTFVG7o0k5t7QnzgtKlRROpwCNnD/+LGwtJyhxyYCcRP1tvAi05+rfYhCzMYAQB+lv
	 fJUkUaLENP3xaTsb9XpRDkqFHj7LCTvxrvQdtrJwz7AUO3qjSy9Jfv1qmGVp2s4dNY48J
	 x5saE7Fwvgw7nK3d/yjz03UfDGxN2YMq2whiEl1Ko7YNXo1uH491Y3UcwHmBKuwh2kN9N
	 YX/BAncqVWvfhgEXLaXloWArW1MHXlWzl1ZEPUpLKXG375iptWYJ+3RxBHCBd+VJCLRdj
	 s4tFQPMLKjBgJ9AIxA+DI0V+0HZBf3Oq2V/7UBN3rSo9XNkVeMPjco1KJc+yTXsdIFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EsAo5tNh;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9A606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 09:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEB9A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EsAo5tNh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793266422; x=1824802422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c0/BRhxJaMjizmiwLS9rWYfE4L3Vyx+SIYse6VesKNY=;
  b=EsAo5tNh52ms0Fs64tL2xMK0JbAzlWB4eqfpAoi0lshs1duolgIp1iA9
   Z3jN9FnhfBkIaja8kYLWzaVfI9/Tp8NX+K/b8m/zaUpDTMbCJTyQg2QaK
   u5gevo352muJCavO1z+6hCqwgWvoP4GeVWyPpXGmgD2iu0n/kBAl/zrin
   q8HFX0qg4KGhGR1NOzTx2xdTKNx7u3f91GqdxXkMpu2Tl6JVwhpqIQs/P
   7yxFzLaZ2AMxg8uTmHYbVUd0ftW7tPLcb44m/OhJ2okk2qmCnMZ+EWZcq
   GsvD92kgTS6PgkZPRVlqNgqGDUvKcOAt+fGKw4AA/iJAopHqI4mUSqG0f
   g==;
X-CSE-ConnectionGUID: GXo+5ctCQ5KUwzR5Fq5iiw==
X-CSE-MsgGUID: SkO9V5NDSEmmOWQCTCL2pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1887606"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1887606"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:33:42 -0700
X-CSE-ConnectionGUID: RD3BO7y+QEe1lOrNef6Qnw==
X-CSE-MsgGUID: zSozMkhUSTWQUytf/WAI0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5183776"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2026 02:33:41 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 6/7] Bluetooth: btintel_pcie: Add target memory read logging under LOG_MASK
Date: Thu, 29 Oct 2026 15:23:43 +0530
Message-ID: <20261029095344.3989729-6-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029095344.3989729-1-kiran.k@intel.com>
References: <20261029095344.3989729-1-kiran.k@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Log the device address and length of each target memory read in
btintel_pcie_read_device_mem(), gated by BTINTEL_PCIE_LOG_TARGET_ACCESS
(bit 5).

Assisted-by: Copilot:Claude Opus 4.7
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 878bcc1412fd..324c25807d57 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -37,6 +37,7 @@
 #define BTINTEL_PCIE_LOG_ALIVE_INTR	BIT(2)
 #define BTINTEL_PCIE_LOG_SX		BIT(3)
 #define BTINTEL_PCIE_LOG_MAC_ACCESS	BIT(4)
+#define BTINTEL_PCIE_LOG_TARGET_ACCESS	BIT(5)
 
 #define BTINTEL_PCI_DEVICE(dev, subdev)	\
 	.vendor = PCI_VENDOR_ID_INTEL,	\
@@ -1806,6 +1807,11 @@ static int btintel_pcie_read_device_mem(struct btintel_pcie_data *data,
 		return err;
 	}
 
+	if (data->log_mask & BTINTEL_PCIE_LOG_TARGET_ACCESS)
+		bt_dev_info(data->hdev,
+			    "Target access read: dev_addr=0x%08x len=%d",
+			    dev_addr, len);
+
 	for (; len > 0; len -= 4, dev_addr += 4, val++)
 		*val = btintel_pcie_rd_dev_mem(data, dev_addr);
 
-- 
2.54.0

