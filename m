Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD13E49E
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777394; cv=none; b=dSu5fPnjL183aK2YtVpKmYy1V6cKghv5Ub5Q1sJhMEZcDvwDRHgJ50h9FC15mb1MBkDalJjuXGGGSA6Wswo1awKyMbujRsvKyTugjoab7O2TDF6n9lzFBhPfE8d+TZwl7EDHddlEvtEXWCorKdWCdXiSXUtJJI7Fxa7mN1UOqvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777394; c=relaxed/simple;
	bh=Ix3HTDZI997fA7IDNDUs4KxG5QUMirXNgwhy6QSg0yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXx781QwfmZahtfaZ2Xu4DgKCD9NYnZS1/hTm+Xn9AQ2hBfcoUj5QWcu0EFXj0YEwXO/yG0/7iF3HEuPum0gsiIFkcxfzw/x283sXtFQ0HqqMI7rdoMt2zysiS/JXXE0VM1wKGXUiBRa/dl/SWzu4Hv98PWBB0eqJQfYTDGu99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZJ1YAI8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZJ1YAI8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-202146e93f6so58549975ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724777392; x=1725382192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6aoBHoM11eMgdvSTx0czC/JL55UqPDuDBjAOfV03kE=;
        b=cZJ1YAI8aGyHc/qglahVS9D1X9T4qkK4nCQViS3xf9zxIdU4YbklF/bsYOB12mfZY5
         9cKG2BlLWoqLWmr5RT1ylvioXWs5/gJ13RwzpqGt/PrmnbYFmbhUt+EkbOt+4PoxzVkq
         ndzGL+b8Q2+L02NaUu4ijIpuVJnMc+25v8+U4onIsSJcy//A5j7pGvqIBLgtMG3QOPUp
         4r5/QJ5UNug5W0XVfmXZ/ajk1ltSDd5zYMNkaPiIdhDpLTYdzaCfEKvt6GtTGKlcwteA
         UF3yJDWQsUz3Gk5npLQJqBV1GSZ0sSK/vgwbdAV2kZ+TGQG/B09D1f7YjTLEGfK1LB/c
         CSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724777392; x=1725382192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6aoBHoM11eMgdvSTx0czC/JL55UqPDuDBjAOfV03kE=;
        b=ByxAeT7vsjvBZIonrU2F+TXWK4bqvCKraD3oLw01lBCfJ59QQq69ECeP3zZuSPQzhL
         ryVs7CFXEPCuyulaegcN4idPdLE/ifoEugl6nkKFgQPOd586tb21PAGw9y1aPL3poSjm
         FfD7b6VmcakRA4Ugvc9XjXhzZrrnXRSy/miMqlsbNVZQJMUcHn+Zh/FcPlrB3ycRhxWM
         kbnF34miS2NC0BDP7XVM+DqTXhRWs9nbwR3kIN4BvPXDlpqTwYDm6kfhlPiUvWfIpuCr
         ih9S3U/SaLhNlq2xV3wLeNLnybnl6RaedilmntyU7iU5S/tXuA8vgA5mRMwk36aMmo/F
         W3bw==
X-Gm-Message-State: AOJu0YzIFL02Z4y2/JmrDmPmdemlsUibDFle7Yg/opj5+nlBbsOXYs/r
	G70+JyCu0zllq/Kgyb6zShEMrroGBM6QU4U3rlclTY+ztwEBeLnk7H0oBw==
X-Google-Smtp-Source: AGHT+IHieHQrIRGSeDA3ZxGkVurzP8YSbUeJHnm6VLJhPLGOuQGFM+jmMnT7IHd4VqGXAorREXzSLQ==
X-Received: by 2002:a17:903:1d2:b0:200:aa78:cfc7 with SMTP id d9443c01a7336-2039e44f09dmr200001415ad.2.1724777391938;
        Tue, 27 Aug 2024 09:49:51 -0700 (PDT)
Received: from apollo.localdomain ([2601:646:9d80:4380::2696])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385be047fsm85319965ad.282.2024.08.27.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:49:51 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v3 BlueZ] Provide GNU basename compatible implementation
Date: Tue, 27 Aug 2024 09:49:48 -0700
Message-ID: <20240827164948.3030478-1-raj.khem@gmail.com>
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
v3: Make just node_name as const and keep node_dir as such

 Makefile.mesh           | 2 ++
 Makefile.tools          | 3 ++-
 mesh/mesh-config-json.c | 6 ++++--
 mesh/rpl.c              | 3 ++-
 src/shared/util.h       | 7 +++++++
 tools/hex2hcd.c         | 3 ++-
 6 files changed, 19 insertions(+), 5 deletions(-)

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
index c198627c6..608384cb6 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -28,6 +28,7 @@
 #include <ell/ell.h>
 #include <json-c/json.h>
 
+#include "shared/util.h"
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
 #include "mesh/mesh-config.h"
@@ -2694,7 +2695,8 @@ bool mesh_config_load_nodes(const char *cfgdir_name, mesh_config_node_func_t cb,
 
 void mesh_config_destroy_nvm(struct mesh_config *cfg)
 {
-	char *node_dir, *node_name;
+	char *node_dir;
+	const char* node_name;
 	char uuid[33];
 
 	if (!cfg)
@@ -2706,7 +2708,7 @@ void mesh_config_destroy_nvm(struct mesh_config *cfg)
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
 
