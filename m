Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCCD42A79B
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981426; cv=none; b=aUu0gCtNU5NZ7RtnhafWPV3eVY3idF174oePwP0QaIVe4RRwU+xG9y3wOfcdNLLTqMYRsYOTGvvn6z206jVsgymkl6Jd8KiFW52E2UEu6Ejiyw4BQrNOFhmh9oUZpUUz/c2qlyDHFU+Anat5pVo8XQbInPvJOWGoTUagiEsvohI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981426; c=relaxed/simple;
	bh=fl3t8gc222n0gUiRAge0UI371dYK9PgdA6dwAMaHorc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+RmH+QPI6Tc9V/HeHqL9rwOrAmXcybi+UFtCZchiBUgL/TyxpLBxPsAYflgzYVDCHcBh8Wx5aHI9x6kpdAd8frTY7d41fL3mC0pVU31eLSqEVfAoTFTVQVq4JcbGNNUoSArzVxW8Rvf9dTgnZaPRmNSIQTA3I4La7nll2ImUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QA2vjVaY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QA2vjVaY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782981410;
	bh=fl3t8gc222n0gUiRAge0UI371dYK9PgdA6dwAMaHorc=;
	h=From:To:Subject:Date:From;
	b=QA2vjVaYGddbsPrikdpl7USlRr4k0AdjyUG1Q98vyTzrJfmanGF0K9RTEcQoTYRcp
	 uevTxA/LeGy0WiOppkWmP+DFYnhXW2RH+YLCM4tuodp75LXs6VJzDei/NJgRdOkaGk
	 MInm2IfnTLnJ/SGbhs2VpxWQVn32oIqGcO8kYqgoxTZ/EAccj5J91PNMcoZr+3qp3S
	 AUkoJwfbNXD/9xu7utM8XpIkCs2BGXXPns75sFcJsuv+2WQMxeXRBvjJGmMVwN22I0
	 VOVgEFWYV4cqx/0b3gzHDYQLh7+CnSL7YmiNtf6NChTicR8NucbhogjyM2Kz9JnVjk
	 vgiZxAdkC+0Nw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5200117E00A0
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 10:36:50 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] plugins/admin: make AdminPolicy state per-adapter
Date: Thu,  2 Jul 2026 10:36:35 +0200
Message-ID: <20260702083641.378994-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Fix AdminPolicy D-Bus updates being emitted on the wrong adapter path
by removing the single global policy context and moving to per-adapter
policy objects.

Changes include:
- track policy contexts in a policy queue keyed by adapter pointer
- keep per-adapter device lists inside each policy context
- emit ServiceAllowList changes using the callback's adapter context
- scope device affected updates to the current adapter only
- clean up probe/remove lifecycle so adapters are registered and torn
  down independently
- remove remaining global policy_data/devices coupling

Assisted-by: GPT:GPT-5.3-Codex
---
 plugins/admin.c | 130 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 99 insertions(+), 31 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 76c65d068..6c5c8d97f 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -39,21 +39,45 @@
 #define BTD_DEVICE_INTERFACE		"org.bluez.Device1"
 
 static DBusConnection *dbus_conn;
-static struct queue *devices; /* List of struct device_data objects */
+static struct queue *policies; /* List of struct btd_admin_policy objects */
 
-/* |policy_data| has the same life cycle as btd_adapter */
-static struct btd_admin_policy {
+/* One policy context per adapter */
+struct btd_admin_policy {
 	struct btd_adapter *adapter;
 	uint16_t adapter_id;
 	struct queue *service_allowlist;
-} *policy_data = NULL;
+	struct queue *devices;
+};
 
 struct device_data {
 	struct btd_device *device;
 	char *path;
 	bool affected;
+	struct btd_admin_policy *policy;
 };
 
