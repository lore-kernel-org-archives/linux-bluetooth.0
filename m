Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B9371876
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920763; cv=none; b=JKmm0/sPuXogoBR2GIG5CXWUn2oyYlr8oNhuL+gDymFcwbttlrG1VylEM0G1ZbBPosnVjNOCy5Di/WdeqrhhxM9w5Blu+W6HTPK7KFQojoN1ZkO19qcOYinh9e6Wm7ZaS+jMFc8D+tbNifhphq1LHxmMg9CK6YjTnZyjmS5b+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920763; c=relaxed/simple;
	bh=86J+eFE1bDy6G8hYPbAU2HpM3XVModZMkH2bMzzsymI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqnTyzYVi2bANkpUAkLg9+YkpfpPihSCliLzfrgg/2LgZyPjgu3s3nJg67dQoWgixuu+SU2pzznILVPjBVjss+yS9+MyXFFu8R3uUSt1Emj2QS0BWUTCYpkzZAYx2nKzgv5MbMkNr89bqyQsw8R0+9sMZviJLa4+76M+qLtS85U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=g2PW9ST4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="g2PW9ST4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so8265525e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 05:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780920759; x=1781525559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLAtDG1zp36QUZcsSX5UT6nKo4edcwss8vaUuCQDJBg=;
        b=g2PW9ST43bZ0Rc9/F1SXZk42ZLr0+aCZVBX21ywRd+wbLXBJSYAuZ827pdJFBZklSO
         BgAevacT02xqTlWPxaIWdVcCVxk5TAt6jNSxSPf86XrJ0CGOgnzdOVvovm5efIVTxpsQ
         FKmS9bGvkXiYcms3RpeTKWokpQFDFH/zuQets=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920759; x=1781525559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vLAtDG1zp36QUZcsSX5UT6nKo4edcwss8vaUuCQDJBg=;
        b=FMiipg7odHWdQNerOxublG03GZ9HALJK9XoStb1ru7hA8YKeStQ+MZu2IoxIifBX0S
         BVAAxN+aDpCicwaq8Iavs1yvauUBhFnPR27jx0q8G7gML8Y50M9q7MVmJVQPmhnZkd4h
         jlNosT2A6v3yrXr8EKW5YhbOUZCXFe3pG6cGQ6MHqqKCpRTkBb+gGSwYPMYzuQ9cfkSt
         PDV8ujZu55rtooD9xpWQgetZMeXKUwJIeLRqd24KSMVcVWbHGlMr5+8vBlYPZnWiekTH
         TSPqb20giEGGekwplCTFeCDu2PMKSBZoXJ3uWoZmFynK1TZp7hDOo2TEWPkFYY0OCvCa
         sh+Q==
X-Gm-Message-State: AOJu0YyipYppRd3ZIWf44b4jijBHnz3UeAeeAIY0bVK7j8snEEDW1yNn
	jSUtbVztPbB5meXKBq6PQUqq1OqoC4hPyBxQLiUbQ4Zk6Rg7hHokDf4I4mWTOeAaC+9sOrmp08S
	cNMIn
X-Gm-Gg: Acq92OHEwOMb6belDPDF7WauiG2BszF8/HElJtlYswUt00fpFAyTQ13BSeEIk0KoriN
	9s270cEPzefZ5FUC1ICRnQIoZH6mxmB2Os2cHp1LZr9gCn6IxxQoJLw0Om9Pm+XEwnDgt6O4+dn
	EnxZXkJcKaVhq1nhP05510mfOlmbLo8Ikf2eiyNJbJRMiFwBkMukbHzjenyJu43KYwROhszPKIe
	TLE5D7P8BXmPKTVYfBpmWyPGo05TEAsiJ5BaKkz0biB7fAZC6mGmh3C4j+c5KvdhsG63iGeGDYt
	7mHK2zffQFzGEjLjEeGR1nJQX3tAyURbeqkZNhx44HD9GEgKj4UeIQd1qxMR65ZdmAqhxwdxhkZ
	1cHDrXQW/m7W8MecepWXV1ZPLrdPGOO3laq7PbJnQJyY2Flbyxzb4nOUljeFbFbkH3I7YXHUhXI
	0Uwk4HScj4ASFyWNKWKV8YpOFEjE+uY/5xGUNERM99Djo1bF4WcD9hRQ==
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-490c260f3cdmr249168835e9.27.1780920759395;
        Mon, 08 Jun 2026 05:12:39 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d6c65sm381234765e9.12.2026.06.08.05.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:12:39 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] client/player: Add get-config command
