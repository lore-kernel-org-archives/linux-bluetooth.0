Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72019E7EC
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140774; cv=none; b=pk5Br1eEWixwd3Kf5b1QPIyvmhjT/yOS3FwgSat5s0s+d0Sa32pm1+FHyZOxrliWDphiVIjAHZpLbU44cXh9MBTOVkeRO2eIlX5M8b2HK2KOCz5MCyeQBZJ7MpNHPuTJYiv4nW2FuEsCnkbFCDtlPE6Cj778FssA8GRlfWp0cXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140774; c=relaxed/simple;
	bh=isCjv8oqYY90+gM2vrdlvmoFvcNhrHtQ7qNhi2LXmws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M9f0aYmRB0S8iN8iMP3uzZoGFZJEEEG4hOhiq8QJD+5iGZ1pv0JstxPFUB1542iBbGlzJbfr9RWelqZQ4ZpA7LmZcevXng7O0N6hmG6hBfAHAkBSHWcFyn0mpYdBila2GmNw2G2LMBD9TthS9x6ysjqFkvD/S9nEdSoPlBtVzr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNulv7TM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNulv7TM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721140772; x=1752676772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=isCjv8oqYY90+gM2vrdlvmoFvcNhrHtQ7qNhi2LXmws=;
  b=gNulv7TMYFF+IikjV0w1WMD6AYmbNshBh6ln9DpIeNEOSLSiYjDGptsJ
   WYgjJ7m2C1XgsKwpqya4jR/4bt3b7jvimTY9v/fnXPN9uINhzsKuHevJE
   ofK1nZo3+5U4mchrPwj3L9ZaOz3ji/mwnyswTE+2Bbmh+Rp50HcptA1UM
   GBuQDcGBFrsQAVzawz5gpqBLfcEJc+uu495Swf6ZugS11Jn5Lar2yXxZq
   SYWQYar62BSj8sFvbKIie1qvk0bQJ84pL7wQf2E/Js/plNdS9pmH7vLou
   zQYvru1FTx3+i5YRLUAjhIMqlHfP2syDlUWVgKLsXz0QL9VngTQPdoC2F
   w==;
X-CSE-ConnectionGUID: 2Kjfcp7sRxOQX/RHnJaj4Q==
X-CSE-MsgGUID: xD5l1R4hSoO8WWWF6jXd9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="22346080"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="22346080"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 07:39:32 -0700
X-CSE-ConnectionGUID: v83Y+olwT3idADPUS64+Fw==
X-CSE-MsgGUID: yLjO4uivQ/2uH+ODoE6bAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49868252"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jul 2024 07:39:30 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] monitor/intel: Add decoding of Intel Read Version event fields
Date: Tue, 16 Jul 2024 20:23:54 +0530
Message-Id: <20240716145354.3900742-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add decoding of Image type, Firmware SHA1 and Firmware ID fields.

snoop traces:

< HCI Command: Intel Read Version (0x3f|0x0005) plen 1
        Requested Type:
          All Supported Types(0xff)
> HCI Event: Command Complete (0x0e) plen 126
      Intel Read Version (0x3f|0x0005) ncmd 32
        Status: Success (0x00)
        CNVi TOP(16): 0x01080900
        CNVr TOP(17): 0x02001910
        CNVi BT(18): 0x001e3700
        CNVr OTP(21): 0x0432
        Device Rev ID(22): 0x0000
        USB VID(23): 0x8087
        USB PID(24): 0x0037
        Image Type(28): Intermediate loader(0x02)
        Time Stamp(29): 24-27
        Build Type(30): 0x03
        Build Num(31): 0x00010060
        OTP Patch Version(39): 0x00
        Secure Boot(40): Enabled(1)
        Key From Header(41): Disabled(0)
        OTP Lock(42): Disabled(0)
        API Lock(43): Enabled(1)
        Debug Lock(44): Disabled(0)
        Minimum FW(45): 1-10.2014
        Limited CCE(46): Disabled(0)
        SBE Type(47): 0x01
        OTP BDADDR: DC:97:BA:54:1F:72 (OUI DC-97-BA)
        Unlocked State(49): Disabled(0)
        Firmware SHA1(50): 0xe4a9801b
        Unknown Type(51):
        00 00 00 00
        Unknown Type(54):
        02
        Unknown Type(56):
        01
        Unknown Type(57):
        01 00
        Unknown Type(58):
        05 00
        Firmware ID(80): usb
---
 monitor/intel.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/monitor/intel.c b/monitor/intel.c
index 0de864d8a41e..dbfd06317bea 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -205,6 +205,9 @@ static void print_version_tlv_img_type(const struct intel_version_tlv *tlv,
 	case 0x01:
 		str = "Bootloader";
 		break;
+	case 0x02:
+		str = "Intermediate loader";
+		break;
 	case 0x03:
 		str = "Firmware";
 		break;
@@ -252,6 +255,12 @@ static void print_version_tlv_mfg(const struct intel_version_tlv *tlv,
 						bt_compidtostr(mfg_id), mfg_id);
 }
 
+static void print_version_tlv_fw_id(const struct intel_version_tlv *tlv,
+				    const char *type_str)
+{
+	print_field("%s(%u): %s", type_str, tlv->type, tlv->val);
+}
+
 static const struct intel_version_tlv_desc {
 	uint8_t type;
 	const char *type_str;
@@ -291,6 +300,8 @@ static const struct intel_version_tlv_desc {
 	{ 47, "SBE Type", print_version_tlv_u8 },
 	{ 48, "OTP BDADDR", print_version_tlv_otp_bdaddr },
 	{ 49, "Unlocked State", print_version_tlv_enabled },
+	{ 50, "Firmware SHA1", print_version_tlv_u32},
+	{ 80, "Firmware ID", print_version_tlv_fw_id},
 	{ 0, NULL, NULL },
 };
 
-- 
2.40.1

