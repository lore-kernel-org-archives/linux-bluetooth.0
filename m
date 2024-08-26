Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5EF42AA0
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712804; cv=none; b=Bu1rFtUEGkh3OozDz6cIl1FD4YeNZ/He85VOS9ViQvkps0VauinRwrR1dL/Ump5MiKIjyusa4xkFHho+dYoEt5/NTPZep4rn1/mEZt/RULgOKijD5k0lhRaDDnKPII5i/53m/Nb40TQId4uM+BQkIZ6S9MIN9jaZBvc+HeVOVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712804; c=relaxed/simple;
	bh=JndGIuSAdqjPKJTQJUS9czgns7oS0ka+0feFGHwC8rI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ug4HwhQTGsdqvj6zEfCAvtmUHGQJuHiTcPDXSRwuh/Ebx/s39WldjLwHOumIcS+AKCNZJ+pQ3An6P1BWFS9fhcTRnlQaM0iyExNypBT1EoZDbnR2dw1PEAEf814N0r/pwePN6837VSDiTg8kRlIGa2AIA6utCf8UQBEw0+EvBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6CB/Cv/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6CB/Cv/"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cd8d2731d1so3174009a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 15:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724712801; x=1725317601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0IShaQHUot8Q8I8pen/H2CIa8QZVmlmGV2bJ/rdq0U=;
        b=K6CB/Cv/A1LpBfGtuusmkNF06yvTVIJiLdzqwti7sFxriidvHusMfmr/g8QefdNTj+
         FtRTf1curzILabkHpY6ZjH323YOVneaKr1RVMCiuXg3L7zL9y8OaSnb/SeUplspep2tt
         D9Z0ERgWtiDlb4uOVpo4aRMqMhLUNYl4gI5ap1QxJC2697zEU/SL9zJFmhQVFnfdEC4L
         IMjDzISd3RM7tGGPP4zlR0jB0oLTfwdWSaDzRldv2xhu857riPg+qiYaQZkP7HF3bXbe
         amlJhC980dZhRb3GFABnP1pPUFO6QyOwLWllbiwoCzOTzbMcANLc5w/9LWZ1WkvIJ7WF
         XSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724712801; x=1725317601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0IShaQHUot8Q8I8pen/H2CIa8QZVmlmGV2bJ/rdq0U=;
        b=N4UCEPMtokC8ImTpx5mnHLxsnSSmFqOvvKzjV1Jiy/iXX35syJ8PfESZeVE36HmIFW
         LuOWD7DxeHoG4dCW36UK2gSNiVdNtzxo78y4vW8qOuHnOa/YxvA6iQBD1kflDjpGYDw+
         dnCQMC6FbbtlzPYZ4IalEj8HMEyoP1azbSW6L+wvoEcba3LFE3o7aOPAsz8F11vqAn+o
         6L8gYxPb/9QHVxW//ac8DmB4CRJpdP+Eh2MYwBReyrRkDhtAo3R+/GVmu+PUV9UR2gux
         eoQeSDPRJKul/j6hSb8BhgSWNJEmGrfjN6Vzgms+Lx6G4AajXAeVWfyX8UllWVv3rvRI
         beNQ==
X-Gm-Message-State: AOJu0YyrpenoacBzqq0KKgxoq9Dp4y1hwH0MIWuX4MzpE678s6rf9ATH
	mqolYMSSXkstFZJZCq9ecrmdQEV8yQbMBBOz+NFwZMbNyY49KD+zmml6cQ==
X-Google-Smtp-Source: AGHT+IE21yzPxlclw82USukDkpnXwJS2udqjwTxsG8UFrTnivrVg4rMakxpMz07Lqsgh1ABQ1m3Lqg==
X-Received: by 2002:a17:90a:604e:b0:2c9:8189:7b4f with SMTP id 98e67ed59e1d1-2d646d1dba8mr10944991a91.32.1724712801294;
        Mon, 26 Aug 2024 15:53:21 -0700 (PDT)
Received: from apollo.localdomain ([2601:646:9d80:4380::2696])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb0b27sm12706320a91.45.2024.08.26.15.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 15:53:20 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v2 BlueZ] Provide GNU basename compatible implementation
Date: Mon, 26 Aug 2024 15:53:18 -0700
Message-ID: <20240826225318.1333106-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call to basename() relies on a GNU extension
to take a const char * vs a char *. Let's define
a trivial helper function to ensure compatibility
with musl.

