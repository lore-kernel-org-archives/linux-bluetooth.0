Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752E15AF6
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 03:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726543072; cv=none; b=Rk8Nz94zFsJUj/ez4s30r97uPdUxblg7VtwNbMKdddDpKDn53MSSeUf5AdtyCobfwyGXKHI0DZRaSCgjNR8cqrAYZUkDdf6OCr3prtC+aS31cO1YS0B0HY5p3TnAbcPg83sb3MPlSjJoyRJX4xUXVNHoWj9vfnNFVT+lTMiAtuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726543072; c=relaxed/simple;
	bh=FuoT01rxjzBs/XBs85vukP42I1pNjJYtvyAkFq9WlAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pwvTMah/0a78c2PXDj7KHdJ73C/UGlm5NXGQcVfClCdvRkcbl8yWlN4nZ8SkxeOJQXwjszyxwgB6ifgZfGzkrHH3NVbf5zPK4jRyEN5ZJpJLB1PcasGOKAL4WlFLheMoRTDSvIvh7IVFHknWSSjsWvS//ZnfnAvPX6bFj/Vlak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzAGtMdz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzAGtMdz"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-205909afad3so52593055ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 20:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726543070; x=1727147870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wpdDR1bCoKjeNN0ZN/hE6LicrubjLRM7s17ic7nByJ8=;
        b=gzAGtMdzJ+TUZz9wQMljTEetNSwEcOpjoiuA2vFJYUtwomP2zzBKeDg8MonVlCtv36
         Ekz6kturpqNKgwgh3NYr6FxYnph13sz/B8C5L5uBGj0TimFTDkp/KakHGpH44N0M9bCb
         wJWgct0zkxTpCm6ZHsq887H7fJDkUp6w2QUvxV046D1BKSJ5pj36PIPI4tObp++UI1s7
         SVoQG5+5LcI2GL+b4A3AJuNGYXysm3Qv6k7EZQPUi8GOjW2mc8KCM1SNyULq7P8ciQ13
         HOOwPpolBR2RjMUoxFKDMe0bDFZW4ZC/LPRtfc5+LTQNXBKc+huZNOdOw3aZwa49/ESs
         gUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726543070; x=1727147870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpdDR1bCoKjeNN0ZN/hE6LicrubjLRM7s17ic7nByJ8=;
        b=XA+b4gghtNACkbeB57l1ZVmhXoa9x4lMY/783BKJzHva4i0yuOkQF1YlVOkUkHKRv+
         tx05lRFt2muaFfksBldGucBuHmMwFhsKWQXjW7jC5vmIPAx+0nNKxJrnsGn2CK96I+v7
         tiqWDa8MiAJK5fjqti/YxBl2+ePfFNOvOMHMW/mZ8YaoU9vgcmDBe/J/Qb2FR+wgkVor
         OHAISQ17CC0g3I3HXUlooD74DAFfzp86e4j4X+RJdRiPXW4zqYX9NkORF7n/lEw0lmM+
         ij2JBPyr3RcjtVneBJpwjKLYUMbh8GV/1tKt2SU3yiniBwtfnG0dCZ+nOZVLB9tb5ibs
         QwBw==
X-Gm-Message-State: AOJu0YwBYXa9AtxtSuNGriSzzfWBp+fNnyInaWUjaSKEIRX/4xwE5ECd
	tt8pYCzp3ShXu35YAn53++8Ac+dN5BvotdLpwc0yZHtuShThZk2bjMGTcHDz
X-Google-Smtp-Source: AGHT+IGajKoSBONeKyzIZX4A9wiWwgfuRhTd7OWDpRV3szWeyrvvwjCFltq6OpecYt6Ip14CAks2pw==
X-Received: by 2002:a17:902:e88a:b0:206:b7b8:1efd with SMTP id d9443c01a7336-2076e417cc1mr207420885ad.53.1726543070175;
        Mon, 16 Sep 2024 20:17:50 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::de58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db49924669sm5009527a12.49.2024.09.16.20.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 20:17:49 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v2] mesh: Move local basename into utility file
