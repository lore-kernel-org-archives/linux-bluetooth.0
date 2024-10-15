Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE65158D9C
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025081; cv=none; b=eQCCB8lGOqeeKzjk1mqSr/96Qa4PvJ0VvDXW48/noqeAHJBTxULbCVc2rlEEZFpyl9hHTbi08piBz2EJgs0kreT57CwqkcE7d1UgYmeN9lakJvSWf1BhzKGso3HtuOf1/+9JnrvCUJjb1BdR3Z3fSlU54ffkV4StWzYEbbkruK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025081; c=relaxed/simple;
	bh=GuOEbimgk+3biGV01gkfKmvBrQdglWRlz/++a57O6Ts=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=snahf0J7thqteDYaf7NHNPn8xaaehY+fi6oe2P74lM9N4qHc/rX0SWSFO0igYmW66XQiHNVOd8RKJSDKQo1oBHH2LniNhjQXIT2HbMGY6nUkYv+LOwbfoGScyHbOUJs3uypJckMepfB4Mbhac2daWMzAxvGD9pbTy2JOu5xF9MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dkeg3vyG; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkeg3vyG"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50d4797098dso1089834e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 13:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729025078; x=1729629878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pNGO3njeXf5dImXgpj8IHrFKH5wckIdkOgRlJY2maBU=;
        b=Dkeg3vyGfbM6T8ta3xf80ukQlxeRPJSI+4VT7TvFpbJkH7nDSL7pGrMJEbiPl/xcfw
         LzkaL9feu9rCPMEA/jMuOEFciwfMMBJYXKUxxMy2eiP37micibI6pWve4Zm47BtLGTle
         g8y17Fi/NpziocGBecqvPM9h/vjR7+zFVDHmsJYg7xlHECAUeoIZ35fqpuHP93HVcSQX
         4d9VzyYV0nFolsF3o1urYKqn2zkCTaL6WLwSOpY/+BQCGK2W2iY/8SdSi7z8viQ5emBI
         0fFYOjtODs5wHln3q0nfS7QKxIayB+MyhxNoAU3TJNSjBrB/RyM9lN5OSNQ6Sf7VIv4a
         g9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729025078; x=1729629878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNGO3njeXf5dImXgpj8IHrFKH5wckIdkOgRlJY2maBU=;
        b=Mks7D18HVwDkbXH0ZmmeQ/wkbDj1dUqscTV9sPe1TXcQc7MGT94c6DVqlPcr/+dYDt
         Pgk8AYROv9cbsPcp8lpzRumW8MojWQEuYoxzbc2BKuxhlXeXvI+FMHF48rMPQaRCS4v+
         yUBu5lIsx6b6+BzpBpyPHgAHUPBW5OInqJ6TRbqQcVHD4NxMYv2dgLs+JB6Rz5iuPkRC
         547nFYoLRwNqatY2WAIXhWeKi/nsfFq2JdZaukk6XRBHsVybqxyBTPXOr6Fc7BaBnl4p
         y1wXDarJOqYNhBpiCRI9BFytcF5fBKkuZoTOw1Zwxi+Vdb6XaLQDsF2eEbFgK93gB4LK
         O53A==
X-Gm-Message-State: AOJu0YyJD+5cC44lqGmE9o5QwHbaeU6KsBf8jP7VR50SWLjYdD4CGc3s
	SxJ4qCb2PHH5I2/+TkTincjOB5cE3IBPgvdrnElOzifOP4N3yP6TFaZjsA==
X-Google-Smtp-Source: AGHT+IH1xAN+eJC/Xlf/sZqgkP901EQlT9qDX87+KMGGYhQoRaQJIpUd1myf42cBFhCaeWYgI2IfqQ==
X-Received: by 2002:a05:6122:4592:b0:50d:5654:951 with SMTP id 71dfb90a1353d-50d8d2220c0mr1784695e0c.5.1729025077677;
        Tue, 15 Oct 2024 13:44:37 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50d7aff674asm290252e0c.26.2024.10.15.13.44.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 13:44:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/shell: Fix not handling prompt with color properly
Date: Tue, 15 Oct 2024 16:44:35 -0400
Message-ID: <20241015204435.573538-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Colors use escape sequence that needs to be enveloped with
RL_PROMPT_START_IGNORE (\001) and RL_PROMPT_END_IGNORE (\002) in order
for readline to properly calculate the prompt length.

Fixes: https://github.com/bluez/bluez/issues/965
---
 client/main.c      | 16 ++++++++--------
 client/mgmt.c      | 10 ++++------
 src/shared/shell.c | 15 +++++++++------
 src/shared/shell.h |  2 +-
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/client/main.c b/client/main.c
index 50aa3e7a6cbe..3f8143dde4b8 100644
--- a/client/main.c
+++ b/client/main.c
@@ -43,7 +43,7 @@
 #define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
 #define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
 
-#define PROMPT_ON	COLOR_BLUE "[bluetooth]" COLOR_OFF "# "
+#define PROMPT_ON	"[bluetooth]# "
 #define PROMPT_OFF	"Waiting to connect to bluetoothd..."
 
 static DBusConnection *dbus_conn;
