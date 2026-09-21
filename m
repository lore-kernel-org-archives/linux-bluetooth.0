Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3350B8A9
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024540; cv=none; b=eIMML9GSLbERU11WoCjafW64NxelmqoWZeM9lIRbhB2gc7vYRE9WP3kOYcbcU988R/ez+sRzKMw7KgThPA9iz3jNrMiwP2PCz3W7c7CcnUvTKzvbMMj2Co3+vd42ViiTVF1CmWwEvE0D2lUXH79LcLPZWaZJQTQiDvX5hlJuG1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024540; c=relaxed/simple;
	bh=Qmk8kzlTTjNlRyx8WgE6pAi8Pnc8ePAKwHRPgsAfFx0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izrT2RzP0MQK7VCcxjdfVS6keCWWGCFaE9HTT0KIKsZg58PRQGprR+FeQC41BJb9co4Axr8NT12m9594hhnb4fcn+OlTXn4LjsjcVkWdhbn9lllWbBdWabw0sxkNr2OphegGhL79q42YGCkwFvHJK87zl/bQ23d8CXDw7dV6S6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSfoVZg0; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSfoVZg0"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c67e512ee5so1275111e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790024538; x=1790629338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z/e8Wt4o+d6Sp//yKpzVYk47Inn57wJlTBhgQrRkF3s=;
        b=hSfoVZg0/rSlrRrOa6lDtfx5XMJagURu6Q7DbLSWPIY3wSHHdJvT2ynqiuqaNU+tMi
         6ggwFeF3xwPACUIfz7vQT2UW7yXPliGmGfIt1Rwu3ZAgBT+9mQ3XBIyYBMG8Xb/tfULz
         /RtIgO88tSY+ktvUcmwP7VLGpt7LlvzGmfHLD2TMngIUoOY+PjB/Bw+KmW51BDvhdVrb
         JYVUqiyRZJvfKgw5WrOO/IjtCRk557v+xmebgLdKk/CoBwV6GUihca+NdAXIgNzyDddt
         05Byg2+5lm2Ppy0pfA2yE/MeCRlVev0fr4Z/mlp0BouYhHbIUA1rjGqzzRmUAp2Qy7gJ
         yn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024538; x=1790629338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z/e8Wt4o+d6Sp//yKpzVYk47Inn57wJlTBhgQrRkF3s=;
        b=FcCA1dU4OwNUE5tX1DAOUmVLYJJqnncYPBx8aZA+5S/a36xW7WFpACDoEourSzMlOJ
         qkg7QeQnAAyRA6WtLC7i9DXkx04VT04xyaSlPQxtglvAl5i6C8I3r+QqZHlOd1T5Pa0f
         iiQbAXTm5RQHQhswHXlzEl0C5qdppsxPSpF3u216JFnO72YQDNkjjRh9DQCQzE9dB2Yp
         p5cgh4TKl8yGlHhSnNr5c0G6Qu77MhK/8GDEAVlxn5+xzcU2GKATdbM4Lmh3DBJiqRgd
         zmN2JAxYH9OGErf8ublDkMqjz7QFDR8zf12aL2uEXHj521aZNs9eW0CbwrHkbu6WY1Ug
         ONXQ==
X-Gm-Message-State: AFuF++kj06ySkT85pF9iH+1Y99JZM/qZLOLhdlkkdEM2DVcpi8x9eeii
	p5qPfOfeCrroDYfE1W3MKPT/ZDiJb5Cw+Hq4DdG9W28TDaLuDm9giuRmMPbWjIyD
X-Gm-Gg: AYBFou2bbLYV45hb+174BwO1yTDeYqvlGSxcq3UwdzT1Ht4m/f99i433uXSWCcvTra8
	ICO0iufO192Ff75yQU+0cDCsX3yanFpi+Zhn34z3H/X6jr+hAVXdCioubv/G8axiR+LHBFRjCH1
	ZKdCFPy6nkSz43fUhzHWWUN+5mml0J+KIENvzpgQ6o++UzIV/mODrmLdvSwF9jsvUZAGXzQKea/
	wpVQN78Z2FuvhLg9QUpyJZmPADzaqxPBonIY/ptSOlntnlQkpJ1ziHVP1kIWhlt7LbT3RWEK9XY
	FUniz3u+W9+BRS2CBe6h+kHB7+NOKc7zNhUjI1R8LNUxziFJdOJsmeSDitH+tZNIYEeC5LpOv1k
	VnkAh7sTfKqDGA0lBdaq+9CnA0XaQ1h5u0/RdM93U1SG58fL60Ofi+WdEXVBsgKLQNEEdqeKKrF
	pl9o0I9O3qnA/w+nbVm8iWxtqfseyOs+XulnHywCZpZO5hzLW5p2vtAD1dCXG9iJ3/XUoQKBybL
	VimXSceX+6ASJUviSMFN7a6eH9ygW4HegA5a9Ww/j1BjfrCe5gTXcF5YY6hqnUP
