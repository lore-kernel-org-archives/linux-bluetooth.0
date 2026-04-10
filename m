Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E613B0AC4
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775811558; cv=none; b=jhDfpAhDgQhbFDwwL7B3DsBkXF7ociLnnfQjDtXRoYDNG5BiMeRJ2Q3IjLcIjWKrLYCaLOdl3JTgk5q/W4s5EKGcRHnVRuXQLnzgaLrbJ0NQklww+RrVrWanttV4vXtHAqPThYGUzj+ou2gQFPkbtyGTjzGv6U80qNdXNZHMy6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775811558; c=relaxed/simple;
	bh=RFXNPWIMeQVL2zkP6vZCfjIeoZE6VXFoVRvHewtcxhk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=S71V9ajQVylcWcQgOXOD3nPbBQwxISyrUPWqpuMUTyz9bO6O0nw/bEywIQvmXfAreS7P9qZwfv5q/HwEUe25/jygYoB49Xq//Cl4xhMlj8aXjiH5Gij9Z7T1X2GhUtKcDEeJ+Itugaxl5GGz/417gXH0OqdYTwJ0YZSWUIMFl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=n4qIJBU6; arc=none smtp.client-ip=43.163.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="n4qIJBU6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775811546; bh=8vNVVYP94Aj5OhQLu+vcUwZaOKuwAUFnj9Lqoh9CHmw=;
	h=From:To:Cc:Subject:Date;
	b=n4qIJBU6PSJA5KHAKxClW2k/xprsts9pHP14Lpjf4xvZgL5V9lxeA787KfoiR4p84
	 DZpCJf+nkEb4JH5emsPegHkJz+exiN6bE48kq8E7t7g+OZKO4GrPUdzL4KEVw/drkG
	 oZec1s065OTCnF7F1biwWlRQbSICClFvd3NWB47Q=
Received: from caitao123456-pc.. ([116.128.244.169])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id EC424ABC; Fri, 10 Apr 2026 16:59:04 +0800
X-QQ-mid: xmsmtpt1775811544tw8bj2u5m
Message-ID: <tencent_8CF6DCCE00806DF68DB0363D6A1E68340707@qq.com>
X-QQ-XMAILINFO: NcJw5CIirWgGTT/h3BnJRNROp1drktkZO/4GNQhxxBmvlc//ImIfilRqbaXZYV
	 3K2gdWcSj4NPuSRsRvxSq51HIjknZ0j7v0+biHiKJc1ydVBh+hQCpmTrhdtZejn7H9JGAxpfJj0g
	 AJbfKnlFgmEgV/BDSIPPf0hA8gTvlKmSOetuTumPBsnZvnEqo3wAOhVa/xtEuPKKq8nBoIHYF+a1
	 h3j2t5wGiEWBH1vrB41LxzCBQEAsptYejb1mrLUFW1ski7UIwsz20RA7KunXk9RIYR6D30kIwdNO
	 FnW58luG1ek5kPuqES07gB/ae/Vxh4NFo5n64NHU7Bhqdw1ajtLb3ywW30RqsE5H0F8Nqinlk9cU
	 sO1RAczAcXe4Gn2jo+b5x4VQNMhzm7v9HvXeHgKb++CdYCp+wAbyspVaIRteO+25AEWbct6Spj2v
	 aV04l7Ih6b1Xk1bHGIFzueHdt6FGHBgh/xCZ3oUvyzY3ZF3kYkVYDtxYQv+IjOI8LJkRwT36ldfa
	 3NlgClssR5pDnvdXT2bYHGSRWEihv4eCOhI/E+meTkJj0OvO893MlAkYJQaUU21oJ6DjqSy/IG7o
	 1LMqToFumfd8bGoCieYQsB6Evzzok+W1dTco57m8g7gXQ2qStk50DpkmYq1syVPxqhxXjIVuY+mx
	 Be9Li5uVd4stWEXTvTQ6YjGW8wffkLERZu5NnOGj2ZLlvH6d9fh47nVBS5drpsQrK124q0YAW9ge
	 ZpMs0fEQB3acstRHdfbOVJKuDrOJBVs1N8d7/gv+z2LR23BLD+JAxnjC5I1b58xv9n7yppArfBzs
	 UHs15vZ2RoBe1LumHKbVG9uigTYFKSiq0XQ8JNMY0DpLq+PzAZO71eBhYaisaqjbE+VnrhUNjNp0
	 sI1gIuEKLK5BjILwp+/A7jTdiXOTN3hga5pC00VMVRARH22Ot3ekfG1yMYdE39/jC0Q3+JC2HLzE
	 wCg00NEH2EWLVr+XaG0Q==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: 294305068@qq.com
To: linux-bluetooth@vger.kernel.org
Cc: caitao <caitao@kylinos.cn>
Subject: [PATCH BlueZ] src/device: Add ConnectedUUIDs property
Date: Fri, 10 Apr 2026 16:59:01 +0800
X-OQ-MSGID: <20260410085901.146337-1-294305068@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: caitao <caitao@kylinos.cn>

