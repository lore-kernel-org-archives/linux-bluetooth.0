Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970F111AD
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Mar 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740934067; cv=none; b=qvook5IVTyGSty2P2f2ebeAMUvlgutW3ZGy8SGCpqa9TPM86f+dJGnzyWL3k07RrclnHmVUcl5cBVSiyzPXgsWDpacB3+fDPV/0jWkTbS9w5r8s/7tMGIcJVrofMRDMV5JYjHn5FRj9VZBRfr7lQqLfg/H4Yu7s6oVlxAL40UWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740934067; c=relaxed/simple;
	bh=3si7UWlPyjXhGgsRSz/VCn+Zaj49hdHa0e/XxcIyXQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uLAr4XDrQYsqYLawvw2TkQ4omGr/WPQphcyZyLLcZh2Pa5G0i/JZuoq92XLw4Cv/ckKiK8N1R8bwMfqkHwUUyrM47eDFC3QDZDNRNtmzdtikg485xKUIaTsyJ/j9ySQSIflGSplTVR8n8AGcfQuDDTekH1Td+9bWAFInKTLWLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KocJICQ2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KocJICQ2"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso5573699a12.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Mar 2025 08:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740934064; x=1741538864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X0kHmsu9327PgQWecyEE6nd87H2WEenP+zrK7c1GCLw=;
        b=KocJICQ2Heri5GbNgzuF5o6dnVEyM2y9vUG15QgZSmif70epBLKcamFYvbhhXEi3Tu
         AZc+x/RlAEiQGUmE2o/tzpLJyCkV0HUWEk6q9pZJ0HKAJ45RF/OWWHqUU/TPJMBahJfb
         2MoEjETBSicY3xxVxSzsa15Ns9QiCMcSbhDhn/Cwrq+Q6LAXTsgJMcGd9eBF+REzFO0y
         S7ziRDSUqg1phHEMkUqgboYlc5SkmRycSSjXVJUQp+pODMyjUrSyKb8QRF2hUdfqOLpA
         NJo7lr6+gjTz2C9bH5ZB+uakoJBBxvMJ36W19P+XTM0EJUnLrjx4QhdtVFPkdbeeNDuF
         6kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740934064; x=1741538864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0kHmsu9327PgQWecyEE6nd87H2WEenP+zrK7c1GCLw=;
        b=W7mY0Mr6P/l8t243B4vfaZO2RFfv2XG2ggFNO0JC7JLn4xPb7V61kRSw5owxxVH4Gs
         k54tlhOJuuIPBV3ATrnPDKxpGId2vmGgkJYqR5Wakchcd2d1mfbDtw3IJIC1AiGTTqGP
         CzJYOjOm0IDYMsq9pdk9RLQUWiO7NmFWqAid1lkA+LA/CJAqBymqm8EAznxxneJQFsQT
         C0jc2wQpI59MBIU33Opb67T5FmD+/jwiXx3m/J/tKWPkGVUV4hvCuVMiGKE51SeUgQRr
         H5K3YnwI66i63jqoUMcboNA68inx/qvhiunm95AxshSXmYn87iPafiTu2TQCLwsuazCJ
         nDGw==
X-Gm-Message-State: AOJu0YyEBKhYNgsRpaDAKFv0SYZtQEqwA+ja2T6Cq+BrsV+NrAc9QXL3
	/sTXv7mxYPVN1Shf/B3Kpu5d/6bc0Kvo2d2qNj208r5t+41H18r/Ha80I+8/
X-Gm-Gg: ASbGncukt23DddZ7A0e0tQZxTjQzU2w0MoZ+5BmL4+AGqFMulF2g6Y9qApVLT518qwp
	rois8NaF2jZ7u68sJwCZgF8SKs3rqU3eSiRM2ZdYaLe7NZdP4urnE/a4v8TF9y8aoYxwZombuFt
	3gSrDLkASSqHYTJu6rFiWFd7qn2gO+Y/iCDjSR1aMjWl80dsFSe8EfzgGhcKXOECzGaT3JBQnZo
	3eZuq2KpubZVR4K+9po0hQ0ionDmjSQPWJPLfKs85v8yPdubDip9HMiFUX89WnH/YdDKX6zrWgo
	qc+jrl92QJ5qkhBgWc7lMvCIOKW+PB2VbzY56un8gD3PELCEVRPOy0GFcPvwoqlaHBw2T64ophK
	QQlrAbABMrdB3/zKOp7hT8TmeL1PuD5j3yeNCgw==
X-Google-Smtp-Source: AGHT+IEhBdMkEOK5OTh3lTH94DKxzNLX9rR9pAJ+mLAPDNkrO8TqCx1OrCAsbPl8EakDjmYdFu9PQQ==
X-Received: by 2002:a05:6402:35cd:b0:5db:f5bc:f696 with SMTP id 4fb4d7f45d1cf-5e4d6ad3e14mr10641654a12.5.1740934063778;
        Sun, 02 Mar 2025 08:47:43 -0800 (PST)
