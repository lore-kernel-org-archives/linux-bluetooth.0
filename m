Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4672F7446
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338469; cv=none; b=AidE0qi2cZ9+HbyXAFuPY5xpX2Ph8Hypor86hQ3cml/AbwxHkznRp6iebOh8uBbtsbfyYDFAltF7WTkPSs2NKkQFBmNZ35erRL0lB/CVSHh2BWKc7YTMPLhQmUPDltvJsmRits9oBfHASkky+v09Dklag+IqxHtneDSle/XPBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338469; c=relaxed/simple;
	bh=J0yBjhx9fzLRAeNDamJ0iyoFlvDK1Hyuxu0lharuU40=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1upJmAU99FUff1bPty0CdvCI5F6O+SUFUGVdknmN82S6hkPaO35oV90k95gQeD2Q/MWVvPas8Ri4+C71D0FMfdaBQexqVy5xrxLH+DKXVRAhqoS/5goiJYWP4U8JxA6TgEGv95SC5Sm7yc4p6411wdb9+Aq+ZX3FW4xBsAaH4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyeOvdza; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyeOvdza"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-932f654eaaeso1742371241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338466; x=1761943266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SgMWR7CT5tsx42SFhTRzgVYWNEYFU0gx0YvQHguNPM=;
        b=hyeOvdzaPYHzeEwHsqV1MtAbfmv0bofbdD0YRr1iyqeX+wvladE6GCKmr25ed32Tim
         sjsoKU33Fz6xBaFghknaplZj/BGadzMXSxiP4ouB6gVNkfHpGv1l8rrWiVxIZaglw21o
         72RLljg5iYXlAAez1p5JMDziM9UlU6IQrDhQx6Dl8xr4veohf1y/MsRlWLpw9PY18XmP
         kXZI81wmKdQTZmwIfnvNcY3nyhK6EpG2CPug6m1UYTUUCziU67XEn84oHJMLk2xug59l
         5noA9atI68WWFT9XdqPrBsi/ak1qi+Vl/VMksrRj36B1C/0HZ8itJbXIlpbe9t9Lzbdc
         ACtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338466; x=1761943266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SgMWR7CT5tsx42SFhTRzgVYWNEYFU0gx0YvQHguNPM=;
        b=bFLAYG15Eblu/VuE/CGpOAi0qYvdFVa/B2p1YbRgdpD0HTV710m/WCyB52ijFXG2kJ
         IBK8dWf26rKNWogQiBdhWdYMq6/F3etFHc0jdO4JifN7B1dKrEnzI+Ot4CXsj9Hy//oi
         g3YqHGcJUZa9xbuD4ow8X5ef1G/NRblbYeK3Jp7dC36kEL1X2U7lrsrOU5w7exLihhNC
         EjSt/ijoEN7+DAzkHjpgy+vSRJ2kCj1SeHKcDd26oc6D094kyU7xJFoYRnstTG3o5Oxt
         UJkx7k7P8j5ewE4JOGn4xxtLpSlhSePA+3KLYaA4wFWrPtDIBAZcH9BF+bi7dbLcA84U
         15mA==
X-Gm-Message-State: AOJu0Yz3/AoJPEyZE5pmXqVfHYDqgRaTvXswseJBG5dNZ9Ddi1IUvLqf
	B6Yt0oLCUTGrZ2+l2lAwZ5gz1wAwGkCPg4vlPeJ/o0WB/OxsuW+KFNP46JEUmA==
X-Gm-Gg: ASbGnctQUCCi8ZggIyhLxSsOZKp9Q2tp7gU2JCi763pglZHDY9QurJf8xTiqrz1E2kD
	+kgo0JlrLvgCRtbLsrq5RGKLHDQI0vxlLgvY5+oVfq5ZioSj7sbxICCjKVjZpv8tFJY6p2LI8b3
	IamGxEHbUgSd5kI4QH2wPMFZl3n29AVcuUTSiRYWPpzWKV2RWsG26EZI9B9zHL7K8q8Bxz3sCvc
	0A8QSOwC+1Y652zPt8gluzMOAGMoymYangWOmlBIZUv9ehf4vYRmCf973kxG/k2Pxq3jZsYAQda
	HNZPUKkPDt7TIajrQ3X+65Um74jei0AShn1efMqtksvB6KPszhqfbzOb+ibjH1RLdlNn8a7zPh2
	o5FM1xiRx5VRNpy0jkVfMglHiGeWD+vNU6SFdfgIRUEKNlA6x6ChXu1rxPzeVQiFVb7Vw2j+15h
	YbM7psBKTaJMHmcw==
X-Google-Smtp-Source: AGHT+IEhzQTR/coJcsQE6JB+oVmG2qCaDgYtuI/x3xIVSjrsu7bNwl4v1oY44P4FY3P7W/nCvPMVqQ==
X-Received: by 2002:a05:6122:2a4b:b0:544:a84d:d3ac with SMTP id 71dfb90a1353d-557cef87017mr1132777e0c.5.1761338465775;
        Fri, 24 Oct 2025 13:41:05 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb2f98asm73501e0c.10.2025.10.24.13.41.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:41:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 10/12] client/assistant: Detect if object already contains a valid BCode
Date: Fri, 24 Oct 2025 16:40:37 -0400
Message-ID: <20251024204039.693918-10-luiz.dentz@gmail.com>
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

