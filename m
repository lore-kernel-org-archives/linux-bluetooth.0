Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628628;
	b=rrrjUBcDtMOGzRuKkHyPXqq6R06s+lL/6t+f/z55AKuNiMkuQmmKH3XW7cElGEsdfCLC
	 8fjh0DZWgBSExFefZMrn0UVRfU9w4nIriob5x0WWyd1o7Aq7FIjSfajFr51VTbvds9SxM
	 ZQpfx9/bH6fLAKOUgmTM2p1p7XOJP3doAeA3kPfwTQJteePHiuHl7Pc9mNOf07PdXvSP9
	 2tbJTiDC20f984wV2n4vz1jdnhyr9oNpkA8ECDvoJeLK4Rjqf1PDeAWlHAYuK39+Kpb4b
	 hkAAdObyVUM+etSIwK0TD+vXC034DImvPLcI9NrhmEKLV+tX2yUqf8dQmT9phdIkSWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628628;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yxlwcEbkd3fhz6GTvmahFiDbG8FUysC+TnosHs5KBL0=;
	b=VHPLocWRvAgP+tiGEftXI/lLzqVaf4nI0dO/pmZTUsd74I590JtR50rEra5FoKt+Y/Tb
	 /ND8ZkdipUc/uTxYlqZNTzwU5uUgrwy47zsgt0HGwjXe5W1yrkNrM0FSuW5a6BFbOWgQz
	 onsl8qKaxwyMktkXHc1vCiPrVYCiFr4mEiDcxtXjq3nUiCi8jbrQLlf6qaknK1S69dE/A
	 od5brKmE4qXhpjB5sTD3TU5smoZk6tQiCVo/TTt96cZytlwrnJWDAfUPKZKhx+ggIIQQN
	 ZfeyuXyb8s2WyF2tT5EfMWY9azaiiOESrVjNKeiQ4wXOq0pa/+RlFAoN3sFYgFhZomA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d1sFuJRU;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD7606A324
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 14:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0AD7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d1sFuJRU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793628628; x=1825164628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZwqQxfxQGPO1Rs4RdE5pOxgdJKrVbZT8Hk3rboxYIrM=;
  b=d1sFuJRUz8oll3qE8wf8PACcJ2H7/qAUDdL+F/WzwPGPtjXGH2W+4ytK
   g59NSSpLfcQ7DviIAA0Mv/xqOPmEb6KLrk4KLz14UMmVMwO2wrxG+/xWs
   hBqyw1mK+GSdknNMD8zSOkwsSAQIOUiEeAyfA8e7nk6bT3N6LIV9pzJZt
   dqiP5995dV6rO2wNG7V1ZHKcbvEHucUik0EmGAtujAtBrnqk7JjI9xzek
   kNpllIv8iJtE75KwE5o3WgIjUHJdFXLRNk5yMTmB1IgYWV6KULfyc+C+L
   LlH+7/fXFdB9lgENK8yrui/K5rpSdkqDcFe2YyAfZySnZdKiCOmwIpFPc
   g==;
X-CSE-ConnectionGUID: y/aevpkXTVSDZEU4QwdGxQ==
X-CSE-MsgGUID: 3LAVAVJvSQmWX76brlclew==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2199660"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2199660"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 06:10:28 -0800
X-CSE-ConnectionGUID: ii7QoCmMTHq3BxzJSV2HXw==
X-CSE-MsgGUID: aWaz6xAbSR6l1X3iacS0MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6301605"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa002.fm.intel.com with ESMTP; 02 Nov 2026 06:10:26 -0800
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1 3/3] Bluetooth: btintel: Zero-initialize new_ver in bootloader setup
Date: Mon,  2 Nov 2026 19:31:52 +0530
Message-ID: <20261102140152.2307401-4-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102140152.2307401-1-aluvala.sai.teja@intel.com>
References: <20261102140152.2307401-1-aluvala.sai.teja@intel.com>
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

btintel_read_version_tlv() only fills the fields whose TLVs are present
in the controller response, and the result is then copied over the
caller's version. Fields missing from the response, such as api_lock,
were left as uninitialized stack data. Zero-initialize new_ver.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a0aa110f4cdd..549612cf253d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3592,7 +3592,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_version_tlv new_ver;
+	struct intel_version_tlv new_ver = {};
 	struct btintel_data *data = hci_get_priv(hdev);
 	u8 hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
 
-- 
2.53.0

