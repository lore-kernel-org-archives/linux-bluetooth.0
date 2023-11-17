Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb9RdeVb"
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA90B2729
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 13:18:22 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-daec4e4c5eeso2333460276.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 13:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700255901; x=1700860701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYf6vvs7/US2fopFUYiPvKGeix259clpc+5ExD+/usI=;
        b=Tb9RdeVbMqmKVZzuWC0A5Cn1NVt7MJcsWHSwWm+7SlawHUgj5Z7C7BDIdTzwPDLMid
         9MpBsFb7i4CyFyYB2Y403Hy/TSUqoLB8sSmLuikp74sAFQF7RiI1VM2lc1hzgstx2o/3
         jaD1jxYlb4URy4Kk9SPYGVOFb3h3Mvnl0gT0ccVWqJs1lgiIECVbBGSNNg3bAcuXxT5j
         tFGRdV6lmcnBnRa2D0v63P2vRowOq9Pxv02gwyY4bYyyD+Y4YIJqJ38txKkmu/asY1Yg
         ERAhrLBN1gzxrl1vbQrO25V5wA0T65LHU4gy+vvmXH/URtfhgLsT4sb5Hzs/plGF0mM3
         vJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700255901; x=1700860701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYf6vvs7/US2fopFUYiPvKGeix259clpc+5ExD+/usI=;
        b=LauC0cx0IBT4+ahy2RjXFdFp4yWZ1vbG19c5pqHcH8RQFDzRgF3iQ4vm9hxRKnzAdY
         rF6OuU2YCcXeizZ/543Qt95HIgf4X0DNsuvPkQpFU5xYEKmN44qjOJtzIogYELR6vDfs
         6ti1lg5xkmgueEd1W8tVa6Rlrtp84YsR0G0aUawu/QOC4JVvlaZ3x5cz9JkE0W4gznYV
         /nBHAQI3uWuf4laduSHmOfZaZsJOeQHfNV82UDw0ImIxPW2vjmQ6UJRgn9z/J1HJWkW6
         xz02rIke1suYLmKKGLomMgOxgSuvJQECTJHgQ7fze9k4XAreiqEE9TMgy4vzvNFSAA8c
         42bg==
X-Gm-Message-State: AOJu0YwOnj57Hey6hMtvDeNDKC/kYEdW5vknLLCn7OMJrlwnZLH/1pYT
	GgjfDACdpnV8nJM3QdEJBuUEhmsC5iQOsA==
X-Google-Smtp-Source: AGHT+IHe7jfkoosnoxYH/IdOqeFK4x5HqRw1x008YKwcKAVex/N82bNVcoK1f8gCpRCADXGDk+ic1g==
X-Received: by 2002:a25:258c:0:b0:da0:c6ae:ad0e with SMTP id l134-20020a25258c000000b00da0c6aead0emr611342ybl.21.1700255900625;
        Fri, 17 Nov 2023 13:18:20 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id w4-20020a254904000000b00da3b52e3cf5sm607009yba.10.2023.11.17.13.18.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:18:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/shell: Remove readline color escapes
Date: Fri, 17 Nov 2023 16:18:19 -0500
Message-ID: <20231117211819.257212-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes readline color escapes from color defines and instead only
used them with prompt since they are only really usefull when readline
is rendering the text, so it can calculate the prompt lenth properly.

Fixes: https://github.com/bluez/bluez/issues/10
---
 src/shared/shell.c |  6 +++++-
 src/shared/shell.h | 16 ++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index fbccff5b54d9..fcce2d3aa5a4 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1419,10 +1419,14 @@ bool bt_shell_add_submenu(const struct bt_shell_menu *menu)
 
 void bt_shell_set_prompt(const char *string)
 {
+	char *prompt;
+
 	if (!data.init || data.mode)
 		return;
 
-	rl_set_prompt(string);
+	asprintf(&prompt, "\001%s\002", string);
+
+	rl_set_prompt(prompt);
 	rl_redisplay();
 }
 
diff --git a/src/shared/shell.h b/src/shared/shell.h
index 87fb5c415f20..a9a635bda959 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -10,14 +10,14 @@
 #include <getopt.h>
 #include <stdbool.h>
 
-#define COLOR_OFF	"\001\x1B[0m\002"
-#define COLOR_RED	"\001\x1B[0;91m\002"
-#define COLOR_GREEN	"\001\x1B[0;92m\002"
-#define COLOR_YELLOW	"\001\x1B[0;93m\002"
-#define COLOR_BLUE	"\001\x1B[0;94m\002"
-#define COLOR_BOLDGRAY	"\001\x1B[1;30m\002"
-#define COLOR_BOLDWHITE	"\001\x1B[1;37m\002"
-#define COLOR_HIGHLIGHT	"\001\x1B[1;39m\002"
+#define COLOR_OFF	"\x1B[0m"
+#define COLOR_RED	"\x1B[0;91m"
+#define COLOR_GREEN	"\x1B[0;92m"
+#define COLOR_YELLOW	"\x1B[0;93m"
+#define COLOR_BLUE	"\x1B[0;94m"
+#define COLOR_BOLDGRAY	"\x1B[1;30m"
+#define COLOR_BOLDWHITE	"\x1B[1;37m"
+#define COLOR_HIGHLIGHT	"\x1B[1;39m"
 
 struct bt_shell_menu;
 
-- 
2.42.0

