Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6053DD87A
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919989; cv=none; b=Z96Ab3A/KrtsAmRmTqffExT4JrdiIsklQiUFLDtFcwvZjeZDfpWOOKXCiQm7p2dDOcmY/G+KjusfkoFY9iVUTc9U9bpsrTe6R5Qah82kzSt2HI5Buw71iSLIYN01aGJOkqe/qnvLx2p1UGsxyAUP3EFATee6aF2VhYdS0LQBAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919989; c=relaxed/simple;
	bh=Pg1oL5QUcGbxse0G5BdtKHQl7tU3iu3wdm83tfHaGG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkOBCtDfANdsqbogA2IPyZ7UPsyeDGKtCrqEtwICESZk4HzemCE7SP6cWzvI7ONfpqhSxvNczu4Re9/I9zO56fqPZ2iYRunPkzJdYLsDCi0tPyF8NiFfRbKsZU3NfLGU8mgjZRMtOZYIt1HAsxNUTZlKGsWdIxJLy/iJrPS/Nlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=QNV+KUUe; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="QNV+KUUe"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b4f2d90c4so3226991eec.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 22:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790919987; x=1791524787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lna9x4Ty5/f/iZm5y6wIav83B+5NQsj8ZDNarOZ1bY8=;
        b=QNV+KUUeWKoEAI7qbA8WAJQ9YhllN8SpwrZkCRvYUTZYe8PCBBMuCMjiJfY7Pd0s3Z
         cjiKF6QDiJZVfbZ1EbM9+G5feBxA2Mq3SuSdnkSjonSWdYXNzJysOJyTkj59TUG6fVsw
         vGvAlmN6VrI/gxI8WHCgr5Iqdjxf/L0+LlImLpDIpSzHWW1px5+8s2aqJhx2d3aLmazs
         nQ+S/pwb+QWASd51JXYcczJVkh6TaSxW0yLkehnikDrGvgE2bGhTUBH+UEvuifDWRhkP
         O66Mgv4Ymt00Y9yPQyloLHmw+To6eZ1l9vodWyYxe+brKh2Yue1HRXL04wnVFJXbz3Mu
         J9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790919987; x=1791524787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lna9x4Ty5/f/iZm5y6wIav83B+5NQsj8ZDNarOZ1bY8=;
        b=hL1eNJdaB/Me+APhU4v2M9WFEJ4qwEohIX62o7yDpjd5EfID6Yg3A2mN6JjMoFt6Ox
         FA9MIg56k6i6VUpyH50lmruVCkPHpE2n1SwPR+Zqob4Ji0n1zoFjteVqIflh9UEvHJdh
         ENsz2Dz27mGSgNfi90dp20a96QlOS/KQvPRRhmtApk4oF369QOZ9uxmfktN0/Le3Soig
         n30qNxPX4br58Yfa3Ze6Nrmkm2fShSwvUCjGrkBflhtTfQjq196UxKoFfwFSMOr/hHFe
         4l1hYqGV80hxuxHfukxK7lWOxrNcRnrzKHF8DsH/aUtvcAtdla6wY/UxDTVEwmwGbP83
         +v7A==
X-Gm-Message-State: AFq9FYKorVC82cNI4rCgF6XowuaGKEyRoxlKobqdNq3GodXxhyBC1drH
	etZUn0cIveOww90YjPwCbBjIqFm0VyEGQ/zLl95P+1XHoN9rgLPd0ypBXMY9GLjx5IiL8sxd0HL
	chG7MXVA=
X-Gm-Gg: AYBFou3DJYmkxMc5ni0F4uOYZ5d6fY7jCgjHJmq0nJU8J16xNHUKCatApNoXWwRYyRp
	7iXSFGQiSs/xlS/3jJgWCVgZv7deMuQ244jSn4HpEToVuWpI+ZfOM7HufiXwTBvNKznI6Z62mAt
	7DNvxcMF3h/8RVsWBObcHcq0R9xHaKCvUZx4bh0j8TIkWuxEJ3yNK+3rQMfoDJHicSLL9bAumWV
	D8E2TMRDB706/gBk7jWr4DQGzJrEMTHUFM3seSELyttuX9uxud+PdA46BqBvMkZSSZt+XKwOaQK
	waoPchoTInk2+4kVw+SGtnIwX+wgaN0iWje3P/fLKKpZxHadRo1JPvv19beOxi4mMEink17/0k1
	dzU261hYIoMsquUdXFRl+F3YbX6UNlR2ltK34tB8NyP7H9udHe5NYHZNGakZc2qc23VGSr3AbWd
	3mcvn0wPmMnovWcYoA2PT6Ff7E3Tf0XlaEt/V+CFjqXD7L8Mif4rj5lY7yreLY0CQsNqEeLP2jq
	43AY5N6hqBIrLTUqBZFcb5ezurKOpl4LeUF5qECrqJUKL7OZMTT0PJeaH7lR6qZcLna7lI2MVd2
	KZChzHuRxfxFX4c56m747Hg2svx3+fkh3iwBtHjd
