Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190EE2E2DD4
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648452; cv=none; b=KWpFkJbSF1ZDIM7bkeNW0ROBGM1TOa0xj3Rd0PEDHXlO8tSo9W+ykb9gIJJPVT3uUK0umVKaqccVTBERX2HGON4GttYNCJ9jCZ7k6Ewpxt4rDoHqX+X3ik/lBuq2zci+Bec9PPHq2EbcYeZbag8t/A3ZtJT/nztU2AlPF++L1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648452; c=relaxed/simple;
	bh=fA0GuoijCjS0oOtIZeCgpCODQ1A6oSWtX05uIo7ZVmA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvIFtwuGZdzoxQj+KkoCe134ekIkERdCvpz6NBsK+CJCzkUdOBjW6+nKQpHsY9UiBlhRxbo39zZhDmHMIZz2u7W4IvLNMRzQ6zYzE6PeaDYOs/4j/XfhhOs0x+N9Re6++CDmgwW669pUXKXY8Yr5AsBfDUIb57ut/qubb+TgurY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZCfV3Ds; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZCfV3Ds"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-551b9d94603so392125e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648449; x=1761253249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uB2cJcV3xbn+01Kt/AEWbmXsiLdladuS5OeoUSa8CZ0=;
        b=fZCfV3Ds9syHz+fO8sT/ECiAfSF+azQzA6XhXTH1XKk2umFpbkVIZV3wAa6PsokCgd
         Zufvmj344T77SvYeO0EhnZOPRG9TwpRtXKd3DVPOgJ5wCNLChkHLMYTeKwk70aaD4T1q
         O3TqzhE3lLDmzNof+75hqL1BHHTmAxVeJ1oH3nFQicRkzUrWzCRXQgAB8juZQ6n0cDnx
         oLS4GZIaVb2Gbk8UWL1uwQgVDY3qgeMVTohg5o3xkZWF1Yzj9uWhrD5py2RwfnJiI8DR
         W+9stPm71MaGzcT2M2BIGLYWV9rntFMV5qtlZvxW90ojakjc8tHm5yF28IuefrJw4CiS
         pTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648449; x=1761253249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB2cJcV3xbn+01Kt/AEWbmXsiLdladuS5OeoUSa8CZ0=;
        b=PXFbxwQ3OvE+AqCo7/DX/2jQxZLSXwLfTaDrkhmgpvFqRkYBrcfatv1TUDZV32q7QM
         hummfX+uEyuZAnt4LpjBd1HVNP+Kt637UCtSWxncSSDm05gkL0YZTc+/i/38CpGJRLOa
         lEXU54ipNBJ3kHur3Z4JbRH4wjwvoYy68QGDRINOB+aBK/z2Kqy+yEGwJzauGc+tH7uV
         56FBWJplHkXxXdWGY3Bo+7+6rtMgrQTQDDfga9lV4s0C7Mhddz/YhNuG41YgINaTDzsb
         Fw/fyybiMgThPs36C12Qx8NVb/ODSyguWLYigMSKWnpoGL1/ARiu2JcUZ1nTUWiybLV4
         O80g==
X-Gm-Message-State: AOJu0YwIAN9gD87Wi522F7dXBIKciVUMtYUFbQzuBJjo63h9a0d3z0KU
	weun6xo4BXhoVyOoirt6Ck6uzjGS3bhLydTJuZzwTo++aP5Uo5utwLBMm1Oakyja
X-Gm-Gg: ASbGncstnW071dCtLuRJ6CrONmdFfAlDKY9nPPFAxosHu1C2UtgcPZkx3tveX192hnd
	OB4zsETY7hjuPsS0p8FNCeqiIyotOqbGnTak5M986cICsWdK+MUInnt7O+NSLGIReOcxzkWqY1P
	W1600H8NKePuc2OnX5V+xppjBr6mCLIB38IWcm6Gv7NELUEfVNnQ1XcGpTeeS454+MHxtmEKiU5
	/e+SyenCwnwnPRnjGqQrUc2ICalEnAEHebYqdcyyc1zTeCRL6DBGdA7XbIqLMQ/PLGqd1QNsV5A
	sK6i90KGrrE1Zla+Jbjli33kvyuWOf+V/Us0MvQoGUk08kkBuj7O1y9suiVZc5d3pUziRLKuV/b
	PLpkaxrlRrFPZmEQuDsbjVTrqQXk5Tvhqd6jGhO8KXuEWOWhPzAJzjIb7oSRWDwt3NKsgmIeBlA
	EHnnY=
X-Google-Smtp-Source: AGHT+IHnqdbcKo3CEdYcqKrqPONBuFN05p3Zeafp8TWEqr+Xplyv+7QozmmcKJxOCTjSyp9euZpbXQ==
X-Received: by 2002:a05:6122:2203:b0:53c:6d68:1cd0 with SMTP id 71dfb90a1353d-5564eedf7cemr925092e0c.14.1760648449184;
        Thu, 16 Oct 2025 14:00:49 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm6590304e0c.18.2025.10.16.14.00.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:00:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 10/13] client/assistant: Handle assistant.push to own broadcasts
Date: Thu, 16 Oct 2025 17:00:16 -0400
Message-ID: <20251016210019.191878-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016210019.191878-1-luiz.dentz@gmail.com>
References: <20251016210019.191878-1-luiz.dentz@gmail.com>
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

