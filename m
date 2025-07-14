Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7723717C
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525339; cv=none; b=IhXvZ1Aynf3FMojoS0ENrEOxf+uB8Q/CLMJC29uKiunEaFqsKEaH2tzgwq2ZZ+jBLt0QieI7T6Gh125Ul+QcMOHmavLkfhy5CAddgV2bMxfKuUdQKANFaSnBPF3YZZZZ/waFjAGTUIP/FW975vN8fR5V4hJWNPr7Mk/XuNQxbzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525339; c=relaxed/simple;
	bh=Vj4FN4JbnQXWonZycy3KE7yDLl9S5K6z5YvEXcIPx7g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZNOoyYaO0+5x9HJx8qhTQzY4XUbIGYK/en5ZGCE7py/MHrUkN8WY64cOArjXZn9N/wg8SVGTDcAI/xuY3cHle1F1uLPvgFn6qLx2x44tc50ZnFQ7HnwIFtGQQ2kGst5eycZaFPHdpVGfSd8e1L8ULJjEPd1v+XZycw9bYq0zkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTSgnX7D; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTSgnX7D"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-87f4c8e9cdcso1974492241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 13:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752525334; x=1753130134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZDhYtBuavK4sULNgKBwvI4z2pQ1PJefjE7Dvd2pLiw=;
        b=CTSgnX7DHMj8xbMYsISgKjuDG6LOzAVwS+l0gPs4Eb+U2/bGF1XzWd6jyrHb7NlA1p
         y4057rnJtcAdAPDSOoqKTN638CeM9LUcROHB+dZ864OKHDtBc3T/tkSq1Y4kfSWAdfT7
         MzsiHsszbLq5JTCicDbD+kNzY3Jo6grwdKWOMdWb+TePbLv0tLEtfZWv5HeXkc8IxQqn
         cQZMpopg1RIz8KCJW332xOUge0Oep8FYSD+uitZxYtOioEs2rZnoboaSq8woqm0ArjTB
         I6Kf+pG6pT8YQtcLUFsIcFRlFlVJSEU5ekhOPqCHyCrublbHM0QTgOfhO+OWEe5MfrfD
         aiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752525334; x=1753130134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZDhYtBuavK4sULNgKBwvI4z2pQ1PJefjE7Dvd2pLiw=;
        b=XMszmZhnSwfEpyhV0KQ2ug9E5BoYpzCGYqn5uCU5bBtplSSwGHBjbnVI0d+QHz7X4l
         G4ACwB5NhBoMJ+7yjOGsLAhsm/T2L4bti7KklZ1Q6jRNK74KSNqTJ6bCCdFIRJCYu4I8
         1aVDBky3uH/1N/csEO5CjIps34JWjGnveaHBmBz4WqjNHfDT3OYTdvmXPmxq6puAWM53
         Q5GIqwJbDCzpFxPm20V3yOlUMtPtYXHXBe83Wz1gSDZNNk/TOzo1kb/l6SDyJTI5dfn/
         Qu7HCgnVtDPRRw+fb2a1PHVwPVl+RKE4wKGswOuL0N7jY0rbsoz9oLpQGTGECgm7Q6X3
         ARjg==
X-Gm-Message-State: AOJu0YymTmIcRnuSAyE9TD+liSSo4NfdnQIhKZaoLnkrgFGyfop7Gz9R
	7BdkCFc4bGZEU3pPLJUQWkKQ6O+TG8HsB8qVO57dGOXAd8vnNd2tAUk82M+WcMLD
X-Gm-Gg: ASbGncuiQQPQ/8YfOTyzat1zFHcL20lPvtfcNC+SgCBMhMwQNC0cCSAKjgUS7uuFatS
	veJUxgmGRW4KN6U6pa6k5QynXdBrU6heswYgBrCTY1QH6AfWvbBDMqzDqKv0kT5n0EFlnz4AGzz
	BZo2jE2rO7SgRTLsEcZV3VZcKdGv6fFNItRgSRBYPYwCm0WjTb4u8oNUXENKB9/kKUITHhL2Hlt
	qGfv0FEPg6MZefRKFcuxpkYQCmGmDCQ22uIzAjN6geRvDhmJOZWut5ZVXxoXHcKlTYN2nm7VrXj
	drFs7BMXnd4gQtxY2fSy2SxWB5g7JkH6R2dWjvxrtEpWuN9pLV4ysM21NEBpf5ip8TwG7NmF+qQ
	oP3a9ztfy2yRbQhyJxr/LPTEgPWnLzQ6mxjTd4D/4vYdiWTAjChs/NshBML7uddKk