Date: Mon, 16 Sep 2024 20:17:45 -0700
Message-ID: <20240917031745.1641153-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Defining an override via a missing.h can prove difficult when a file
needs to use basename and dirname both the APIs and needs to include
libgen.h for them, in such situations there will be signature clash
for basename function.
---
v2: Remove reference to missing.h in Makefile.mesh

 Makefile.mesh           |  2 +-
 mesh/mesh-config-json.c |  3 +--
 mesh/missing.h          | 21 ---------------------
 mesh/rpl.c              |  3 +--
 mesh/util.c             | 10 ++++++++++
 mesh/util.h             |  5 +++++
 6 files changed, 18 insertions(+), 26 deletions(-)
 delete mode 100644 mesh/missing.h

diff --git a/Makefile.mesh b/Makefile.mesh
index f5e99a955..e4c9fa6a3 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -38,7 +38,7 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/keyring.h mesh/keyring.c \
 				mesh/rpl.h mesh/rpl.c \
 				mesh/prv-beacon.h mesh/prvbeac-server.c \
-				mesh/mesh-defs.h mesh/missing.h
+				mesh/mesh-defs.h
 pkglibexec_PROGRAMS += mesh/bluetooth-meshd
 
 mesh/mesh.$(OBJEXT): ell/internal
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index a17a48b6d..5372130d7 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -28,7 +28,6 @@
 #include <ell/ell.h>
 #include <json-c/json.h>
 
-#include "mesh/missing.h"
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
 #include "mesh/mesh-config.h"
@@ -2708,7 +2707,7 @@ void mesh_config_destroy_nvm(struct mesh_config *cfg)
 	if (!hex2str(cfg->uuid, 16, uuid, sizeof(uuid)))
 		return;
 
-	node_name = basename(node_dir);
+	node_name = mesh_basename(node_dir);
 
 	/* Make sure path name of node follows expected guidelines */
 	if (strcmp(node_name, uuid))
diff --git a/mesh/missing.h b/mesh/missing.h
deleted file mode 100644
index 464df9b1c..000000000
--- a/mesh/missing.h
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: LGPL-2.1-or-later
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2024  Khem Raj <raj.khem@gmail.com>
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-#if !HAVE_DECL_BASENAME
-#include <string.h>
-static inline const char *basename(const char *path)
-{
-	const char *base = strrchr(path, '/');
-
-	return base ? base + 1 : path;
-}
-#endif
diff --git a/mesh/rpl.c b/mesh/rpl.c
index 2fa17d72f..69533bf43 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -24,7 +24,6 @@
 
 #include <ell/ell.h>
 
-#include "mesh/missing.h"
 #include "mesh/mesh-defs.h"
 
 #include "mesh/node.h"
@@ -147,7 +146,7 @@ static void get_entries(const char *iv_path, struct l_queue *rpl_list)
 	if (!dir)
 		return;
 
-	iv_txt = basename(iv_path);
+	iv_txt = mesh_basename(iv_path);
 	if (sscanf(iv_txt, "%08x", &iv_index) != 1) {
 		closedir(dir);
 		return;
diff --git a/mesh/util.c b/mesh/util.c
index 82b57f642..73f13aab7 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -161,3 +161,13 @@ void enable_debug(void)
 	debug_enabled = true;
 	l_debug_enable("*");
 }
+
+#if !HAVE_DECL_BASENAME
+#include <string.h>
+const char *mesh_basename(const char *path)
+{
+	const char *base = strrchr(path, '/');
+
+	return base ? base + 1 : path;
+}
+#endif
diff --git a/mesh/util.h b/mesh/util.h
index 085ec3330..bb417dc40 100644
--- a/mesh/util.h
+++ b/mesh/util.h
@@ -16,3 +16,8 @@ void print_packet(const char *label, const void *data, uint16_t size);
 int create_dir(const char *dir_name);
 void del_path(const char *path);
 void enable_debug(void);
+#if !HAVE_DECL_BASENAME
+const char *mesh_basename(const char *path);
+#else
+#define mesh_basename basename
+#endif
