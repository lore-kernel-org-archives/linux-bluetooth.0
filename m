Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E2E38D6B8
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199313; cv=none; b=toGYTWbvlmLX28DM3HjufihWz2BoTXAafsJRHGvPBlb3EOjYaBDHUPRDTMBNks5e/GjBkDng9jtNZk0xTyAhaVcs3L4YhyKhkgnzkfSg/Wh3RxEdIUFxF/WpUvi1cWTLBv0TzmKXIE5+nJ162p2poBzR94GUfuUBNq1GjMfqdkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199313; c=relaxed/simple;
	bh=P+uJHKl7Qv18NfTPYQjmhMJxVkhMFqKiI6Pa0Rqp5PA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qBrYri1oki9j0noalh8ZDrYOSkYWKfJjT8XuFkHT7RHnqQiXLeT5e7iY/aVEMTXWAjMNtsf6oRh8P+VBHEkA2/o0mOGiM+smzgr3967AkEdyBmmYJGgXZjwmU5kXgptJ7kLb/GaR2jAp7G3iiFWlMGgIZAKDcQLTBR1STCFwP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uj5zEyJv; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uj5zEyJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784199305; bh=X0+/XKEOFmIwuwY7fq0XH6KuG/0LGxzensQfw1+1Qvw=;
	h=From:To:Cc:Subject:Date;
	b=uj5zEyJvzIKm12KMXYv80PzCmC6DIen2lyZhwqnAcpJi2tL9w4OOP2be6/En4HSr2
	 6umdWTjT6KrrV4ZJJ4uKPa/XCq2iJSFC1luXw9GzMaR75BDBXWnOxtoHUnO+ewJiRy
	 w0BhUrznuz8V99Oet3Wv42u8W0PjZfBrXTaHH0qE=
Received: from v25u1-PC ([61.183.83.60])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id DC39B052; Thu, 16 Jul 2026 18:55:03 +0800
X-QQ-mid: xmsmtpt1784199303t1ldcuq0o
Message-ID: <tencent_7E6A07CE6162892EDEFA29E082F2D2A8AE05@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvT7+0FjoSCa6+JAtMgiIPDYLqrR4PQeVVuPt0p0OYLKgFJYhgXaf
	 RqhKdlcrQdZFg4U9zZCZvWzSsvfb8O1W9UDlw9NpPu3VsfgTj9qpW0tUlru03lEhA9PRPwMbA+wD
	 zIwoaNgDq8K5HqVnxll69vff/6Acf1+A5gwgX0IWGaNy7QbI4WnJhkeoDyesremvshRE7zm+AAnp
	 BsUQcYjIeN4g2z4M6pxAIyjSWZADottTZudnJ5RePjE6H1vBoujITNyEOeskhKLxnSXY4W392hSY
	 fdQz/Bsp/FtjmH1AuQ/tCPxuRC1kEHhDyVXf/YAnPtQ32vxCTqEewPSl2b0KcQ0fThS3JqlkbW0Z
	 /vhUVXYR1gPbPxs0iVaKNvO5OZwvfR9P1GF/CcUGaY23JxR4KxJ+yq0JBcg3A1PY/h2wrB0pnhyR
	 1Wu1X3p2fMntV6ocsFgXPUEpm59+icwrNaAu0ph+0Uj9T40xczPIsZxSVWOx9KPo7L4Utzz4KMyk
	 PGj7B+uyi69P9P8mOhgYwGCPVTklIghv1PJ0ZLgv4eKS2PQbR2sM5NdonoS5XK6x6nWhBEKN9JeW
	 oW9P4IM27Pno5hb8QA7xie0FvH4dcDRQKSMdi5mzk94OABiFz6TNb3pOGvPWCDxCXu4ldtBIqKI4
	 DjjC7DfqYUpKfe5BIJzYEJ97Kh+Fv1QlyeQgBqvQRfb7xCa4WaygwYmIqdXDdaStuMDstsvsTuwg
	 H80sX6oXUXkKCt13vKAn/iCFVvUy7e0umG2380RghILK1gachi6GtIRuqscxQyacEdlx9pqAbAlK
	 cAhgUD95MIraYsgiWb3fLuRBUmLjnlAC0xZVpCK7dPN7TsuRgBsKq/YwfQVGA+nK4aqTgOeOMqJU
	 oK7joXGcyuNOuahTi5WftkRHFYWlDfpGvX8bdIEmsn529fHCMr51BpTFnjiGiPl8rKsgeAZpxx96
	 cQx5e58hv9VMwR0i6IZ32hfYigHK6ZH1rwkkZ2GwJK14OZgYXT9dn78MC4W8aPHrB9eglTpJj0ZT
	 6IitATXtuKoO4IHRUhOusvURKAJ0HJbzTP05XpJQbQfAqU7KSnWp96FfG+djE=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Chengyi Zhao <chengyi.zhao@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	Chengyi Zhao <zhaochengyi@uniontech.com>
