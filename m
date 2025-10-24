Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BEE2F99BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338467; cv=none; b=Ok11YARX38vQrHNTyr0llx0evv9gh2qluRfi7lEaXLb2KxC4OVZaIp+WoIFtzOr89C4b0fnwfGvacL9/JtR9nQtk+4mUCbDql3iZTjh5CrBQqCi2MkatC+CghnfPtHsL+mFsFD1kpeabHZBC41VhBUTH1jZiBRuWBfzgBHYE+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338467; c=relaxed/simple;
	bh=fA0GuoijCjS0oOtIZeCgpCODQ1A6oSWtX05uIo7ZVmA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sq1aWbcCFHBNiHuHCniBvOvO4J3g18i30JawTOxJyXIjn5tYEFt2y+BHH6nebkiL/VTpJyP/9EhHQNAY2U8EtY4s0BmqfMOJz+H+0HEHi0y7bZD2fuGDgBfqzHIukQBBNwZ2Ubg3TtdRgUmCNEu/lTXRUJBiinMOv+ZZd6jBBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSymmjOf; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSymmjOf"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5563c36f6d4so2367092e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338464; x=1761943264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uB2cJcV3xbn+01Kt/AEWbmXsiLdladuS5OeoUSa8CZ0=;
        b=LSymmjOfrMcVlrzUPsXDrUDSTM8Gv9Qa5GgK6/yMXqHuP2bE0K9FcLG5ptE4j8uGo6
         oCi5JWc6qNLZU6sLHDFszg6upd8VDox4bkRqlDFBWF0Ks0mKJgBFIvsVS4T1UN6fCUhy
         l51fxyfzyg36hwyUPKPlnAknQtRN29FTpfUnt2zvN6xwzL3uyS1ZHJ11A/rCVQPWjRls
         53bMvy6FgcGtA1l9cQJd88lcG3W/5bJB1jfmiei0p6jLr5KL1+2hf1uub3SP4ZAppRg1
         JPySPnLYsctHN+B8FlFRlomDYqCQ5BNObE1rDhsIK9iZ7J1Xwile4aQ+no7mWlnv6g+Z
         wRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338464; x=1761943264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB2cJcV3xbn+01Kt/AEWbmXsiLdladuS5OeoUSa8CZ0=;
        b=vWELrEBhg32K6J/3wqKgZLHMHqbdT5GKLtorV4LfOHvJc+s+46AAjXvVS7jCS3FLY6
         BamPLxXPeKHDaQyHrjpcmGlP1siQyTgW7j2Xye6sY1eJKGg6xJrGeUCL2xDSmu9x53fJ
         8xz2reC6v/qx8ZvTGAJ9nqKlgTugDpgWotsqfQK/BSsNPatTv4p4bkLRUMO07z14j36m
         ut1EcPKYNwK9teu//SAjSlSTvLVripTtQjK7fY+HUoQJ1OvRyFIwKgwWVvcRknOwdCr/
         vvCALsmuWPZhaOgWft4Pu0sEzePFx8ojPFdbO7RGcAJByrohGI3rGZ1F2yY6gOyaC5LZ
         VP+A==
X-Gm-Message-State: AOJu0Yz+fMwzxHM5Pdw3D4u4Si+h9sYpQmJdfVHhwbgfONP3egm5RH3v
	uBP2YjJZxtl0xAvIQftjvgmO/zeETw6YgMARZRon3eGIXtnu/Q/SKMGHOSRhlA==
X-Gm-Gg: ASbGncucpIwx0qVqiu/bRlxslqJbc0iFlAVIEKCJZ1OGFSpsKshbygbqVm8IJPy0Lsv
	j0xyONiqZ9BjOmjdHp3+8hPuYT5/g65BKQVqede0L0JK5gwXGRGsp94Ts0d3JpjPncLV0RGJvRh
	TZLzY6qEYb3bX98z0pZx2N+9H0z4bW7ytVFgXum8QGDKErjI6t5nFrqAjHHbavoLOJMAb9HpDTc
	FBuoaVGuhVehP+3UC7cW+fXMZzaFcdKFBXf01Otn0Dzz+pLdeiL+vkOmPJzEpQSOSdOfohE2Zno
	UQvf8VHdHGwpmFnTXFN4K61irQkhNfrfmGy/FekYq+Y0uyQBZ0U0zd6ZwFZ3pX5fnn27OVNAjEk
	8uCO5vT/LGBHhwfiTmUkEPO1szLDTDPgEComjtY48f4BDhTgMJhwPAylHaEk3/T9pZ0yWirYGJy
	sw9no=
X-Google-Smtp-Source: AGHT+IHg0gXn0g0Rz+g2QOGoJ8G0HWvgPVmNn9h1UbzY817boxP5854QjQc/kOwDtlPqgRZALZD6Ng==
X-Received: by 2002:a05:6122:3bce:b0:554:e726:7818 with SMTP id 71dfb90a1353d-557cda6154amr1452396e0c.2.1761338463696;
        Fri, 24 Oct 2025 13:41:03 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb2f98asm73501e0c.10.2025.10.24.13.41.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:41:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 09/12] client/assistant: Handle assistant.push to own broadcasts
Date: Fri, 24 Oct 2025 16:40:36 -0400
Message-ID: <20251024204039.693918-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024204039.693918-1-luiz.dentz@gmail.com>
References: <20251024204039.693918-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/assistant.c | 114 ++++++++++++++++++++++++++++++++++-----------
 client/mgmt.c      |   5 +-
 2 files changed, 92 insertions(+), 27 deletions(-)

