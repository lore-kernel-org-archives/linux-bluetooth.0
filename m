Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127D2E2DD4
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648455; cv=none; b=CJB+MeTQL2Y+eQAeV72b+bBZ8/pz562hfE/W0b29kwR6omPi2uA+pzR0FG9ITKKWq+4nfKvzMgxv/YG9l0cuR/bMbTvhb/WFUhVHVZagh/bna/05hbty05UO4vcqCzoldD9xX92DAkyVvMgz0FOZJTI5zqZVLvL0Y7Ht252KTs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648455; c=relaxed/simple;
	bh=J0yBjhx9fzLRAeNDamJ0iyoFlvDK1Hyuxu0lharuU40=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pm73/jLj8TCj3BLJVGEKcPbt8QOxjWVZg8XgAYjDFgEjmlgq1sUOrpS677TT4ONkdhFR6rrHY8kP+cRoQ15ZDGz/wOddsjnAc26Qs+Nf1gfuFUMti3yzzQ6bKwH7aF7nNz7aVjRUXYhqUZ4x3XcouxQC7ima2rjslQIpsL2ZKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOQknxbw; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOQknxbw"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54aa4b86b09so613020e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648452; x=1761253252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SgMWR7CT5tsx42SFhTRzgVYWNEYFU0gx0YvQHguNPM=;
        b=HOQknxbwbY1F3l1yP3QmnMFf2CtoX+8HcFM2CN9bsljrHqfmW4EOsZynZigGy9eYMN
         UZDUyTMsoMAvkdBNqCN2rS6Rh8ifTskL4+ZqqBb+MU32O+0hhyJrFOfQRv40iyj8ZYFB
         uzVAY6YHiGxIAssTT3NLgWeiEg8dw+gk8SDkhMbFVoXT+N2xtfy86ftMvV4Z0rFf3hkr
         o11LR3uDb5YiKlpy1WQgbqOidGZ3FKeAZIVNxtC5g/38Lvfniyot8FokcawCbyavWnrX
         xnwsCiQj0NP3Z+dPHx6/QzPT1Qyu9ePFZsrCPQtugKUMsIQPCBrXXkg74MlMmmbQX2yz
         4zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648452; x=1761253252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SgMWR7CT5tsx42SFhTRzgVYWNEYFU0gx0YvQHguNPM=;
        b=LHfY1umLWFCVhRb+BBqXnL97kNntCAqZY8+pQQdduLfUS7YrTglZJ7ZlrNLsgzecZr
         yBU2UJSXYVWggIuWrsX55qp84B9m3z/rkVKF5pXtOZ0wjDSextw88RIXZZGsu7S8ZWMw
         C7Qpa8fepX9CPJ7NfiBJJjhmnPLoh+eXpE6IuWbDe1O933CJazaH3ELgi9lrjYlKK17l
         35llp6leg4aXt3KYUk4MGLsgWN6PVUNI4RsQR5JFDlyMaWalzIXcpG0ich6d95ZVTgNI
         n70vXR+5v3xj/m4n2sWylfXr3F/wf/STj+C9I+Pt1ojd8FH0724QIWDYo/HmGc09xgx8
         yO8Q==
X-Gm-Message-State: AOJu0YzUJfMZ6XS9zwh9ckvmdMQuapC8miEqJB850EKuNd85hwDyieaH
	0iH/ghQaqzj2YNbhGNWfnC9BpV8fAlmtdMIRehszbt/9wPfjYe+6RylNu8rp+bEl
X-Gm-Gg: ASbGnct7KbwOKaepX5II33o4Z/noQGUFfYFsAQmEBDrzaNqqfX2X8P5ZD2JzoADLIEz
	/spZNZWO5Rw/IphLFvEOZsSOtEIC1Trtt9Vsh5/bzHK0zJZjnKz7ZMTFU3JwQQLonUfGIWJLz6N
	+6kALgZBPdqnNK9vv+u1TmNqh4xelRB5acwvs5grZKglLuizmQdFz92PFs0SpiUQklAgTljYP50
	VVfCIKppnjNaIIbByxp2T6ruLlwXe4ma22LJWB63vnp3bIVxLUxbkMD6XSfOozL9/50GB0VwJN2
	E0Er6fO2Xm5pg2F+tbfRpuVCxiHBsw3rvXMmdezYRP8xIe9mumjrVaE1Ec9FHjdUjQtdcjTJxPG
	E5099Tfzct7Cqwtp8YZpEMyBuOlgGZ1360668B9JI9K41iE2aq1b3agzAXKx/khsfTvajFnfwUH
	tXnyk=
X-Google-Smtp-Source: AGHT+IFOnBFc0TQMmFOUvOduZk+o+amHQBkV5MiH0ygz7N+2B1OjGYHGGsOQvq7i1YdBcgkZk5pH9A==
X-Received: by 2002:a05:6122:3d09:b0:54a:a251:ad57 with SMTP id 71dfb90a1353d-5564eeefa92mr819399e0c.16.1760648451621;
        Thu, 16 Oct 2025 14:00:51 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm6590304e0c.18.2025.10.16.14.00.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:00:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 11/13] client/assistant: Detect if object already contains a valid BCode
Date: Thu, 16 Oct 2025 17:00:17 -0400
Message-ID: <20251016210019.191878-11-luiz.dentz@gmail.com>
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