+static void free_device_data(void *data);
+static void unregister_device_data(void *data, void *user_data);
+
+static bool policy_match_adapter(const void *data, const void *match_data)
+{
+	const struct btd_admin_policy *policy = data;
+	const struct btd_adapter *adapter = match_data;
+
+	if (!policy)
+		return false;
+
+	return policy->adapter == adapter;
+}
+
+static struct btd_admin_policy *admin_policy_find(struct btd_adapter *adapter)
+{
+	if (!policies)
+		return NULL;
+
+	return queue_find(policies, policy_match_adapter, adapter);
+}
+
 static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
 {
 	struct btd_admin_policy *admin_policy = NULL;
@@ -68,6 +92,16 @@ static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
 	admin_policy->adapter = adapter;
 	admin_policy->adapter_id = btd_adapter_get_index(adapter);
 	admin_policy->service_allowlist = queue_new();
+	admin_policy->devices = queue_new();
+
+	if (!admin_policy->service_allowlist || !admin_policy->devices) {
+		queue_destroy(admin_policy->service_allowlist, free);
+		queue_destroy(admin_policy->devices, NULL);
+		g_free(admin_policy);
+		btd_error(btd_adapter_get_index(adapter),
+				"Failed to allocate queues for admin_policy");
+		return NULL;
+	}
 
 	return admin_policy;
 }
@@ -82,6 +116,7 @@ static void admin_policy_free(void *data)
 	struct btd_admin_policy *admin_policy = data;
 
 	free_service_allowlist(admin_policy->service_allowlist);
+	queue_destroy(admin_policy->devices, free_device_data);
 	g_free(admin_policy);
 }
 
@@ -89,6 +124,8 @@ static void admin_policy_destroy(struct btd_admin_policy *admin_policy)
 {
 	const char *path = adapter_get_path(admin_policy->adapter);
 
+	queue_foreach(admin_policy->devices, unregister_device_data, NULL);
+
 	g_dbus_unregister_interface(dbus_conn, path,
 						ADMIN_POLICY_SET_INTERFACE);
 	g_dbus_unregister_interface(dbus_conn, path,
@@ -346,7 +383,7 @@ static void load_policy_settings(struct btd_admin_policy *admin_policy)
 			btd_adapter_get_storage_dir(admin_policy->adapter));
 
 	if (stat(filename, &st) < 0)
-		store_policy_settings(policy_data);
+		store_policy_settings(admin_policy);
 
 	key_file = g_key_file_new();
 
@@ -387,11 +424,11 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 	}
 
 	g_dbus_emit_property_changed(dbus_conn,
-					adapter_get_path(policy_data->adapter),
+					adapter_get_path(admin_policy->adapter),
 					ADMIN_POLICY_STATUS_INTERFACE,
 					"ServiceAllowList");
 
-	queue_foreach(devices, update_device_affected, NULL);
+	queue_foreach(admin_policy->devices, update_device_affected, NULL);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -488,66 +525,86 @@ static void remove_device_data(void *data)
 
 	DBG("device_data for %s removing", device_data->path);
 
