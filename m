Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B940C43444
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E30217F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeL1WH5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:07:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:19951 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeL1WH4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 17:07:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 14:07:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,411,1539673200"; 
   d="scan'208";a="113968716"
Received: from bgix-dell-lap.sea.intel.com ([10.252.140.14])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2018 14:07:55 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v6 12/26] mesh: Hex-String manipulation, and debug logging
Date:   Fri, 28 Dec 2018 14:07:31 -0800
Message-Id: <20181228220745.25147-13-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181228220745.25147-1-brian.gix@intel.com>
References: <20181228220745.25147-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

Centralized some frequently used functionaility for logging
and save/retrieve of long (128+ bit) hexidecimal data.
---
 mesh/util.c | 27 ++++++++++++++++++++++++++-
 mesh/util.h |  2 +-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/mesh/util.c b/mesh/util.c
index 2cdcdf37d..b3ce1ce5f 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -15,7 +15,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  Lesser General Public License for more details.
  *
- *
  */
 
 #ifdef HAVE_CONFIG_H
@@ -26,10 +25,36 @@
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
index 61110104a..007ea368e 100644
--- a/mesh/util.h
+++ b/mesh/util.h
@@ -15,10 +15,10 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  Lesser General Public License for more details.
  *
- *
  */
 
 uint32_t get_timestamp_secs(void);
 bool str2hex(const char *str, uint16_t in_len, uint8_t *out,
 							uint16_t out_len);
 size_t hex2str(uint8_t *in, size_t in_len, char *out, size_t out_len);
+void print_packet(const char *label, const void *data, uint16_t size);
-- 
2.14.5

