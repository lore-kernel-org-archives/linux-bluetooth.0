Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDBCC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 03:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiKVDXq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 22:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiKVDXp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 22:23:45 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33BF23EA5
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 19:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669087424; x=1700623424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8VVdGqrvO4rN5n2VC5kIKRX1GL4xfQEfz1FS1yeD86g=;
  b=Isf7kM/6DWNBDqkHF+MSdE52lwL26BXSZZTl4yjo5NrwcUI271tp0uUD
   +8lDMgZxnnDEy9ciITsbvEU7NbdS0kjC1c/KGLrGYq5iwRU0tLftjlwLs
   jfcqIKbFNfb1cNFpFaqkF2nvA9tECbMiQYvOTyhQU2tZFFAklbnr5iNwN
   /EX9/4CydqRxXTzHS4/Sz3VjgDadzVkPYa42upHnQGQqJbtiVc+bi8m3t
   cvEKt1Qe6vXJp19sz0dNbK0qfumxPvWTZUTAlrQfCPNMJlyEN8sQV66DY
   zyshkbH3DUGUlPYVfwmEj/7Qg3On8NsjGtugdCHfPTTc6E1+C+KM38T2X
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="340583266"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="340583266"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 19:23:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672331698"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="672331698"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2022 19:23:43 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ V2 1/6] lib/uuid: Add CSIS UUIDs
Date:   Tue, 22 Nov 2022 08:55:25 +0530
Message-Id: <20221122032530.3842-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122032530.3842-1-sathish.narasimman@intel.com>
References: <20221122032530.3842-1-sathish.narasimman@intel.com>
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