Subject: [PATCH BlueZ] policy: Connect profiles for bonded inbound ACL connections
Date: Thu, 16 Jul 2026 18:55:03 +0800
X-OQ-MSGID: <20260716105503.63216-1-chengyi.zhao@qq.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengyi Zhao <zhaochengyi@uniontech.com>

When a bonded device initiates an inbound ACL connection (e.g. after
resume, the remote wins the page race), BlueZ accepts the ACL link
but does not establish AVDTP/AVCTP profiles. The remote's subsequent
L2CAP connect for PSM 25 fails with "security block" because the link
is not yet encrypted, and the kernel does not retry. The ACL link
stays up with no audio.

Add btd_connect_cb callback infrastructure to the adapter core
mirroring the existing btd_disconnect_cb pattern, invoked from
connected_callback so it only fires on new MGMT_EV_DEVICE_CONNECTED
events. Register a callback in the policy plugin that starts a
2-second grace timer for bonded BR/EDR connections. If an audio
profile connects naturally within the window the timer is cancelled;
otherwise btd_device_connect_services is called as a fallback, but
only if no audio profile is connected yet. The grace timer is also
cancelled on disconnect to avoid racing with device removal.

Outbound L2CAP is queued by the kernel until encryption completes,
surviving the race. The fallback is safe when the host already won
since btd_device_connect_services returns -EBUSY if a connection is
already in progress.
---
 plugins/policy.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.c    |  24 +++++++++++
 src/adapter.h    |   4 ++
 3 files changed, 134 insertions(+)

diff --git a/plugins/policy.c b/plugins/policy.c
index 0e1ce5c9a..c0004e743 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -45,6 +45,7 @@
 #define HS_RETRIES SOURCE_RETRIES
 #define CT_RETRIES 1
 #define TG_RETRIES CT_RETRIES
+#define GRACE_TIMEOUT 2
 
 struct reconnect_data {
 	struct btd_device *dev;
@@ -92,6 +93,7 @@ struct policy_data {
 	uint8_t tg_retries;
 	unsigned int hs_timer;
 	uint8_t hs_retries;
+	unsigned int grace_timer;
 };
 
 static struct reconnect_data *reconnect_find(struct btd_device *dev)
@@ -190,6 +192,9 @@ static void policy_remove(void *user_data)
 	if (data->hs_timer > 0)
 		timeout_remove(data->hs_timer);
 
+	if (data->grace_timer > 0)
+		timeout_remove(data->grace_timer);
+
 	g_free(data);
 }
 
@@ -209,6 +214,83 @@ static struct policy_data *policy_get_data(struct btd_device *dev)
 	return data;
 }
 