Date: Mon,  8 Jun 2026 14:12:25 +0200
Message-ID: <20260608121226.3727101-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608121226.3727101-1-simon.mikuda@streamunlimited.com>
References: <20260608121226.3727101-1-simon.mikuda@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/player.c                 | 57 +++++++++++++++++++++++++++++++++
 doc/bluetoothctl-endpoint.rst   | 11 +++++++
 doc/org.bluez.MediaEndpoint.rst | 13 ++++++++
 3 files changed, 81 insertions(+)

diff --git a/client/player.c b/client/player.c
index c5e4beef0..e0477c538 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4571,6 +4571,60 @@ enter_cc:
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void get_config_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+	DBusMessageIter iter, array;
+	uint8_t *data;
+	int len, i;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to get configuration: %s\n",
+								error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!dbus_message_iter_init(message, &iter) ||
+			dbus_message_iter_get_arg_type(&iter) !=
+							DBUS_TYPE_ARRAY) {
+		bt_shell_printf("Invalid GetConfiguration reply\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	dbus_message_iter_recurse(&iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &data, &len);
+
+	bt_shell_printf("Configuration (%d bytes):", len);
+
+	for (i = 0; i < len; i++)
+		bt_shell_printf(" %02x", data[i]);
+
+	bt_shell_printf("\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_get_config_endpoint(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	proxy = g_dbus_proxy_lookup(endpoints, NULL, argv[1],
+						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Endpoint %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "GetConfiguration", NULL,
+				get_config_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to call GetConfiguration\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static const struct bt_shell_menu endpoint_menu = {
 	.name = "endpoint",
 	.desc = "Media Endpoint Submenu",
@@ -4591,6 +4645,9 @@ static const struct bt_shell_menu endpoint_menu = {
 						cmd_config_endpoint,
 						"Configure Endpoint",
 						endpoint_generator },
+	{ "get-config",   "<endpoint>", cmd_get_config_endpoint,
+						"Get Endpoint Configuration",
+						endpoint_generator },
 	{ "presets",      "<endpoint>/<UUID> [codec[:company]] [preset] "
 						"[codec config] [metadata]",
 						cmd_presets_endpoint,
diff --git a/doc/bluetoothctl-endpoint.rst b/doc/bluetoothctl-endpoint.rst
index 019e64e38..b8277dd57 100644
--- a/doc/bluetoothctl-endpoint.rst
+++ b/doc/bluetoothctl-endpoint.rst
@@ -154,6 +154,17 @@ Note:
 If the endpoint was registered by an audio server, it can't be configured from bluetoothctl.
 This must be done by the audio server as well.
 
+get-config
+----------
+
+Get Endpoint Configuration.
+
+:Usage: **> get-config <endpoint>**
+:Uses: **org.bluez.MediaEndpoint(5)** method **GetConfiguration**
+:<endpoint>: Path to the remote endpoint to query
+:Example Get configuration of remote endpoint:
+	| **> get-config /org/bluez/hci0/dev_00_11_22_33_44_55/sep1**
+
 presets
 -------
 
diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index d1b9c8114..7518caf25 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -96,6 +96,19 @@ Examples:
 
 :bluetoothctl: > endpoint.config <endpoint> <local endpoint> [preset]
 
+array{byte} GetConfiguration()
+``````````````````````````````
+
+Retrieve the current configuration of the remote endpoint.
+
+Sends an AVDTP GET_CONFIGURATION command to the remote endpoint and returns
+the configuration as a raw byte array containing AVDTP service capabilities.
+
+Possible errors:
+
+	:org.bluez.Error.NotAvailable:
+	:org.bluez.Error.Failed:
+
 array{byte} SelectConfiguration(array{byte} capabilities)
 `````````````````````````````````````````````````````````
 
-- 
2.43.0

