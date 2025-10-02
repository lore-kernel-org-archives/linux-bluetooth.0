Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF193126AB
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412460; cv=none; b=CkYUJGcSkg34/IxXr8IjSB0LmQNEMdNofQEaDCqla111DY9ucnw7haYGDeU/kllSlK4Hp+6cicV5WjM6H7thSDL7uzkIhrg34JSf5yIPvsHHuA/lh3iwNQntjyG5gElFywfsctIydueo5SHnOlNimPEvm8R0V3ddarioo7awpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412460; c=relaxed/simple;
	bh=J0yBjhx9fzLRAeNDamJ0iyoFlvDK1Hyuxu0lharuU40=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=p/ajiAS68f8PKA+dUXMZx/NjASIIJJ4F1pA0pt3MyXUdLlAfcsgUz95HCu7KZaiQdLVR8EYXUut8jsNH02bSMn2zdHsy/1QkHhiKK8APwKYIGnQ01d+NGmWOLvKoj78iJsLyTX5Ok/HmwjQEPJDflup/jo+25yKeif/dbmrACJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipGvRPYS; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipGvRPYS"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5522bd69e14so577122e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Oct 2025 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759412456; x=1760017256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5SgMWR7CT5tsx42SFhTRzgVYWNEYFU0gx0YvQHguNPM=;
        b=ipGvRPYSlQ0JiECGJ7hDBYQxD+Cj9Fx8hxw8lClr2MUrs23gVLFcRqj2q7IoRiFJSK
         jNNbW9V3SLM1izsUNItERsAlMYtJ37nA1lGyh+fgdAcEkCWm/s+iAl8bicxAB7fjGWP2
         dDfIKdZhgaIwRt2sPa/krwliTcJ7O5PTDsiZAPEdXqic1pGybHbBNLeLi7pGx76nKXel
         ZnADi/669b4JgZR5WlEsuqLv3WaSXyuGO7bQiyCTEt0PCghxX2uFn4DoEVaD+sVuanth
         zZVgHydSXQfEIErAUbYN2tYVjhYTGd2s2prsha97mSd8KDqBagfk+l4zVIkrQeqFbK95
         8/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759412456; x=1760017256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5SgMWR7CT5tsx42SFhTRzgVYWNEYFU0gx0YvQHguNPM=;
        b=GXTdFq0+WStmXvuYGWRApfaDoUD2jKhkXpyItSi7GK1/WTd3/mVquZqIce9mSpQ0fJ
         L4ydr4tMxZpGUhO7W79cREqbf5gFHG839YH5geN1c547HMPttf58f6avhs8PpAKU2cc7
         hWNvZ6p1qQsLe4QskdlyWHVRhKlVpKteHuFuqVPnWT1IxbZOZBQCZ/RjvMFojRKDDu5p
         G872IQhy5ZNbAq/mLTZgd8moGCvMJrwfB/QmxZ2Q19ddBmMz7JGxYgz2NucbgjqygHvd
         3VvAQXE9h+SklF+jBMAq9vB+mGDOn5BfVYh11dDZifFFp2C+/Ekxi32NgYVSyr6uN4ZS
         JTuw==
X-Gm-Message-State: AOJu0YxqBc7EwfcA+8mLtvD4OJ/n+JCA3QrB51zheq6fp1+pBzc9BbhJ
	oe4CpAfgz1n4mJoRDgEOxQ/BxSS8vlPsHnOkcWAXJB4261K1O9BL0qNoS8K2285b
X-Gm-Gg: ASbGncuszdIQGp6sS2AWXo+GZZe/XFY5GOqCOflX5goXu4fmZ8yOwCZCCagTryNcJZH
	ZNG9vidWzvtVsEmgbLHAK3anA6htwA31R/h6qLMI5pLz2+Lgf+QZbWc1Y2XtJbG7ZBzHPhb9wBW
	DmMcrsdpVxkA9ozPNleGHw3H+sy74Tj9DDAfY/KaHOvunUxgZcceo9d2JJa8OxXBwmxwKrJx65r
	gfo3qdYhXUNgw80CrZT4OFGZjD7eLJKg1qVQ2GLKsQdE7tWlWiQ3urOyt+rpd6gd9bzzm+4HWZj
	/+DjIDjcJlfPdsrjLb/gtdoL4fuNPUi4GXF+QOjW0gwDBLbDiV6cpMvGLRTbM71zPaonRbpQNib
	aMCXo4sMbC9M1+zP+afhNDLJ6lCV/OLpceGt8sLLctEeGlD3zqsIxKzntksuOj5Py6HzieCFluF
	iu5lqZK0CAHtQcuw==
