Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2EA399
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841816; cv=none; b=dq2/8KHbnqK4p/OBfHTpHNWKWO303fHk8NpalkonBckVNeaF47vokl25jYwUWZo9jQf+fJ9qCrXVXPRQuUXhxU/5blXcboDh9f16NKVC6lVq3N5OiiF+M3z50/v0H0Bggoo1mpcH9cJGA6pymMHkfT6zHFSM39E08QX9rTfjOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841816; c=relaxed/simple;
	bh=ZPhiTtmHA5Wz+bP/VwMzuP5GMayeXXPL5w4/3O/na9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LBvuEOq+0h4Kwhmda9yHBjaaVk2f8rBvRTkJqfO/ElbyqukCwe2SCBc9U2hA2Ch+We3M/v+pVTrwyNO7gip/XwfAmiIn2MbUPQ5sKUNZ8JWz9ewUWF7dL5q/D06hZR1t/4om9b5GnrRpPw1HZvpklZki2qNqsPSblTVYTK0C4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D55pZu3+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D55pZu3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707841814; x=1739377814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZPhiTtmHA5Wz+bP/VwMzuP5GMayeXXPL5w4/3O/na9w=;
  b=D55pZu3+Fos+VMDPQkzKmi5bED3LImlMnbmncLqaE0vhR1utFz5DrRJu
   Sc2lHF79LjDdbs/vA2YrNj18lLWVTvr7PjlAbxUO8k6GVShj0iUx5Dyer
   kXdQLlwLI+fQsHEcvh6ftEhhBVSdL7Enm653Fk0bekpBsV1C1VCRaVu7T
   vWmdPDhnK1hjf0dtrv8x2muZlypEclWAiCQBlSRynyR6xEwkJa20EQGAq
   V/QElSu9oEXGupg26m4TT31c3QgF/yQf492cfFES9ZhcjUF4v/k9nrQGF
   Yuzlay65SZ3CYhyE3HrDy4vRPhIhklj1lnuK27ge3B5mAX8MR25Z+apZL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5629500"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="5629500"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:30:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2904747"
Received: from weba0535.iind.intel.com ([10.224.186.30])
  by orviesa009.jf.intel.com with ESMTP; 13 Feb 2024 08:30:10 -0800
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	Ajay KV <ajay.k.v@intel.com>
Subject: [PATCH BlueZ 1/3] lib/uuid: Add support to compare 16bit uuids
Date: Tue, 13 Feb 2024 23:56:58 +0200
Message-Id: <20240213215703.21507-1-ajay.k.v@intel.com>
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

