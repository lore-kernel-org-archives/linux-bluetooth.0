Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D6FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 06:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2623A20721
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 06:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgE2Ghx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 02:37:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:53719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgE2Ghx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 02:37:53 -0400
IronPort-SDR: h4gDQnocrz1+36VDF+XTETLHr4oqnNtOmG9/14VACbObT11zHXY7aupbiRyUG8TfYFqof2fnxN
 ACgAMW2/2ATA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 23:37:53 -0700
IronPort-SDR: 6jm5KFS88cBfZXkLyraLzheyPaTOEBdz+jSOsIFXFAnVq2k2fQBeqXBomNEq2ytNkMslXXKUQb
 XvO5JXOtlMdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="257260590"
Received: from dmikkels-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.228.187])
  by fmsmga008.fm.intel.com with ESMTP; 28 May 2020 23:37:52 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/5] mesh: Make helper packet print depends on debug setting
Date:   Thu, 28 May 2020 23:37:46 -0700
Message-Id: <20200529063750.186278-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529063750.186278-1-inga.stotland@intel.com>
References: <20200529063750.186278-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes the utility function print_packet() to check if
daemon is running in debug mode.
---
 mesh/main.c |  3 ++-
 mesh/util.c | 11 +++++++++++
 mesh/util.h |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/mesh/main.c b/mesh/main.c
index c6bf1ff41..1a4e6ba76 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -37,6 +37,7 @@
 #include "mesh/crypto.h"
 #include "mesh/dbus.h"
 #include "mesh/mesh-io.h"
+#include "mesh/util.h"
 
 static const char *config_dir;
 static const char *mesh_conf_fname;
@@ -210,7 +211,7 @@ int main(int argc, char *argv[])
 			detached = false;
 			break;
 		case 'd':
-			l_debug_enable("*");
+			enable_debug();
 			break;
 		case 'c':
 			config_dir = optarg;
diff --git a/mesh/util.c b/mesh/util.c
index 43340f159..7d283331a 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -34,10 +34,15 @@
 
 #include "mesh/util.h"
 
+static bool debug_enabled;
+
 void print_packet(const char *label, const void *data, uint16_t size)
 {
 	struct timeval pkt_time;
 
+	if (!debug_enabled)
+		return;
+
 	gettimeofday(&pkt_time, NULL);
 
 	if (size > 0) {
@@ -154,3 +159,9 @@ void del_path(const char *path)
 {
 	nftw(path, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
 }
+
+void enable_debug(void)
+{
+	debug_enabled = true;
+	l_debug_enable("*");
+}
diff --git a/mesh/util.h b/mesh/util.h
index 092d33041..93c2d8687 100644
--- a/mesh/util.h
+++ b/mesh/util.h
@@ -24,3 +24,4 @@ size_t hex2str(uint8_t *in, size_t in_len, char *out, size_t out_len);
 void print_packet(const char *label, const void *data, uint16_t size);
 int create_dir(const char *dir_name);
 void del_path(const char *path);
+void enable_debug(void);
-- 
2.26.2

