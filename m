Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A92D46C1
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533014; cv=none; b=LyUonxNxTTiFiPKlNV38tFbdcKldCOuJ7jlfmuW4E8nW43mg0T7PPApFS/ntlHu8fduC8nbX3ZhB3kpLTbdVAZh7u+LH9BxOQ0AQHbqXbX4SNELUgoL7leZZu3hsBIVvtiMXaiYEQismdamvHS4i1dgwwWfBQUDzVfIoQB/hw4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533014; c=relaxed/simple;
	bh=tx2cjMROEF6FMUVFAPEqW+aLQsdoN2ylkPp7AZEEqB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDSiYwPxY83PJtclCApYguKaeuB9QHXP61cL0UJVQhn+Gp1EsP5UJN8CVUky9aK3qpCnQoIn1tWiveJomshjzoiCwEci7jQYIcV99PjW0TIwmCsVGWzKRk21TtnSoomFiyol0gAfZ6QGuO/Xp/8gA8fMMFuHdZFifwKRa3Hs+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EB9543195;
	Thu,  3 Jul 2025 08:56:44 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 15/19] src: Fix typos
Date: Thu,  3 Jul 2025 10:53:23 +0200
Message-ID: <20250703085630.935452-16-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703085630.935452-1-hadess@hadess.net>
References: <20250703085630.935452-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght

