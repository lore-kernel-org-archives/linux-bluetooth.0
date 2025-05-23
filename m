Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E98429672F
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010313; cv=none; b=MTozFPWeSSBLBFsmnxo3QqKSEFIbV9+1ZqdAXFQMMgPU80A040sVOkzELO2GYTiR0mpebpgou3HyR15ZCbsJHN3elR+APKxuKz47pqfM4xeN3vDmkUAM2k1NsUffdLuwTx54kDk6E/JYQY0w9BkprRc8bSUEAZ3j/RRYII6DswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010313; c=relaxed/simple;
	bh=WkPpEYQD6/0L3oU5nfiijjL8PK5jrszRcNjt/hq1NSc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoRjCIU5sAylK5++bf1LFXjjQbkrQfdExnbVc18fit595HE7lCWIV7XSYn1GSQxc74JJPGu17rcDWyzeqwBa6ZFpMDjsy3lhhooYZJhpRsOf0Uxt47tMGEkWl5oEEoNATG3+jreK4ycEwGn/PdcNQjEtecQ8XhsO/3mUi5XRcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyQFY9Ug; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyQFY9Ug"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c7913bab2cso926162785a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748010309; x=1748615109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjXH6omJNQD/ZRNQroaO4b00SQL+neFkNXItZmD5B5I=;
        b=UyQFY9UgWdPV5pifn7W8pJSmH5AG1MBlDH7bN9fFXNOGT793ugO8Z5lrHBRrwvv9yA
         9rPAPtBB9wTQVAElGVhORk8Ht7iuGaBAb6Of5TPFFxhnPczljMApvvK6LDXw/mjm2LRl
         PyG+Gzx6eMYvVeNeUQF3We7DUKrO0wii5H2AHLHzO4bQyyZbn6zIAlStoa9e8L+NQMKX
         74s2dC1watb2ylgUPzfUhLbNWneteMyGb/1nzrwUQABquTM1fJ/uU4Pavc+jpvJ6Oynm
         JDNJPdhrUTeUahsssqXy4yilWsU+M6bniRQKh3A7MkfYRuvOOsv5mBQL+iHJIO4BhBZM
         xdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748010309; x=1748615109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjXH6omJNQD/ZRNQroaO4b00SQL+neFkNXItZmD5B5I=;
        b=kQubBsRucjpX1FXSIVFDwFORAie3eGTVG8QhpfTDSrf//TCn1Njuhi9NI3PQtADoHm
         gs/vtKw2rgrtVK2Gu1WBf8ka8eicvljNw+qd1OrQNDOISj9gcG3WJKnBBew48ZcVThGc
         B7DXG4X2mqaVTRlFUEl4qD4MEtDCgbutPwVyVf1rPz5xLY8XQUtNTOLrewKLOi206CE8
         BqSVZO/H1F8Jjk8C49M2kaQH/Q3+N2rrVTnsJfIy4SWnGyrXr2YYOcKSB87AB/EeYpoK
         2UCAbo6LnjKHoXfWYeCHj3Ak3fV2etNNr8dME4Qf3Ea80tOj/pJl+PeWqcovAHJW4VhA
         0Veg==
X-Gm-Message-State: AOJu0YzkFkQCpk90YW3GlznjI2U2zL2FmKTlXtOB8xQKFSVgINc4KMOy
	OqkPF7rXf9d41yhj93tKJbaiNIHKq8TGLYKbKZUQXbcCjw5uY0lf24DqaTXsV4e7
X-Gm-Gg: ASbGnctGTqcNNmIaG5Yh/LL2tFU5oCWX69KHHUbDqkZyLzZVcfdhAC1kIJ4SGBmqOX7
	SB8kZ9Gp7r3Qfe5/hSgi55RSRUL0AS+IaN7XDl3dAAzDE/PubAVYX8Hk1Lxl5kI0W9SCz74JjxQ
	JY6prT+GaNyhJDf1FFJ0o9Mx1Xm9liWmaA+FF0+Y1FzpKssdGIJDe7E8ZAMArO1rAQvbvGd5nPN
	OLE5uNu203mWGRqy4biZOWO9+PWzpMjh4+v2vJwHXbYfIqJeqbxIZKeiTU3UZjtcdJ8pcpwK3QI
	iB0OPmxB47/TRP/cK8MWHgPzOi7UUMokiF45l4rT/MDzOxq3btxhK2MMzEtrfUgFHP9BiUC+vUM
	EGdJNFtp5VtKM7lJyzdCN5AOCRqMFKxE=
X-Google-Smtp-Source: AGHT+IFCSpZSYZ958gdLJrokQU87TSm2XonyC+GweDahCXdJmwoOQnuR5laNL2P2LGnnjsw+pE/UuQ==
X-Received: by 2002:a05:620a:254c:b0:7ce:bd16:a1a5 with SMTP id af79cd13be357-7cebd16a676mr2823969285a.18.1748010309207;
        Fri, 23 May 2025 07:25:09 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec027524sm12246308241.0.2025.05.23.07.25.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:25:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] adapter: Implement SetFilterPolicy AutoConnect filter
