Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BA1DE4CB
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176012; cv=none; b=dmj0qYlAzpaFtzH++pCbKQmOV9PJ9zTwQB1EOBakpn+EGsH2mKMdDH3sGrrl7X2Cur57EDSyB4pMUScG33dx7OzeW1GrsTHmAwwJpUY+D6dC0uvvxqRSeVvo8O3PjNgHx94BBAaWqUnU5cU1/InNM5zxmPaAK9GGs2teImoMi+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176012; c=relaxed/simple;
	bh=RUJH/3G48pwMCm0nsSIuMMZfn2PM2QAHZQJzewLD8bo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YE4cepeczixt71uzUBwI/aL7aMDRli+pSy3IMUnX1cAsvmX01xvJuZBuLBNmFu31bm+0MpGWMcA74ZAne2q3VVddJMmZo3JdZppMnQJQtBP8R3JIcX+gKJYURl9WazVgsANT7MlRzQFqjSP7oZPGqXq9r5cZo5InKYQ2COukoHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNK6IwrN; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNK6IwrN"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e4d624ac28so636250b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729176006; x=1729780806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLlRIEMJB+3vqZAS7S42FJ6+oZh8wnyuSFTPFOgZxFE=;
        b=UNK6IwrN0TB6vYweFPF79hqiHSS8CVOGhIVJQNRF1mlVb1XoFOCsWc1d43Lm1Nen4u
         r5dRLxQKTrNbpBWO6hkRbFTESwiEJ9CEVo5AyZbL1zkIahYNZTYMaJdnfUQ6ngPetor6
         ysopWizZoC4KyvsRcKkTnHLrN/M952aRCR8epHfEU+g5eMR6AZzpMPg1BsVsrQh6qDkQ
         Ul8wsP2kV359STgoCoXekIvik2OuAPW9wduFz2+MadlIYctm7yhrIN2mF3tfZcEft4Fx
         iu8mKgxySlPu9Xp/+Y2tHZwqhogK0y7CTXZY6EcDmam2b8DTipXWHFSxLFWHYURi31gL
         BLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729176006; x=1729780806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLlRIEMJB+3vqZAS7S42FJ6+oZh8wnyuSFTPFOgZxFE=;
        b=D8L6AezvrrWFRhqURmN9zkw1dLxI6vzPb50qo9l7/VeTrQxN1ftxmJbiNaFF36748C
         7vfZHwL5yshAW7huar/UxWBZocnr2XUYUt9alSl5yCZwaC7fWnc4/06MrK++Wpf3/Ban
         nffOCEzi+Gz1kwMwz5A2+UPnOfWcs6Kn+PjFkIWNDMk4uY1K12XHheVcAQ61rGur8fIj
         +fu8Nw6WuCKm9U/gN8vR91wFMFGarhBCBoOKiwRNl/DgmoqGu9WP+nCc3keefDp5oVkl
         +s0cmIKUNscS/kdvnyPyXpHvRczZX4c+rU5YMJX41rQ+uneku9xm2B1Y/s1sMKx+8V0H
         P69Q==
X-Gm-Message-State: AOJu0Yz6PAjLgpMaSdM2JnZy03zWBmV5TyaIrYRdZ533JPiJRGJ+GMtR
	DCbAaIetgQuKUYnkPyW4Ei1VDBOWMemneKgTsSZIHZOXLDDN84D4vrAvEQ==
X-Google-Smtp-Source: AGHT+IEVM1mEHSt+XdX5bU+y35HTuf8LYvmM38FbBY0NE6p9h3FSKbCwC4hms8uuxoolDbpFifVCdg==
X-Received: by 2002:a05:6808:1205:b0:3db:3303:834c with SMTP id 5614622812f47-3e5f051251bmr6312432b6e.39.1729176005757;
        Thu, 17 Oct 2024 07:40:05 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-850317a9fc4sm841091241.5.2024.10.17.07.40.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:40:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] shared/shell: Fix not handling prompt with color properly