Found using codespell.
---
 src/adapter.c     | 24 ++++++++++++------------
 src/adv_monitor.c |  4 ++--
 src/device.c      | 10 +++++-----
 src/main.conf     |  4 ++--
 src/profile.c     |  4 ++--
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 70141e1542d7..67489b41f7f9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -238,7 +238,7 @@ struct service_auth {
 
 struct btd_adapter_pin_cb_iter {
 	GSList *it;			/* current callback function */
-	unsigned int attempt;		/* numer of times it() was called */
+	unsigned int attempt;		/* number of times it() was called */
 	/* When the iterator reaches the end, it is NULL and attempt is 0 */
 };
 
@@ -1655,7 +1655,7 @@ static void stop_passive_scanning(struct btd_adapter *adapter)
 	DBG("");
 
 	/* If there are any normal discovery clients passive scanning
-	 * wont be running */
+	 * won't be running */
 	if (adapter->discovery_list)
 		return;
 
@@ -2267,7 +2267,7 @@ static int merge_discovery_filters(struct btd_adapter *adapter, int *rssi,
 		*rssi = HCI_RSSI_INVALID;
 
 	/*
-	 * Empty_uuid variable determines wether there was any filter with no
+	 * Empty_uuid variable determines whether there was any filter with no
 	 * uuids. In this case someone might be looking for all devices in
 	 * certain proximity, and we need to have empty uuids in kernel filter.
 	 */
@@ -2282,7 +2282,7 @@ static int merge_discovery_filters(struct btd_adapter *adapter, int *rssi,
 
 		/*
 		 * It there is both regular and filtered scan running, then
-		 * clear whole fitler to report all devices.
+		 * clear whole filter to report all devices.
 		 */
 		*transport = adapter_scan_type;
 		*rssi = HCI_RSSI_INVALID;
@@ -2314,7 +2314,7 @@ static void populate_mgmt_filter_uuids(uint8_t (*mgmt_uuids)[16], GSList *uuids)
 /*
  * This method merges all adapter filters into one that will be send to kernel.
  * cp_ptr is set to null when regular non-filtered discovery is needed,
- * otherwise it's pointing to filter. Returns 0 on succes, -1 on error
+ * otherwise it's pointing to filter. Returns 0 on success, -1 on error
  */
 static int discovery_filter_to_mgmt_cp(struct btd_adapter *adapter,
 		       struct mgmt_cp_start_service_discovery **cp_ptr)
@@ -4325,7 +4325,7 @@ static void set_privacy_complete(uint8_t status, uint16_t length,
 		return;
 	}
 
-	DBG("Successfuly set privacy for index %u", adapter->dev_id);
+	DBG("Successfully set privacy for index %u", adapter->dev_id);
 }
 
 static int set_privacy(struct btd_adapter *adapter, uint8_t privacy)
@@ -5706,7 +5706,7 @@ void adapter_auto_connect_add(struct btd_adapter *adapter,
 	bdaddr_type = btd_device_get_bdaddr_type(device);
 
 	if (bdaddr_type == BDADDR_BREDR) {
-		DBG("auto-connection feature is not avaiable for BR/EDR");
+		DBG("auto-connection feature is not available for BR/EDR");
 		return;
 	}
 
@@ -5838,7 +5838,7 @@ void adapter_auto_connect_remove(struct btd_adapter *adapter,
 	bdaddr_type = btd_device_get_bdaddr_type(device);
 
 	if (bdaddr_type == BDADDR_BREDR) {
-		DBG("auto-connection feature is not avaiable for BR/EDR");
+		DBG("auto-connection feature is not available for BR/EDR");
 		return;
 	}
 
@@ -8457,7 +8457,7 @@ static void bonding_attempt_complete(struct btd_adapter *adapter,
 		device = btd_adapter_find_device(adapter, bdaddr, addr_type);
 
 	if (status == MGMT_STATUS_AUTH_FAILED && adapter->pincode_requested) {
-		/* On faliure, issue a bonding_retry if possible. */
+		/* On failure, issue a bonding_retry if possible. */
 		if (device != NULL) {
 			if (device_bonding_attempt_retry(device) == 0)
 				return;
@@ -10322,7 +10322,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	case BT_MODE_BREDR:
 		if (!(adapter->supported_settings & MGMT_SETTING_BREDR)) {
 			btd_error(adapter->dev_id,
-				"Ignoring adapter withouth BR/EDR support");
+				"Ignoring adapter without BR/EDR support");
 			goto failed;
 		}
 
@@ -10336,7 +10336,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	case BT_MODE_LE:
 		if (!(adapter->supported_settings & MGMT_SETTING_LE)) {
 			btd_error(adapter->dev_id,
-				"Ignoring adapter withouth LE support");
+				"Ignoring adapter without LE support");
 			goto failed;
 		}
 
@@ -10514,7 +10514,7 @@ failed:
 	 * Remove adapter from list in case of a failure.
 	 *
 	 * Leaving an adapter structure around for a controller that can
-	 * not be initilized makes no sense at the moment.
+	 * not be initialized makes no sense at the moment.
 	 *
 	 * This is a simplification to avoid constant checks if the
 	 * adapter is ready to do anything.
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index cb38916fc28b..4323063e2787 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -102,7 +102,7 @@ struct rssi_parameters {
 	int8_t low_rssi;		/* Low RSSI threshold */
 	uint16_t low_rssi_timeout;	/* Low RSSI threshold timeout */
 	uint16_t sampling_period;	/* Merge packets in the same timeslot.
-					 * Currenly unimplemented in user space.
+					 * Currently unimplemented in user space.
 					 * Used only to pass data to kernel.
 					 */
 };
@@ -406,7 +406,7 @@ static void merged_pattern_replace(
 	/* If the RSSI are the same then nothing needs to be done, except on
 	 * the case where pattern is being removed. In that case, we need to
 	 * re-add the pattern.
-	 * high_rssi_timeout is purposedly left out in the comparison since
+	 * high_rssi_timeout is purposely left out in the comparison since
 	 * the value is ignored upon submission to kernel.
 	 */
 	if (merged_pattern->rssi.high_rssi == rssi->high_rssi &&
diff --git a/src/device.c b/src/device.c
index 2892b75e7e25..a50d9ad5cee5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3240,7 +3240,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_in_progress(msg);
 
 	/* Only use this selection algorithms when device is combo
-	 * chip. Ohterwise, it will use the wrong bearer to establish
+	 * chip. Otherwise, it will use the wrong bearer to establish
 	 * a connection if the device is already paired, which will
 	 * stall the pairing procedure. For example, for a BLE only
 	 * device, if the device is already paired, and upper layer
@@ -4692,7 +4692,7 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
 	if (l && !g_slist_find_custom(device->primaries, prim->uuid,
 							prim_uuid_cmp)) {
 		/*
-		 * If this happend since the db was cleared for a non-bonded
+		 * If this happened since the db was cleared for a non-bonded
 		 * device, then don't remove the btd_service just yet. We do
 		 * this so that we can avoid re-probing the profile if the same
 		 * GATT service is found on the device on re-connection.
@@ -5061,7 +5061,7 @@ void btd_device_set_connectable(struct btd_device *device, bool connectable)
  * case it has first been discovered over BR/EDR and has a private
  * address when discovered over LE for the first time. In such a case we
  * need to inherit critical values from the duplicate so that we don't
- * ovewrite them when writing to storage. The next time bluetoothd
+ * overwrite them when writing to storage. The next time bluetoothd
  * starts the device will show up as a single instance.
  */
 void device_merge_duplicate(struct btd_device *dev, struct btd_device *dup)
@@ -6972,7 +6972,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 	 * request
 	 */
 	if (state->svc_resolved && bonding) {
-		/* Attept to store services for this device failed because it
+		/* Attempt to store services for this device failed because it
 		 * was not paired. Now that we're paired retry. */
 		store_gatt_db(device);
 
@@ -7111,7 +7111,7 @@ static gboolean device_bonding_retry(gpointer data)
 	DBG("retrying bonding");
 	bonding->retry_timer = 0;
 
-	/* Restart the bonding timer to the begining of the pairing. If not
+	/* Restart the bonding timer to the beginning of the pairing. If not
 	 * pincode request/reply occurs during this retry,
 	 * device_bonding_last_duration() will return a consistent value from
 	 * this point. */
diff --git a/src/main.conf b/src/main.conf
index ada9b9b5ebf1..86759d53c1f2 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -207,7 +207,7 @@
 #ScanWindowSuspend=
 
 # LE scanning parameters used for active scanning supporting discovery
-# proceedure
+# procedure
 #ScanIntervalDiscovery=
 #ScanWindowDiscovery=
 
@@ -220,7 +220,7 @@
 #ScanIntervalConnect=
 #ScanWindowConnect=
 
-# LE default connection parameters.  These values are superceeded by any
+# LE default connection parameters.  These values are superseded by any
 # specific values provided via the Load Connection Parameters interface
 #MinConnectionInterval=
 #MaxConnectionInterval=
diff --git a/src/profile.c b/src/profile.c
index ad204362816d..8a25a97cc62b 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1262,7 +1262,7 @@ static void ext_confirm(GIOChannel *io, gpointer user_data)
 	DBG("incoming connect from %s", addr);
 
 	if (!btd_adapter_is_uuid_allowed(adapter_find(&src), uuid)) {
-		info("UUID %s is not allowed. Igoring the connection", uuid);
+		info("UUID %s is not allowed. Ignoring the connection", uuid);
 		return;
 	}
 
@@ -1304,7 +1304,7 @@ static void ext_direct_connect(GIOChannel *io, GError *err, gpointer user_data)
 	}
 
 	if (!btd_adapter_is_uuid_allowed(adapter_find(&src), uuid)) {
-		info("UUID %s is not allowed. Igoring the connection", uuid);
+		info("UUID %s is not allowed. Ignoring the connection", uuid);
 		return;
 	}
 
-- 
2.50.0