Date: Fri, 23 May 2025 10:25:03 -0400
Message-ID: <20250523142505.3476436-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523142505.3476436-1-luiz.dentz@gmail.com>
References: <20250523142505.3476436-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements AutoConnect filter option in SetFilterPolicy method
according to its documentation.
---
 src/adapter.c |  55 +++++++++++++++++++++----
 src/device.c  | 111 +++++++++++++++++++++++++++-----------------------
 2 files changed, 107 insertions(+), 59 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index fd425e6d2fe4..6f0699302257 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -214,6 +214,7 @@ struct discovery_filter {
 	GSList *uuids;
 	bool duplicate;
 	bool discoverable;
+	bool auto_connect;
 };
 
 struct discovery_client {
@@ -2697,6 +2698,21 @@ static bool parse_pattern(DBusMessageIter *value,
 	return true;
 }
 
+static bool parse_auto_connect(DBusMessageIter *value,
+					struct discovery_filter *filter)
+{
+	dbus_bool_t connect;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return false;
+
+	dbus_message_iter_get_basic(value, &connect);
+
+	filter->auto_connect = connect;
+
+	return true;
+}
+
 struct filter_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct discovery_filter *filter);
@@ -2708,6 +2724,7 @@ struct filter_parser {
 	{ "DuplicateData", parse_duplicate_data },
 	{ "Discoverable", parse_discoverable },
 	{ "Pattern", parse_pattern },
+	{ "AutoConnect", parse_auto_connect },
 	{ }
 };
 
@@ -2748,6 +2765,7 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 	(*filter)->type = get_scan_type(adapter);
 	(*filter)->duplicate = false;
 	(*filter)->discoverable = false;
+	(*filter)->auto_connect = false;
 	(*filter)->pattern = NULL;
 
 	dbus_message_iter_init(msg, &iter);
@@ -2794,11 +2812,12 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 		goto invalid_args;
 
 	DBG("filtered discovery params: transport: %d rssi: %d pathloss: %d "
-		" duplicate data: %s discoverable %s pattern %s",
+		" duplicate data: %s discoverable %s pattern %s auto-connect %s",
 		(*filter)->type, (*filter)->rssi, (*filter)->pathloss,
 		(*filter)->duplicate ? "true" : "false",
 		(*filter)->discoverable ? "true" : "false",
-		(*filter)->pattern);
+		(*filter)->pattern,
+		(*filter)->auto_connect ? "true" : "false");
 
 	return true;
 
@@ -7212,7 +7231,7 @@ static void filter_duplicate_data(void *data, void *user_data)
 
 static bool device_is_discoverable(struct btd_adapter *adapter,
 					struct eir_data *eir, const char *addr,
-					uint8_t bdaddr_type)
+					uint8_t bdaddr_type, bool *auto_connect)
 {
 	GSList *l;
 	bool discoverable;
@@ -7242,15 +7261,21 @@ static bool device_is_discoverable(struct btd_adapter *adapter,
 		discoverable = false;
 
 		pattern_len = strlen(filter->pattern);
-		if (!pattern_len)
+		if (!pattern_len) {
+			*auto_connect = filter->auto_connect;
 			return true;
+		}
 
-		if (!strncmp(filter->pattern, addr, pattern_len))
+		if (!strncmp(filter->pattern, addr, pattern_len)) {
+			*auto_connect = filter->auto_connect;
 			return true;
+		}
 
 		if (eir->name && !strncmp(filter->pattern, eir->name,
-							pattern_len))
+							pattern_len)) {
+			*auto_connect = filter->auto_connect;
 			return true;
+		}
 	}
 
 	return discoverable;
@@ -7274,6 +7299,7 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 	bool name_resolve_failed;
 	bool scan_rsp;
 	bool duplicate = false;
+	bool auto_connect = false;
 	struct queue *matched_monitors = NULL;
 
 	confirm = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
@@ -7310,7 +7336,7 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 	ba2str(bdaddr, addr);
 
 	discoverable = device_is_discoverable(adapter, &eir_data, addr,
-							bdaddr_type);
+						bdaddr_type, &auto_connect);
 
 	dev = btd_adapter_find_device(adapter, bdaddr, bdaddr_type);
 	if (!dev) {
@@ -7330,7 +7356,14 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 				MGMT_SETTING_ISO_SYNC_RECEIVER))
 			monitoring = true;
 
-		if (!discoverable && !monitoring && not_connectable) {
+		/* Monitor Devices advertising RSI since those can be
+		 * coordinated sets not marked as visible but their object are
+		 * needed.
+		 */
+		if (eir_data.rsi)
+			monitoring = true;
+
+		if (!discoverable && !monitoring) {
 			eir_data_free(&eir_data);
 			return;
 		}
@@ -7468,6 +7501,12 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 	adapter->discovery_found = g_slist_prepend(adapter->discovery_found,
 									dev);
 
+	/* If device has a pattern match and it also set auto-connect then
+	 * attempt to connect.
+	 */
+	if (!btd_device_is_connected(dev) && auto_connect)
+		btd_device_connect_services(dev, NULL);
+
 	return;
 
 connect_le:
diff --git a/src/device.c b/src/device.c
index 56583f71a78b..60fdc2ef2779 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2569,9 +2569,61 @@ static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 	return dev->pending;
 }
 
