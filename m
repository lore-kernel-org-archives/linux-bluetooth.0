Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8D224B15
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045417; cv=none; b=SDZr7ZBvaX8jAKaNSU/5eZhCSAt5ntBtfKDuOFpXABWZPOpslYD9wqCKXynHsT74xDL5CRPlNmzZXmWqtEVubOpsNKT0wx63uBpe2m6zlsR5cIWXMbww12zuN5EOgsVIYXZaXN81olk0Y8h0QrRnAKFd5MsAqx4f61yMSWK11+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045417; c=relaxed/simple;
	bh=J0yBjhx9fzLRAeNDamJ0iyoFlvDK1Hyuxu0lharuU40=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fikSjZMVYxn1d37UW3V42wjDNy5aU1U6ywwZtX/rCmP3nRWP3fRtyZZIRAL2vkVQDvcPfQahjjYyP+ixpK/WBKK295wHc8jzA98G+XWqaxL91t3grtkiraBo+WGx1hl7B2cGdl+1Zwhx5BOCkYX6/Wy/8qDQlPHcBFPDe1aQkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKGO31Pe; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKGO31Pe"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5a0d17db499so1283500137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760045414; x=1760650214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SgMWR7CT5tsx42SFhTRzgVYWNEYFU0gx0YvQHguNPM=;
        b=nKGO31Pe46R7/XtueZ5vHE78hFNIqunJj2gvRE3rICfJSUcSQ2+8Z2vvR8iBfy0aBU
         O7oTu3iRaqEkxOtKC4LsOo+DcckD3WTsqDNRLhAXfEWMDawP+mTFbLB+sKbJmJ1YsQu4
         PVbxDZ78IJ4l5cbQ40MfNd6acYopKDYsU6J/heQgpVSOTbA4+oTjOnMMGNAdPdb03hwA
         2uorg3+UJjm2K3D0GlG3MogxTHMYwL8z5KZZTEh+OTCBy2vIx+ZMxgETOFqyDAaEjOo3
         doh3yFjYDxaT9i7y21Aj5Aj+d7t0ht0eIwga5MMkXYi4Lbey2yosKbwUJ6ALI0nRmiUc
         CsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045414; x=1760650214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SgMWR7CT5tsx42SFhTRzgVYWNEYFU0gx0YvQHguNPM=;
        b=V7FYef8kcFBft4B0zvyLmPN7V7LQNxa0jvnbq7C/tGoiAdTiVwH/sENaLHjvNmof9Q
         6i8J2HEV7+YEzi+XdYFQkyzKlgAzUl+yBfOo2RCktAHzhATx2/joZMHR51WpBx7BA1ht
         odofIccR7zwcag6NyjSKqgF4BQOgq62AFV8Vbj9or7R7s/34emodjgSEYZoz1mnn70FJ
         CwayVrcrsWq7rpOJrNwFAbqYADodZhWxgP2dD20WH0GSpiVsOef7yewXDVKIcZTLpwPQ
         BQaQJnhL07Zd5WSeES+I1li0eVNtQ5MbpD9GeJ+DA0mnlYzJwICN0qZ8zyNJVXmGJY3/
         rqXg==
X-Gm-Message-State: AOJu0YwjEHwf/4Fu7Ccy7xD97nrkPNon+vXLc4MOE3rvxCTBuiqlodcJ
	oqn5J9tgdrCX4cL3kJbpgXs9jnv1gYznV79symaEQubCrM14bTab4m6J+5vq3b2G
X-Gm-Gg: ASbGncsVDndeugOz/P0igrx6CE7bd6wigNTpTTBhRzrFnT3vWmbznuBNrbQF62K3PTn
	rN2100GrR51M7xpeoS77yuJdkxhFJtYSJcOi5akt3Svop/Y4rbE8x9Ik1NMiegn3/KMnGczvsAb
	YyU5SLyEw73NovM/bIS+Eli99Qyo1yvvPRGMTuc9gy54VeF+38waj9yTII3xKOjl3Og80TWlPx2
	kubZv2kN5HGDIuGxUQioJhCRe5m363QJZA38yBoI2YVXb5phvh+EVzC+/Wi9pFlMKl/ZDEMXjwz
	JfbOj8+vrNr82fKiBs0dgn6kZPfLUHmf+XhjoC1zbrONFvaNO28Rp//kMsjXmK32sNU+IHjz8dz
	Rexl3joQrfmXKZmRtNGYNo8ce4DMo2grypsFi3GxzGJj+pfb8pRCIB55Uc1cK8uNEyTtrep/eBk
	mR/GhrKhLNpfVXqJbZwOazrlM2
X-Google-Smtp-Source: AGHT+IHYcYrKH5KH0+QGktQxtdkabqE6Mp3jpjbUNsgBmUnupE3i9ObHGcV5Q5dIn7P8gJxJwkX4pw==
X-Received: by 2002:a05:6102:c8e:b0:5d4:222:9f8a with SMTP id ada2fe7eead31-5d5e2322d17mr4016180137.19.1760045414142;
        Thu, 09 Oct 2025 14:30:14 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f01e3fsm211224e0c.7.2025.10.09.14.30.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:30:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 13/13] client/assistant: Detect if object already contains a valid BCode
Date: Thu,  9 Oct 2025 17:29:31 -0400
Message-ID: <20251009212931.445719-13-luiz.dentz@gmail.com>
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