X-Received: by 2002:a05:6122:1d9f:b0:5c8:2ad8:1484 with SMTP id 71dfb90a1353d-5c9b58b9184mr7194665e0c.1.1790024506898;
        Mon, 21 Sep 2026 14:01:46 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9850c318641sm83527241.9.2026.09.21.14.01.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:01:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/6] client: connect a device that is already paired
Date: Mon, 21 Sep 2026 17:01:22 -0400
Message-ID: <20260921210123.3690449-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921210123.3690449-1-luiz.dentz@gmail.com>
References: <20260921210123.3690449-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Pairing a device that is already paired is rejected by the daemon with
AlreadyExists, which is of no use to the user: the bond asked for is
already there, and what pairing it anew takes is removing it first.

Connect it instead, telling what happened, so pairing a device is a way
of getting to it whether it is known already or not.

The documentation already described this behaviour, though as removing
the pairing first, which is not what happened either.

Assisted-by: opencode:claude-opus-5
---
 client/main.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 doc/bluetoothctl.rst |  6 ++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index 3fef1e9a5179..314aead8c9bb 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2068,6 +2068,9 @@ static void cmd_info(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static const char *proxy_address(GDBusProxy *proxy);
+static void connect_device(GDBusProxy *proxy);
+
 static void pair_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
@@ -2101,11 +2104,31 @@ static const char *proxy_address(GDBusProxy *proxy)
 static void cmd_pair(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
+	DBusMessageIter iter;
+	dbus_bool_t paired;
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
+	/* Pairing a device that is already paired is rejected with
+	 * AlreadyExists, so connect it instead: the bond is there, which
+	 * is what pairing it again would be for, and removing it first is
+	 * what actually pairs it anew.
+	 */
+	if (g_dbus_proxy_get_property(proxy, "Paired", &iter)) {
+		dbus_message_iter_get_basic(&iter, &paired);
+
+		if (paired) {
+			bt_shell_printf("Device %s is already paired, "
+					"connecting instead, remove it first "
+					"to pair it again\n",
+					proxy_address(proxy));
+			connect_device(proxy);
+			return;
+		}
+	}
+
 	if (g_dbus_proxy_method_call(proxy, "Pair", NULL, pair_reply,
 							NULL, NULL) == FALSE) {
 		bt_shell_printf("Failed to pair\n");
@@ -2365,6 +2388,23 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void connect_device(GDBusProxy *proxy)
+{
+	struct connection_data *data;
+
+	data = new0(struct connection_data, 1);
+	data->proxy = proxy;
+
+	if (g_dbus_proxy_method_call(proxy, "Connect", connection_setup,
+					connect_reply, data, NULL) == FALSE) {
+		bt_shell_printf("Failed to connect\n");
+		g_free(data);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to connect to %s\n", proxy_address(proxy));
+}
+
 static void prompt_scan_connect(const char *input, void *user_data)
 {
 	char *address = user_data;
diff --git a/doc/bluetoothctl.rst b/doc/bluetoothctl.rst
index cc58e1f5be19..23f92a512911 100644
--- a/doc/bluetoothctl.rst
+++ b/doc/bluetoothctl.rst
@@ -207,7 +207,8 @@ pair
 Pair with device.
 
 This will pair with a device and then trust and connect to it. If the device is
-already paired this will first remove the pairing.
+already paired this will connect to it instead, as the bond is already in
+place: use **remove** first to pair it again.
 
 The command can either be used while the controller is in the connected or not
 connected state.
@@ -221,7 +222,8 @@ Before pairing the agent must be selected to choose the authentication
 mechanism.
 
 :Usage: **> pair [dev]**
-:Uses: **org.bluez.Device(5)** method **Pair**
+:Uses: **org.bluez.Device(5)** method **Pair**, or **Connect** if the device is
+	already paired
 :[dev]: Device MAC address (XX:XX:XX:XX:XX:XX) (optional, uses current device if omitted)
 :Example Pair with device using MAC address:
 	| **> pair 00:11:22:33:44:55**
-- 
2.55.0

