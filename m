Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E14F3923
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569104; cv=none; b=Vx3QLs/KqjtNeuuJ7/KvUz4tJyy8RZPzy9jYWuczatbi0le6YORxm+Qzy2obXLIqmVo9SzGmcLXTa2c6qtQD+Mw59c8rlxLPHci40zCi4JMZ9p1BWTPKvzX6W1E9jXfAcdixYvfNkLiGlGuwUkYbV2y3TZzYxU4rb3RdSFWxaAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569104; c=relaxed/simple;
	bh=d21FiCqLKamxIWRWYyMQDpxRCgqHxaR8WzonKJrV4Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLHXslam9iqQimXiuUKGLilO4pDYQREmOd3jAcgQr18VHz2wwMkJZc7pA7bwy9lqx77C8xcUweoCkMFFtBX2T7Gw12TqntJlJqIAk+8kA32HEkEfRu4gysjSpozvP1hL5KnCYxvZbW665t56rOx/Em2QUsGNBHmWBPMPnvC9qug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=kJnPTDZu; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="kJnPTDZu"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15168a20b47so3061365c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791569102; x=1792173902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L35wP0WkPyHLnL0l5gcSmULRno2ikdVqSpT5B0+inNo=;
        b=kJnPTDZusF8SaZWbDA3VZNdsE6ZQK3tZEZFEmuIkl/c/YlQBJcVg57wlx/t3oyw25e
         IpUX1ZNlUnTQ51tPte5LDr5URxKeQFhM7PmLKwtrW+CTByAD8zs6H2LOH7fV8NX+1c8p
         Z5wXABoQELrHbf/s/QKHDPgJ42xY723JWGQF6CEL9LTLY03nghCmylcoVQj2Ac4eoAxz
         HL4itK8zdLAo52TH7c1ADLCqgWGawH0xrW5RhLIjfpnOXW/ASjbQtI+8XnpcxJfHypGg
         HdayZe/35G1CJszpBb9EFqdcoxin7UgzsCuiCcsvw9p0VvQ5Nkl96ek9GtnbltP3GaSZ
         jggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569102; x=1792173902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L35wP0WkPyHLnL0l5gcSmULRno2ikdVqSpT5B0+inNo=;
        b=GqjgTSZplKZsHe4BXSqqXEnLqNPjJwMK1ZlczXLAiO1ovkrdl0l7lpYEkxlH9v1QTW
         l1wNwYHMQUsidloM0ydLKTZSqCZ0KHv2GhZ28huqYQMcqNK1o4lyy7qemJDZIvcO4YI+
         WWGATP2GQw3XaJEouDMaUOTFzZdYmXMcD1nY6b/im9Ahdv8FYBOcwAiVk9ma7lGPHIe8
         qVvNC1ZAITulH1iC1Kwxeb4Lj/mWzdqAEJFGvjKJoEJQ48ibnwYUtE6QUuZ8+zCR8oXP
         00Tnvd24B+V4HEtMSIgRG7JwfDLO1FDoad6FLMj/z9cZ2DQ/Y6Bh8d+3xl/+QKrXxAe8
         YEHQ==
X-Gm-Message-State: AFuF++lO7sWuTCW3vJ9U3XH9j+4rpoaatKKwoJW5gGiUg7e/NEeKolhX
	DAG9/MzHHZ0WpubSG2TvO35evAfWr7+nQJLdDWuDHjOZUelvpHacn3Zg5o4Khx11OzYL9H4cvWS
	zumzP
X-Gm-Gg: AYBFou1zZXdvdn5F7fMvejdiHzDjBEFJbPJmzkyCyW1gh3sy3826raS1USbMZnDKps1
	MuvAF1zCMzpvcnQ+S2u48XYIzgy1yu3As14KhMr/hD9mHAHtnRj9Q1Ivzfmm0zua/xXMtwvxJQL
	lK86dIK/eexeQfpLd7yCrCzbVynbQJ0ynZN55vvAmOIiTos/JB8HwitkIuUsdqNxHgqrrN9JfCR
	STbLVF3JJJ68l9pAO1NRMszwrq0N/vtR41AtLzMTrKj+i1QnnzK0cEMYA3glmIO1qgAnh55Czed
	GqzZ+sacexldmXPuHeeZcbQkJ8CAWApAw5QDBBsANLPvF2FwrPwlZsI3LiaodsFsRhOjoqIK6VD
	Su6/1HCiGtYsA8aaOtfsHvc2tYYTbTdoZ6S2DiEaorr0ZgdP+lMYrqRP2yYqi/Yn7nCJHXng7S6
	2sK9jjfe7biTfOlGUAIQJXqPXd/40ZYNW0VnvjyqgIzCuqbd6vU/6POuQC3n+nYa5aBOW4/SjN8
	LC3SQMdo+IhJL800ozfqncEhMvAYvzkcWkWGJ9WeyMLj5jVdUPr2WXL0T0mRP86kJm1x5t91038
	acv5e/mpPETFeXKeY8q/UlVEkDfsJMVMBgz39i+NhkXaYg1ZRQ==
