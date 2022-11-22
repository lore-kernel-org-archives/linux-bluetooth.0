Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065FCC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 10:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiKVKKz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiKVKKx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 05:10:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80EC45A3D
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 02:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669111852; x=1700647852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8VVdGqrvO4rN5n2VC5kIKRX1GL4xfQEfz1FS1yeD86g=;
  b=Mozeddf2fKbVol5O4LpfyD1y52Z4pl+y6RbKqgFC7Ba5ZyS/j0risWVE
   J1EwnNVbdZyZNByEi9+oqZz54fW1ei3yybKVqy869XE4f8W14+bnI2OUA
   qZqxU2Ae/UOLrzp1gNZuWhQqyziDLRl/G2RaCxAhfsXN1jgk0p26FdLbK
   Z1BvAsFx2UvR0DmHcecnte4Gsi3PlXdwv/DSpA+Y0DKILBO3tegdl3uY5
   fZO0YwxLPLpAnPZaHpqz23Yy7aHRhg908DR9ZEqfh7C0ZUnKwj+NXu0w+
   WQt6I3nEMqh1F9g0DA4rS7jo4/3OpjrM21RvR+RU2pJsuqeCJ/zAP4isf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="378039353"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="378039353"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 02:10:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672431896"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="672431896"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 02:10:49 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ v3 2/7] lib/uuid: Add CSIS UUIDs
Date:   Tue, 22 Nov 2022 15:42:27 +0530
Message-Id: <20221122101232.45320-3-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122101232.45320-1-sathish.narasimman@intel.com>
References: <20221122101232.45320-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds Coordinated Set Identification Service UUIDs which will
be used by Coordinated Set Identification Profile.
---
 lib/uuid.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index d5e5665e475c..84ff46cd8f36 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -186,6 +186,13 @@ extern "C" {
 #define MEDIA_CP_OP_SUPPORTED_CHRC_UUID         0x2ba5
 #define MEDIA_CONTENT_CONTROL_ID_CHRC_UUID      0x2bba
 
+/* Coordinated Set Identification Profile(CSIP) */
+#define CSIS_UUID					0x1846
+#define CS_SIRK						0x2B84
+#define CS_SIZE						0x2B85
+#define CS_LOCK						0x2B86
+#define CS_RANK						0x2B87
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
2.25.1

