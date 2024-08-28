Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969818030
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 04:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818609; cv=none; b=m60K8IJC7v7Y23WYz1sROXjn0ISrxu5BJuwgyeotwMK6MhVoRfl9CfyeQxSd/VJoqpINo4U9oSR3RISw73M+uzVbswr7BnSRjf5z1564hrbtWFUMQoVtcKX1uvj4SrIK/TND8VbvS1BDCCQtjmGehbjttJCpvsKXvhZVx6tf9Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818609; c=relaxed/simple;
	bh=D+m6fbuOEtfVFZ4K1fTKwh6PtJRBGqGiYhAIpkRrCtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNABPISVLcuBs1SgkuKLUK0qL/q6q77sDOWXo4vGmWFPKzMttQOc9nTUr40vHQem0bG6HUH6kdbqRUgWRyiR5ZtWA1co0TIbtnym6tuWTzPXrDwNsVWqbCAU8qVBJ8TcT5GRt8t9tBZ44DDlSRT8iAJll9flltkN8LYRqY5vUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMUPc/o9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMUPc/o9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-202376301e6so48524955ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 21:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724818607; x=1725423407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tn1fvWdumJz2IAU/LWcW5WsOScj35FqKLct5nfcgB1Y=;
        b=WMUPc/o9nX8IrQtx/XomgIdUcJfwGP75XfQ4VGLwRE6q6pb6RdEgkVpIb0blEwEvE/
         FuYt4wYtbrI/Qg08XCSwbRCoYIBKxZnSoOc6/MfBXAji7XKL3kNhWSroVeCtXYfVm4QS
         frmtlWpB/3hDU52hHc1c9dOxSsjUjLOdYX2VRsNDA71pjGR7CzIuTAFZGuIndmoRh6cH
         i53eG7eoTlgGRKLscNqgO8e3PFbLIdqAZYWgQ7BfVmCWBzIvRyC5Qf7DS/lACL0SQbKr
         8K5WWnyHlXt92wFDEWF60/HxhkHPS7ULXKkfQWt665WPrslxxqF9JTv+b5f/kUuLXO6H
         33FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724818607; x=1725423407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tn1fvWdumJz2IAU/LWcW5WsOScj35FqKLct5nfcgB1Y=;
        b=jPURIiTreapZS+2j33FUm8GDlM+Dpgd6HEePI4A/Nu50I48UDmJ6HyBPkoM9RjVHny
         yK2qJhqqsjwAktxsP0Yu8XHJb5Wj1CTJTJVhnVcXaYDP/XE/gRec+yE1DkUw9+/jccFf
         sCcBG+E7tr/caIQqm6LhpAEsDdNjMf34EgTuesEUK2GLlsvajSSkNwDWu+wt2rQGJjto
         F9i5dSsh9xG+W+skUXIPHHsjJK24zIZhEU7QqqM9YJpg5gX2vkcn4T1u1St+0TbdODR5
         eOhNoPJyfOO9ZAs97obdql+TklpnEkxRoRxKau4nRKJtSkJl0+V+VxnwP2Ry/lB94SO8
         8coA==
X-Gm-Message-State: AOJu0YxhCFobIzmzyEGL7X0p5cMTeTd7EQHsRoPL6Ou+VN6dIlnRvL1f
	MUj6I/aCikOTb+5YbpGrAy50l8GG29CBUVcZoozkwK9ObEje4D4fnWZP+w==
X-Google-Smtp-Source: AGHT+IF0xmI8G9YyfomV5F9IyXQ4h9jqk17LTgatzcEVaNwiLBqOPBhl/OpxkgGMDy4uso5CUSM/FQ==
X-Received: by 2002:a17:902:f647:b0:1fc:369b:c1dd with SMTP id d9443c01a7336-2039e44ee47mr150777885ad.6.1724818606793;
        Tue, 27 Aug 2024 21:16:46 -0700 (PDT)
Received: from apollo.localdomain ([2601:646:9d80:4380::2696])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567907sm91156635ad.12.2024.08.27.21.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 21:16:46 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v5 BlueZ] Provide GNU basename compatible implementation
Date: Tue, 27 Aug 2024 21:16:44 -0700
Message-ID: <20240828041644.3331363-1-raj.khem@gmail.com>
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
v5: Redo the patch to address textrels seen on ppc32/arm

 configure.ac            | 11 ++++++++++-
 mesh/mesh-config-json.c |  4 +++-
 mesh/missing.h          | 21 +++++++++++++++++++++
 mesh/rpl.c              |  1 +
 tools/hex2hcd.c         |  1 +
 tools/missing.h         | 21 +++++++++++++++++++++
 6 files changed, 57 insertions(+), 2 deletions(-)
 create mode 100644 mesh/missing.h
 create mode 100644 tools/missing.h

diff --git a/configure.ac b/configure.ac
index d31eb1656..f0f1ec100 100644
--- a/configure.ac
+++ b/configure.ac
@@ -70,7 +70,16 @@ AC_CHECK_LIB(pthread, pthread_create, dummy=yes,
 AC_CHECK_LIB(dl, dlopen, dummy=yes,
 			AC_MSG_ERROR(dynamic linking loader is required))
 
-AC_CHECK_HEADERS(linux/types.h linux/if_alg.h linux/uinput.h linux/uhid.h sys/random.h)
+AC_CHECK_HEADERS(string.h linux/types.h linux/if_alg.h linux/uinput.h linux/uhid.h sys/random.h)
+
+# basename may be only available in libgen.h with the POSIX behavior,
+# not desired here
+AC_CHECK_DECLS([basename], [],
+				AC_MSG_WARN([GNU basename extension not found]),
+				[#define _GNU_SOURCE 1
+				 #include <string.h>
+				 ])
+
 
 PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28)
 
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index c198627c6..e3b0a1809 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -28,6 +28,7 @@
 #include <ell/ell.h>
 #include <json-c/json.h>
 
+#include "mesh/missing.h"
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
diff --git a/mesh/missing.h b/mesh/missing.h
new file mode 100644
index 000000000..eaf32815e
--- /dev/null
+++ b/mesh/missing.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024  Khem Raj <raj.khem@gmail.com>
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+#if !HAVE_DECL_BASENAME
+#include <string.h>
+static inline const char *basename(const char *path)
+{
+  const char *base = strrchr(path, '/');
+
+  return base ? base + 1 : path;
+}
+#endif
diff --git a/mesh/rpl.c b/mesh/rpl.c
index fb225dddd..2fa17d72f 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -24,6 +24,7 @@
 
 #include <ell/ell.h>
 
+#include "mesh/missing.h"
 #include "mesh/mesh-defs.h"
 
 #include "mesh/node.h"
diff --git a/tools/hex2hcd.c b/tools/hex2hcd.c
index e6dca5a81..452ab2beb 100644
--- a/tools/hex2hcd.c
+++ b/tools/hex2hcd.c
@@ -24,6 +24,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <sys/stat.h>
+#include "tools/missing.h"
 
 static ssize_t process_record(int fd, const char *line, uint16_t *upper_addr)
 {
diff --git a/tools/missing.h b/tools/missing.h
new file mode 100644
index 000000000..eaf32815e
--- /dev/null
+++ b/tools/missing.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024  Khem Raj <raj.khem@gmail.com>
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+#if !HAVE_DECL_BASENAME
+#include <string.h>
+static inline const char *basename(const char *path)
+{
+  const char *base = strrchr(path, '/');
+
+  return base ? base + 1 : path;
+}
+#endif
