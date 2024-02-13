Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DEEBA53
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841818; cv=none; b=K/UKkpfIKO+tRieWcuhkmuSVdcZ1yWpUBwE1nYyVZEXpPnbxv7LCv6Afg1ncOPc4abxB0dLPpJF8iRzajWbi1++1P5DWg7ddYOC08ZOF1RYhiRSplB7XHH2bCUc2y22nSprsXk/FHSDJ4jQmgwd74kzQxejgS8C+7ol6Mn0TTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841818; c=relaxed/simple;
	bh=2JHVNISoH9PC5E92Apajn8Qk9GGQh+lYA3YlwsUOMfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFEUTJNtE9Bt+R4Mn3ExDuWkAIbKeUBn2Uoi85eQTx7NLTEqLf2ZoAEyipGpJEX4n/zshTdKwBmpVyLKg4yDIN14HRJKcFWG8mWYXD6Qnb4D4+WFK7E/MqjuWUmMQOm1QVrt3g3Z8h/xN3udOR5s2BiA5DduM4BSfJPi2xVml7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPx/9xeY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPx/9xeY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707841816; x=1739377816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2JHVNISoH9PC5E92Apajn8Qk9GGQh+lYA3YlwsUOMfM=;
  b=nPx/9xeYjSFkOHDPMpaa1/x+fBlLWMbz2pDsUrhu1k3/FKQ9fnvIFW1a
   Ir47acvBumhPSqm2ePiQzOURSkk3O7BdPRt8OWaeOVmiu9riIMpXIF92k
   HhiiCx8Qz9UHS2sOeqcrXfUtolaNVWYyPjwg7o4LUWC1F6Io0D1z2QyzL
   nmCq7BOmN129WmPAILXsIOV3+Q154KYg3Gug8Bdj3FaYz7+tC2zPuGHPn
   wto9pt7qDl/5UpasJ6jdzIpVttvGz9dvaZMBaHRFD35bgbdTr3UGOvXeg
   D+Un+tg2cikUbluzW0VjN51N3rBRE8VOR/j9wo0Ar4A3rP0AbILPBaUnL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5629505"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="5629505"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:30:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2904753"
Received: from weba0535.iind.intel.com ([10.224.186.30])
  by orviesa009.jf.intel.com with ESMTP; 13 Feb 2024 08:30:11 -0800
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	Ajay KV <ajay.k.v@intel.com>
Subject: [PATCH BlueZ 2/3] lib/uuid: Add GTBS UUIDS for Call Control Profile.
Date: Tue, 13 Feb 2024 23:56:59 +0200
Message-Id: <20240213215703.21507-2-ajay.k.v@intel.com>
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

