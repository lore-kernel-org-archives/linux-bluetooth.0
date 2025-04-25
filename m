Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5777A13A
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592266; cv=none; b=VOD1Kh5nkAXgczBXDZn5QHK5i8jNObFctTcPVDwUNBykIBnGW0NyQNqbQwc+Is9gjUOYkH0huOuQ87zxVIRAGGKrEPnRbSnKpww5OrcCzzHnFU8tynZy1s4Fj4NWIIk0/fdO9bteZLB0yamULaTf60nS2tSj0uOOwUDZ8twArUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592266; c=relaxed/simple;
	bh=YjRwW71bV0ZobNcv6BkBoe3YdWjUMdRfuxZG9OnHJfg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YoeG9PsT2dbCnL85fWJWXOUT5lrjO3R6F1M540qVoMMjWVpccvz8fPsjUVEaun8AQ2abXxULvCkRezzNZXZmeJ5VJRGGOUefgFs3rBCxktXMTzeX4RvT0VmAngDthIrzZDZ4fkzL9Je+H5qHjrxjJlVi0xbtLlbXjNV62fONYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GLkA4J7o; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GLkA4J7o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745592262;
	bh=YjRwW71bV0ZobNcv6BkBoe3YdWjUMdRfuxZG9OnHJfg=;
	h=From:To:Subject:Date:From;
	b=GLkA4J7oWWDASE/AoEUGp9He3zzg5xd7gNqJziA+reav2JlqCCuLIWZwJzLaHeu8X
	 dWKEUNAgg5m8kpk6We315IvAuBIusjDx7ZEV6ehBSZCfLEKY4qDPE8KU854fS51Bqp
	 MEiJGy87WFjch4YZnXH62uGzllGB4VQO1jRe5ixGKzKtoAThre/EeYmqD2wXCi7Yr1
	 1P6Da7wTLIs9oW18p5UOo50Db2beWAC60JWlwQ8bdPxe/ec55Qk7psGOXv8pJJETRA
	 CJ2aT6BAXicnGU7TTJ+FSS9HRw1/aexJLvYFOjyFCu3CidFOq957K6FJqUgCzbOe5Y
	 kul3NUTZAeQ6g==
Received: from fdanis-XPS-13-9370.. (2a02-8428-af44-1001-0A51-E92B-FF6f-9CEb.rev.sfr.net [IPv6:2a02:8428:af44:1001:a51:e92b:ff6f:9ceb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C2BA717E00BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 16:44:22 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Check presence of ServiceRecords when loading from store
Date: Fri, 25 Apr 2025 16:44:18 +0200
Message-ID: <20250425144418.408145-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

For a HID paired device, if the cache file containing the SDP records
is not present this will prevent the device to connect and need to
remove it and pair again.

Current bluetoothd traces:
src/shared/mgmt.c:can_read_data() [0x0000] event 0x000b
src/adapter.c:connected_callback() hci0 device EC:83:50:76:BD:67
  connected eir_len 31
src/shared/mgmt.c:can_read_data() [0x0000] event 0x0006
profiles/input/server.c:connect_event_cb() Incoming connection from
  EC:83:50:76:BD:67 on PSM 17
profiles/input/device.c:input_device_set_channel() idev 0x5580c6a331b0
  psm 17
profiles/input/server.c:confirm_event_cb()
profiles/input/server.c:connect_event_cb() Incoming connection from
  EC:83:50:76:BD:67 on PSM 19
profiles/input/device.c:input_device_set_channel() idev 0x5580c6a331b0
  psm 19
profiles/input/device.c:hidp_add_connection() Could not parse HID SDP
  record: No such file or directory (2)
profiles/input/device.c:ctrl_watch_cb() Device EC:83:50:76:BD:67
  disconnected
profiles/input/device.c:intr_watch_cb() Device EC:83:50:76:BD:67
  disconnected

This commit sets BREDR svc_resolved to false if the ServiceRecords
entry is not present in the cache file, triggering service rediscover
on next device connection.
---
 src/device.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7d0b35cb1..2ee319c4f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4091,10 +4091,37 @@ next:
 	uuids = g_key_file_get_string_list(key_file, "General", "Services",
 						NULL, NULL);
 	if (uuids) {
+		char filename[PATH_MAX];
+		char device_addr[18];
+		struct stat st;
+		GKeyFile *key_file = g_key_file_new();
+		GError *gerr = NULL;
+
 		load_services(device, uuids);
 
-		/* Discovered services restored from storage */
-		device->bredr_state.svc_resolved = true;
+		ba2str(&device->bdaddr, device_addr);
+		create_filename(filename, PATH_MAX, "/%s/cache/%s",
+			btd_adapter_get_storage_dir(device->adapter),
+			device_addr);
+
+		/* Check if ServiceRecords cached group exists */
+		if (stat(filename, &st) < 0) {
+			DBG("Missing cache file for ServiceRecords");
+			device->bredr_state.svc_resolved = false;
+		} else if (!g_key_file_load_from_file(key_file, filename,
+							0, &gerr)) {
+			DBG("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+			g_clear_error(&gerr);
+			device->bredr_state.svc_resolved = false;
+		} else if (!g_key_file_has_group(key_file, "ServiceRecords")) {
+			DBG("Missing ServiceRecords from cache file");
+			device->bredr_state.svc_resolved = false;
+		} else {
+			/* Discovered services restored from storage */
+			device->bredr_state.svc_resolved = true;
+		}
+		g_key_file_free(key_file);
 	}
 
 	/* Load device id */
@@ -6852,8 +6879,10 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 
 	if (state->svc_resolved || !btd_opts.reverse_discovery)
 		cb->idle_id = g_idle_add(svc_idle_cb, cb);
-	else if (dev->discov_timer > 0) {
-		timeout_remove(dev->discov_timer);
+	else {
+		if (dev->discov_timer > 0)
+			timeout_remove(dev->discov_timer);
+
 		dev->discov_timer = timeout_add_seconds(
 						0,
 						start_discovery,
-- 
2.43.0

