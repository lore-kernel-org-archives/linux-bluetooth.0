Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A419AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 02:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiBXCHK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 21:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiBXCHH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 21:07:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB613F1B
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 18:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645668397; x=1677204397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8SqBVtgDsgaVxiakoL8JO8fpMci0Q8v54T46iiGEzQU=;
  b=P0Ikl5szZ9Co//wten/H1CWFkKpxkYBwF+psxSAZOVBeyGbJtgCANDPR
   aP7/kyYVuQlb/++6s+3nQf8UuiBIWzYrNem+PH2eSzO0s5Eebnm/CpPf/
   RRd74zne2RKOwed21pJTlE43CUDXJgeMSsA9ESOIlCn4jnuj3BT4hdFjt
   QMKsbVcumSm326Y1j9oKTA0MlHyCAQtP56UdC4hTyFvzjCF7uhsg72xrn
   jcleAQGBJnKar+S8GHohCUe7QyN5yvkE5MvYRiX+lWN4lVbOCqlWqAylE
   jyOZdkeIj7AoCDB6whsB5wMbQl5NWQRPG9zldwDzxSXkGwvC6gBr3nE4o
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239525004"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="239525004"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607268575"
Received: from tjsmith-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.34.213])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:34 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH 5/7] mesh: Added default "auto" to command line parsing
Date:   Wed, 23 Feb 2022 18:06:22 -0800
Message-Id: <20220224020624.159247-6-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224020624.159247-1-brian.gix@intel.com>
References: <20220224020624.159247-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

While it will still be possible to request the "unit" and "hci"
based transports, "auto" has been added as a default to specify
"best choice" as determined by MGMT based enumeration of available
controllers.
---
 mesh/main.c | 39 +++++++++++++++++++++++++++++++++++----
 mesh/mesh.c |  6 +++++-
 mesh/mesh.h |  2 +-
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index dd99c3085..619b17d88 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -123,6 +123,12 @@ static void disconnect_callback(void *user_data)
 	l_main_quit();
 }
 
+static void kill_to(struct l_timeout *timeout, void *user_data)
+{
+	l_timeout_remove(timeout);
+	l_main_quit();
+}
+
 static void signal_handler(uint32_t signo, void *user_data)
 {
 	static bool terminated;
@@ -131,13 +137,38 @@ static void signal_handler(uint32_t signo, void *user_data)
 		return;
 
 	l_info("Terminating");
-	l_main_quit();
+	mesh_cleanup(true);
+	l_timeout_create(1, kill_to, NULL, NULL);
 	terminated = true;
 }
 
 static bool parse_io(const char *optarg, enum mesh_io_type *type, void **opts)
 {
-	if (strstr(optarg, "generic") == optarg) {
+	if (strstr(optarg, "auto") == optarg) {
+		int *index = l_new(int, 1);
+
+		*type = MESH_IO_TYPE_AUTO;
+		*opts = index;
+
+		optarg += strlen("auto");
+		if (!*optarg) {
+			*index = MGMT_INDEX_NONE;
+			return true;
+		}
+
+		if (*optarg != ':')
+			return false;
+
+		optarg++;
+
+		if (sscanf(optarg, "hci%d", index) == 1)
+			return true;
+
+		if (sscanf(optarg, "%d", index) == 1)
+			return true;
+
+		return false;
+	} else if (strstr(optarg, "generic") == optarg) {
 		int *index = l_new(int, 1);
 
 		*type = MESH_IO_TYPE_GENERIC;
@@ -251,7 +282,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (!io)
-		io = l_strdup_printf("generic");
+		io = l_strdup_printf("auto");
 
 	if (!parse_io(io, &io_type, &io_opts)) {
 		l_error("Invalid io: %s", io);
@@ -295,7 +326,7 @@ done:
 	l_free(io);
 	l_free(io_opts);
 
-	mesh_cleanup();
+	mesh_cleanup(false);
 	l_dbus_destroy(dbus);
 	l_main_exit();
 
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 62d650328..91cf25175 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -324,11 +324,15 @@ static void free_pending_join_call(bool failed)
 	join_pending = NULL;
 }
 
-void mesh_cleanup(void)
+void mesh_cleanup(bool signaled)
 {
 	struct l_dbus_message *reply;
 
 	mesh_io_destroy(mesh.io);
+	mesh.io = NULL;
+
+	if (signaled)
+		return;
 
 	if (join_pending) {
 
diff --git a/mesh/mesh.h b/mesh/mesh.h
index 0f77ebc58..c30a8d1f0 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -28,7 +28,7 @@ typedef void (*prov_rx_cb_t)(void *user_data, const uint8_t *data,
 bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
 					enum mesh_io_type type, void *opts,
 					mesh_ready_func_t cb, void *user_data);
-void mesh_cleanup(void);
+void mesh_cleanup(bool signaled);
 bool mesh_dbus_init(struct l_dbus *dbus);
 
 const char *mesh_status_str(uint8_t err);
-- 
2.35.1

