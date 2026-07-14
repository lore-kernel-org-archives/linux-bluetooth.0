Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907337D10A
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996528; cv=none; b=OPkL287tMoh0Mq+7Os1lj1XxpsZ8g5QBgkXYh6e58Uv9g3cYMOBVwkShqaXJ937L14W2OO97gepa0q/izJTKd53IciblkQ10OUpNMWxWmfySi6QmDEMiMoh9DCbUysSnASle6NT2MwJJvDP3/SNqVOtCJyy/eahVbGnYG+xXywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996528; c=relaxed/simple;
	bh=RFXNPWIMeQVL2zkP6vZCfjIeoZE6VXFoVRvHewtcxhk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=OcuOxdrG0aJOGobl/Jp+6vykR+kXONQu8v36m4QaAkUskvKE1hnNFUKF/nRMGgZ7prIgMVqjnrJd/E7R1PpX5HrwJOhKOtl+2Z7GX+ljl6VK186inQyT5sNCvFWAfBgxTLhInHsGYOvqPG4g2z1rsKeLTowmyiD4RVWhm3GNfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=J8xZerZS; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="J8xZerZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783996517; bh=8vNVVYP94Aj5OhQLu+vcUwZaOKuwAUFnj9Lqoh9CHmw=;
	h=From:To:Cc:Subject:Date;
	b=J8xZerZSiYB52ZnPbq4Lt13zBZg0Rf+/NmFHhiVs9bYlezDfTqYOUL7+cZOoO4Bew
	 Ec3C8UwrgHj7KZsGg7rcz/c3XN7OhkV6stcwN3iBIhtRxpMOBnAtWW8lLTgPneAU6x
	 TviM8XmedyLBv8yw0ZJ+mOEJTDydnUICsyISRYSk=
Received: from caitao123456-pc.. ([116.128.244.169])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 8CF1665C; Tue, 14 Jul 2026 10:35:15 +0800
X-QQ-mid: xmsmtpt1783996515t3ifx2p8q
Message-ID: <tencent_30C21B156DA3D489D07B0E45B94001C9DB08@qq.com>
X-QQ-XMAILINFO: NHWsITUsYMGe0bRqE1NqmsmYuu9JUuIreOd6557VwSeVNk7JZo8BWvg/Xcl9OX
	 KGqg/vKvPxK0advhGDcPEaIwSCGIin7cT7+5nl35f0iUY4eqjOGOrIQX+hyvpR2pDUG94G/pVfjO
	 6Cdfi5jm5gZWou7Lu8P10QY8/ZB5m/RWJpQXhKZMErtcyIcDOhYVX7gOUJIFgwNEHlzjYdsUxcpg
	 xOFCacEtZ0kBaz5f+c4fgzmYdzQlZByAjMPbKxkxfQ/oile8A5BJffFxMiAUvIg2uLfFmTUzxL58
	 Bq6pwfJD2Z3XAzEHDZl7M8mI3ggSYdruxNSagOPNKuQA1duTSft2Hg6KqCFnmaTmtrTshaaHFKzZ
	 aj15dwhCkEsJ2yx9jkr27Z4v2P0TDVmwvUctehqnPRXQpoNPYox0mLDVxnjnlAmUeIJdjYdEbTW5
	 +mXtSnwhrgP95HgUlyEv2UU90u1xfF9NPbEMQwSTHRzu9Jd6TC3g1jJ/8d6I8bhS0MlgeKVzTrSc
	 p9cgKcBJ2EPAsRS3vUJxWnlMgM3K/SuLz3T8R1cIJ0kmOoJpGmRRQYU81qQgJMkAbbVvaBvDK9WP
	 sDOXAEVl/48iDScmJE9vOtIaMSDYYUP4nzcsMfldla9gBB3d0BWzs/JFWFJzGgbNjlPiMZ+GVH4C
	 TYhpghGkoFWchaweNFUPPo95277LH0SeFkQ28dKyrSwePqzWhbU6Y3iqTzph+EPrMc4bsuMXfBnF
	 5GEQnRF4j0wOtluLP83bK4P69hm05doa4nkhFqK4H35L8bL6EYLLffhhSNkTVVEd2lNRUjLlFz9r
	 pTgTiJuh6V38VcpqHunFgJ7uosZJgfNoSqsPq7wC13IRi+VGokK7BmyFB2NKVLgsT9o8+zKcMt02
	 FcQcZOkeN+UPDp63tFoO3v5GZdONIIcTPfmR5F7Oijx+8m/LhM4sK2POJJNtiFQWaeH58U3x95tf
	 AgLitu+j7iHsRHKEezH/Pu48gz5fy25vWsKXNKSF+ZcDxPoxRKfaNKiuwkyNUuFqqJuWffiuuymS
	 HmcJxLOw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: caitao <294305068@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	caitao <caitao@kylinos.cn>
Subject: [PATCH BlueZ] src/device: Add ConnectedUUIDs property
Date: Tue, 14 Jul 2026 10:35:08 +0800
X-OQ-MSGID: <20260714023508.84708-1-294305068@qq.com>
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