X-Google-Smtp-Source: AGHT+IHsy8Pwp3FIkQTD/GgoUrXykU5gafny6QBhllm1RhGaOLW9DkABAJ+P0M+45R8NwyQBcbwYMg==
X-Received: by 2002:a05:6102:50a8:b0:4e5:980a:d164 with SMTP id ada2fe7eead31-4f6403c47bbmr8929348137.0.1752525333711;
        Mon, 14 Jul 2025 13:35:33 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-888ec44a6f6sm1887177241.24.2025.07.14.13.35.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 13:35:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] client: Add support for org.bluez.Bearer.{BREDR, LE}1
Date: Mon, 14 Jul 2025 16:35:18 -0400
Message-ID: <20250714203519.345226-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714203519.345226-1-luiz.dentz@gmail.com>
References: <20250714203519.345226-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for printing properties related to
org.bluez.Bearer.{BREDR, LE}1:

> info XX:XX:XX:XX:XX:XX
...
	BREDR.Paired: yes
	BREDR.Bonded: yes
	BREDR.Connected: no
	LE.Paired: yes
	LE.Bonded: yes
	LE.Connected: no
...
[CHG] BREDR XX:XX:XX:XX:XX:XX Connected: yes
---
 client/main.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index d99a5158e35a..09df7b37c46f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -58,6 +58,7 @@ struct adapter {
 	GDBusProxy *adv_monitor_proxy;
 	GList *devices;
 	GList *sets;
+	GList *bearers;
 };
 
 static struct adapter *default_ctrl;
@@ -452,6 +453,36 @@ static void set_added(GDBusProxy *proxy)
 	bt_shell_set_env(g_dbus_proxy_get_path(proxy), proxy);
 }
 
+static void print_bearer(GDBusProxy *proxy, const char *label,
+					const char *description)
+{
+	bt_shell_printf("%s%s%s%s %s\n",
+				description ? "[" : "",
+				description ? : "",
+				description ? "] " : "",
+				label,
+				g_dbus_proxy_get_path(proxy));
+}
+
+static void bearer_added(GDBusProxy *proxy)
+{
+	struct adapter *adapter = find_parent(proxy);
+
+	if (!adapter)
+		return;
+
+	adapter->bearers = g_list_append(adapter->bearers, proxy);
+
+	if (!strcmp(g_dbus_proxy_get_interface(proxy),
+			"org.bluez.Bearer.BREDR1"))
+		print_bearer(proxy, "BREDR", COLORED_NEW);
+	else if (!strcmp(g_dbus_proxy_get_interface(proxy),
+			"org.bluez.Bearer.LE1"))
+		print_bearer(proxy, "LE", COLORED_NEW);
+
+	bt_shell_set_env(g_dbus_proxy_get_path(proxy), proxy);
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -489,6 +520,10 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		admon_manager_added(proxy);
 	} else if (!strcmp(interface, "org.bluez.DeviceSet1")) {
 		set_added(proxy);
+	} else if (!strcmp(interface, "org.bluez.Bearer.BREDR1")) {
+		bearer_added(proxy);
+	} else if (!strcmp(interface, "org.bluez.Bearer.LE1")) {
+		bearer_added(proxy);
 	}
 }
 
@@ -540,6 +575,7 @@ static void adapter_removed(GDBusProxy *proxy)
 			ctrl_list = g_list_remove_link(ctrl_list, ll);
 			g_list_free(adapter->devices);
 			g_list_free(adapter->sets);
+			g_list_free(adapter->bearers);
 			g_free(adapter);
 			g_list_free(ll);
 			return;
@@ -560,6 +596,19 @@ static void set_removed(GDBusProxy *proxy)
 	bt_shell_set_env(g_dbus_proxy_get_path(proxy), NULL);
 }
 
