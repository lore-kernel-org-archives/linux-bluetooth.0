Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0E2F2F
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841819; cv=none; b=Hqcu8uSNGhy4vMNPNZLL4fFAC+CFjJG/HxDnxcb+AzwPhuwcVplQUa4ENdYQOJutp/zciK2BfSju1Rwo4ZdhKUBKlpsu90eT9j3trguHJjJwiMiQ935vu/j+C101FVdWm/J2bgh5bmyja85+QTmy7dJCP7yWldw74nKyxaAjnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841819; c=relaxed/simple;
	bh=DFK6r90ERvZBmDjexRZ+0Ca86dXdPjNFRZfJWJqXjuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmuMvAdg9IXclXONv5SoywjaEiOpniUtS6T6wewwusfyyLiHEHvg/2sSjoN0Zl09i6ySmfJFWC2ho5f8QEmDy563WNd6oUBSM/plgwhlGuNG3iiI3tQoF8VQAEmeoxku8A8QjlHV0tB24TytJDC+JdIdjcVK3KyP/ezRaBrjHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xg3VJp5d; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xg3VJp5d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707841818; x=1739377818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DFK6r90ERvZBmDjexRZ+0Ca86dXdPjNFRZfJWJqXjuY=;
  b=Xg3VJp5dS0WF6eRrxVEn7vXGrJQKGjhtWrWgyrAriQky5YLOSUR4GQvK
   tRbf4p4dhlOZYmVkMtUT+eXEaHckGZ4VfkXd6+gVRhKwBogxbHywgldXq
   HquXY0YMHwHT6xs0aLpaC2eVo3p8juVzKURPla5MB0zCTmGho0pSOWL54
   vUT/p8ZX/L4Pt+qols7+eI3/7zqRYHX6MmGkBN1OUIiLOI/ckGprTRhrT
   vB8YmnK4/s84kefSZ9ImVkHNjqaCLtep6+l7gnZtZ69Oxppy3eIK9W7mn
   aZmnSjfaVTzvmTfp+1L3biAoR3fI2eBm4KhiGaQ3dokgY8bu6IsTiikbT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5629507"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="5629507"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2904773"
Received: from weba0535.iind.intel.com ([10.224.186.30])
  by orviesa009.jf.intel.com with ESMTP; 13 Feb 2024 08:30:15 -0800
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	Ajay KV <ajay.k.v@intel.com>
Subject: [PATCH v2 1/3] lib/uuid: Add support to compare 16bit uuids
Date: Tue, 13 Feb 2024 23:57:01 +0200
Message-Id: <20240213215703.21507-4-ajay.k.v@intel.com>
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
 lib/uuid.c | 9 +++++++++
 lib/uuid.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 1d2e1f7328b8..9a216e7cef60 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -120,6 +120,15 @@ int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2)
 	return bt_uuid128_cmp(&u1, &u2);
 }
 
+int bt_uuid16_cmp(const bt_uuid_t *uuid1, uint16_t uuid2)
+{
+
+	if (!uuid1 || (uuid1->type != BT_UUID16))
+		return 0;
+
+	return (uuid1->value.u16 == uuid2);
+}
+
 /*
  * convert the UUID to string, copying a maximum of n characters.
  */
diff --git a/lib/uuid.h b/lib/uuid.h
index 8839dea08140..124e74985a80 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -242,6 +242,7 @@ int bt_uuid32_create(bt_uuid_t *btuuid, uint32_t value);
 int bt_uuid128_create(bt_uuid_t *btuuid, uint128_t value);
 
 int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2);
+int bt_uuid16_cmp(const bt_uuid_t *uuid1, uint16_t uuid2);
 void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst);
 
 #define MAX_LEN_UUID_STR 37
-- 
2.34.1

