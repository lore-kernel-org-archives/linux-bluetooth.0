Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F17C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 19:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiF2TnU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiF2TnT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 15:43:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04251A39A
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656531799; x=1688067799;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jHcFb4OVhaJKib6SGfga8n1lmQJDq7Dy/DmjLvIB5i8=;
  b=YA/kLe+bPUeF+rz5nHvgkfSbdMeBBii6v6om9SqqXexWoWF6Y+oR3Ihv
   4lJSdz4TGJ8Srl5M+iTYyjcYETJcG/p6fHLs0lYQDRJdPidIfxjwne0Ti
   gGct3pX/sjkKIf1XNUcfgiSW/Dn/jf7ZY6YvjxZmfrf4Yvgtga0BBBI59
   2qygn5mFa1928LonWsL5Z02X3SKs7X6+FOLN+ka/to40nAInN1v5wMO9J
   l7hvJiksbFBJSTauX2cEidRLPwzi6zqp4qEDInLgzLqIld6b4GWHwa5P0
   fIP4jO2xvERBpFJqTrrxkzv7NDW1T2jlfJFthIf/C/y4pYNoY821+W++R
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="343825263"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="343825263"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 12:19:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="647541505"
Received: from bsquresh-mobl4.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.91.166])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 12:19:54 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ] monitor: fix usage of size_t %z formater
Date:   Wed, 29 Jun 2022 12:19:43 -0700
Message-Id: <20220629191943.17326-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some versions of GCC use strict typing for the %z formater, so passing
an argument of type uint64_t instead of size_t throws an error.
---
 monitor/l2cap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index 00a8ffbbd..86113e59d 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -291,7 +291,7 @@ static inline bool l2cap_frame_print_be64(struct l2cap_frame *frame,
 		return false;
 	}
 
-	print_field("%s: 0x%zx", label, u64);
+	print_field("%s: 0x%zx", label, (size_t)u64);
 
 	return true;
 }
@@ -320,7 +320,7 @@ static inline bool l2cap_frame_print_le64(struct l2cap_frame *frame,
 		return false;
 	}
 
-	print_field("%s: 0x%zx", label, u64);
+	print_field("%s: 0x%zx", label, (size_t)u64);
 
 	return true;
 }
-- 
2.36.1

