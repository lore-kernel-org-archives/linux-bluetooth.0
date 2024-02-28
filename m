Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D74322065
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111567; cv=none; b=iObZWDFT25qv7b9QSYHTFgJPlzZxDq5+tnBSRyq4MrzT2O6Td277rCLszlYtFaakgtlgJ7ZZyFkXqPyEvDdOuZsVcRYPR+EJAOTAACITFSlIxUSs8Qo/uvCAWPO2FBeDshYbB8GqFADztwRz7l4fA8ZHgOhm+HOXvWxqmehyfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111567; c=relaxed/simple;
	bh=Ds4vrfrn3SzVSKeb+mnKQ4GmeNNuApOXg4f9oVa0QSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lIm4v9XwnfT9T299iKJNjjI5Ww12tCMtkEuWVIoGPSwb4lYmRbIG1ZHKyPvNjaYrckZlBaEKFN2wX2oUXbW6p1jBV9JjJHJLWIGpH2IM6Bj6P4bW3YPVng29bxIKcfrxB6u3NsBivUtlM8aIdCoikndThHKjWHBwZBhY3oDv6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mP7E7+B4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mP7E7+B4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709111565; x=1740647565;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ds4vrfrn3SzVSKeb+mnKQ4GmeNNuApOXg4f9oVa0QSw=;
  b=mP7E7+B4VqZWB3RiXMpuD6vZxWPaVtowb3PaNKu27plJtfRRLYKT10Xl
   yLSQPMo3zgOZaXbOT+XpRuKGrgDsp7AvI39UmkUW4lpvAgolgg2zIHt8l
   /D7yNELnCzPfzKr+dCtUgyBpruN7ce3cNRUyCL0kfS0XmpyiUuwAp3vYc
   iQg9kOz7RITSPOsbhhG4K6mmnJJYF/TRVrdH3Kga9MBlGEfY2EqaQdDsA
   fJZ1M5nTUP4DZS8nR70V8rcY/lClDNxhBqZp1sQfp7kT1zbOTBSZJgGTP
   ato7RuUt5v0L4O7K36BCl4BAneueC7zm3+EO12y7VgVARi+rjgPVx0eO8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7282273"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7282273"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 01:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7797515"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 28 Feb 2024 01:12:43 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] monitor/intel: Add decoding of firmware SHA1 in read version event
Date: Wed, 28 Feb 2024 14:55:04 +0530
Message-Id: <20240228092504.3716904-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

< HCI Command: Intel Read Version (0x3f|0x0005) plen 1
        Requested Type:
          All Supported Types(0xff)
> HCI Event: Command Complete (0x0e) plen 107
      Intel Read Version (0x3f|0x0005) ncmd 1
        Status: Success (0x00)
        CNVi TOP(16): 0x00400410
        CNVr TOP(17): 0x00400410
        CNVi BT(18): 0x00173700
        CNVr BT(19): 0x00123720
        CNVr OTP(21): 0x0413
        Device Rev ID(22): 0x0000
        USB VID(23): 0x8087
        USB PID(24): 0x0032
        Image Type(28): Firmware(0x03)
        Time Stamp(29): 23-42
        Build Type(30): 0x01
        Build Num(31): 0x00011d97
        FW Build Product(32): 0x06
        FW Build HW(33): 0x06
        FW Build Step(34): 0xa0
        BT Spec(35): 0x00
        Manufacturer(36): Intel Corp. (2)
        HCI Revision(37): 0x3597
        LMP SubVersion(38): 0x3597
        OTP Lock(42): Disabled(0)
        API Lock(43): Disabled(0)
        Firmware SHA1(50): 0x2e575f2a
        Unknown Type(51):
        00
        Unknown Type(52):
        Unknown Type(53):
        00 00 00 00
---
 monitor/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/intel.c b/monitor/intel.c
index 0de864d8a41e..aa05a803bf8e 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -291,6 +291,7 @@ static const struct intel_version_tlv_desc {
 	{ 47, "SBE Type", print_version_tlv_u8 },
 	{ 48, "OTP BDADDR", print_version_tlv_otp_bdaddr },
 	{ 49, "Unlocked State", print_version_tlv_enabled },
+	{ 50, "Firmware SHA1", print_version_tlv_u32 },
 	{ 0, NULL, NULL },
 };
 
-- 
2.34.1