Received: from localhost.localdomain (46.205.201.86.nat.ftth.dynamic.t-mobile.pl. [46.205.201.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51e1sm5808146a12.61.2025.03.02.08.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:47:43 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] client: Support single profile connection/disconnection
Date: Sun,  2 Mar 2025 17:47:36 +0100
Message-Id: <20250302164736.22101-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/main.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/client/main.c b/client/main.c
index feb21a116..e4ed692ec 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1969,13 +1969,44 @@ static void cmd_remove(int argc, char *argv[])
 	remove_device(proxy);
 }
 
+struct connection_data {
+	GDBusProxy *proxy;
+	char *uuid;
+};
+
+static void connection_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct connection_data *data = user_data;
+
+	if (!data->uuid)
+		return;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &data->uuid);
+}
+
+static void format_connection_profile(char *output, size_t size,
+							const char *uuid)
+{
+	const char *text;
+
+	text = bt_uuidstr_to_str(uuid);
+	if (!text)
+		text = uuid;
+
+	snprintf(output, size, " profile \"%s\"", text);
+}
+
 static void connect_reply(DBusMessage *message, void *user_data)
 {
-	GDBusProxy *proxy = user_data;
+	struct connection_data *data = user_data;
+	GDBusProxy *proxy = data->proxy;
 	DBusError error;
 
 	dbus_error_init(&error);
 
+	g_free(data->uuid);
+	g_free(data);
+
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to connect: %s %s\n", error.name,
 				error.message);
@@ -1991,6 +2022,9 @@ static void connect_reply(DBusMessage *message, void *user_data)
 
 static void cmd_connect(int argc, char *argv[])
 {
+	struct connection_data *data;
+	const char *method = "Connect";
+	char profile[128] = "";
 	GDBusProxy *proxy;
 
 	if (check_default_ctrl() == FALSE)
@@ -2002,31 +2036,49 @@ static void cmd_connect(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (g_dbus_proxy_method_call(proxy, "Connect", NULL, connect_reply,
-							proxy, NULL) == FALSE) {
+	data = new0(struct connection_data, 1);
+	data->proxy = proxy;
+
+	if (argc == 3) {
+		method = "ConnectProfile";
+		data->uuid = g_strdup(argv[2]);
+		format_connection_profile(profile, sizeof(profile), argv[2]);
+	}
+
+	if (g_dbus_proxy_method_call(proxy, method, connection_setup,
+					connect_reply, data, NULL) == FALSE) {
 		bt_shell_printf("Failed to connect\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_printf("Attempting to connect to %s\n", argv[1]);
+	bt_shell_printf("Attempting to connect%s to %s\n", profile, argv[1]);
 }
 
 static void disconn_reply(DBusMessage *message, void *user_data)
 {
-	GDBusProxy *proxy = user_data;
+	struct connection_data *data = user_data;
+	const bool profile_disconnected = data->uuid != NULL;
+	GDBusProxy *proxy = data->proxy;
 	DBusError error;
 
 	dbus_error_init(&error);
 
+	g_free(data->uuid);
+	g_free(data);
+
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to disconnect: %s\n", error.name);
 		dbus_error_free(&error);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_printf("Successful disconnected\n");
+	bt_shell_printf("Disconnection successful\n");
 
-	if (proxy == default_dev)
+	/* If only a single profile was disconnected, the device itself might
+	 * still be connected. In that case, let the property change handler
+	 * take care of setting the default device to NULL.
+	 */
+	if (proxy == default_dev && !profile_disconnected)
 		set_default_device(NULL, NULL);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -2034,19 +2086,31 @@ static void disconn_reply(DBusMessage *message, void *user_data)
 
 static void cmd_disconn(int argc, char *argv[])
 {
+	struct connection_data *data;
+	const char *method = "Disconnect";
+	char profile[128] = "";
 	GDBusProxy *proxy;
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
-	if (g_dbus_proxy_method_call(proxy, "Disconnect", NULL, disconn_reply,
-							proxy, NULL) == FALSE) {
+	data = new0(struct connection_data, 1);
+	data->proxy = proxy;
+
+	if (argc == 3) {
+		method = "DisconnectProfile";
+		data->uuid = g_strdup(argv[2]);
+		format_connection_profile(profile, sizeof(profile), argv[2]);
+	}
+
+	if (g_dbus_proxy_method_call(proxy, method, connection_setup,
+					disconn_reply, data, NULL) == FALSE) {
 		bt_shell_printf("Failed to disconnect\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_printf("Attempting to disconnect from %s\n",
+	bt_shell_printf("Attempting to disconnect%s from %s\n", profile,
 						proxy_address(proxy));
 }
 
@@ -3241,10 +3305,13 @@ static const struct bt_shell_menu main_menu = {
 								dev_generator },
 	{ "remove",       "<dev>",    cmd_remove, "Remove device",
 							dev_generator },
-	{ "connect",      "<dev>",    cmd_connect, "Connect device",
-							dev_generator },
-	{ "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
+	{ "connect",      "<dev> [uuid]", cmd_connect,
+				"Connect a device and all its profiles or "
+				"optionally connect a single profile only",
 							dev_generator },
+	{ "disconnect",   "[dev] [uuid]", cmd_disconn,
+				"Disconnect a device or optionally disconnect "
+				"a single profile only", dev_generator },
 	{ "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set wake support",
 							dev_generator },
 	{ } },
-- 
2.39.5

