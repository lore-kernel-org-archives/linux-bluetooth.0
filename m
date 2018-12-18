Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D861BC43444
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 22:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21662184C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 22:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeLRWcK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:32:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:60673 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbeLRWby (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 17:31:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 14:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="101704172"
Received: from bgix-dell-lap.sea.intel.com ([10.241.111.161])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2018 14:31:51 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org
Subject: [PATCH BlueZ v4 13/30] mesh: centralize generic utilities
Date:   Tue, 18 Dec 2018 14:31:22 -0800
Message-Id: <20181218223139.8041-14-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181218223139.8041-1-brian.gix@intel.com>
References: <20181218223139.8041-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/util.c | 26 ++++++++++++++++++++++++++
 mesh/util.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/mesh/util.c b/mesh/util.c
index 2cdcdf37d..ac0294742 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -26,10 +26,36 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
+#include <unistd.h>
+#include <termios.h>
 #include <time.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+
+#include <ell/ell.h>
 
 #include "mesh/util.h"
 
+void print_packet(const char *label, const void *data, uint16_t size)
+{
+	struct timeval pkt_time;
+
+	gettimeofday(&pkt_time, NULL);
+
+	if (size > 0) {
+		char *str;
+
+		str = l_util_hexstring(data, size);
+		l_debug("%05d.%03d %s: %s",
+				(uint32_t) pkt_time.tv_sec % 100000,
+				(uint32_t) pkt_time.tv_usec/1000, label, str);
+		l_free(str);
+	} else
+		l_debug("%05d.%03d %s: empty",
+				(uint32_t) pkt_time.tv_sec % 100000,
+				(uint32_t) pkt_time.tv_usec/1000, label);
+}
+
 uint32_t get_timestamp_secs(void)
 {
 	struct timespec ts;
diff --git a/mesh/util.h b/mesh/util.h
index 61110104a..b8efb6521 100644
--- a/mesh/util.h
+++ b/mesh/util.h
@@ -22,3 +22,4 @@ uint32_t get_timestamp_secs(void);
 bool str2hex(const char *str, uint16_t in_len, uint8_t *out,
 							uint16_t out_len);
 size_t hex2str(uint8_t *in, size_t in_len, char *out, size_t out_len);
+void print_packet(const char *label, const void *data, uint16_t size);
-- 
2.14.5

