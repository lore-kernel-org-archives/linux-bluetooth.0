Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A59A485505;
	Thu, 15 Oct 2026 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062146; cv=none; b=smYFBkH1ov5SExGEDc6w/JXJ8wOkeF+/DwyNF+27HQEonmYPQTEC6fA7nSw2xCYHqtsNe1sVnq8HV60PT4ybISamo/HxmFNdh5k+G3utwCHOxsBBG3dNVCly2EgArH8YFAYcAT1jq1Uu+UUBJOUkUpvRYNc6fNBXTNYyPNofxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062146; c=relaxed/simple;
	bh=ESS2EiCaSpe8CqgEdQQHguXco7p+CSqoUFm/F/zwevs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foA/pT/MNV4UOw8TSjb4u9TRlKgb3l4ivvhmtx9jWuMOs2oH0pZRuQEjGqFPlzjELGw3cIEbsmKp8EqdHqSMnZGxcvL4Gjb3Xce63qysY5FBl88XObhgKX8RF58egwkF5fXpyJnNwc1SP13zGX3R3Z951HD0Pz9E18IekMaKR+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PW1ywTgf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PW1ywTgf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792062145; x=1823598145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ESS2EiCaSpe8CqgEdQQHguXco7p+CSqoUFm/F/zwevs=;
  b=PW1ywTgfLlXUZXPFy/R8Djt/2jedljhP8San+O+FK9bEFEpLgD34S2ts
   /OfLBmi5XTmvl6PV/jMa0Lh2PVNyJI6iC1SzvO9KUoGRbZu3bBUYTUcmK
   zH0khE09TLVUnPjLFbrPxooXucDgfF7T79de5JsMAhrBGZh8XLWfAdTck
   IlU9WzsWgtVWY6pXY5SYUZ5OsH4ZJD65uPF4uUJWaBW3AuSNj0jzI8XT7
   dDJF2HyBRVfAwgXPB4q3dbKtZxOziy/JsN4WQQqkG/CPER6Qr/UG7/3ft
   kISnYTGzk1Lpdl2a/ovxny+dYxtEle9DMt7wEgzUTB3bUNCtusICIGNDP
   w==;
X-CSE-ConnectionGUID: o9yvRi2fRaSaWP784ssFqw==
X-CSE-MsgGUID: /cleY1I5SHaCBcmoIgxDcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="723513"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="723513"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 04:02:24 -0700
X-CSE-ConnectionGUID: FNrzUmJXTd6sRJ3E3BOyqg==
X-CSE-MsgGUID: Q2wFBBc0QyOzFbXh3mTNyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1549082"
Received: from unknown (HELO WEBAPTLH032.iind.intel.com) ([10.66.250.231])
  by orviesa007.jf.intel.com with ESMTP; 15 Oct 2026 04:02:22 -0700
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ajaykv <ajay.k.v@intel.com>
Subject: [PATCH v4 2/3] Bluetooth: btintel_pcie: Validate the YoYo DEBUG_INFO TLV
Date: Thu, 15 Oct 2026 14:02:17 +0300
Message-ID: <20261015110218.22585-2-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015110218.22585-1-ajay.k.v@intel.com>
References: <20261015110218.22585-1-ajay.k.v@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ajaykv <ajay.k.v@intel.com>

Require a DEBUG_INFO TLV in the YoYo firmware configuration. Validate
its payload length, version, Bluetooth domain, external image type,
and Bluetooth core type before accepting the configuration.

Reject missing or invalid metadata so the driver keeps legacy DBGC
defaults instead of enabling an incompatible configuration.

Signed-off-by: Ajaykv <ajay.k.v@intel.com>

diff --git a/drivers/bluetooth/btintel_pcie_debug.c b/drivers/bluetooth/btintel_pcie_debug.c
index 0e933f4ec376..615996232cdf 100644
--- a/drivers/bluetooth/btintel_pcie_debug.c
+++ b/drivers/bluetooth/btintel_pcie_debug.c
@@ -11,11 +11,59 @@
 
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/unaligned.h>
 #include <net/bluetooth/bluetooth.h>
 #include "btintel_pcie_debug.h"
 