Date: Thu, 17 Oct 2024 10:40:02 -0400
Message-ID: <20241017144002.941979-1-luiz.dentz@gmail.com>
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
 client/main.c            | 16 ++++++++--------
 client/mgmt.c            | 10 ++++------
 src/shared/shell.c       | 15 +++++++++------
 src/shared/shell.h       |  2 +-
 tools/bluetooth-player.c |  9 ++++-----
 tools/btpclientctl.c     |  2 +-
 tools/mesh-cfgclient.c   |  6 +++---
 tools/mesh-gatt/util.c   |  4 ++--
 tools/mesh/util.c        |  4 ++--
 tools/meshctl.c          | 10 +++++-----
 tools/obexctl.c          | 15 +++++++--------
 11 files changed, 46 insertions(+), 47 deletions(-)

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
diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index eba104d09fdb..83045ca3fe41 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -33,21 +33,20 @@
 #include "src/shared/shell.h"
 #include "client/player.h"
 
-#define PROMPT_ON	COLOR_BLUE "[bluetooth]" COLOR_OFF "# "
-#define PROMPT_OFF	"[bluetooth]# "
+#define PROMPT	"[bluetooth]# "
 
 static DBusConnection *dbus_conn;
 
 static void connect_handler(DBusConnection *connection, void *user_data)
 {
 	bt_shell_attach(fileno(stdin));
-	bt_shell_set_prompt(PROMPT_ON);
+	bt_shell_set_prompt(PROMPT, COLOR_BLUE);
 }
 
 static void disconnect_handler(DBusConnection *connection, void *user_data)
 {
 	bt_shell_detach();
-	bt_shell_set_prompt(PROMPT_OFF);
+	bt_shell_set_prompt(PROMPT, NULL);
 }
 
 int main(int argc, char *argv[])
@@ -56,7 +55,7 @@ int main(int argc, char *argv[])
 	int status;
 
 	bt_shell_init(argc, argv, NULL);
-	bt_shell_set_prompt(PROMPT_OFF);
+	bt_shell_set_prompt(PROMPT, NULL);
 
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 
diff --git a/tools/btpclientctl.c b/tools/btpclientctl.c
index c30d5bd4e739..eb97463148d2 100644
--- a/tools/btpclientctl.c
+++ b/tools/btpclientctl.c
@@ -2340,7 +2340,7 @@ int main(int argc, char *argv[])
 	mainloop_add_fd(btpclientctl->server_fd, EPOLLIN, server_callback,
 			btpclientctl, NULL);
 
-	bt_shell_set_prompt(PROMPT_ON);
+	bt_shell_set_prompt(PROMPT_ON, COLOR_BLUE);
 
 	status = bt_shell_run();
 
diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index e39f145c6241..e64950a9cc65 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -38,7 +38,7 @@
 #include "tools/mesh/model.h"
 #include "tools/mesh/remote.h"
 
-#define PROMPT_ON	COLOR_BLUE "[mesh-cfgclient]" COLOR_OFF "# "
+#define PROMPT_ON	"[mesh-cfgclient]# "
 #define PROMPT_OFF	"Waiting to connect to bluetooth-meshd..."
 
 #define CFG_SRV_MODEL	0x0000
@@ -2482,7 +2482,7 @@ static void client_ready(struct l_dbus_client *client, void *user_data)
 static void client_connected(struct l_dbus *dbus, void *user_data)
 {
 	bt_shell_printf("D-Bus client connected\n");
-	bt_shell_set_prompt(PROMPT_ON);
+	bt_shell_set_prompt(PROMPT_ON, COLOR_BLUE);
 }
 
 static void client_disconnected(struct l_dbus *dbus, void *user_data)
@@ -2642,7 +2642,7 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	bt_shell_set_prompt(PROMPT_OFF);
+	bt_shell_set_prompt(PROMPT_OFF, NULL);
 
 	dbus = l_dbus_new_default(L_DBUS_SYSTEM_BUS);
 