+#define NVAL_TIME ((time_t) -1)
+#define SEEN_TRESHHOLD 300
+
+static uint8_t select_conn_bearer(struct btd_device *dev)
+{
+	time_t bredr_last = NVAL_TIME, le_last = NVAL_TIME;
+	time_t current = time(NULL);
+
+	/* Use preferred bearer or bonded bearer in case only one is bonded */
+	if (dev->bredr_state.prefer ||
+			(dev->bredr_state.bonded && !dev->le_state.bonded))
+		return BDADDR_BREDR;
+	else if (dev->le_state.prefer ||
+			(!dev->bredr_state.bonded && dev->le_state.bonded))
+		return dev->bdaddr_type;
+
+	/* If the address is random it can only be connected over LE */
+	if (dev->bdaddr_type == BDADDR_LE_RANDOM)
+		return dev->bdaddr_type;
+
+	if (dev->bredr_state.connectable && dev->bredr_state.last_seen) {
+		bredr_last = current - dev->bredr_state.last_seen;
+		if (bredr_last > SEEN_TRESHHOLD)
+			bredr_last = NVAL_TIME;
+	}
+
+	if (dev->le_state.connectable && dev->le_state.last_seen) {
+		le_last = current - dev->le_state.last_seen;
+		if (le_last > SEEN_TRESHHOLD)
+			le_last = NVAL_TIME;
+	}
+
+	if (le_last == NVAL_TIME && bredr_last == NVAL_TIME)
+		return dev->bdaddr_type;
+
+	if (dev->bredr && (!dev->le || le_last == NVAL_TIME))
+		return BDADDR_BREDR;
+
+	if (dev->le && (!dev->bredr || bredr_last == NVAL_TIME))
+		return dev->bdaddr_type;
+
+	/*
+	 * Prefer BR/EDR if time is the same since it might be from an
+	 * advertisement with BR/EDR flag set.
+	 */
+	if (bredr_last <= le_last && btd_adapter_get_bredr(dev->adapter))
+		return BDADDR_BREDR;
+
+	return dev->bdaddr_type;
+}
+
 int btd_device_connect_services(struct btd_device *dev, GSList *services)
 {
 	GSList *l;
+	uint8_t bdaddr_type;
 
 	if (dev->pending || dev->connect || dev->browse)
 		return -EBUSY;
@@ -2579,6 +2631,14 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
 	if (!btd_adapter_get_powered(dev->adapter))
 		return -ENETDOWN;
 
+	bdaddr_type = select_conn_bearer(dev);
+	if (bdaddr_type != BDADDR_BREDR) {
+		if (dev->le_state.connected)
+			return -EALREADY;
+
+		return device_connect_le(dev);
+	}
+
 	if (!dev->bredr_state.svc_resolved)
 		return -ENOENT;
 
@@ -2661,57 +2721,6 @@ resolve_services:
 	return NULL;
 }
 
-#define NVAL_TIME ((time_t) -1)
-#define SEEN_TRESHHOLD 300
-
-static uint8_t select_conn_bearer(struct btd_device *dev)
-{
-	time_t bredr_last = NVAL_TIME, le_last = NVAL_TIME;
-	time_t current = time(NULL);
-
-	/* Use preferred bearer or bonded bearer in case only one is bonded */
-	if (dev->bredr_state.prefer ||
-			(dev->bredr_state.bonded && !dev->le_state.bonded))
-		return BDADDR_BREDR;
-	else if (dev->le_state.prefer ||
-			(!dev->bredr_state.bonded && dev->le_state.bonded))
-		return dev->bdaddr_type;
-
-	/* If the address is random it can only be connected over LE */
-	if (dev->bdaddr_type == BDADDR_LE_RANDOM)
-		return dev->bdaddr_type;
-
-	if (dev->bredr_state.connectable && dev->bredr_state.last_seen) {
-		bredr_last = current - dev->bredr_state.last_seen;
-		if (bredr_last > SEEN_TRESHHOLD)
-			bredr_last = NVAL_TIME;
-	}
-
-	if (dev->le_state.connectable && dev->le_state.last_seen) {
-		le_last = current - dev->le_state.last_seen;
-		if (le_last > SEEN_TRESHHOLD)
-			le_last = NVAL_TIME;
-	}
-
-	if (le_last == NVAL_TIME && bredr_last == NVAL_TIME)
-		return dev->bdaddr_type;
-
-	if (dev->bredr && (!dev->le || le_last == NVAL_TIME))
-		return BDADDR_BREDR;
-
-	if (dev->le && (!dev->bredr || bredr_last == NVAL_TIME))
-		return dev->bdaddr_type;
-
-	/*
-	 * Prefer BR/EDR if time is the same since it might be from an
-	 * advertisement with BR/EDR flag set.
-	 */
-	if (bredr_last <= le_last && btd_adapter_get_bredr(dev->adapter))
-		return BDADDR_BREDR;
-
-	return dev->bdaddr_type;
-}
-
 static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
-- 
2.49.0