+/* TLV-specific parser DEBUG_INFO TLV type */
+static int btintel_pcie_yoyo_parse_dbg_info(struct btintel_pcie_yoyo_ctx *ctx,
+					    const struct btintel_pcie_tlv_dbg_info *info,
+					    u32 len)
+{
+	const u8 *data = (const u8 *)info;
+	u32 domain, image_type, core_type, version;
+
+	if (len != sizeof(*info) - sizeof(struct btintel_pcie_tlv_hdr))
+		return -EBADMSG;
+
+	image_type = get_unaligned_le32(data +
+				       offsetof(struct btintel_pcie_tlv_dbg_info,
+						image_type));
+	core_type = get_unaligned_le32(data +
+				      offsetof(struct btintel_pcie_tlv_dbg_info,
+					       core_type));
+	domain = get_unaligned_le32(data +
+				   offsetof(struct btintel_pcie_tlv_dbg_info,
+					    dbg_hdr.domain));
+	version = get_unaligned_le32(data +
+				     offsetof(struct btintel_pcie_tlv_dbg_info,
+					      dbg_hdr.tlv_data_version));
+
+	if (domain != BTINTEL_PCIE_DOMAIN_BT ||
+	    version != BTINTEL_PCIE_DBG_INFO_TLV_VERSION) {
+		BT_WARN("YoYo: unsupported domain/version (%u/%u), disabling",
+			domain, version);
+		return -EINVAL;
+	}
+
+	if (image_type != BTINTEL_PCIE_IMAGE_TLV_TYPE_EXTERNAL) {
+		BT_WARN("YoYo: unsupported image_type 0x%x, disabling", image_type);
+		return -EINVAL;
+	}
+
+	if (core_type != BTINTEL_PCIE_CORE_TYPE_BT) {
+		BT_WARN("YoYo: non BT core_type %u, disabling", core_type);
+		return -EINVAL;
+	}
+
+	ctx->dbg_info_present = true;
+	BT_DBG("YoYo: config='%.64s' image=%u core=%u",
+	       info->config_name, image_type, core_type);
+	return 0;
+}
+
 /*
  * Parse the optional YoYo firmware TLV stream and validate each record.
  * This is the entry point for the runtime debug configuration payload.
@@ -27,6 +75,7 @@ static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
 	const u8 *ptr = buf;
 	size_t remaining = buf_len;
 	u32 count = 0;
+	int ret = 0;
 
 	while (remaining >= sizeof(*tlv)) {
 		size_t tlv_size;
@@ -45,6 +94,13 @@ static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
 
 		switch (type) {
 		case BTINTEL_PCIE_TLV_TYPE_DBG_INFO:
+			ret = btintel_pcie_yoyo_parse_dbg_info(ctx,
+							       (const void *)tlv, len);
+			if (ret) {
+				ctx->dbg_info_present = false;
+				return ret;
+			}
+			break;
 		case BTINTEL_PCIE_TLV_TYPE_DBG_REGION:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_HCMD:
@@ -105,6 +161,7 @@ void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx)
 		return;
 
 	ctx->enabled = false;
+	ctx->dbg_info_present = false;
 }
 EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_cleanup);
 
@@ -149,6 +206,10 @@ int btintel_pcie_yoyo_load_and_parse(struct btintel_pcie_yoyo_ctx *ctx,
 		BT_ERR("YoYo: tlv parsing failed (%d)", ret);
 		return ret;
 	}
+	if (!ctx->dbg_info_present) {
+		BT_ERR("YoYo: Invalid BT debug Info tlv, using legacy DBGC defaults");
+		return -EBADMSG;
+	}
 
 	ctx->enabled = true;
 
diff --git a/drivers/bluetooth/btintel_pcie_debug.h b/drivers/bluetooth/btintel_pcie_debug.h
index b0b94c2a169d..717e8838c4d5 100644
--- a/drivers/bluetooth/btintel_pcie_debug.h
+++ b/drivers/bluetooth/btintel_pcie_debug.h
@@ -26,6 +26,19 @@
 #define BTINTEL_PCIE_TLV_TYPE_DBG_CONFIG_SET		0x100000A
 #define BTINTEL_PCIE_TLV_TYPE_DBG_PRESET_OVERRIDE	0x100000B
 
+/* Supported TLV type versions */
+#define BTINTEL_PCIE_DBG_INFO_TLV_VERSION	2
+/* Debug Info TLV */
+#define BTINTEL_PCIE_CONFIG_NAME_LEN		64
+#define BTINTEL_PCIE_DOMAIN_BT			0
+#define BTINTEL_PCIE_CORE_TYPE_BT		1
+
+enum btintel_pcie_image_tlv_type {
+	BTINTEL_PCIE_IMAGE_TLV_TYPE_EXTERNAL	= 0x1,
+	BTINTEL_PCIE_IMAGE_TLV_TYPE_INTERNAL	= 0x2,
+	BTINTEL_PCIE_IMAGE_TLV_TYPE_UNKNOWN	= 0xff,
+};
+
 /* TLV header */
 struct btintel_pcie_tlv_hdr {
 	__le32 type;
@@ -44,6 +57,25 @@ struct btintel_pcie_addr_value {
 	__le32 value;
 } __packed;
 
+/*
+ * struct btintel_pcie_tlv_dbg_info - YoYo DEBUG_INFO TLV
+ * @hdr: TLV type and payload length
+ * @dbg_hdr: Debug TLV version and domain
+ * @image_type: Firmware image type
+ * @core_type: Firmware core type
+ * @config_name: Fixed-size name of the firmware configuration
+ *
+ * Describes the firmware image targeted by the YoYo configuration. Fields
+ * are stored in little-endian format in the packed firmware TLV.
+ */
+struct btintel_pcie_tlv_dbg_info {
+	struct btintel_pcie_tlv_hdr hdr;
+	struct btintel_pcie_dbg_hdr dbg_hdr;
+	__le32 image_type;
+	__le32 core_type;
+	u8 config_name[BTINTEL_PCIE_CONFIG_NAME_LEN];
+} __packed;
+
 /*
  * struct btintel_pcie_yoyo_ctx- Runtime state for YoYo debug configuration
  * @enabled: Whether the loaded YoYo configuration passed validation
@@ -58,12 +90,11 @@ struct btintel_pcie_addr_value {
  */
 struct btintel_pcie_yoyo_ctx {
 	bool			 enabled;
-
+	bool			 dbg_info_present;
 	struct list_head	 region_list;
 	struct list_head	 trigger_list;
 	struct list_head	 hcmd_list;
 	struct list_head	 config_set_list;
-
 	struct hci_dev		 *hdev;
 };
 
-- 
2.53.0

