Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C81799F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825372; cv=none; b=lA0exf1CGW6MhPSNF9E75+lzmfyrFTO5vFfHODpy1DMOVoQGeQ3TuylmYbkoOM6zNRXzS5d2GZs/sEddb6JeGEE+t3jM6wSewO0Lk0EWMW3DQEho6wMugQAA/6sjAlCtPcItRrXjYli4vCI7DZf3cceYnAheD48XBdbQV07tsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825372; c=relaxed/simple;
	bh=vSgrLZdB5jFFnPniMfdH5yALfJNcKQ9uR8PuiswWfPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kg46Tm9n21XwhYtohgGz+UtPPOZiSgVb2SRvDuZaEFvw9iuLvskRqhpTUcB5BgTDJ4cYynPWEOXAnyade/qr041W7l0OxnJuPQY0jsSzWlgvmOORjnDdsyS3YWNQkAbSkBiXpWtGDTSp5FCXpSJdh4ikDDrY0o0k75DJ/jK+jIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8q38ngK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8q38ngK"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6bce380eb96so3501896a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 23:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724825370; x=1725430170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+q6S0XKqpcPPscvDqEl6W7sRJoVGKE4nojGmodtgk38=;
        b=F8q38ngKDtgYUKlUHWA2tLivG7fvrfuay2HLFonXsZjoVe2PZrxjRdQhAZad85ajJ9
         MHWcm5AJkh+qmf3LuE3d0yFUzMrO5aFFpAI7+YBRyhpYFk6nNZMWjzff14GOravBUkaO
         rsiaqAyrZJQIdW1n/bCDkAumieHJVnXnk/lI4gwqMBlCxlWH5wLmOScAd8+ijnkZ8mfx
         XMvHBjru81KGK44cZ6rPSQQGJFQQ3wWyBCgu/FBWte0h52y5XluT7mRtxvdGWzoaxBEa
         mDte71uJ7iaLV6mjXHJ2AzikUkKob3xocSoT9GogE//yygpv00aLOX+NwSU7jkOojNVS
         GY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724825370; x=1725430170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+q6S0XKqpcPPscvDqEl6W7sRJoVGKE4nojGmodtgk38=;
        b=LyXiEWrmPead2MHDYlLVYVHF4+yMwYVAsaRKJ5SXGXNDiyuvJkRhC2hp6rG8t+h+Eu
         5jpB4kxXJqZrPum7ohxTNcLn5QVe+C9sU4WB/ZNkF6RC0Vmt7JscjM3pVewCCDv6QG7R
         1OjH+SjQTfkwtiUurJorMse+zxpPSnT/Ves07rLomX9y65vGhUl9Tu44w6r945E2GU3M
         DJp/rhAeWHFr3VsZXcg0onkeWPPg5Wzu4xsB4dz+ffh18uyEUv5y1G5RSm3tXXRsaHMN
         8+SaNk74X6++L21veCQOv2jxGcqDQOusoJZ5VzJBuDC3rrn3h4AcrBD2WJUStcbVQJxt
         88Xg==
X-Gm-Message-State: AOJu0YzCGCg2FOiiRvR3dvCcrZYT0dAvG3BDr3MO24G/Vv48fWwz+fw3
	yEfXjNlMHaOOyFy9Hp/AZ1ezJjpIoduHAuw1r/4OK2pA6jUBFdqf7BK2Sw==
X-Google-Smtp-Source: AGHT+IGPCnD9llfl2MxZClvpxlDQmTqPBvIUd70YQWZCzIrxCCd7nM9eBze8IWYhstXcM1aD5Ky8aQ==
X-Received: by 2002:a05:6a20:6f01:b0:1c2:9070:90ce with SMTP id adf61e73a8af0-1ccd28dd44amr866177637.43.1724825369464;
        Tue, 27 Aug 2024 23:09:29 -0700 (PDT)
Received: from apollo.localdomain ([2601:646:9d80:4380::2696])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855664b3sm92144605ad.21.2024.08.27.23.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 23:09:29 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v6 BlueZ] Provide GNU basename compatible implementation
Date: Tue, 27 Aug 2024 23:09:26 -0700
Message-ID: <20240828060926.3710535-1-raj.khem@gmail.com>
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
v6: Fix checkpatch.pl errors/warnings

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
index c198627c6..a17a48b6d 100644
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
+	const char *node_name;
 	char uuid[33];
 
 	if (!cfg)
diff --git a/mesh/missing.h b/mesh/missing.h
new file mode 100644
index 000000000..464df9b1c
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
+	const char *base = strrchr(path, '/');
+
+	return base ? base + 1 : path;
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
index 000000000..464df9b1c
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
+	const char *base = strrchr(path, '/');
+
+	return base ? base + 1 : path;
+}
+#endif
