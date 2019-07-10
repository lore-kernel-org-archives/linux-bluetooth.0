Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20D8C73C68
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37A820838
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfGJFKJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:10:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:28143 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfGJFKI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 01:10:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 22:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="scan'208";a="189050346"
Received: from ingas-nuc1.sea.intel.com ([10.254.182.100])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2019 22:10:08 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 7/9] mesh: Implement config read/write for mesh json format
Date:   Tue,  9 Jul 2019 22:09:57 -0700
Message-Id: <20190710050959.7321-8-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710050959.7321-1-inga.stotland@intel.com>
References: <20190710050959.7321-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds implementation of
mesh_config_create_config(), mesh_config_release_config(),
mesh_config_get_config(), mesh_config_get_config_backup(),
mesh_config_restore_backup() and mesh_config_save_config()
for the JSON based node configuration storage.
---
 mesh/mesh-config-json.c | 171 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 5ca086ad0..3c65b3846 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -22,9 +22,14 @@
 #endif
 
 #define _GNU_SOURCE
+
+#include <dirent.h>
 #include <errno.h>
+#include <fcntl.h>
+#include <ftw.h>
 #include <stdio.h>
 #include <string.h>
+#include <unistd.h>
 
 #include <ell/ell.h>
 #include <json-c/json.h>
@@ -35,6 +40,10 @@
 
 #define CHECK_KEY_IDX_RANGE(x) (((x) >= 0) && ((x) <= 4095))
 
+static const char *cfg_name = "/node.json";
+static const char *bak_name = "/node.json.bak";
+static const char *tmp_name = "/node.json.tmp";
+
 static bool get_int(json_object *jobj, const char *keyword, int *value)
 {
 	json_object *jvalue;
@@ -1827,3 +1836,165 @@ bool mesh_config_model_sub_del_all(void *cfg, uint16_t addr, uint32_t mod_id,
 
 	return delete_model_property(jnode, addr, mod_id, vendor, "subscribe");
 }
+
+static char *create_filename(const char *dir, const char *fname)
+{
+	size_t path_len = strlen(dir) + strlen(fname);
+
+	if (path_len + 1 >= PATH_MAX)
+		return NULL;
+
+	return l_strdup_printf("%s%s", dir, fname);
+}
+
+static void *get_node_config(const char *dir, const char *fname)
+{
+	int fd;
+	char *str = NULL, *fname_full;
+	struct stat st;
+	ssize_t sz;
+	json_object *jconfig = NULL;
+
+	fname_full = create_filename(dir, fname);
+	if (!fname)
+		return NULL;
+
+	l_info("Loading configuration from %s", fname_full);
+
+	fd = open(fname_full, O_RDONLY);
+	if (fd < 0)
+		goto done;
+
+	if (fstat(fd, &st) == -1)
+		goto done;
+
+	str = (char *) l_new(char, st.st_size + 1);
+	if (!str)
+		goto done;
+
+	sz = read(fd, str, st.st_size);
+	if (sz != st.st_size) {
+		l_error("Failed to read configuration file %s", fname_full);
+		goto done;
+	}
+
+	jconfig = json_tokener_parse(str);
+
+done:
+	if (fd >= 0)
+		close(fd);
+
+	l_free(str);
+	l_free(fname_full);
+
+	return jconfig;
+}
+
+void *mesh_config_get_config(const char *dir)
+{
+	if (!dir)
+		return NULL;
+
+	return get_node_config(dir, cfg_name);
+}
+
+void *mesh_config_get_config_backup(const char *dir)
+{
+	if (!dir)
+		return NULL;
+
+	return get_node_config(cfg_name, bak_name);
+}
+
+bool mesh_config_restore_backup(const char *dir)
+{
+	char *fname_cfg = NULL, *fname_bak = NULL;
+	bool res = false;
+
+	fname_cfg = create_filename(dir, cfg_name);
+	fname_bak = create_filename(dir, bak_name);
+
+	if (fname_cfg && fname_bak) {
+		remove(fname_cfg);
+		rename(fname_bak, fname_cfg);
+		res = true;
+	}
+
+	l_free(fname_bak);
+	l_free(fname_cfg);
+
+	return res;
+}
+
+static bool save_config(void *cfg, const char *fname)
+{
+	FILE *outfile;
+	const char *str;
+	bool result = false;
+	json_object *jnode = cfg;
+
+	outfile = fopen(fname, "w");
+
+	if (!outfile)
+		return false;
+
+	str = json_object_to_json_string_ext(jnode, JSON_C_TO_STRING_PRETTY);
+
+	if (fwrite(str, sizeof(char), strlen(str), outfile) < strlen(str))
+		l_warn("Incomplete write of mesh configuration");
+	else
+		result = true;
+
+	fclose(outfile);
+
+	return result;
+}
+
+void *mesh_config_create_config(void)
+{
+	return json_object_new_object();
+}
+
+void mesh_config_release_config(void *cfg)
+{
+	json_object *jnode = cfg;
+
+	if (!cfg)
+		return;
+
+	json_object_put(jnode);
+}
+
+bool mesh_config_save_config(const char *dir, void *cfg)
+{
+	char *fname_cfg;
+	char *fname_bak;
+	char *fname_tmp;
+	bool result = false;
+
+	fname_cfg = create_filename(dir, cfg_name);
+	fname_bak = create_filename(dir, bak_name);
+	fname_tmp = create_filename(dir, tmp_name);
+
+	if (!fname_cfg || !fname_bak || !fname_tmp)
+		goto done;
+
+	result = save_config(cfg, fname_tmp);
+
+	if (result) {
+		remove(fname_bak);
+		rename(fname_cfg, fname_bak);
+		rename(fname_tmp, fname_cfg);
+	} else {
+		l_error("Failed to save configuration to %s", fname_tmp);
+	}
+
+	remove(fname_tmp);
+
+done:
+	l_free(fname_cfg);
+	l_free(fname_bak);
+	l_free(fname_tmp);
+
+	return result;
+}
-- 
2.21.0

