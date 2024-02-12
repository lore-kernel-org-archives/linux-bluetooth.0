Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D411E3AC0C
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735031; cv=none; b=lBMkHpakxegGWP3FBN14reQ5m8Em1R7pJwMDO2m1Yjaoh0KwPKxc4jV7R9CFGywchEcTdHWKuzOs0h2q64iSSxVu8FKvRO8edBZrVXxtDc3g9boqD3Szu02B3jP0lqqlXhjnOn+6czK7/EcDWfYbR3drCjTBhZNQ1SwEUdvw0ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735031; c=relaxed/simple;
	bh=ZPhiTtmHA5Wz+bP/VwMzuP5GMayeXXPL5w4/3O/na9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NEw/CvIla2MqkmIVd4xU8z2Oi0epdyUzVMtqXA3NQ9wQxaCtonqD07Oe4NlUUNQv261Ljy1762r3Gu6caPw63Sgs8s3lC86FXTciSUBDxMDgdP9K8q8ypxxiB5zXRLeYeRy3Dn/fsVwdM+MirxQsGXeOSOt0/3Xk12lyD9mUFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2eyExow; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2eyExow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707735029; x=1739271029;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZPhiTtmHA5Wz+bP/VwMzuP5GMayeXXPL5w4/3O/na9w=;
  b=D2eyExowth2Fm3DWKv/fvxjqB7wMlfDWb5WEYiBOWmmlvoXuLCEs0vVA
   jBfKlPEfSQAR4hPpX/G79GT7QOi5yoEOMZeyX1yBaTRaVktqUzWG6olBO
   5opugKkBEryv5Gitl7srEJ3ZLRnjIK2KoXXfwf0oo/hTQd3iT31S6y7Yn
   +gX/ZGbFcHz3eOOivOTF4vTNNxkocT9bgq/ibs/tbd/R6Tc7hS6CsepnU
   4jr470SLPzEX/+Qjpd1qGvjJg5CkDgJZhDzuYDQebrDibSoQ9XFt4f6W6
   eIfqTJJYMU/FmBHSrTLdNH23jz/6mXJcS3O/f09AiUDaV5IzGu7TU76/N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1609237"
X-IronPort-AV: E=Sophos;i="6.05,263,1701158400"; 
   d="scan'208";a="1609237"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:50:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,263,1701158400"; 
   d="scan'208";a="33347542"
Received: from weba0535.iind.intel.com ([10.224.186.30])
  by orviesa002.jf.intel.com with ESMTP; 12 Feb 2024 02:50:28 -0800
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.sriv@intel.com,
	kiran.k@intel.com,
	Ajay KV <ajay.k.v@intel.com>
Subject: [PATCH BlueZ 1/3] lib/uuid: Add support to compare 16bit uuids
Date: Mon, 12 Feb 2024 18:17:24 +0200
Message-Id: <20240212161726.3097145-1-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.34.1
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
index 1d2e1f7328b8..3ef45db5408c 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -120,6 +120,15 @@ int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2)
 	return bt_uuid128_cmp(&u1, &u2);
 }
 
+int bt_uuid16_cmp(const bt_uuid_t *uuid1, uint16_t uuid2)
+{
+
+  if (!uuid1 || (uuid1->type != BT_UUID16))
+    return 0;
+
+  return (uuid1->value.u16 == uuid2);
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

