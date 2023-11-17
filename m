Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKFzdGeR"
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35ECD4E
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 14:05:12 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so2477063276.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 14:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700258710; x=1700863510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=p07Z4lx0VQFwXa8YKhuzjNWE/5ssgyIYSEaqb8TuP7g=;
        b=TKFzdGeREDOmezQLG70T9aGKBemORpdSOq8M7Kr1KHtKChoCHHjtdirxo7xEL9vd2u
         mVl5JPK7n/5wK++m/dv1fAaZ3bJtGGOEl7Cu4iTzWoIZdfdoSVLDOI5w7WX6Zhqk7LLI
         TUD9DSrixW4wfjyoZdUV/DGoYfZG05WQUwYhMxk8o8SO9uSQXmMZ7sAHAPVliDZAnRxz
         r6VbCtmrNUHsJqpyC4gmEXcyZwqAd9vAoLhrYdH1SCzjVQ1qKnVoP/7UsK4WTBpjZ1Rw
         ChuLZUQiWDHAlqCynpgDI+D1T7Y+5dRXVKb8LNfYojhoXS3nytI4XQjYUDqfGJXV3fnY
         olgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700258710; x=1700863510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p07Z4lx0VQFwXa8YKhuzjNWE/5ssgyIYSEaqb8TuP7g=;
        b=qhTNI7kj4qziUT/H8d85PGdDpKW4/wbxKjaeKlIZVItavtk4X3NYzMdFbuVK5qIDcP
         w8Xf2/Lqv8dQrD5xwVDxIbaGPrfsYPBU4lcvhW0T9MW0g1UBecfTtUXEhRHmlpsw6OE+
         zs3EfhR2OCLwBXwZzv/h5R+SoRLp9l0yNpCGgVwQQ1od5Oo1SGdiJXPnOsAJssggq9R8
         j9lbE+MeRVdMF0S8nu0jTyjHgJANkrLLmkpueMqsG3fxchHab3yiBAk7zC19bhHxLvKz
         UOHcoAgAoiFF+x98eHNTs6xLkp/mwkoLckfKr7aY1IxHNSek7ldgG6mRHfSVFn9N8lcO
         sLQg==
X-Gm-Message-State: AOJu0YxxcPfD7a/QW9tqqzLHZN0eIOGgWXqKR0I+F0A1qfIXP7DYn3tm
	BqfBb8laGuCzpqKanqnl8aOlvxWQD6b0pw==
X-Google-Smtp-Source: AGHT+IG4MNXVabYUirhgW2IuW5x06q6CEKBLascBFcC4DoHdmVz0uH85bBDvZHhx3ENdSEobyUX3GA==
X-Received: by 2002:a05:6902:184:b0:da0:c49a:5fdf with SMTP id t4-20020a056902018400b00da0c49a5fdfmr869628ybh.7.1700258709911;
        Fri, 17 Nov 2023 14:05:09 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id y36-20020a25ad24000000b00d9a577d8434sm614460ybi.53.2023.11.17.14.05.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 14:05:09 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] shared/shell: Remove readline color escapes
Date: Fri, 17 Nov 2023 17:05:06 -0500
Message-ID: <20231117220506.273238-1-luiz.dentz@gmail.com>
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
used them with prompt since they are only really useful when readline
is rendering the text, so it can calculate the prompt length properly.

Fixes: https://github.com/bluez/bluez/issues/10
---
 src/shared/shell.c | 10 +++++++++-
 src/shared/shell.h | 16 ++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index fbccff5b54d9..68499b464b69 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1419,10 +1419,18 @@ bool bt_shell_add_submenu(const struct bt_shell_menu *menu)
 
 void bt_shell_set_prompt(const char *string)
 {
+	char *prompt;
+
 	if (!data.init || data.mode)
 		return;
 
-	rl_set_prompt(string);
+	if (asprintf(&prompt, "\001%s\002", string) < 0)
+		rl_set_prompt(string);
+	else {
+		rl_set_prompt(prompt);
+		free(prompt);
+	}
+
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

