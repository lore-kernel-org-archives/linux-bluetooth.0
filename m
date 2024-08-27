Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8DB1C4623
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784753; cv=none; b=d7wHSUny+aGBmLUhvFkcqZP0S63ER37ugRpRYKoKM5IhV+DBsvf3PtX74OKBR03gk/pKKcoSufm+z6mkZ8R7aJ3ghM1gYgaUCWspNfrKTNC0MQ3ctSPSwJOCBRKRgMvt4dUL9tO68fy6xex/kBEJqVy2B+HOOcxyUAYeWQ3R7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784753; c=relaxed/simple;
	bh=2UJBCjjKZPnrpQ+/a9n9uNexJBrORM1Y2azUFeB+fCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gHG74/35uwLCuAzTmcytGdlIt12OHEtWez9hZsojx1lx7e3YoCIFTolMlxJ+ljRumI8ZRMYMFo4jwhOMa46DvSkJMOSKE+obuS4+f5E/fVg4kcwg7XLAqiPtguKuIR02SBD9N3egn2JgGqP4Y3kLtO5bydx7tuxUiJKz0IzGRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNXXad4f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNXXad4f"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2020b730049so45865145ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724784751; x=1725389551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJFP5B2pIGfuZyPIPwpbdrESn84N7z11eaQC27/xb9o=;
        b=PNXXad4fmF3hKL6o37s43z2LQtl8UyUems0XsHztZgXr5LTTt923jEVGLDtvJgypFX
         cIkq+gBGwIuzvQ6W1nwk9hb4syEFFH8QFevciDpDbF/2REqZOgwC8QqswvvF+avHEeC0
         5qCDzFXeLETusnWHkMCSVm7C3Z6TumFJHWGSnjgIM0K+wYnc4ka3ib866DVniqB2ruE2
         cbz4DAy5pHIlWT5IQazI87dAEKLFgPbb+NpIb4uPddziqMqFOcKg4m808wXO+HlikyZQ
         EOgfjploq9cxMhIZwOnZuwvhapTTk72lH4FsfiGs7YlImcSOI/uik7+pJoNvXbL5AY3r
         Rq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784751; x=1725389551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJFP5B2pIGfuZyPIPwpbdrESn84N7z11eaQC27/xb9o=;
        b=tbwNDd23zYb1CPNtUAFPa82rWljgoMCEn/Vu4xI4ztKKqwrVOaBXxi4DXmwt4Tv/QY
         T8pq136jDmiA7IkzeyBP/9mo83QXbtTZ2LscctnWliSAkxaOAlTdPAiM0jzc5Y54sPaZ
         MLqPhFS33ZiLqM/UXmRWMw4JXavJ1V2IY+QsQunjAFFgxvHex72gDyzdyfBdzsZyoAtH
         tbPcObAgHahuj7atRJrIxTL3XlZHUf5E3ptm2sKnWgMQ2J4lj5ILpvQ7/00Irsx89ugu
         tOO7u8OrshczT1Ozg+njLtjx/rjwQN3kdotcObziBDtESQP/2+WNFNaOJ8/hPvv3WH1i
         eCxg==
X-Gm-Message-State: AOJu0Ywcxh/b3My4b1cetmMNFiqyINIxpN/rd1YGfih9fSisvPtc2tc8
	bhaWCvKXMA+DSn8d3ef/Co1TKZxbz7zkbyBEmqA5ANz2owKKa2piZmPyiw==
X-Google-Smtp-Source: AGHT+IFDA4D38MRoWbeFzsW7rZvxa+1bqu2QFz340XkRPyrZbbi6QOn4dn9FP+K0dTxxJca62iqbAw==
X-Received: by 2002:a17:902:a508:b0:202:5e7:115 with SMTP id d9443c01a7336-2039e538fd3mr106725645ad.56.1724784751186;
        Tue, 27 Aug 2024 11:52:31 -0700 (PDT)
Received: from apollo.localdomain ([2601:646:9d80:4380::2696])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557eec1sm86542055ad.91.2024.08.27.11.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:52:30 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v4 BlueZ] Provide GNU basename compatible implementation
Date: Tue, 27 Aug 2024 11:52:28 -0700
Message-ID: <20240827185228.3515299-1-raj.khem@gmail.com>
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
v4: Fix code formatting errors

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
index c198627c6..85e2adb0e 100644
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
+	const char *node_name;
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
 