-	queue_remove(devices, device_data);
+	if (device_data->policy)
+		queue_remove(device_data->policy->devices, device_data);
+
 	free_device_data(device_data);
 }
 
 static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 {
+	struct btd_admin_policy *policy;
 	const char *adapter_path;
 
-	if (!devices)
-		devices = queue_new();
+	if (!policies)
+		policies = queue_new();
 
-	if (policy_data) {
-		btd_warn(policy_data->adapter_id,
+	if (!policies)
+		return -ENOMEM;
+
+	if (admin_policy_find(adapter)) {
+		btd_warn(btd_adapter_get_index(adapter),
 						"Policy data already exists");
-		policy_data = NULL;
+		return -EALREADY;
 	}
 
-	policy_data = admin_policy_new(adapter);
-	if (!policy_data)
+	policy = admin_policy_new(adapter);
+	if (!policy)
 		return -ENOMEM;
 
-	load_policy_settings(policy_data);
+	load_policy_settings(policy);
 	adapter_path = adapter_get_path(adapter);
 
 	if (!g_dbus_register_interface(dbus_conn, adapter_path,
 					ADMIN_POLICY_SET_INTERFACE,
 					admin_policy_adapter_methods, NULL,
-					NULL, policy_data, NULL)) {
-		btd_error(policy_data->adapter_id,
+					NULL, policy, NULL)) {
+		btd_error(policy->adapter_id,
 			"Admin Policy Set interface init failed on path %s",
 								adapter_path);
+		admin_policy_free(policy);
 		return -EINVAL;
 	}
 
-	btd_info(policy_data->adapter_id,
+	btd_info(policy->adapter_id,
 				"Admin Policy Set interface registered");
 
 	if (!g_dbus_register_interface(dbus_conn, adapter_path,
 					ADMIN_POLICY_STATUS_INTERFACE,
 					NULL, NULL,
 					admin_policy_adapter_properties,
-					policy_data, NULL)) {
-		btd_error(policy_data->adapter_id,
+					policy, NULL)) {
+		btd_error(policy->adapter_id,
 			"Admin Policy Status interface init failed on path %s",
 								adapter_path);
+		g_dbus_unregister_interface(dbus_conn, adapter_path,
+						ADMIN_POLICY_SET_INTERFACE);
+		admin_policy_free(policy);
 		return -EINVAL;
 	}
 
-	btd_info(policy_data->adapter_id,
+	btd_info(policy->adapter_id,
 				"Admin Policy Status interface registered");
 
+	queue_push_tail(policies, policy);
+
 	return 0;
 }
 
 static void admin_policy_device_added(struct btd_adapter *adapter,
 						struct btd_device *device)
 {
+	struct btd_admin_policy *policy;
 	struct device_data *data;
 
-	if (queue_find(devices, device_data_match, device))
+	policy = admin_policy_find(adapter);
+	if (!policy) {
+		btd_warn(btd_adapter_get_index(adapter),
+				"Policy data not found for adapter");
+		return;
+	}
+
+	if (queue_find(policy->devices, device_data_match, device))
 		return;
 
 	data = g_new0(struct device_data, 1);
@@ -560,6 +617,7 @@ static void admin_policy_device_added(struct btd_adapter *adapter,
 	data->device = device;
 	data->path = g_strdup(device_get_path(device));
 	data->affected = !btd_device_all_services_allowed(data->device);
+	data->policy = policy;
 
 	if (!g_dbus_register_interface(dbus_conn, data->path,
 					ADMIN_POLICY_STATUS_INTERFACE,
@@ -573,7 +631,7 @@ static void admin_policy_device_added(struct btd_adapter *adapter,
 		return;
 	}
 
-	queue_push_tail(devices, data);
+	queue_push_tail(policy->devices, data);
 
 	DBG("device_data for %s added", data->path);
 }
@@ -589,9 +647,14 @@ static void unregister_device_data(void *data, void *user_data)
 static void admin_policy_device_removed(struct btd_adapter *adapter,
 						struct btd_device *device)
 {
+	struct btd_admin_policy *policy;
 	struct device_data *data;
 
-	data = queue_find(devices, device_data_match, device);
+	policy = admin_policy_find(adapter);
+	if (!policy)
+		return;
+
+	data = queue_find(policy->devices, device_data_match, device);
 
 	if (data)
 		unregister_device_data(data, NULL);
@@ -599,15 +662,20 @@ static void admin_policy_device_removed(struct btd_adapter *adapter,
 
 static void admin_policy_remove(struct btd_adapter *adapter)
 {
+	struct btd_admin_policy *policy;
+
 	DBG("");
 
-	queue_foreach(devices, unregister_device_data, NULL);
-	queue_destroy(devices, g_free);
-	devices = NULL;
+	policy = admin_policy_find(adapter);
+	if (!policy)
+		return;
+
+	queue_remove(policies, policy);
+	admin_policy_destroy(policy);
 
-	if (policy_data) {
-		admin_policy_destroy(policy_data);
-		policy_data = NULL;
+	if (!queue_length(policies)) {
+		queue_destroy(policies, NULL);
+		policies = NULL;
 	}
 }
 
-- 
2.43.0

