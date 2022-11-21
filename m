Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35F2C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 23:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiKUXqm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 18:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiKUXqS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 18:46:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3849EDAD17
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 15:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669074280; x=1700610280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8VVdGqrvO4rN5n2VC5kIKRX1GL4xfQEfz1FS1yeD86g=;
  b=L9RGTYlAVv8YxMsFjrbmGvrYPi2mJrEJiCHg21/Z7blC3HxuvSWsb47I
   qruN7QTphJFt96Z8MKpwARSy7PfCiu5Mdpv0DrtSja03ONeATgpUG0kC7
   hyrjT5SNpOqKaudA9vl2w6/XZv9yqPk5hxkQWx7jI6vLJS1dSJPJj9eoe
   d4uKLJM/IQ8OARGMaJJsTfZj+FDLhmVr2/X6h7c/WY301Yh2ZmopmbhC/
   ZkkofByDnUUDdBjk5jclcDURZBDXlUnkrQQn82JHroexBuyXCHKghd/12
   e7Sl5lk1uHciAcLJ1VFQIWaWYsHx719AbZpAfaWYG24wSMJlchjf5BYIX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="377946590"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="377946590"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 15:44:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="783633435"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="783633435"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2022 15:44:38 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ 1/6] lib/uuid: Add CSIS UUIDs
Date:   Tue, 22 Nov 2022 05:16:19 +0530
Message-Id: <20221121234624.2961-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121234624.2961-1-sathish.narasimman@intel.com>
References: <20221121234624.2961-1-sathish.narasimman@intel.com>
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