X-Google-Smtp-Source: AGHT+IF0mXpOwTNkD2LNp2JHVlSDpAHrTF2rILk9UikK0h0mVti9fN5VZuKobvRlPzIKhuZ6b91Wig==
X-Received: by 2002:a05:6122:32d4:b0:54b:c080:a55e with SMTP id 71dfb90a1353d-5522cef10bdmr3393299e0c.0.1759412456493;
        Thu, 02 Oct 2025 06:40:56 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523cf6558esm490157e0c.22.2025.10.02.06.40.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:40:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] client/assistant: Detect if object already contains a valid BCode
Date: Thu,  2 Oct 2025 09:40:41 -0400
Message-ID: <20251002134043.196760-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If assistant object already contains a valid (non-zero) BCode
(e.g state=local) use it instead of always request the user to
re-enter.
---
 client/assistant.c | 55 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/client/assistant.c b/client/assistant.c
index 1ff8001d7216..ed0c8cdd6c7a 100644
--- a/client/assistant.c
+++ b/client/assistant.c
@@ -293,7 +293,7 @@ fail:
 
 static bool assistant_get_qos(struct assistant_config *cfg)
 {
-	DBusMessageIter iter, dict, entry, value;
+	DBusMessageIter iter, dict;
 	const char *key;
 
 	/* Get QoS property to check if the stream is encrypted */
@@ -305,22 +305,45 @@ static bool assistant_get_qos(struct assistant_config *cfg)
 
 	dbus_message_iter_recurse(&iter, &dict);
 
-	if (dbus_message_iter_get_arg_type(&dict) != DBUS_TYPE_DICT_ENTRY)
-		return false;
+	while (dbus_message_iter_get_arg_type(&dict) != DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter entry, value;
+		int var;
 
-	dbus_message_iter_recurse(&dict, &entry);
-	dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_recurse(&dict, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
 
-	if (strcasecmp(key, "Encryption") != 0)
-		return false;
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
 
-	dbus_message_iter_next(&entry);
-	dbus_message_iter_recurse(&entry, &value);
+		var = dbus_message_iter_get_arg_type(&value);
 
-	if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_BYTE)
-		return false;
+		if (!strcasecmp(key, "Encryption")) {
+			if (var != DBUS_TYPE_BYTE)
+				return false;
 
-	dbus_message_iter_get_basic(&value, &cfg->qos.bcast.encryption);
+			dbus_message_iter_get_basic(&value,
+						&cfg->qos.bcast.encryption);
+		} else if (!strcasecmp(key, "BCode")) {
+			DBusMessageIter array;
+			struct iovec iov = {0};
+
+			if (var != DBUS_TYPE_ARRAY)
+				return false;
+
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_fixed_array(&array,
+							&iov.iov_base,
+							(int *)&iov.iov_len);
+
+			if (iov.iov_len != 16) {
+				bt_shell_printf("Invalid size for BCode: "
+						"%zu != 16\n", iov.iov_len);
+				return false;
+			}
+
+			memcpy(cfg->qos.bcast.bcode, iov.iov_base, iov.iov_len);
+		}
+	}
 
 	return true;
 }
@@ -328,6 +351,7 @@ static bool assistant_get_qos(struct assistant_config *cfg)
 static void assistant_set_metadata_cfg(const char *input, void *user_data)
 {
 	struct assistant_config *cfg = user_data;
+	uint8_t no_bcode[16] = {};
 
 	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto"))
 		goto done;
@@ -346,7 +370,8 @@ done:
 	if (!assistant_get_qos(cfg))
 		goto fail;
 
-	if (cfg->qos.bcast.encryption)
+	if (cfg->qos.bcast.encryption &&
+			!memcmp(cfg->qos.bcast.bcode, no_bcode, 16))
 		/* Prompt user to enter the Broadcast Code to decrypt
 		 * the stream
 		 */
@@ -373,13 +398,15 @@ fail:
 static void assistant_set_device_cfg(const char *input, void *user_data)
 {
 	struct assistant_config *cfg = user_data;
+	uint8_t no_bcode[16] = {};
 
 	cfg->device = strdup(input);
 
 	if (!assistant_get_qos(cfg))
 		goto fail;
 
-	if (cfg->qos.bcast.encryption) {
+	if (cfg->qos.bcast.encryption &&
+			!memcmp(cfg->qos.bcast.bcode, no_bcode, 16)) {
 		/* Prompt user to enter the Broadcast Code to decrypt
 		 * the stream
 		 */
-- 
2.51.0