diff --git a/client/assistant.c b/client/assistant.c
index 3551aaad8a16..1ff8001d7216 100644
--- a/client/assistant.c
+++ b/client/assistant.c
@@ -47,6 +47,8 @@
 
 struct assistant_config {
 	GDBusProxy *proxy;	/* DBus object reference */
+	char *state;		/* Assistant state */
+	char *device;		/* Device address */
 	struct iovec *meta;	/* Stream metadata LTVs */
 	struct bt_iso_qos qos;	/* Stream QoS parameters */
 };
@@ -223,6 +225,10 @@ static void push_setup(DBusMessageIter *iter, void *user_data)
 				DBUS_TYPE_BYTE, &cfg->meta->iov_base,
 				cfg->meta->iov_len);
 
+	if (cfg->device)
+		g_dbus_dict_append_entry(&dict, "Device", DBUS_TYPE_OBJECT_PATH,
+						&cfg->device);
+
 	if (cfg->qos.bcast.encryption)
 		append_qos(&dict, cfg);
 
@@ -285,11 +291,43 @@ fail:
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static bool assistant_get_qos(struct assistant_config *cfg)
+{
+	DBusMessageIter iter, dict, entry, value;
+	const char *key;
+
+	/* Get QoS property to check if the stream is encrypted */
+	if (!g_dbus_proxy_get_property(cfg->proxy, "QoS", &iter))
+		return false;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return false;
+
+	dbus_message_iter_recurse(&iter, &dict);
+
+	if (dbus_message_iter_get_arg_type(&dict) != DBUS_TYPE_DICT_ENTRY)
+		return false;
+
+	dbus_message_iter_recurse(&dict, &entry);
+	dbus_message_iter_get_basic(&entry, &key);
+
+	if (strcasecmp(key, "Encryption") != 0)
+		return false;
+
+	dbus_message_iter_next(&entry);
+	dbus_message_iter_recurse(&entry, &value);
+
+	if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_BYTE)
+		return false;
+
+	dbus_message_iter_get_basic(&value, &cfg->qos.bcast.encryption);
+
+	return true;
+}
+
 static void assistant_set_metadata_cfg(const char *input, void *user_data)
 {
 	struct assistant_config *cfg = user_data;
-	DBusMessageIter iter, dict, entry, value;
-	const char *key;
 
 	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto"))
 		goto done;
@@ -305,32 +343,9 @@ static void assistant_set_metadata_cfg(const char *input, void *user_data)
 	}
 
 done:
-	/* Get QoS property to check if the stream is encrypted */
-	if (!g_dbus_proxy_get_property(cfg->proxy, "QoS", &iter))
+	if (!assistant_get_qos(cfg))
 		goto fail;
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
-		goto fail;
-
-	dbus_message_iter_recurse(&iter, &dict);
-
-	if (dbus_message_iter_get_arg_type(&dict) != DBUS_TYPE_DICT_ENTRY)
-		goto fail;
-
-	dbus_message_iter_recurse(&dict, &entry);
-	dbus_message_iter_get_basic(&entry, &key);
-
-	if (strcasecmp(key, "Encryption") != 0)
-		goto fail;
-
-	dbus_message_iter_next(&entry);
-	dbus_message_iter_recurse(&entry, &value);
-
-	if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_BYTE)
-		goto fail;
-
-	dbus_message_iter_get_basic(&value, &cfg->qos.bcast.encryption);
-
 	if (cfg->qos.bcast.encryption)
 		/* Prompt user to enter the Broadcast Code to decrypt
 		 * the stream
@@ -355,9 +370,45 @@ fail:
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void assistant_set_device_cfg(const char *input, void *user_data)
+{
+	struct assistant_config *cfg = user_data;
+
+	cfg->device = strdup(input);
+
+	if (!assistant_get_qos(cfg))
+		goto fail;
+
+	if (cfg->qos.bcast.encryption) {
+		/* Prompt user to enter the Broadcast Code to decrypt
+		 * the stream
+		 */
+		bt_shell_prompt_input("Assistant",
+				"Enter Broadcast Code (auto/value):",
+				assistant_set_bcode_cfg, cfg);
+	} else {
+		if (!g_dbus_proxy_method_call(cfg->proxy, "Push",
+						push_setup, push_reply,
+						cfg, NULL)) {
+			bt_shell_printf("Failed to push assistant\n");
+			goto fail;
+		}
+	}
+
+	return;
+
+fail:
+	free(cfg->device);
+	free(cfg->meta);
+	g_free(cfg);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
 static void cmd_push_assistant(int argc, char *argv[])
 {
 	struct assistant_config *cfg;
+	DBusMessageIter iter;
 
 	cfg = new0(struct assistant_config, 1);
 	if (!cfg)
@@ -371,6 +422,17 @@ static void cmd_push_assistant(int argc, char *argv[])
 		goto fail;
 	}
 
+	if (g_dbus_proxy_get_property(cfg->proxy, "State", &iter)) {
+		dbus_message_iter_get_basic(&iter, &cfg->state);
+
+		if (!strcmp(cfg->state, "local")) {
+			/* Prompt user to enter metadata */
+			bt_shell_prompt_input("Assistant",
+					"Enter Device (path):",
+					assistant_set_device_cfg, cfg);
+			return;
+		}
+	}
 	/* Prompt user to enter metadata */
 	bt_shell_prompt_input("Assistant",
 			"Enter Metadata (auto/value):",
diff --git a/client/mgmt.c b/client/mgmt.c
index 255155e41873..968efdbca5b0 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -369,7 +369,10 @@ static const char *settings_str[] = {
 				"cis-central",
 				"cis-peripheral",
 				"iso-broadcaster",
-				"sync-receiver"
+				"sync-receiver",
+				"ll-privacy",
+				"past-sender",
+				"past-receiver"
 };
 
 static const char *settings2str(uint32_t settings)
-- 
2.51.0