X-Received: by 2002:a05:7300:6811:b0:33b:ef1f:14b9 with SMTP id 5a478bee46e88-34f150bd713mr1495246eec.15.1790919986657;
        Thu, 01 Oct 2026 22:46:26 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f15019999sm3064217eec.29.2026.10.01.22.46.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 22:46:26 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 4/6] bearer: Add Connectable property
Date: Thu,  1 Oct 2026 22:46:15 -0700
Message-ID: <20261002054618.30994-5-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002054618.30994-1-kevin@simpleble.org>
References: <20261002054618.30994-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements Connectable property for both bearers. For LE it
reflects whether the last advertising report was connectable, and
PropertiesChanged is emitted from device_update_last_seen when it
changes or first becomes known. BREDR always reports it as true.
---
 src/bearer.c | 38 ++++++++++++++++++++++++++++++++++++++
 src/bearer.h |  1 +
 src/device.c | 18 ++++++++++++++++++
 src/device.h |  2 ++
 4 files changed, 59 insertions(+)

diff --git a/src/bearer.c b/src/bearer.c
index ac3a220..f3b7a23 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -249,6 +249,31 @@ static gboolean bearer_get_connected(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean bearer_get_connectable(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_bearer *bearer = data;
+	dbus_bool_t connectable;
+
+	connectable = btd_device_bdaddr_type_connectable(bearer->device,
+								bearer->type);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &connectable);
+
+	return TRUE;
+}
+
+static gboolean bearer_connectable_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_bearer *bearer = data;
+
+	if (bearer->type == BDADDR_BREDR)
+		return TRUE;
+
+	return btd_device_bdaddr_type_seen(bearer->device, bearer->type);
+}
+
 static const GDBusSignalTable bearer_signals[] = {
 	{ GDBUS_SIGNAL("Disconnected",
 			GDBUS_ARGS({ "name", "s" }, { "message", "s" })) },
@@ -264,6 +289,9 @@ static const GDBusPropertyTable bearer_properties[] = {
 			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Connected", "b", bearer_get_connected, NULL, NULL,
 			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Connectable", "b", bearer_get_connectable, NULL,
+			bearer_connectable_exists,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{}
 };
 
@@ -354,6 +382,16 @@ void btd_bearer_bonded(struct btd_bearer *bearer)
 					"Bonded");
 }
 
+void btd_bearer_connectable(struct btd_bearer *bearer)
+{
+	if (!bearer || !bearer->path)
+		return;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
+					bearer_interface(bearer->type),
+					"Connectable");
+}
+
 void btd_bearer_connected(struct btd_bearer *bearer, int err)
 {
 	DBusMessage *reply;
diff --git a/src/bearer.h b/src/bearer.h
index a201003..238d0a1 100644
--- a/src/bearer.h
+++ b/src/bearer.h
@@ -18,5 +18,6 @@ void btd_bearer_destroy(struct btd_bearer *bearer);
 
 void btd_bearer_paired(struct btd_bearer *bearer);
 void btd_bearer_bonded(struct btd_bearer *bearer);
+void btd_bearer_connectable(struct btd_bearer *bearer);
 void btd_bearer_connected(struct btd_bearer *bearer, int err);
 void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason);
diff --git a/src/device.c b/src/device.c
index dedab65..77744d0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3829,6 +3829,19 @@ bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type)
 	return dev->le_state.connected;
 }
 
+bool btd_device_bdaddr_type_connectable(struct btd_device *dev, uint8_t type)
+{
+	if (type == BDADDR_BREDR)
+		return true;
+
+	return dev->le_state.connectable;
+}
+
+bool btd_device_bdaddr_type_seen(struct btd_device *dev, uint8_t type)
+{
+	return get_state(dev, type)->last_seen != 0;
+}
+
 static void clear_temporary_timer(struct btd_device *dev)
 {
 	if (dev->temporary_timer) {
@@ -5372,8 +5385,10 @@ void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type,
 	struct bearer_state *state;
 	bool known = device_connectable_known(device);
 	bool was_connectable = device_is_connectable(device);
+	bool changed;
 
 	state = get_state(device, bdaddr_type);
+	changed = !state->last_seen || state->connectable != connectable;
 
 	state->last_seen = time(NULL);
 	state->connectable = connectable;
@@ -5383,6 +5398,9 @@ void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type,
 		g_dbus_emit_property_changed(dbus_conn, device->path,
 					DEVICE_INTERFACE, "Connectable");
 
+	if (changed && bdaddr_type != BDADDR_BREDR)
+		btd_bearer_connectable(device->le);
+
 	if (!device_is_temporary(device))
 		return;
 
diff --git a/src/device.h b/src/device.h
index fdc036e..597df74 100644
--- a/src/device.h
+++ b/src/device.h
@@ -127,6 +127,8 @@ void device_set_flags(struct btd_device *device, uint8_t flags);
 bool btd_device_is_connected(struct btd_device *dev);
 bool btd_device_bearer_is_connected(struct btd_device *dev);
 bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type);
+bool btd_device_bdaddr_type_connectable(struct btd_device *dev, uint8_t type);
+bool btd_device_bdaddr_type_seen(struct btd_device *dev, uint8_t type);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
-- 
2.54.0 (Apple Git-157)

