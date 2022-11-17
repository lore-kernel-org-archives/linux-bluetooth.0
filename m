Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25C0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Nov 2022 20:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiKQUWF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 15:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbiKQUWD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 15:22:03 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8811920189
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 12:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668716522; x=1700252522;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yjgrbDITLo7e6M4DATCiPUB6AujLMyEgDUbFsv21TDs=;
  b=l+CneAn/9Adb7khtKVd/LM+vv18DNSB1S1vzTDJ523so5+4Zn8ho1aBd
   KNWvihQqHPPoGj6bLieVV6t23Fdro7luX/Y3qxdgN5t575ugEI6Qhu3Vp
   o2UIERL7jlTdhA8nR4nZ+Q3bSBdEO6y2y2TerjJW137zBhGIbPWu9i5mo
   kZgDrNmxJ5j1T5PgZOe0dt+L8RrU0aDQ6dlZirMl8ymwg9IiAWMn88+vm
   K5X31ASQa3ozvkwd89DtIAhVtsHh5wVTu8/SP+gVtaWDGve0MLIm7Na5v
   ryZPPdIZ3czapXY+VhfUHutCuW9PCNpArU253quroudREMbygIp6qLBbo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="310597664"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="310597664"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 12:22:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="745694216"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="745694216"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.20.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 12:22:02 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ] tools: Use portable 64 bit data formats
Date:   Thu, 17 Nov 2022 12:21:50 -0800
Message-Id: <20221117202150.56236-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The isotest executable was using the non-portable %zd string formatter
for loging 64 bit integers. This replaces them with PRId64.
---
 tools/isotest.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index 8a50bfee8..dcd087ee1 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -30,6 +30,7 @@
 #include <sys/uio.h>
 #include <linux/sockios.h>
 #include <time.h>
+#include <inttypes.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -589,12 +590,12 @@ static void send_wait(struct timespec *t_start, uint32_t us)
 	delta_us = us - TS_USEC(&t_diff);
 
 	if (delta_us < 0) {
-		syslog(LOG_INFO, "Send is behind: %zd us", delta_us);
+		syslog(LOG_INFO, "Send is behind: %" PRId64 " us", delta_us);
 		delta_us = 1000;
 	}
 
 	if (!quiet)
-		syslog(LOG_INFO, "Waiting (%zd us)...", delta_us);
+		syslog(LOG_INFO, "Waiting (%" PRId64 " us)...", delta_us);
 
 	usleep(delta_us);
 
-- 
2.38.1