X-Received: by 2002:a05:7022:b057:10b0:160:a80f:3ed2 with SMTP id a92af1059eb24-16a5dbfecb9mr3189226c88.10.1791569101761;
        Fri, 09 Oct 2026 11:05:01 -0700 (PDT)
Received: from localhost.localdomain ([12.158.218.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6be0sm16111163c88.13.2026.10.09.11.05.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 11:05:01 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v3 2/5] bearer: Add Role property
Date: Fri,  9 Oct 2026 11:04:45 -0700
Message-ID: <20261009180448.29117-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261009180448.29117-1-kevin@simpleble.org>
References: <20261009180448.29117-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements Role property for the LE bearer using the initiator
flag of the Device Connected event, which the kernel sets when the
adapter created the connection as central, and emits PropertiesChanged
along with Connected.

Assisted-by: Claude:claude-opus-5.5
---
 src/bearer.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/device.c |  5 +++++
 src/device.h |  1 +
 3 files changed, 48 insertions(+)

diff --git a/src/bearer.c b/src/bearer.c
index f3b7a2337..25224dcc7 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -274,6 +274,34 @@ static gboolean bearer_connectable_exists(const GDBusPropertyTable *property,
 	return btd_device_bdaddr_type_seen(bearer->device, bearer->type);
 }
 
+static gboolean bearer_get_role(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_bearer *bearer = data;
+	const char *role;
+
+	/* The initiator of an LE connection is always the central */
+	if (btd_device_bdaddr_type_initiator(bearer->device, bearer->type))
+		role = "peripheral";
+	else
+		role = "central";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &role);
+
+	return TRUE;
+}
+
+static gboolean bearer_role_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_bearer *bearer = data;
+
+	if (bearer->type == BDADDR_BREDR)
+		return FALSE;
+
+	return btd_device_bdaddr_type_connected(bearer->device, bearer->type);
+}
+
 static const GDBusSignalTable bearer_signals[] = {
 	{ GDBUS_SIGNAL("Disconnected",
 			GDBUS_ARGS({ "name", "s" }, { "message", "s" })) },
@@ -292,6 +320,8 @@ static const GDBusPropertyTable bearer_properties[] = {
 	{ "Connectable", "b", bearer_get_connectable, NULL,
 			bearer_connectable_exists,
 			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Role", "s", bearer_get_role, NULL, bearer_role_exists,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{}
 };
 
@@ -416,6 +446,12 @@ void btd_bearer_connected(struct btd_bearer *bearer, int err)
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
 					bearer_interface(bearer->type),
 					"Connected");
+
+	if (!err && bearer->type != BDADDR_BREDR)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					bearer->path,
+					bearer_interface(bearer->type),
+					"Role");
 }
 
 void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason)
@@ -444,6 +480,12 @@ void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason)
 					bearer_interface(bearer->type),
 					"Connected");
 
+	if (bearer->type != BDADDR_BREDR)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					bearer->path,
+					bearer_interface(bearer->type),
+					"Role");
+
 	switch (reason) {
 	case MGMT_DEV_DISCONN_UNKNOWN:
 		name = "org.bluez.Reason.Unknown";
diff --git a/src/device.c b/src/device.c
index 1ab4e5342..4ccafd15a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3869,6 +3869,11 @@ bool btd_device_bdaddr_type_seen(struct btd_device *dev, uint8_t type)
 	return get_state(dev, type)->last_seen != 0;
 }
 
+bool btd_device_bdaddr_type_initiator(struct btd_device *dev, uint8_t type)
+{
+	return get_state(dev, type)->initiator;
+}
+
 static void clear_temporary_timer(struct btd_device *dev)
 {
 	if (dev->temporary_timer) {
diff --git a/src/device.h b/src/device.h
index 756540056..5ead73958 100644
--- a/src/device.h
+++ b/src/device.h
@@ -129,6 +129,7 @@ bool btd_device_bearer_is_connected(struct btd_device *dev);
 bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type);
 bool btd_device_bdaddr_type_connectable(struct btd_device *dev, uint8_t type);
 bool btd_device_bdaddr_type_seen(struct btd_device *dev, uint8_t type);
+bool btd_device_bdaddr_type_initiator(struct btd_device *dev, uint8_t type);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
-- 
2.54.0 (Apple Git-157)

