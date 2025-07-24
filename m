Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A442BD5AE
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358001; cv=none; b=Dqbo4z3lad/WLxAU1RQz8B5R8dboL/ezRkefl7vSTFB1xltMR/nJLd93u8ahQo6d2XrKaLH3GHRllHWr9J4FoszyoOXGW10D4T6DNBVs8Bc3/K0rZHntKmZWyCIsnA8ownx2nwfiIJcYOeV6eK+TjF0Wa1NfFi/aZ3J78oFmPKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358001; c=relaxed/simple;
	bh=YfeMkpYIPFB1DMwWqJzj5xiIsuUhth3awjhatKRu5qE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=icTAhoM+m/ZAk3GNv8vV5ypy7JIglIe+qgro+C6RpIWBANyBXJMF0CNmAVLHWqAegNrzB42lVT2F2ovMkVtfNdCF52NVdiveYauZaCQZu76Qe+4rbvQlTJQhwd/U10xOG5eOzwh+FADLA8aYX3/xedJl44HiQ4YbAjxSmukqWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpjarF3H; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpjarF3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753358000; x=1784894000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YfeMkpYIPFB1DMwWqJzj5xiIsuUhth3awjhatKRu5qE=;
  b=MpjarF3H6HwiHtZO1FrsfcHRHa1/pSVUBXS3a5DZD3lTLT+vBEte8DhY
   +W09BBIzy0LDMyCR0ZzLxx011UrsAKHIDF4lJ5IiQuvgEQW955KdBN39+
   nEZAlNYyvEwR5FpytWl3kmW5EWtIwc94Ho/CJU8xqlhHRgJnB6yYz3HFA
   3OI1tkWm1+s/NdJ6VtbAZliXh5yHK07YpOd/MckhPZUVW8aZi3Uk54+qr
   c+yhw0svto6K7cpUCftr8sVAfy+Jv9WjFYffKS3LsDSrlVq0PStpFWZjg
   iRsRTUb7jMcvhFmlxccsZAubJpClupWXul3Iy4NjIGwAez5CVjSxIWmgi
   Q==;
X-CSE-ConnectionGUID: ChFhycTiRo6GtqZpTyvAGQ==
X-CSE-MsgGUID: H6AkpOaHRiaaBFyH41ZeKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="67018536"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="67018536"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:53:19 -0700
X-CSE-ConnectionGUID: pRWDHySTSuG/Wu47P2TEMw==
X-CSE-MsgGUID: kFc4x2ZAQZK3LuajQ6ew/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="165562053"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa004.fm.intel.com with ESMTP; 24 Jul 2025 04:53:18 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] monitor/intel: Add decoding of cnvi core
Date: Thu, 24 Jul 2025 17:39:53 +0530
Message-ID: <20250724120953.1344384-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add decoding of cnvi core from Intel read version event.

sudo hcitool cmd 3f 05 ff

HCI traces:
< HCI Command: Intel Read Version (0x3f|0x0005) plen 1
        Requested Type:
          All Supported Types(0xff)
> HCI Event: Command Complete (0x0e) plen 122
      Intel Read Version (0x3f|0x0005) ncmd 1
        Status: Success (0x00)
        CNVi TOP(16): 0x01080901
        CNVr TOP(17): 0x00002a10
        CNVi BT(18): cnvi (BlazarIW) cnvibt: (0x00223700)
        CNVr BT(19): 0x00313000
        CNVr OTP(21): 0x0344
	.....
	.....
---
 monitor/intel.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/monitor/intel.c b/monitor/intel.c
index 0de864d8a41e..dd1e3396086a 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -196,6 +196,48 @@ static void print_version_tlv_enabled(const struct intel_version_tlv *tlv,
 					tlv->val[0]);
 }
 
+static void print_version_tlv_cnvi_bt(const struct intel_version_tlv *tlv,
+				      const char *type_str)
+{
+	const char *str;
+	uint32_t cnvibt = get_le32(tlv->val);
+
+	switch ((cnvibt >> 16) & 0x3f) {
+	case 0x17:
+		str = "Typhoon Peak2";
+		break;
+	case 0x18:
+		str = "Solar";
+		break;
+	case 0x19:
+		str = "Solar F";
+		break;
+	case 0x1b:
+		str = "Magnetor";
+		break;
+	case 0x1c:
+		str = "Gale Peak2";
+		break;
+	case 0x1d:
+		str = "BlazarU";
+		break;
+	case 0x1e:
+		str = "BlazarI";
+		break;
+	case 0x1f:
+		str = "Scorpious Peak";
+		break;
+	case 0x22:
+		str = "BlazarIW";
+		break;
+	default:
+		str = "Unknown";
+		break;
+	}
+	print_field("%s(%u): cnvi (%s) cnvi_bt: (0x%8.8x)", type_str, tlv->type,
+		    str, get_le32(tlv->val));
+}
+
 static void print_version_tlv_img_type(const struct intel_version_tlv *tlv,
 				       const char *type_str)
 {
@@ -259,7 +301,7 @@ static const struct intel_version_tlv_desc {
 } intel_version_tlv_table[] = {
 	{ 16, "CNVi TOP", print_version_tlv_u32 },
 	{ 17, "CNVr TOP", print_version_tlv_u32 },
-	{ 18, "CNVi BT", print_version_tlv_u32 },
+	{ 18, "CNVi BT", print_version_tlv_cnvi_bt},
 	{ 19, "CNVr BT", print_version_tlv_u32 },
 	{ 20, "CNVi OTP", print_version_tlv_u16 },
 	{ 21, "CNVr OTP", print_version_tlv_u16 },
-- 
2.43.0

