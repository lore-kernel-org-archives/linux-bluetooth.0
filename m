Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B919412F
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693929; cv=none; b=HhXqc/su+k0nPOcP0kjzLQj7AUUdq/qn6SaHwrQu2Pcp17iNwq2mJnmb/N9jXFOsTXmXfta6XiwURGth3ljn8xPXPwQh+pkmT3D8y4GZrmN8cxpYR4jubvE+QsgSGZQgVR5bOzbXFVtjyGo7eWFLOykN12vGNg+X2xDRaMQgdgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693929; c=relaxed/simple;
	bh=IEL9mcKuoi6p93sB9gx45tD7+aLeEpBPem+FwW3oFV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+U703uFdl3VbzgbY9xBEQtRjUh7bPlKTUGP+dPxTL1WavDXpywFgqebyjDBUzbGDFGxv9U2/vnf8CRS38eQjlLVkLeB96FtMib/Kbgj48/snWwh4R4HgaFN+a6ziK7KQq2CyXLLS2F2VFU8KUbqYhOsoQPBsUA/+oUGJee5Mcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cACk45HS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cACk45HS"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so3622467b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724693927; x=1725298727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtI5VlJZLIEFTTgL2T+lpjJvYe+gCRXPjG5WcgeEucM=;
        b=cACk45HSvR95z1rRgK4l1XxWQh/rom+d7VjHnTw+LN7cKd5x9QmNvLBYMwxz3DWnEe
         PnYBCOo+b5ZuqwOvMtJKwAzjbLr4PQSZMmBS3jjUfP4RNOmqv/sUKgvYwCpEvQI+X21g
         aVVEqGIRC+nkZ58EeFl+/DD/qZ16UOHDsMbq8el9Zu0vs7Ia2f3/1THE/Oj08r27u+D2
         +JD2AsErv03pai54BVXrSCY+DqWK4yzBerKEKb/G4SEB5o9e8k5iFsD9AXu4Tcnf32rS
         nkWy1cE4sZ4yCFxMA0pKpQx0cWq8zTK9Hrn3BQXJ/6mCDAZY42KBspJFH2IpzTbvKeOb
         7isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693927; x=1725298727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtI5VlJZLIEFTTgL2T+lpjJvYe+gCRXPjG5WcgeEucM=;
        b=Vri2vXZyJqCtNRjGty/IjIHz8UaJtffWIMH0LFu2Hm/feBCC3v24AMQC7nfY8TKLOX
         nWXkIt6Focj1WrR658FP9P1fXu1585m8SrIuaRr2fevPqVLFZnk8o5Eget9iJytBRBkO
         26ufNjtBjKz7C9KcJtnUnLcFKuOJZIdrABeeCar1Hjm/W1eSwMufkiKKEcFk5phHZPgV
         bU/2QpIchLMlPJLP+T9ZnZf9zKmyj16b8kq+fBOh/VVFHTe9Uo8qzoBgeIOTjgvU4g0v
         s2YQnmmhs/22y053Jak78rMV9inrRUxIq5KUNqEX9qfHM4Ka5AArhktMvOB6jSegXQn+
         LnKQ==
X-Gm-Message-State: AOJu0YysJOZJcA0upy3iSERTMPcnK2SXGYGCe3Sy3/vf8qmnEyMRM0bJ
	EglstpoUPRBrNcwMCaPo+yuNUZGVr9+gKuViYKal+aW6b6NLqF+A/j2cMQ==
X-Google-Smtp-Source: AGHT+IHLfRXeZEqDerqL4sIoALzhFUFa17T5bBjGqPAyI9fIlT2Z6UHCyu5O7oUBOr4v+afJRLQfeA==
X-Received: by 2002:a05:6a20:9d91:b0:1c6:b0cc:c448 with SMTP id adf61e73a8af0-1ccc097b720mr308269637.43.1724693927240;
        Mon, 26 Aug 2024 10:38:47 -0700 (PDT)
Received: from apollo.localdomain ([2601:646:9d80:4380::2696])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434309676sm7509299b3a.174.2024.08.26.10.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:38:46 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH BlueZ] Provide GNU basename compatible implementation
Date: Mon, 26 Aug 2024 10:38:44 -0700
Message-ID: <20240826173844.2918630-1-raj.khem@gmail.com>
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
 Makefile.mesh           | 2 ++
 Makefile.tools          | 3 ++-
 mesh/mesh-config-json.c | 5 +++--
 mesh/rpl.c              | 3 ++-
 src/shared/util.h       | 6 ++++++
 tools/hex2hcd.c         | 3 ++-
 6 files changed, 17 insertions(+), 5 deletions(-)

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
index f2ca4f29f..0f0f67718 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -296,3 +296,9 @@ static inline void put_be64(uint64_t val, void *dst)
 {
 	put_unaligned(cpu_to_be64(val), (uint64_t *) dst);
 }
+
+static inline const char *bluez_basename(const char *path)
+{
+	const char *base = strrchr(path, '/');
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
 
