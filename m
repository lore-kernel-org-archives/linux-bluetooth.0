Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34DC4A33F5
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466611; cv=none; b=LHyotgXcJexzo0t5+4g3tw/DojCb24oowTeCEZUdM03+aa8UHPzJPN4aROS94Q/WttYD4PJX5T1Vd/RYViqVdmttuxuceMtr1HMBufGbWB196bBK4IqP0WjoEADij/+xrxN8v6LTMgt0+fetgQ9vJnBBqSkSRY7P7R+Ywfbzf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466611; c=relaxed/simple;
	bh=Gehve5wmJfGGhVc4s3LK2Q9LvkdBJ85b301dxUeCN0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdSRhnt0wnv6pQFsbIX502DOQn2oDE0wUXcbJIiHvoTDD9EccAhyqbmzb4e9T9NisAgtZlKer00Z5clNGcFn5E93OiewH4fRKF5/7wrp4DwO9jD2L4BZdwLdkwPiIoZUeSMvya8upNNFj5rl0dTqZCXGMvy2JgAQdYV9iZk9HKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=KnRd8aSv; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="KnRd8aSv"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so4453967c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791466609; x=1792071409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+vgCBkwpPc0QQYsm3ww/mNPHGGB0onQDJXSzTjsk6sU=;
        b=KnRd8aSvSXPMPMHNUxSgCxZ4/Q9VTkh6WXM3EcHRz4ywkHBqAksS3a7PIok+j3TsA6
         ZeTlh9fxeK4e9WSA6+yCnF09FtnjedNF5TfaBz7ZZ2yPocp+1p/qr754ui4LD6eziFbG
         iHccQwbqqHMImEsJuacOMFIexoGx5R1DXffjkkleN4giV3C8QfJV43r/NKR7CMB5w8X3
         YE3NjkHAroxyYmLIJOJkR3oz2dsomb0a8XDgV9P8mpGo6NaZmWoY4iUGuwAjddFWfoJx
         V1sGyT+2oh9zaaIBYFurwDZgTUQzxxNbwQJFT8XSXfxRCxuPknPADZSYIiuLqwW5VU2F
         3N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791466609; x=1792071409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+vgCBkwpPc0QQYsm3ww/mNPHGGB0onQDJXSzTjsk6sU=;
        b=cWuVuUwz7LWfphtfwJct6KzsEaWVGklj2GIjNjtJiAxolz9CdxapyWForlQoYTUM+n
         yzSr65pJySazTl4UpbCnnu1bSWBYdfRza44EUZj1pYohKhSsdA7z6HB6jPc0mmSu91e7
         4RzNaTi5jIM5AWbM1wvxC2XytTR2+Y1DStImzrWg2Z3WyyuTw+wwhA7wxgRmQwWxUhnp
         bdEcURgqQVZexeE1pxE1FIBAfdi+Ar440Y3I1/fb53pT44ZGc9ZVhtgtz2hPUzJpIqQs
         yGY460vR0xTsvWga1koF2SWYRa55HayWR/TIr5vwTl2iKvXMXgZh9+T7YeHI4141km5l
         cL3w==
X-Gm-Message-State: AFuF++m2rxNCpZvf4LBfHLVlSk8kkM+k66LxJjTSYIN0I2YzRrqhmBCv
	kC1Z4fIX0M1K9mHyS5EaVUJ7twHPDyrI2m3aiyo3x7JIuA1nCL06IVTv57L7kawBbgW8EfVrgyI
	dYbsK
X-Gm-Gg: AYBFou0YehAOb5g8heAqNdw7ESvJJV+sp+REpOfgs3FgxDhhpaeHEQ1cP1WCdAtVGzZ
	6Mq477mo9aEX1ThtGBeqoP12lErjN23g+tCXPOqf+32rixsQx8wSz0TKNo4Ut32lc0n2H/28m1m
	dzdD2dhbolHQsF6HDvgAjR2yKMcNasW/T5J/s5FadEGvT9Z/31oc/9+o7ppxQU50BKk/x8s8hyS
	2rbCMNkxAFhrf3mzbXxBh05R96/5BRqzikgZ5UKROf83jGIiLilzVpsrcmgUyOg39oS9oRqQHsk
	X6V+B7KqCegeVrn6GslbJs50aCIPEb7ZbQZh7S3qDfitny0cOBOBksIePH+QCc4vvUuf8JYXMpk
	/a5WJoZCKqsPHQxc5yiu8R6aJIBun0sEoa3bGyNVF2JnUnGxKWyQchX+AGu3ytvFfmWV4rsLGYz
	SrnPc9ctBKuz325XtDXlSGb3s0emSMS3TaKhJ/E62k1sjTF2v/aqFlDFgOGZcQPnzzyBOJObjJ0
	gxQeweSaqbm/9Bsz905emazEL0mIc7uKiQE4Vo9zw4k6nbf5h5HkEiaUuS6KD6gqVIIpLrvCpYE
	NbsEo9da9MmY1XOIMuWUb4X3hX1ijqjgHNJCJRva
X-Received: by 2002:a05:7022:3b8a:b0:143:2982:1046 with SMTP id a92af1059eb24-165dce72ec8mr3882528c88.39.1791466608477;
        Thu, 08 Oct 2026 06:36:48 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16168f62a5esm15220725c88.14.2026.10.08.06.36.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 06:36:48 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 2/3] device: Add Role property
Date: Thu,  8 Oct 2026 06:36:33 -0700
Message-ID: <20261008133634.30362-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008133634.30362-1-kevin@simpleble.org>
References: <20261008133634.30362-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements Role property using the initiator flag of the Device
Connected event, which the kernel sets when the adapter created the
connection as central, and emits PropertiesChanged when an LE
connection is added or removed.

Assisted-by: Claude:claude-opus-5.5
---
 src/device.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/device.c b/src/device.c
index 1ab4e5342..1984b3e1c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1457,6 +1457,28 @@ static gboolean dev_property_get_connected(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_get_role(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *dev = data;
+	const char *role;
+
+	/* The initiator of an LE connection is always the central */
+	role = dev->le_state.initiator ? "peripheral" : "central";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &role);
+
+	return TRUE;
+}
+
+static gboolean dev_property_exists_role(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *dev = data;
+
+	return dev->le_state.connected;
+}
+
 static gboolean dev_property_get_uuids(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -3796,6 +3818,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "CablePairing", "b", dev_property_get_cable_pairing },
 	{ "RSSI", "n", dev_property_get_rssi, NULL, dev_property_exists_rssi },
 	{ "Connected", "b", dev_property_get_connected },
+	{ "Role", "s", dev_property_get_role, NULL, dev_property_exists_role },
 	{ "UUIDs", "as", dev_property_get_uuids },
 	{ "Modalias", "s", dev_property_get_modalias, NULL,
 						dev_property_exists_modalias },
@@ -3944,6 +3967,10 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
 	state->connected = true;
 	state->initiator = flags & BIT(3);
 
+	if (bdaddr_type != BDADDR_BREDR)
+		g_dbus_emit_property_changed(dbus_conn, dev->path,
+						DEVICE_INTERFACE, "Role");
+
 	if (dev->le_state.connected && dev->bredr_state.connected)
 		return;
 
@@ -4060,6 +4087,10 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 	state->initiator = false;
 	device->general_connect = FALSE;
 
+	if (bdaddr_type != BDADDR_BREDR)
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "Role");
+
 	device_set_svc_refreshed(device, false);
 
 	if (device->disconn_timer > 0) {
-- 
2.54.0 (Apple Git-157)

