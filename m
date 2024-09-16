Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C06153808
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726529270; cv=none; b=oCZp8pbCbILoilGSc7/n2Bt2ZUIqeAXYgZfPJFw+fo3PMuELT+O9vOciqBMT22B17CZAqqFozQiZ9+vNBGT2u0vWtQWcbuzFEd7FxMhdJpsu5w4+Wa4gKJgYav3YE6DuVxuxM2veFqS1v/rW7hCsm/7r8mCckubxayp4YX57Qzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726529270; c=relaxed/simple;
	bh=UCnCOA4xx0hfa0X89I86gimM4nGbzffBKhLFFnzDyo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtZZcJHoTYCC/v85kA5jAmQkQ+A6GRj+1mP4gvFV1EHwyW5EdimJ+pFvTAJINkVT/0fh2Q6sOKYDFtU9e9KD/u556TxGZ6zVuEo0cJSMlF1wxRZHTWrys2VO7kfIPePWApLwHnbPfAN1FMyoN7TekxDCeoLnMjCI42NUKu3VYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3nxAdTN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3nxAdTN"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20696938f86so40921375ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 16:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726529268; x=1727134068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c0+WCkpDnh584RfbkEw8uvFclMsCjZFA/d0bM8asmTw=;
        b=J3nxAdTNpc5wWcWqKGJFwEr2UAeKW5GLUZK8ejTXWOFfYAO5aDGH9iyMG6qqD6is8e
         jIJaERLzfZgy89e/3YJxsbpK3bFEdwYJK58jYm11gTQkVolLc4oIC9Tg/bPtbtu5x04H
         u3nl9QBXEvX/YZhUAaYy4BkZr8vMRpItldVl/GWGi9j2OgiLiNgv/nImQmCuutQkXUfw
         +XpsxNlYEvSXjH+pKAWrbXDA20w/cIoJt2o6F6qYz9KloWbOCn0D+9njghDDNmpfpg1N
         7H/c3mre5LGcoo1J213CGaRASPj5YWVdotkUV9VNyg5fVQ7b+KmyvIDlOFnIZ9e1WT1T
         wZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726529268; x=1727134068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0+WCkpDnh584RfbkEw8uvFclMsCjZFA/d0bM8asmTw=;
        b=LV+VoDGhRr4aAuStZLIE14ao8pYu6a9eXoarnXLgNFLrGEBwXD43wUmgB35CBkYDKF
         lsWe5luEIeSEQiCTfK/JDcgRbYEqWYFf4yCRv7zrQ5lgb3NgxPUPG47zXGan1TG/YwsZ
         dVXkVHxIPkAQqEgfD6/NXXKn1mRV7V3TADcJ/rXgK2w4OQbCvTEoPNNufQYf/tyE0Fqd
         4SukyJnPAu3DwzsbvIEatmX+0m92P9CjHKP+S6UCd8As8Mu1TXysqxLOEQRXkQQpO4MT
         r60VSZiw+AouyJ0TZz9lr2XvRbxtRdzTQCMPSfDbjFwtb8xG46eA2SF9PsZiiZmdYiIP
         6rmw==
X-Gm-Message-State: AOJu0YyvQRu0y9HoV1dGv9uupggPyEl1AAWguzL5opbQ8fc8ZO2xn3H3
	SeQcBNPiH9oNrhXrMQNvwK8guml39+rYKOpSfq2yMFZvacWwW17CH9NWZSma
X-Google-Smtp-Source: AGHT+IG3cJ4aI/JiCXov2LWnR+XmbTIWrrmx9v6FvEO3WmGS9VBbbRVVLG9SX5gUqsLBJyuLD/7csQ==
X-Received: by 2002:a17:902:d4c2:b0:201:f6e8:637f with SMTP id d9443c01a7336-2076e31a877mr303111065ad.11.1726529267788;
        Mon, 16 Sep 2024 16:27:47 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::de58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945daa86sm41306215ad.61.2024.09.16.16.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 16:27:47 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] mesh: Move local basename into utility file
Date: Mon, 16 Sep 2024 16:27:44 -0700
Message-ID: <20240916232744.1618862-1-raj.khem@gmail.com>
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
 mesh/mesh-config-json.c |  3 +--
 mesh/missing.h          | 21 ---------------------
 mesh/rpl.c              |  3 +--
 mesh/util.c             | 10 ++++++++++
 mesh/util.h             |  5 +++++
 5 files changed, 17 insertions(+), 25 deletions(-)
 delete mode 100644 mesh/missing.h

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
