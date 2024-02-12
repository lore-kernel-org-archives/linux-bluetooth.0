Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9F3AC34
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735033; cv=none; b=FU5XYnzicZWM/+QnwK2lU8z6W9wF8sB1HxlWPPvz1rF9oXPmiTGbGdKhh0TawQ+EnkLBOtm4kM8Cb0fKwd2S6joZyPkpW/KxHZLr0RRyEL+8cQMDGUP0LOH9X34pNvxIasB9aHvXPcw+ENhCyfvyimMxtLzaLUT3dj1hRWAP8zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735033; c=relaxed/simple;
	bh=2JHVNISoH9PC5E92Apajn8Qk9GGQh+lYA3YlwsUOMfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5MLuHPn0OvqeB9yePAymDY9iiXgA1t7Cpd49kHxb1Tese2hHAmkxMEJxbe0cgL4hUmNXHF2bopGBdoe3+DavGrT6ivg7f11sZD6eg66dz0wwCRIlCH0NvhAYE96dflhnatyVTbh/8Z/qUGeTF8vbBn7qqZNq6d/wkEQ1hWni0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PH+7BArw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PH+7BArw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707735031; x=1739271031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2JHVNISoH9PC5E92Apajn8Qk9GGQh+lYA3YlwsUOMfM=;
  b=PH+7BArw1zDJoNTuSQ9WxqbC5viuzW7gVPTiFCyR3bmSbGMBpM7kOHdW
   4EdcsJLIbEyY+UrE29Rvldb9nhwIse/QNdU8DNLCZsk2AaNGHqnsVLMIJ
   RK+kqxcbEyKbRVPO6+MqVKboQnEP2o+q3Zz/BN/+48U90yx5zJOI+pUSx
   XLrmsQ75bd5HGgubURq3TjlREzPdM0PPAg4Zd0yr3yv8jh05JOlZ84C25
   CXvPobIa9D3KBDcq7VYFV18QmauSLfl5VUnV/VcSWqcGvBObhYo/wL5/F
   8skqTr97e1RJrlWhCD95tgrrShpB7UwZet3flk9QsBFFkD8qCV99VnVdJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1609238"
X-IronPort-AV: E=Sophos;i="6.05,263,1701158400"; 
   d="scan'208";a="1609238"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,263,1701158400"; 
   d="scan'208";a="33347550"
Received: from weba0535.iind.intel.com ([10.224.186.30])
  by orviesa002.jf.intel.com with ESMTP; 12 Feb 2024 02:50:30 -0800
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.sriv@intel.com,
	kiran.k@intel.com,
	Ajay KV <ajay.k.v@intel.com>
Subject: [PATCH BlueZ 2/3] lib/uuid: Add GTBS UUIDS for Call Control Profile.
Date: Mon, 12 Feb 2024 18:17:25 +0200
Message-Id: <20240212161726.3097145-2-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212161726.3097145-1-ajay.k.v@intel.com>
References: <20240212161726.3097145-1-ajay.k.v@intel.com>
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