Fixes Issue: https://github.com/bluez/bluez/issues/843
---
v2: Fix code formatter reported errors

 Makefile.mesh           | 2 ++
 Makefile.tools          | 3 ++-
 mesh/mesh-config-json.c | 5 +++--
 mesh/rpl.c              | 3 ++-
 src/shared/util.h       | 7 +++++++
 tools/hex2hcd.c         | 3 ++-
 6 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Makefile.mesh b/Makefile.mesh
index e4c9fa6a3..bebedaf05 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -47,6 +47,8 @@ mesh/main.$(OBJEXT): src/builtin.h lib/bluetooth/bluetooth.h
 mesh_bluetooth_meshd_SOURCES = $(mesh_sources) mesh/main.c
 mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
 
+mesh_bluetooth_meshd_CFLAGS = -I${top_srcdir}/src
+
 if MANPAGES
 man_MANS += mesh/bluetooth-meshd.8
 endif
diff --git a/Makefile.tools b/Makefile.tools
index 5b9034078..6fc73b8a2 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -328,7 +328,8 @@ tools_l2ping_LDADD = lib/libbluetooth-internal.la
 tools_bluemoon_SOURCES = tools/bluemoon.c monitor/bt.h
 tools_bluemoon_LDADD = src/libshared-mainloop.la
 
-tools_hex2hcd_SOURCES = tools/hex2hcd.c
+tools_hex2hcd_SOURCES = tools/hex2hcd.c src/shared/util.h
+tools_hex2hcd_CFLAGS = -I${top_srcdir}/src
 
 tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
 tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index c198627c6..8f89a1498 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -28,6 +28,7 @@
 #include <ell/ell.h>
 #include <json-c/json.h>
 
+#include "shared/util.h"
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
 #include "mesh/mesh-config.h"
@@ -2694,7 +2695,7 @@ bool mesh_config_load_nodes(const char *cfgdir_name, mesh_config_node_func_t cb,
 
 void mesh_config_destroy_nvm(struct mesh_config *cfg)
 {
-	char *node_dir, *node_name;
+	const char *node_dir, *node_name;
 	char uuid[33];
 
 	if (!cfg)
@@ -2706,7 +2707,7 @@ void mesh_config_destroy_nvm(struct mesh_config *cfg)
 	if (!hex2str(cfg->uuid, 16, uuid, sizeof(uuid)))
 		return;
 
-	node_name = basename(node_dir);
+	node_name = bluez_basename(node_dir);
 
 	/* Make sure path name of node follows expected guidelines */
 	if (strcmp(node_name, uuid))
diff --git a/mesh/rpl.c b/mesh/rpl.c
index fb225dddd..fb89f0afd 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -24,6 +24,7 @@
 
 #include <ell/ell.h>
 
+#include "shared/util.h"
 #include "mesh/mesh-defs.h"
 
 #include "mesh/node.h"
@@ -146,7 +147,7 @@ static void get_entries(const char *iv_path, struct l_queue *rpl_list)
 	if (!dir)
 		return;
 
-	iv_txt = basename(iv_path);
+	iv_txt = bluez_basename(iv_path);
 	if (sscanf(iv_txt, "%08x", &iv_index) != 1) {
 		closedir(dir);
 		return;
diff --git a/src/shared/util.h b/src/shared/util.h
index f2ca4f29f..f55b3a4c3 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -296,3 +296,10 @@ static inline void put_be64(uint64_t val, void *dst)
 {
 	put_unaligned(cpu_to_be64(val), (uint64_t *) dst);
 }
+
+static inline const char *bluez_basename(const char *path)
+{
+	const char *base = strrchr(path, '/');
+
+	return base ? base + 1 : path;
+}
diff --git a/tools/hex2hcd.c b/tools/hex2hcd.c
index e6dca5a81..05fa69470 100644
--- a/tools/hex2hcd.c
+++ b/tools/hex2hcd.c
@@ -24,6 +24,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <sys/stat.h>
+#include "shared/util.h"
 
 static ssize_t process_record(int fd, const char *line, uint16_t *upper_addr)
 {
@@ -302,7 +303,7 @@ static void ver_parse_entry(const char *pathname)
 	}
 
 	if (S_ISREG(st.st_mode)) {
-		ver_parse_file(basename(pathname));
+		ver_parse_file(bluez_basename(pathname));
 		goto done;
 	}
 