Add a new D-Bus property "ConnectedUUIDs" (array of strings, read-only)
to the org.bluez.Device interface. This property tracks the UUIDs of
profiles that are currently connected on the device.

The property is updated dynamically when a service state changes to
CONNECTED or DISCONNECTED.
---
 doc/org.bluez.Device.rst |  5 +++
 src/device.c             | 72 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 3e6a30aaf..c592afbd5 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -284,6 +284,11 @@ array{string} UUIDs [readonly, optional]
 
 List of 128-bit UUIDs that represents the available remote services.
 
+array{string} ConnectedUUIDs [readonly]
+````````````````````````````````````````
+
+List of 128-bit UUIDs of profiles currently connected.
+
 boolean Paired [readonly]
 `````````````````````````
 
diff --git a/src/device.c b/src/device.c
index bb5bcd4f0..3bb244b98 100644
--- a/src/device.c
+++ b/src/device.c
@@ -244,6 +244,7 @@ struct btd_device {
 	char		*modalias;
 	struct btd_adapter	*adapter;
 	GSList		*uuids;
+	GSList		*connected_uuids;	/* Currently connected UUIDs */
 	GSList		*primaries;		/* List of primary services */
 	GSList		*services;		/* List of btd_service */
 	GSList		*pending;		/* Pending services */
@@ -910,6 +911,7 @@ static void device_free(gpointer user_data)
 	device->client_dbus = NULL;
 
 	g_slist_free_full(device->uuids, g_free);
+	g_slist_free_full(device->connected_uuids, g_free);
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->svc_callbacks, svc_dev_remove);
 
@@ -1464,6 +1466,70 @@ static gboolean dev_property_get_uuids(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static GSList *device_get_connected_uuids(struct btd_device *device)
+{
+	return device->connected_uuids;
+}
+
+static gboolean property_get_connected_uuids(const GDBusPropertyTable *property,
+						DBusMessageIter *iter,
+						void *data)
+{
+	struct btd_device *device = data;
+	GSList *l, *uuids = device_get_connected_uuids(device);
+	DBusMessageIter array_iter;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					 DBUS_TYPE_STRING_AS_STRING,
+					 &array_iter);
+
+	for (l = uuids; l; l = g_slist_next(l)) {
+		const char *uuid = l->data;
+		dbus_message_iter_append_basic(&array_iter,
+					       DBUS_TYPE_STRING,
+					       &uuid);
+	}
+
+	dbus_message_iter_close_container(iter, &array_iter);
+	return TRUE;
+}
+
+static void device_add_connected_uuid(struct btd_device *device, const char *uuid)
+{
+	if (!device || !uuid)
+		return;
+
+	if (g_slist_find_custom(device->connected_uuids, uuid,
+				(GCompareFunc)strcmp))
+		return;
+
+	device->connected_uuids = g_slist_append(device->connected_uuids,
+						 g_strdup(uuid));
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+				     DEVICE_INTERFACE, "ConnectedUUIDs");
+}
+
+static void device_remove_connected_uuid(struct btd_device *device, const char *uuid)
+{
+	GSList *match;
+
+	if (!device || !uuid)
+		return;
+
+	match = g_slist_find_custom(device->connected_uuids, uuid,
+				    (GCompareFunc)strcmp);
+	if (!match)
+		return;
+
+	g_free(match->data);
+	device->connected_uuids = g_slist_delete_link(device->connected_uuids,
+						      match);
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+				     DEVICE_INTERFACE, "ConnectedUUIDs");
+}
+
 static gboolean dev_property_get_modalias(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -3715,6 +3781,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "RSSI", "n", dev_property_get_rssi, NULL, dev_property_exists_rssi },
 	{ "Connected", "b", dev_property_get_connected },
 	{ "UUIDs", "as", dev_property_get_uuids },
+	{ "ConnectedUUIDs", "as", property_get_connected_uuids },
 	{ "Modalias", "s", dev_property_get_modalias, NULL,
 						dev_property_exists_modalias },
 	{ "Adapter", "o", dev_property_get_adapter },
@@ -8231,6 +8298,11 @@ static void service_state_changed(struct btd_service *service,
 		device_profile_connected(device, profile, err);
 	else if (old_state == BTD_SERVICE_STATE_DISCONNECTING)
 		device_profile_disconnected(device, profile, err);
+
+	if (new_state == BTD_SERVICE_STATE_CONNECTED)
+		device_add_connected_uuid(device, profile->remote_uuid);
+	else if (new_state == BTD_SERVICE_STATE_DISCONNECTED)
+		device_remove_connected_uuid(device, profile->remote_uuid);
 }
 
 struct btd_service *btd_device_get_service(struct btd_device *dev,
-- 
2.43.0

