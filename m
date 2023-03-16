Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CA1C7618D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 00:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjCPAPe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 20:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjCPAPc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 20:15:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881DD76164
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 17:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678925727; x=1710461727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mB/7JQG5ZEOogGz7UF6AXmvX0g47eY48njIDQRTB9xE=;
  b=B/BG8E0gV/s7hGC/gtmpnLHYCuR6DPeVQcMLtHQZt8UZZ4J6ZSxuPgTg
   Jfc45x714RXxlWVSebkMssNFRbdUeSf8xY1FNoli7Fy8aA+8r9jdhsOfY
   bC3NJooXgXE9e+XpE2wWv2v6vgBk3s3IXogeFcabf/NuDUZonT+YQhQ9l
   yhOn0AHWszhnCw0JUle9K9QhfaKszEn6vwvDx/sxgBlfG2ZYT6gdEpL+W
   DE2xFlF6H7YaSDbUfR7aMWVssgNyWkSyhdiJouS/KSLoy5uUmgBzoL5HC
   fKujaewtMJPDgrlaYz1a05JnR4bmBdnKd/l1Ub1ESP0Yxesl/C6u6t7M/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="318245181"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="318245181"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 17:15:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="672928229"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="672928229"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2023 17:15:25 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 2/2] ACPI: utils: acpi_evaluate_dsm_typed - fix redefinition error
Date:   Thu, 16 Mar 2023 05:55:59 +0530
Message-Id: <20230316002559.32562-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230316002559.32562-1-kiran.k@intel.com>
References: <20230316002559.32562-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

acpi_evaluate_dsm_typed function needs to be gaurded with CONFIG_ACPI to
avoid redefintion error when stub is also enabled.

In file included from ../drivers/bluetooth/btintel.c:13:
../include/acpi/acpi_bus.h:57:1: error: redefinition of 'acpi_evaluate_dsm_typed'
   57 | acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid,..
      | ^~~~~~~~~~~~~~~~~~~~~~~
In file included from ../drivers/bluetooth/btintel.c:12:
../include/linux/acpi.h:967:34: note: previous definition of
'acpi_evaluate_dsm_typed' with type 'union acpi_object *(void *,
const guid_t *, u64,  u64,  union acpi_object *, acpi_object_type)'
{aka 'union acpi_object *(void *, const guid_t *, long long unsigned int,
long long unsigned int,  union acpi_object *, unsigned int)'}
  967 | static inline union acpi_object
*acpi_evaluate_dsm_typed(acpi_handle handle,

Fixes: 1b94ad7ccc21 ("ACPI: utils: Add acpi_evaluate_dsm_typed() and acpi_check_dsm() stubs")
Signed-off-by: Kiran K <kiran.k@intel.com>
---

changes:
Fix compilation error when compiled for ARCH=arc
Details here:
https://patchwork.kernel.org/project/bluetooth/patch/20230313151549.15791-1-kiran.k@intel.com/


 include/acpi/acpi_bus.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e44be31115a6..fc131b4aee4e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -52,7 +52,7 @@ bool acpi_dock_match(acpi_handle handle);
 bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
 			u64 rev, u64 func, union acpi_object *argv4);
-
+#ifdef CONFIG_ACPI
 static inline union acpi_object *
 acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 			u64 func, union acpi_object *argv4,
@@ -68,6 +68,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 
 	return obj;
 }
+#endif
 
 #define	ACPI_INIT_DSM_ARGV4(cnt, eles)			\
 	{						\
-- 
2.17.1

