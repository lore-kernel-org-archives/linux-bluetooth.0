Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A702919
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841821; cv=none; b=mQJ3cQIWS8NYie4BL34bpa/3jnZ31iwsbv23rVRsFTrc0nZEvjA0yO3gZgl+rMOyxxUA1LLWh4w0BFDsu+XyieUn0wV/exlYinK6nyCG6PWOZuq3CwPdzkmmZnlDrn/v9Hx6FpjcDDpUbu5FAkML4xqWc5434z4DOMH12pPHYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841821; c=relaxed/simple;
	bh=2JHVNISoH9PC5E92Apajn8Qk9GGQh+lYA3YlwsUOMfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSbf2zvFJUoNHRnUnfzVwK2YRR3YdthCrpNPXbVQ/dPPQ+cv9ag2ArG8pPaRzTsXvyMf2vm7O1k9nrzSU6JkHAQkCSMmAntllgVCg22CYwaOK+sbwtmLUD+cfrZiolaGMIhH0FDZYTtfBaWwr7r/R2gSeYq6uZgeeeJEbMnrElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZL56UuVJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZL56UuVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707841818; x=1739377818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2JHVNISoH9PC5E92Apajn8Qk9GGQh+lYA3YlwsUOMfM=;
  b=ZL56UuVJe9F26iGGDiUEdw57JnnEC8xgth03HrNUNObxzowN2M9zRaYH
   0UpMEE1taM5Ir8C+neiEAvCqaHs4p0MEoUyARI+obnDTlVtiXphrtAeI0
   QF7Zq/9b/lKSQ8cJ32RB3eokFDkbrVtohaVpktuLO7eGaUHMXeUmaiwQk
   /BMIvLOwrznpr5z5yf6EMdWPOvWdfiDjqcgIkvq88zVOHCPMslv//fMmK
   82hADMpgDs4kf4m7STFKbakTl6ZCNVimP39Pf97wbKekg1hxrr+JhaVBK
   7Zbi3Tcj8WYVdN/49gkhNKM9M4jk/h08jtMa3AEL0d3MKf+zpcI1QByez
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5629510"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="5629510"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2904785"
Received: from weba0535.iind.intel.com ([10.224.186.30])
  by orviesa009.jf.intel.com with ESMTP; 13 Feb 2024 08:30:16 -0800
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	Ajay KV <ajay.k.v@intel.com>
Subject: [PATCH v2 2/3] lib/uuid: Add GTBS UUIDs for Call Control Profile
Date: Tue, 13 Feb 2024 23:57:02 +0200
Message-Id: <20240213215703.21507-5-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213215703.21507-1-ajay.k.v@intel.com>
References: <20240213215703.21507-1-ajay.k.v@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 lib/uuid.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 124e74985a80..8404b287ed01 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -221,6 +221,27 @@ extern "C" {
 #define MICS_UUID					0x184D
 #define MUTE_CHRC_UUID					0x2BC3
 
+/* Call Control Service(TBS/CCS) */
+#define TBS_UUID                                0x184B
+#define GTBS_UUID                               0x184C
+
+#define BEARER_PROVIDER_NAME_CHRC_UUID          0x2bb3
+#define BEARER_UCI_CHRC_UUID                    0x2bb4
+#define BEARER_TECH_CHRC_UUID                   0x2bb5
+#define BEARER_URI_SCHEME_CHRC_UUID             0x2bb6
+#define BEARER_SIGNAL_STR_CHRC_UUID             0x2bb7
+#define BEARER_SIGNAL_INTRVL_CHRC_UUID          0x2bb8
+#define CURR_CALL_LIST_CHRC_UUID                0x2bb9
+#define BEARER_CCID_CHRC_UUID                   0x2bba
+#define CALL_STATUS_FLAG_CHRC_UUID              0x2bbb
+#define INCOM_CALL_TARGET_URI_CHRC_UUID         0x2bbc
+#define CALL_STATE_CHRC_UUID                    0x2bbd
+#define CALL_CTRL_POINT_CHRC_UUID               0x2bbe
+#define CALL_CTRL_POINT_OPT_OPCODE_CHRC_UUID    0x2bbf
+#define TERMINATION_REASON_CHRC_UUID            0x2bc0
+#define INCOMING_CALL_CHRC_UUID                 0x2bc1
+#define CALL_FRIENDLY_NAME_CHRC_UUID            0x2bc2
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
2.34.1