@@ -106,14 +106,14 @@ static void setup_standard_input(void)
 
 static void connect_handler(DBusConnection *connection, void *user_data)
 {
-	bt_shell_set_prompt(PROMPT_ON);
+	bt_shell_set_prompt(PROMPT_ON, COLOR_BLUE);
 }
 
 static void disconnect_handler(DBusConnection *connection, void *user_data)
 {
 	bt_shell_detach();
 
-	bt_shell_set_prompt(PROMPT_OFF);
+	bt_shell_set_prompt(PROMPT_OFF, NULL);
 
 	g_list_free_full(ctrl_list, proxy_leak);
 	g_list_free_full(battery_proxies, proxy_leak);
@@ -333,12 +333,12 @@ static void set_default_device(GDBusProxy *proxy, const char *attribute)
 	path = g_dbus_proxy_get_path(proxy);
 
 	dbus_message_iter_get_basic(&iter, &desc);
-	desc = g_strdup_printf(COLOR_BLUE "[%s%s%s]" COLOR_OFF "# ", desc,
+	desc = g_strdup_printf("[%s%s%s]# ", desc,
 				attribute ? ":" : "",
 				attribute ? attribute + strlen(path) : "");
 
 done:
-	bt_shell_set_prompt(desc ? desc : PROMPT_ON);
+	bt_shell_set_prompt(desc ? desc : PROMPT_ON, COLOR_BLUE);
 	g_free(desc);
 }
 
@@ -2099,9 +2099,9 @@ static void set_default_local_attribute(char *attr)
 	default_local_attr = attr;
 	default_attr = NULL;
 
-	desc = g_strdup_printf(COLOR_BLUE "[%s]" COLOR_OFF "# ", attr);
+	desc = g_strdup_printf("[%s]# ", attr);
 
-	bt_shell_set_prompt(desc);
+	bt_shell_set_prompt(desc, COLOR_BLUE);
 	g_free(desc);
 }
 
@@ -3187,7 +3187,7 @@ int main(int argc, char *argv[])
 	bt_shell_add_submenu(&advertise_monitor_menu);
 	bt_shell_add_submenu(&scan_menu);
 	bt_shell_add_submenu(&gatt_menu);
-	bt_shell_set_prompt(PROMPT_OFF);
+	bt_shell_set_prompt(PROMPT_OFF, NULL);
 
 	if (agent_option)
 		auto_register_agent = g_strdup(agent_option);
diff --git a/client/mgmt.c b/client/mgmt.c
index fba409f823ef..602b92228ab8 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -78,13 +78,11 @@ static void update_prompt(uint16_t index)
 	char str[32];
 
 	if (index == MGMT_INDEX_NONE)
-		snprintf(str, sizeof(str), "%s# ",
-					COLOR_BLUE "[mgmt]" COLOR_OFF);
+		snprintf(str, sizeof(str), "[mgmt]# ");
 	else
-		snprintf(str, sizeof(str),
-				COLOR_BLUE "[hci%u]" COLOR_OFF "# ", index);
+		snprintf(str, sizeof(str), "[hci%u]# ", index);
 
-	bt_shell_set_prompt(str);
+	bt_shell_set_prompt(str, COLOR_BLUE);
 }
 
 void mgmt_set_index(const char *arg)
@@ -860,7 +858,7 @@ static void prompt_input(const char *input, void *user_data)
 						&prompt.addr);
 		} else {
 			mgmt_confirm_neg_reply(prompt.index, &prompt.addr);
-			bt_shell_set_prompt(PROMPT_ON);
+			bt_shell_set_prompt(PROMPT_ON, COLOR_BLUE);
 		}
 		break;
 	}
diff --git a/src/shared/shell.c b/src/shared/shell.c
index 2100434f6b15..a8ad956c7948 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -750,15 +750,13 @@ void bt_shell_echo(const char *fmt, ...)
 
 	va_start(args, fmt);
 	ret = vasprintf(&str, fmt, args);
-	if (ret >= 0)
-		ret = asprintf(&str, COLOR_HIGHLIGHT "%s " COLOR_OFF "#", str);
 	va_end(args);
 
 	if (ret < 0)
 		return;
 
 	rl_save_prompt();
-	bt_shell_set_prompt(str);
+	bt_shell_set_prompt(str, COLOR_HIGHLIGHT);
 	rl_restore_prompt();
 }
 
@@ -823,7 +821,7 @@ static void prompt_input(const char *str, bt_shell_prompt_input_func func,
 	data.saved_user_data = user_data;
 
 	rl_save_prompt();
-	bt_shell_set_prompt(str);
+	bt_shell_set_prompt(str, COLOR_HIGHLIGHT);
 }
 
 void bt_shell_prompt_input(const char *label, const char *msg,
@@ -1574,14 +1572,19 @@ bool bt_shell_add_submenu(const struct bt_shell_menu *menu)
 	return true;
 }
 
-void bt_shell_set_prompt(const char *string)
+void bt_shell_set_prompt(const char *string, const char *color)
 {
 	char *prompt;
 
 	if (!data.init || data.mode)
 		return;
 
-	if (asprintf(&prompt, "\001%s\002", string) < 0) {
+	/* Envelope color within RL_PROMPT_START_IGNORE (\001) and
+	 * RL_PROMPT_END_IGNORE (\002) so readline can properly calculate the
+	 * prompt length.
+	 */
+	if (!color || asprintf(&prompt, "\001%s\002%s\001%s\002", color, string,
+				COLOR_OFF) < 0) {
 		rl_set_prompt(string);
 	} else {
 		rl_set_prompt(prompt);
diff --git a/src/shared/shell.h b/src/shared/shell.h
index b03250cac80f..e431db9f5821 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -66,7 +66,7 @@ bool bt_shell_add_submenu(const struct bt_shell_menu *menu);
 
 bool bt_shell_remove_submenu(const struct bt_shell_menu *menu);
 
-void bt_shell_set_prompt(const char *string);
+void bt_shell_set_prompt(const char *string, const char *color);
 
 void bt_shell_printf(const char *fmt,
 				...) __attribute__((format(printf, 1, 2)));
-- 
2.47.0

