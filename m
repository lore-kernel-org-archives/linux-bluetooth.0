Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E052594A5
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944937; cv=none; b=PdesqNDTU1fH03VTa6jsthXDvcVzeRq1og/+nkGNj0yEr8RF8rkxmK2lPlysA1gDa22KqHnNyOt3yAARfDkeclldBevPwSXcMy4j5IvEzy35qqMhewtCDTq8WhNAesv+dHsE60jumKzD3q6qk/MwRmicewW6tLprCvdISezBx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944937; c=relaxed/simple;
	bh=l/5FHLYr04XhlSWBZGOT+CkwGNNbydpoNJppu/IR5nA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CM9YFe19C3PPEEMyD/DdpWVDRt9MD9lULBLlWV3zTGg1XROPzRu9K9FbPHm+83DgXWtf/DvfxrnU+l2n4m8DPj201F77UKfJX+IDRXZBfjr9xdppsgQPuFpL+xeb3KG+uRRFK/qUHC2P1Uasmzx9+JAwJ7QpsBxx5xxpG63BQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVaE0lJc; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVaE0lJc"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6efe4324f96so48509047b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733944932; x=1734549732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=anHBtQYJ6KQdQcYE7bhg46eOJ1Y2DGanoXn0gMS3LNs=;
        b=GVaE0lJcwZoCbJkKlTI6imkS3DNRBgbyzzbP+6dSGp/wEIbvpIb68ENJ51iZJqPdBx
         eUotYCCTVSQAne1CgfVowIN1AXJPClJknS4ohcPN/Nj7Z9B+43nq0D10WrBzhaZH829b
         3W5ZDCRjGR/cao/8kSn2iE/q8BF18W6o+BJwGzI4vN3QkvfFXgvJLVjC1CzMTVZDR0bn
         3dN4Sgsqv41C+nJozLOVeSLU1BCeaE10oFo4JLxQWAdwRsdqUWaQjS8egZz32ebjKJLz
         +GQz8aDLCPsywpzzkSL72XM2+zA0YElzi17MYO3fookDFqFaYDI84ScmWw8do5yt9gcf
         2pqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733944932; x=1734549732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anHBtQYJ6KQdQcYE7bhg46eOJ1Y2DGanoXn0gMS3LNs=;
        b=YhHKUm8kb+Ic8Pfml5EVwIlOkdxDv2Bf2tahEobrhfk3Be5WSD28zvzgu0XGt3Wl3S
         HSKxCZ8eaVxgE6KWcurLxoR9i8KEQW9krwJASeP/AfvxZw4O/lgwUbZz7k7ne4PGqOs0
         VcsNXhQWUt51lFXv/r47r2KHSgg781QZHa282p5Pw1Gv6EtlR323e9tWiBCcmHGd1Npo
         Racl+OZYtp0/z9x3QDRpbft/tEcmOr+FRjmsP5OA/YN5jmyN5FNgE8twiguuBXBdB4B9
         WEwNU/ibVW1wNxzz2E6d8G3MaMTiZQKzxOoiQs7WILdsSV2rjuJm9rcjgEtOTaFFiymL
         DJyg==
X-Gm-Message-State: AOJu0YwHYFSy3I0JZgFhwb0wVz6JKaJAO73aK/wL4UC5qwFa8Tf2k+SK
	3GNh/NZfP2mL+Je9+Hz4gwF7UFE3VxcHjq2j66hvFHCCl577KcWuC7i1kg==
X-Gm-Gg: ASbGncuxKc+MiOtj/bfYtsCJxnIR8Zbp7qsZv/2TKS0+hu9hbGYRLawU72CUnaihXvW
	XZxEKJ1SArdR49hHWMGq0xtcpHSyf2TY14OTplADND0nSBE7MJ4p3ELjnYcYaHAEoMyAzd3VvTR
	kyPeYK7Qh06JJ/SmQfa0zsjcSml8d/1XDOdHNhkpO5DB14TN7+Yr6RmDTCrs7KG3wSMqIlPsyyW
	5Vig5OCMKOlg6ZOMx8M+dEHIakx3EFGcLhmUj5vlIDFhiwBkGQ2fJmqcsdBGmxdHgXbCc4qbrl1
	DF4NmhZMPepXdihFjeGudjtWGg==
X-Google-Smtp-Source: AGHT+IE/iPzsJVyhXaDULezfcQ1gW7qdwvSGvNT2VaqdLxNlsDce0ONTFvYBNv4tngv7SJ2Sa7h73A==
X-Received: by 2002:a05:690c:64c1:b0:6ef:5fee:1cbe with SMTP id 00721157ae682-6f19e86b362mr7168587b3.40.1733944932405;
        Wed, 11 Dec 2024 11:22:12 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14ce8be30sm3670077b3.79.2024.12.11.11.22.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:22:11 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/5] tools: Use '>' as prompt end marker
Date: Wed, 11 Dec 2024 14:22:06 -0500
Message-ID: <20241211192210.1864347-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces the use of '#' with '>' as prompt end marker since the
former is used to describe comments on the script which might be
confused with prompt.
---
 client/main.c            | 6 +++---
 client/mgmt.c            | 6 +++---
 tools/bluetooth-player.c | 2 +-
 tools/btpclientctl.c     | 2 +-
 tools/mesh-cfgclient.c   | 2 +-
 tools/mesh-gatt/util.c   | 2 +-
 tools/mesh/util.c        | 2 +-
 tools/meshctl.c          | 4 ++--
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/client/main.c b/client/main.c
index 3f8143dde4b8..9258b44655dd 100644
--- a/client/main.c
+++ b/client/main.c
@@ -43,7 +43,7 @@
 #define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
 #define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
 