diff --git a/tools/mesh-gatt/util.c b/tools/mesh-gatt/util.c
index eb8b8eb29467..58f240a7748e 100644
--- a/tools/mesh-gatt/util.c
+++ b/tools/mesh-gatt/util.c
@@ -29,9 +29,9 @@ void set_menu_prompt(const char *name, const char *id)
 {
 	char *prompt;
 
-	prompt = g_strdup_printf(COLOR_BLUE "[%s%s%s]" COLOR_OFF "# ", name,
+	prompt = g_strdup_printf("[%s%s%s]# ", name,
 					id ? ": Target = " : "", id ? id : "");
-	bt_shell_set_prompt(prompt);
+	bt_shell_set_prompt(prompt, COLOR_BLUE);
 	g_free(prompt);
 }
 
diff --git a/tools/mesh/util.c b/tools/mesh/util.c
index dea496dbeb8c..310aae0c63e6 100644
--- a/tools/mesh/util.c
+++ b/tools/mesh/util.c
@@ -28,9 +28,9 @@ void set_menu_prompt(const char *name, const char *id)
 {
 	char *prompt;
 
-	prompt = l_strdup_printf(COLOR_BLUE "[%s%s%s]" COLOR_OFF "# ", name,
+	prompt = l_strdup_printf("[%s%s%s]# ", name,
 					id ? ": Target = " : "", id ? id : "");
-	bt_shell_set_prompt(prompt);
+	bt_shell_set_prompt(prompt, COLOR_BLUE);
 	l_free(prompt);
 }
 
diff --git a/tools/meshctl.c b/tools/meshctl.c
index 38ffd35f3c9b..00a68a3d1d57 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -54,7 +54,7 @@
 #define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
 #define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
 
-#define PROMPT_ON	COLOR_BLUE "[meshctl]" COLOR_OFF "# "
+#define PROMPT_ON	"[meshctl]# "
 #define PROMPT_OFF	"Waiting to connect to bluetoothd..."
 
 #define MESH_PROV_DATA_IN_UUID_STR	"00002adb-0000-1000-8000-00805f9b34fb"
@@ -172,14 +172,14 @@ static void proxy_leak(gpointer data)
 
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
 	ctrl_list = NULL;
@@ -608,7 +608,7 @@ static void set_connected_device(GDBusProxy *proxy)
 				mesh ? buf : "");
 
 done:
-	bt_shell_set_prompt(desc ? desc : PROMPT_ON);
+	bt_shell_set_prompt(desc ? desc : PROMPT_ON, COLOR_BLUE);
 	g_free(desc);
 
 	/* If disconnected, return to main menu */
@@ -1901,7 +1901,7 @@ int main(int argc, char *argv[])
 
 	bt_shell_init(argc, argv, &opt);
 	bt_shell_set_menu(&main_menu);
-	bt_shell_set_prompt(PROMPT_OFF);
+	bt_shell_set_prompt(PROMPT_OFF, NULL);
 
 	if (!config_dir) {
 		char *home;
diff --git a/tools/obexctl.c b/tools/obexctl.c
index 56a76915cd93..6ca1b74f6301 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -33,8 +33,7 @@
 #define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
 #define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
 
-#define PROMPT_ON	COLOR_BLUE "[obex]" COLOR_OFF "# "
-#define PROMPT_OFF	"[obex]# "
+#define PROMPT		"[obex]# "
 
 #define OBEX_SESSION_INTERFACE "org.bluez.obex.Session1"
 #define OBEX_TRANSFER_INTERFACE "org.bluez.obex.Transfer1"
@@ -64,13 +63,13 @@ struct transfer_data {
 static void connect_handler(DBusConnection *connection, void *user_data)
 {
 	bt_shell_attach(fileno(stdin));
-	bt_shell_set_prompt(PROMPT_ON);
+	bt_shell_set_prompt(PROMPT, COLOR_BLUE);
 }
 
 static void disconnect_handler(DBusConnection *connection, void *user_data)
 {
 	bt_shell_detach();
-	bt_shell_set_prompt(PROMPT_OFF);
+	bt_shell_set_prompt(PROMPT, NULL);
 }
 
 static char *generic_generator(const char *text, int state, GList *source)
@@ -404,15 +403,15 @@ static void set_default_session(GDBusProxy *proxy)
 	default_session = proxy;
 
 	if (!g_dbus_proxy_get_property(proxy, "Destination", &iter)) {
-		desc = g_strdup(PROMPT_ON);
+		desc = g_strdup(PROMPT);
 		goto done;
 	}
 
 	dbus_message_iter_get_basic(&iter, &desc);
-	desc = g_strdup_printf(COLOR_BLUE "[%s]" COLOR_OFF "# ", desc);
+	desc = g_strdup_printf("[%s] #", desc);
 
 done:
-	bt_shell_set_prompt(desc);
+	bt_shell_set_prompt(desc, COLOR_BLUE);
 	g_free(desc);
 }
 
@@ -2152,7 +2151,7 @@ int main(int argc, char *argv[])
 
 	bt_shell_init(argc, argv, NULL);
 	bt_shell_set_menu(&main_menu);
-	bt_shell_set_prompt(PROMPT_OFF);
+	bt_shell_set_prompt(PROMPT, NULL);
 
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
 
-- 
2.47.0