+static void bearer_removed(GDBusProxy *proxy)
+{
+	struct adapter *adapter = find_parent(proxy);
+
+	if (!adapter)
+		return;
+
+	adapter->bearers = g_list_remove(adapter->bearers, proxy);
+
+	print_set(proxy, COLORED_DEL);
+	bt_shell_set_env(g_dbus_proxy_get_path(proxy), NULL);
+}
+
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -602,6 +651,10 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		adv_monitor_remove_manager(dbus_conn);
 	} else if (!strcmp(interface, "org.bluez.DeviceSet1")) {
 		set_removed(proxy);
+	} else if (!strcmp(interface, "org.bluez.Bearer.BREDR1")) {
+		bearer_removed(proxy);
+	} else if (!strcmp(interface, "org.bluez.Bearer.LE1")) {
+		bearer_removed(proxy);
 	}
 }
 
@@ -619,6 +672,20 @@ static struct adapter *find_ctrl(GList *source, const char *path)
 	return NULL;
 }
 
+static GDBusProxy *find_proxies_by_path(GList *source, const char *path)
+{
+	GList *list;
+
+	for (list = g_list_first(source); list; list = g_list_next(list)) {
+		GDBusProxy *proxy = list->data;
+
+		if (strcmp(g_dbus_proxy_get_path(proxy), path) == 0)
+			return proxy;
+	}
+
+	return NULL;
+}
+
 static void property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -703,6 +770,36 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 		print_iter(str, name, iter);
 		g_free(str);
+	} else if (!strcmp(interface, "org.bluez.Bearer.BREDR1") ||
+			!strcmp(interface, "org.bluez.Bearer.LE1")) {
+		if (default_ctrl &&
+				proxy_is_child(proxy, default_ctrl->proxy)) {
+			DBusMessageIter addr_iter;
+			GDBusProxy *dev;
+			char *str;
+			bool le = !strcmp(interface, "org.bluez.Bearer.LE1");
+
+			dev = find_proxies_by_path(default_ctrl->devices,
+						g_dbus_proxy_get_path(proxy));
+			if (!dev)
+				return;
+
+			if (g_dbus_proxy_get_property(dev, "Address",
+							&addr_iter)) {
+				const char *address;
+
+				dbus_message_iter_get_basic(&addr_iter,
+								&address);
+				str = g_strdup_printf("[" COLORED_CHG
+							"] %s %s ",
+							le ? "LE" : "BREDR",
+							address);
+			} else
+				str = g_strdup("");
+
+			print_iter(str, name, iter);
+			g_free(str);
+		}
 	}
 }
 
@@ -753,14 +850,17 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
 	return NULL;
 }
 
-static GDBusProxy *find_proxies_by_path(GList *source, const char *path)
+static GDBusProxy *find_proxies_by_iface(GList *source, const char *path,
+							const char *iface)
 {
 	GList *list;
 
 	for (list = g_list_first(source); list; list = g_list_next(list)) {
 		GDBusProxy *proxy = list->data;
 
-		if (strcmp(g_dbus_proxy_get_path(proxy), path) == 0)
+		if (!strcmp(g_dbus_proxy_get_path(proxy), path) &&
+				!strcmp(g_dbus_proxy_get_interface(proxy),
+					iface))
 			return proxy;
 	}
 
@@ -1728,6 +1828,7 @@ static void cmd_info(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 	GDBusProxy *battery_proxy;
+	GDBusProxy *bearer;
 	DBusMessageIter iter;
 	const char *address;
 
@@ -1779,6 +1880,25 @@ static void cmd_info(int argc, char *argv[])
 	print_property_with_label(battery_proxy, "Percentage",
 					"Battery Percentage");
 
+	bearer = find_proxies_by_iface(default_ctrl->bearers,
+				      g_dbus_proxy_get_path(proxy),
+				      "org.bluez.Bearer.BREDR1");
+	if (bearer) {
+		print_property_with_label(proxy, "Paired", "BREDR.Paired");
+		print_property_with_label(proxy, "Bonded", "BREDR.Bonded");
+		print_property_with_label(proxy, "Connected",
+							"BREDR.Connected");
+	}
+
+	bearer = find_proxies_by_iface(default_ctrl->bearers,
+				      g_dbus_proxy_get_path(proxy),
+				      "org.bluez.Bearer.LE1");
+	if (bearer) {
+		print_property_with_label(proxy, "Paired", "LE.Paired");
+		print_property_with_label(proxy, "Bonded", "LE.Bonded");
+		print_property_with_label(proxy, "Connected", "LE.Connected");
+	}
+
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-- 
2.50.0