-#define PROMPT_ON	"[bluetooth]# "
+#define PROMPT_ON	"[bluetoothctl]> "
 #define PROMPT_OFF	"Waiting to connect to bluetoothd..."
 
 static DBusConnection *dbus_conn;
@@ -333,7 +333,7 @@ static void set_default_device(GDBusProxy *proxy, const char *attribute)
 	path = g_dbus_proxy_get_path(proxy);
 
 	dbus_message_iter_get_basic(&iter, &desc);
-	desc = g_strdup_printf("[%s%s%s]# ", desc,
+	desc = g_strdup_printf("[%s%s%s]> ", desc,
 				attribute ? ":" : "",
 				attribute ? attribute + strlen(path) : "");
 
@@ -2099,7 +2099,7 @@ static void set_default_local_attribute(char *attr)
 	default_local_attr = attr;
 	default_attr = NULL;
 
-	desc = g_strdup_printf("[%s]# ", attr);
+	desc = g_strdup_printf("[%s]> ", attr);
 
 	bt_shell_set_prompt(desc, COLOR_BLUE);
 	g_free(desc);
diff --git a/client/mgmt.c b/client/mgmt.c
index 59dcb3135344..1946d65d2fe2 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -71,16 +71,16 @@ static int pending_index = 0;
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
 #endif
 
-#define PROMPT_ON	COLOR_BLUE "[mgmt]" COLOR_OFF "# "
+#define PROMPT_ON	COLOR_BLUE "[mgmt]" COLOR_OFF "> "
 
 static void update_prompt(uint16_t index)
 {
 	char str[32];
 
 	if (index == MGMT_INDEX_NONE)
-		snprintf(str, sizeof(str), "[mgmt]# ");
+		snprintf(str, sizeof(str), "[mgmt]> ");
 	else
-		snprintf(str, sizeof(str), "[hci%u]# ", index);
+		snprintf(str, sizeof(str), "[hci%u]> ", index);
 
 	bt_shell_set_prompt(str, COLOR_BLUE);
 }
diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 83045ca3fe41..63a95b878fb8 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -33,7 +33,7 @@
 #include "src/shared/shell.h"
 #include "client/player.h"
 
-#define PROMPT	"[bluetooth]# "
+#define PROMPT	"[bluetooth-player]> "
 
 static DBusConnection *dbus_conn;
 
diff --git a/tools/btpclientctl.c b/tools/btpclientctl.c
index eb97463148d2..f6f61ed5d651 100644
--- a/tools/btpclientctl.c
+++ b/tools/btpclientctl.c
@@ -34,7 +34,7 @@
 
 #define DEFAULT_SOCKET_PATH	"/tmp/bt-stack-tester"
 
-#define PROMPT_ON	COLOR_BLUE "[btpclient]" COLOR_OFF "# "
+#define PROMPT_ON	COLOR_BLUE "[btpclient]" COLOR_OFF "> "
 
 #define EVT_OPCODE_BASE	0x80
 
diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index e64950a9cc65..3bd2b673ad7f 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -38,7 +38,7 @@
 #include "tools/mesh/model.h"
 #include "tools/mesh/remote.h"
 
-#define PROMPT_ON	"[mesh-cfgclient]# "
+#define PROMPT_ON	"[mesh-cfgclient]> "
 #define PROMPT_OFF	"Waiting to connect to bluetooth-meshd..."
 
 #define CFG_SRV_MODEL	0x0000
diff --git a/tools/mesh-gatt/util.c b/tools/mesh-gatt/util.c
index 58f240a7748e..84fa7b5eedb0 100644
--- a/tools/mesh-gatt/util.c
+++ b/tools/mesh-gatt/util.c
@@ -29,7 +29,7 @@ void set_menu_prompt(const char *name, const char *id)
 {
 	char *prompt;
 
-	prompt = g_strdup_printf("[%s%s%s]# ", name,
+	prompt = g_strdup_printf("[%s%s%s]> ", name,
 					id ? ": Target = " : "", id ? id : "");
 	bt_shell_set_prompt(prompt, COLOR_BLUE);
 	g_free(prompt);
diff --git a/tools/mesh/util.c b/tools/mesh/util.c
index 310aae0c63e6..6e81bf5f0285 100644
--- a/tools/mesh/util.c
+++ b/tools/mesh/util.c
@@ -28,7 +28,7 @@ void set_menu_prompt(const char *name, const char *id)
 {
 	char *prompt;
 
-	prompt = l_strdup_printf("[%s%s%s]# ", name,
+	prompt = l_strdup_printf("[%s%s%s]> ", name,
 					id ? ": Target = " : "", id ? id : "");
 	bt_shell_set_prompt(prompt, COLOR_BLUE);
 	l_free(prompt);
diff --git a/tools/meshctl.c b/tools/meshctl.c
index 00a68a3d1d57..7b9c44b11e49 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -54,7 +54,7 @@
 #define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
 #define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
 
-#define PROMPT_ON	"[meshctl]# "
+#define PROMPT_ON	"[meshctl]> "
 #define PROMPT_OFF	"Waiting to connect to bluetoothd..."
 
 #define MESH_PROV_DATA_IN_UUID_STR	"00002adb-0000-1000-8000-00805f9b34fb"
@@ -603,7 +603,7 @@ static void set_connected_device(GDBusProxy *proxy)
 			goto done;
 
 	dbus_message_iter_get_basic(&iter, &desc);
-	desc = g_strdup_printf(COLOR_BLUE "[%s%s%s]" COLOR_OFF "# ", desc,
+	desc = g_strdup_printf(COLOR_BLUE "[%s%s%s]" COLOR_OFF "> ", desc,
 			       (desc && mesh) ? "-" : "",
 				mesh ? buf : "");
 
-- 
2.47.1

