Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF33BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 19:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiF2Twg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiF2Twd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 15:52:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2E33466C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656532348; x=1688068348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zNItVhoGjzoxHAkmOctou+y+s3aQ4QlGYYRgIt7SeLc=;
  b=Rq/HJvrS/TKSJgQXSaGpN17CU7G5J0OY4yiKRaGZueGhW5CtwpXzDbco
   uTYCcp2ip6D7XrmmCBD1+HPGPYTDmPf11ZHkQ643QJx/d4GbDzINOaVgt
   NqkLu0k11qh7J+/8bZ8zLzgk7lEhHdGddvfFTcTvP/rqQ/3/3PkK++QbY
   3P+56LjtNbDwFjNaNIzAKQBVZxsLd4BKjEOU73RopqtKY6GowBMyiUD+X
   T7BrbEqPBV9++t9IygwO3rviqK20RHPvyx4JGh37ifT6NrWMoMefePRnp
   Igdsp3BAuUXz3VRKEOxll7HmXwiOJxCosaoKKLCyNDrj0FcHmVLfXIoy8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="282175957"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="282175957"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 12:44:43 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="647553056"
Received: from bsquresh-mobl4.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.91.166])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 12:44:43 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ 1/2] core: make bt_uuid_hash() portable across archs
Date:   Wed, 29 Jun 2022 12:44:31 -0700
Message-Id: <20220629194432.20229-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

bt_uuid_t is defined as a byte array, so it can cause alignment errors
on some architectures, when the two 64 bit halves are treated as u64s.
This patch ensures proper alignment across all architectures.

Fixes:
src/adapter.c: In function ‘bt_uuid_hash’:
src/adapter.c:3617:8: error: cast increases required alignment of target type [-Werror=cast-align]
  val = (uint64_t *)&uuid_128.value.u128;
        ^
cc1: all warnings being treated as errors
---
 src/adapter.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index afefa1d5d..c8b3d27a7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3607,16 +3607,14 @@ static void add_uuid_to_uuid_set(void *data, void *user_data)
 static guint bt_uuid_hash(gconstpointer key)
 {
 	const bt_uuid_t *uuid = key;
-	bt_uuid_t uuid_128;
-	uint64_t *val;
+	uint64_t uuid_128[2];
 
 	if (!uuid)
 		return 0;
 
-	bt_uuid_to_uuid128(uuid, &uuid_128);
-	val = (uint64_t *)&uuid_128.value.u128;
+	bt_uuid_to_uuid128(uuid, (bt_uuid_t *)uuid_128);
 
-	return g_int64_hash(val) ^ g_int64_hash(val+1);
+	return g_int64_hash(uuid_128) ^ g_int64_hash(uuid_128+1);
 }
 
 static gboolean bt_uuid_equal(gconstpointer v1, gconstpointer v2)
-- 
2.36.1