+static bool policy_has_audio_profile(struct btd_device *dev)
+{
+	struct btd_service *service;
+
+	service = btd_device_get_service(dev, A2DP_SINK_UUID);
+	if (service && btd_service_get_state(service) ==
+					BTD_SERVICE_STATE_CONNECTED)
+		return true;
+
+	service = btd_device_get_service(dev, A2DP_SOURCE_UUID);
+	if (service && btd_service_get_state(service) ==
+					BTD_SERVICE_STATE_CONNECTED)
+		return true;
+
+	return false;
+}
+
+static void policy_clear_grace_timer(struct policy_data *data)
+{
+	if (data->grace_timer > 0) {
+		timeout_remove(data->grace_timer);
+		data->grace_timer = 0;
+	}
+}
+
+static bool policy_grace_timeout(gpointer user_data)
+{
+	struct policy_data *data = user_data;
+	struct btd_device *dev = data->dev;
+	int err;
+
+	data->grace_timer = 0;
+
+	DBG("Grace period expired for %s", device_get_path(dev));
+
+	if (policy_has_audio_profile(dev))
+		return false;
+
+	err = btd_device_connect_services(dev, NULL);
+	if (err < 0)
+		error("Fallback profile connection failed: %s (%d)",
+							strerror(-err), -err);
+
+	return false;
+}
+
+static void policy_set_grace_timer(struct policy_data *data)
+{
+	policy_clear_grace_timer(data);
+
+	DBG("Starting %d second grace period for %s", GRACE_TIMEOUT,
+						device_get_path(data->dev));
+
+	data->grace_timer = timeout_add_seconds(GRACE_TIMEOUT,
+						policy_grace_timeout, data,
+						NULL);
+}
+
+static void policy_connect_cb(struct btd_device *dev, uint8_t bdaddr_type)
+{
+	struct policy_data *data;
+
+	if (bdaddr_type != BDADDR_BREDR)
+		return;
+
+	if (!device_is_bonded(dev, BDADDR_BREDR))
+		return;
+
+	if (policy_has_audio_profile(dev))
+		return;
+
+	DBG("Bonded BREDR ACL connected for %s", device_get_path(dev));
+
+	data = policy_get_data(dev);
+	policy_set_grace_timer(data);
+}
+
 static bool policy_connect_hs(gpointer user_data)
 {
 	struct policy_data *data = user_data;
@@ -716,6 +798,22 @@ static void service_cb(struct btd_service *service,
 			g_str_equal(profile->remote_uuid, HSP_HS_UUID))
 		hs_cb(service, old_state, new_state);
 
+	/* Cancel grace timer if an audio profile connected naturally.
+	 * Only A2DP connectivity cancels the timer: a non-audio profile
+	 * (HFP, HID, etc.) may connect after the security block window
+	 * without resolving the A2DP failure the timer is meant to catch.
+	 */
+	if (new_state == BTD_SERVICE_STATE_CONNECTED) {
+		struct btd_device *dev = btd_service_get_device(service);
+		struct policy_data *data = find_data(dev);
+
+		if (data && data->grace_timer > 0 &&
+				policy_has_audio_profile(dev)) {
+			DBG("Audio connected during grace period, cancelling");
+			policy_clear_grace_timer(data);
+		}
+	}
+
 	/*
 	 * Return if the reconnection feature is not enabled (all
 	 * subsequent code in this function is about that).
@@ -810,9 +908,14 @@ static void reconnect_set_timer(struct reconnect_data *reconnect, int timeout)
 static void disconnect_cb(struct btd_device *dev, uint8_t reason)
 {
 	struct reconnect_data *reconnect;
+	struct policy_data *data;
 
 	DBG("reason %u", reason);
 
+	data = find_data(dev);
+	if (data)
+		policy_clear_grace_timer(data);
+
 	/* Only attempt reconnect for the following reasons */
 	if (reason != MGMT_DEV_DISCONN_TIMEOUT &&
 	    reason != MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND)
@@ -917,6 +1020,8 @@ static int policy_init(void)
 
 	service_id = btd_service_add_state_cb(service_cb, NULL);
 
+	btd_add_connect_cb(policy_connect_cb);
+
 	conf = btd_get_main_conf();
 	if (!conf) {
 		reconnect_uuids = g_strdupv((char **) default_reconnect);
@@ -988,6 +1093,7 @@ static void policy_exit(void)
 {
 	btd_remove_disconnect_cb(disconnect_cb);
 	btd_remove_conn_fail_cb(conn_fail_cb);
+	btd_remove_connect_cb(policy_connect_cb);
 
 	if (reconnect_uuids)
 		g_strfreev(reconnect_uuids);
diff --git a/src/adapter.c b/src/adapter.c
index 4ffa32a52..e6e061893 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -167,6 +167,7 @@ static GSList *adapter_drivers = NULL;
 
 static GSList *disconnect_list = NULL;
 static GSList *conn_fail_list = NULL;
+static GSList *connect_list = NULL;
 
 struct link_key_info {
 	bdaddr_t bdaddr;
@@ -8609,6 +8610,17 @@ int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 	return 0;
 }
 
+static void connect_notify(struct btd_device *dev, uint8_t bdaddr_type)
+{
+	GSList *l;
+
+	for (l = connect_list; l; l = g_slist_next(l)) {
+		btd_connect_cb connect_cb = l->data;
+
+		connect_cb(dev, bdaddr_type);
+	}
+}
+
 static void disconnect_notify(struct btd_device *dev, uint8_t reason)
 {
 	GSList *l;
@@ -8662,6 +8674,16 @@ void btd_remove_disconnect_cb(btd_disconnect_cb func)
 	disconnect_list = g_slist_remove(disconnect_list, func);
 }
 
+void btd_add_connect_cb(btd_connect_cb func)
+{
+	connect_list = g_slist_append(connect_list, func);
+}
+
+void btd_remove_connect_cb(btd_connect_cb func)
+{
+	connect_list = g_slist_remove(connect_list, func);
+}
+
 static void disconnect_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9606,6 +9628,8 @@ static void connected_callback(uint16_t index, uint16_t length,
 		adapter_msd_notify(adapter, device, eir_data.msd_list);
 
 	eir_data_free(&eir_data);
+
+	connect_notify(device, ev->addr.type);
 }
 
 static void controller_resume_notify(struct btd_adapter *adapter)
diff --git a/src/adapter.h b/src/adapter.h
index 4e07f71ad..a9e1bbf66 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -65,6 +65,10 @@ typedef void (*btd_conn_fail_cb) (struct btd_device *device, uint8_t status);
 void btd_add_conn_fail_cb(btd_conn_fail_cb func);
 void btd_remove_conn_fail_cb(btd_conn_fail_cb func);
 
+typedef void (*btd_connect_cb) (struct btd_device *device, uint8_t bdaddr_type);
+void btd_add_connect_cb(btd_connect_cb func);
+void btd_remove_connect_cb(btd_connect_cb func);
+
 struct btd_adapter *adapter_find(const bdaddr_t *sba);
 struct btd_adapter *adapter_find_by_id(int id);
 
-- 
2.50.1

