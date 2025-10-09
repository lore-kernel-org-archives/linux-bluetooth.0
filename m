Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA02848AF
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045413; cv=none; b=rN5+dH/WCv9fdGTcpvCua8c/toB91/t/E7M8bfIdM4lASqc4DIWF01NbCcP9UKJD30+hAN8+4bCaImS9MgCkrN+hQZzoVW1XhL9L72onE5XKfUzNmkGZbRgJHJTjNIfvQnzgedkgh2fcGzR+WiMpT7lS2FJJEG7jzA12uXEpcZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045413; c=relaxed/simple;
	bh=fA0GuoijCjS0oOtIZeCgpCODQ1A6oSWtX05uIo7ZVmA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzCmjsGa7ovi8zTBUKkjwHGV1EdwhOR9bObIa8UnkzMgJEjpRZ8IVbL6QfKjR6whB+xzhqaDHxBNhb0PzRXsrrfwMoCbj1hakWw9Xd6XT5YDRz840frK5h7dzkd3No7+UubbhtjtwBvE77lsVIGR0fcdbrDBfxAClyJ3Z5t3gAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0jxudYt; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0jxudYt"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54bbc2a8586so463481e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760045410; x=1760650210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uB2cJcV3xbn+01Kt/AEWbmXsiLdladuS5OeoUSa8CZ0=;
        b=I0jxudYtyHXByOmIjmwTs5Sc1dEdtXwNQXlyI2KgtfCMPiFKQbyxDeBjaSrW5KG0Tm
         lSIj/D8uLeY0H9QkRPKnt0wAtrMhi/wRmFPSnB3wuBnq89YYE2y8NFxCOiFZLlhg1HIE
         qzx2Me7M+U642Unm5O8d3otImx71qH+15165STHhiPy0AeEopE/T8qDdrlfDRrVIlzO9
         UOKhdaD0LsgYfOEpDD326GeVt+/96YDp6p53NKt3OfOIhaksId/J09M6sBXoArXPBc/X
         r4qZVESu6X952CLrL3z4jvUvJoWJnAPVOera3G/ZOjNE1iIjRzmafExNbwDGGTJ/SENM
         hE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045410; x=1760650210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB2cJcV3xbn+01Kt/AEWbmXsiLdladuS5OeoUSa8CZ0=;
        b=UZyzwL23L7tPbxOgkNQlhbUWnjlb1Cwo6bvf3DxGxMEegQd1NDi9a6T1NnU68GAdOC
         fWIxJoMkN/xyTRaesumskoBKn0k0oolI9T166MUTD9CYmr38sH4jyM2Qtx32xzY7BqZY
         zRot5eyr9bihtaYw+PKQ9EWBrmABR73MAgtL01p52wyOFp46HiENE824a/CqZ0YdPc0Z
         Pk9UDB42PYEIS5yYrFM7pHBnVCqm7oK09B2Hm21ZmYeEBvacYIL62tKZq3TrtGKXSQny
         mDTq0YBM0WiDROqUgYYxmT7pkQaiVQY7XzeyZybqtDolTI/+fXKv35bhGGnobyrAvWVT
         84sA==
X-Gm-Message-State: AOJu0YzfJZSxjpEnLRFp+I+oUzpU9fv2iYceOuO+Qa6xS33Bsnm8/7NV
	t8aJM+qJTYoCRrA5mXQcWn56gAU/QB+Ke7g6MVovOns59mtTMIX3CKhOrLsS/Xi/
X-Gm-Gg: ASbGncv2oS13Bur5q2QQLdYiLYKlYQPEvg+yfmlrMUWjSDLJG1HWcxo1cui/5bMGMOC
	1OM3K1AXCn2Yy5eQ7PxoAOgbPM0I7WrFVSNtFGDB60FK20XzH5doFfhwgeHNByCoVLE8RLPMU6I
	f2eK/4t7cx3fySXbIIquuBulEEUk4uRioE0SOoVb9kt+Q/1d4vfXeUg9+QM0QnwnUwVLcIO44E4
	mXA0oAA4boTjbyeAksRrG4ZeWnsZ3QP/4Air1qrvgi1q0nlAsm1njnc78bWmeIjCbkoB/gMznYs
	ca8ZAhLB6uBC9PD/q3kXfi/sP7UWtVUt0SQgrM33cnhCEqdU+jNL1AQPKqNKsXU1I4TEaTxbXb7
	Dv+bR2LdM0li+dJ4K/rNLeYLKwwbVfhrd1CXA35x5P02/ZO/2eUMQpZOX/7p91Yroap8r72wRuU
	I/nAcmICmOU5xti7l+InNe7qSs
X-Google-Smtp-Source: AGHT+IG8bWfkTINt688hj8wsrGNIcV5E7zBaZ/ThGt3O+61Z0eeL0n3N5J7TnlOeVmD9nh517cHedA==
X-Received: by 2002:a05:6122:78c:b0:541:fdc4:2551 with SMTP id 71dfb90a1353d-554b8a7f6dcmr3521640e0c.3.1760045409793;
        Thu, 09 Oct 2025 14:30:09 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f01e3fsm211224e0c.7.2025.10.09.14.30.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:30:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 12/13] client/assistant: Handle assistant.push to own broadcasts
Date: Thu,  9 Oct 2025 17:29:30 -0400
Message-ID: <20251009212931.445719-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009212931.445719-1-luiz.dentz@gmail.com>
References: <20251009212931.445719-1-luiz.dentz@gmail.com>
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

