Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526312;
	b=1XBa29oPsgkI80pU0DNLSuf5m6WKSwmVFa6O8kq7ea9rHMVhVlIK3+Mf2mwHs29rKKhD
	 82a5JdS9VE5HmOjFQNqhn8KSam3hMUmC/sI/EzU7XB7GKAYVMJjDibuZksGolTqWvBWwh
	 XTrMHQD8wJqnZzq+eY3e9SP4x62gyFFMwUJeZb8gLH7KYQ4Gtpyd+fSdv4/BaRG93au1e
	 uVJ7gvU8iyEDDRozciNLtKE5Pmy28vhslTFIC5ZdgKb0Z+jhDAODcIdG4p3V9hyJhPoqs
	 MvBFm+xWuGCp1zK7aUKaO/6eja4TTUG8TA8wuffuZpi3NhVWqzxR7+1GvSJLLzBYqYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=R1AWy09Mo/ANmuodNCHSiGnDUgtiv823mqIF8JN2Eo8=;
	b=J9tniMDGE6abF9JKDcviOB8STxUGW5Dg3mIIN4AzRTX6/wOlGKvKsPheQczEmquvj8k5
	 4hlEtYFEup0Bjtf88XRKg/MKrrmOt/vtEW2YTCJturzYswyO3R+O+j5OPp5f1ghSmyIbF
	 NGBIQXKz6aLWQe2IO63MSJbz3/umu+BlEomCqrEjUiEcPVHzoEBOnoSSrJDT7PqEhCyNJ
	 HmKlQXwwzgbb4/WAniowOKJkABKdk6nFFLlEPCKGY9y+CryKkwVXhveXqrl6MrUrddcFL
	 UeHbZ7tgK59ASe4CbTJ9tylbWCBUMd8THv2FNtJ/omWFD5IMQVtdlanClQY3ayrICzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=y8Y5bkDp;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6929606A333
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6929606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=y8Y5bkDp
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so42850095e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795526310; x=1796131110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R1AWy09Mo/ANmuodNCHSiGnDUgtiv823mqIF8JN2Eo8=;
        b=y8Y5bkDpr7THrs9kRjk0dLV59SYfeU3j57auHtnQWO7WkFR/q9a7wvILFva2XYUSSA
         DlF/9vZSXJ9bnNklm7oUz7GCrv+/yoo/1++V053nQpyFm5K8eM7aezF0StZvTs2rNkia
         mkWXqhFPB9EAv8JawPGULANqYFVZzsRiSUkJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526310; x=1796131110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R1AWy09Mo/ANmuodNCHSiGnDUgtiv823mqIF8JN2Eo8=;
        b=B/Y/gnPdM7Iitw2XUIP4K9//+quDkgTxrafiGi2jtU3leKzdq4EHA3KAvtVOERYgaf
         Ghg8EMynbljSDLRbWZl0OyObizrSjcfulz85FkJfw/pqc7bBJEBJaGEGNXeXxhE04qmm
         Is4PcrZ3kjWBuzONb40qiDupcVKlj52yMcAm94PQMkh6/LqKNzLDmRDS2MgR0DYB+AvF
         uOQF0b9i6oRlTRHb1+a/UWddzEzDQSyUX4CHeNyUu5i7kcy5rxjtvUKXfAzvc4duBmL3
         Awib8FdbrPPFqz9my7uoAMr2JLHhj6n6K6IFyGmqDDdl9KYlElVpmrTvKazLm7a3JBJK
         JoHA==
X-Gm-Message-State: APuU4Z9Wg8Qa/CjOhfM6i49nJGbYjml0riTukgPn0BL25SjIxHuruDKo
	xFVB8HfoEYlmBqhKYjvVAptlbHLMyVL0m75DlM80pECl7RTk1sPXum+TllXfNwK7mbfOVJGuw5r
	JVXsN
X-Gm-Gg: AZFdTZdElRkvVQoPoUqDm/692xdRIU1KWqMv3znuF1Fk5yNYP9W06YlFc0486tUY/Cs
	EVGRUdwEgukcfyW5Ol+z+funtWJNSNErC3IO/tEZiOm4reMk4TUf1kk71qUp+19MtPksbLanYnN
	/e/8aqJryLwViTXVUhvlXKeHYhIwJd3LkYvWO+twU/xuwSZj2HPCkHeeSpuOCHiI8p0BNcdir/g
	j88s8LFFpCKmrvmX5cuU/wxg6Jf/XoAkuK+KnzvVXrUht+ZIjajN+yvuOkqIl7yc3y5f7HuSnJ5
	5FwVlOt/JRqazBIl+y2YWWe1uVNWDgRqU5KIovt0FI8DvYii9cNTTsOH5ur0dnJE73tHrIEWZXL
	nPz+a15nGMPMZC9XyNt/z+BBHlLGnDPcgprTQzPhmZnhuQ2M2i9CZIL5Nk38udf+i01gvpOl0k6
	lYr77g12QSlWYwIiVbehI1/zx0OqCd8plyEy3xBxey5Mpl6ptY2se3b2K8nrWOlS6o2ZTF1Gt9S
	a97vBSIWRSxSH9iAU8Aq1T8mQwzUzXVwlekc3U1P6cBEHRne1SDjcl0vsQj8tDQCN/5kzbqG193
	x3rnzC9RCrb0aN24T3M0mmxeyVLfr5palWdkI0cby4UvRgaKhA==
X-Received: by 2002:a05:600c:4e0e:b0:4a1:da58:1ee with SMTP id 5b1f17b1804b1-4bb88938dc9mr309924665e9.31.1795526309960;
        Tue, 24 Nov 2026 05:18:29 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2e6dsm28007691f8f.6.2026.11.24.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:18:29 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] device: Run reverse service discovery on the bonded bearer
Date: Tue, 24 Nov 2026 14:18:22 +0100
Message-ID: <20261124131823.3848364-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a remote bonds with us, reverse service discovery is started after
DISCOVERY_TIMER, but it browses SDP whenever the device supports
BR/EDR, whichever bearer bonded. A dual-mode phone that connects and
bonds over LE is then paged for SDP while only LE is connected. A
browse on one bearer also makes a browse on the other fail with
-EBUSY, as there is a single request per device.

Keep the discovery timer and the browse request per bearer, and
discover SDP on BR/EDR and GATT on LE.

Assisted-by: Claude:claude-opus-5-5
---
 src/device.c | 122 +++++++++++++++++++++++++++------------------------
 1 file changed, 65 insertions(+), 57 deletions(-)

diff --git a/src/device.c b/src/device.c
index 36a980d1e..40d17bae4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -157,6 +157,8 @@ struct bearer_state {
 	bool connectable;
 	time_t last_seen;
 	time_t last_used;
+	unsigned int discov_timer;	/* reverse service discovery timer */
+	struct browse_req *browse;	/* service discovery request */
 };
 
 struct ltk_info {
@@ -246,9 +248,7 @@ struct btd_device {
 	bool		connectable;
 	bool		cable_pairing;
 	unsigned int	disconn_timer;
-	unsigned int	discov_timer;
 	unsigned int	temporary_timer;	/* Temporary/disappear timer */
-	struct browse_req *browse;		/* service discover request */
 	struct bonding_req *bonding;
 	struct authentication_req *authr;	/* authentication request */
 	uint8_t		bonding_status;
@@ -787,8 +787,10 @@ static void browse_request_free(struct browse_req *req)
 {
 	struct btd_device *device = req->device;
 
-	if (device->browse == req)
-		device->browse = NULL;
+	if (device->bredr_state.browse == req)
+		device->bredr_state.browse = NULL;
+	if (device->le_state.browse == req)
+		device->le_state.browse = NULL;
 
 	if (req->listener_id)
 		g_dbus_remove_watch(dbus_conn, req->listener_id);
@@ -928,8 +930,10 @@ static void device_free(gpointer user_data)
 	if (device->disconn_timer)
 		timeout_remove(device->disconn_timer);
 
-	if (device->discov_timer)
-		timeout_remove(device->discov_timer);
+	if (device->bredr_state.discov_timer)
+		timeout_remove(device->bredr_state.discov_timer);
+	if (device->le_state.discov_timer)
+		timeout_remove(device->le_state.discov_timer);
 
 	if (device->temporary_timer)
 		timeout_remove(device->temporary_timer);
@@ -2076,8 +2080,10 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 	if (device->bonding)
 		bonding_request_cancel(device->bonding);
 
-	if (device->browse)
-		browse_request_cancel(device->browse);
+	if (device->bredr_state.browse)
+		browse_request_cancel(device->bredr_state.browse);
+	if (device->le_state.browse)
+		browse_request_cancel(device->le_state.browse);
 
 	if (device->att_io) {
 		g_io_channel_shutdown(device->att_io, FALSE, NULL);
@@ -2660,7 +2666,7 @@ void btd_device_update_allowed_services(struct btd_device *dev)
 	/* If service discovery is ongoing, let the service discovery complete
 	 * callback call this function.
 	 */
-	if (dev->browse) {
+	if (dev->bredr_state.browse || dev->le_state.browse) {
 		ba2str(&dev->bdaddr, addr);
 		DBG("service discovery of %s is ongoing. Skip updating allowed "
 							"services", addr);
@@ -2801,7 +2807,7 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
 	GSList *l;
 	uint8_t bdaddr_type;
 
-	if (dev->pending || dev->connect || dev->browse)
+	if (dev->pending || dev->connect || dev->bredr_state.browse)
 		return -EBUSY;
 
 	if (!btd_adapter_get_powered(dev->adapter))
@@ -2852,7 +2858,7 @@ DBusMessage *device_connect_profiles(struct btd_device *dev,
 	DBG("%s %s, client %s", dev->path, uuid ? uuid : "(all)",
 						dbus_message_get_sender(msg));
 
-	if (dev->pending || dev->connect || dev->browse)
+	if (dev->pending || dev->connect || dev->bredr_state.browse)
 		return btd_error_in_progress_str(msg, ERR_BREDR_CONN_BUSY);
 
 	if (!btd_adapter_get_powered(dev->adapter)) {
@@ -3206,7 +3212,7 @@ static void browse_request_complete(struct browse_req *req, uint8_t type,
 
 	/* if successfully resolved services we need to free browsing request
 	 * before passing message back to connect functions, otherwise
-	 * device->browse is set and "InProgress" error is returned instead
+	 * the bearer's browse is set and "InProgress" error is returned instead
 	 * of actually connecting services
 	 */
 	msg = dbus_message_ref(req->msg);
@@ -3251,7 +3257,7 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 						uint8_t bdaddr_type, int err)
 {
 	struct bearer_state *state = get_state(dev, bdaddr_type);
-	struct browse_req *req = dev->browse;
+	struct browse_req *req = state->browse;
 
 	DBG("%s err %d", dev->path, err);
 
@@ -5658,8 +5664,10 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 		device_cancel_bonding(device, status);
 	}
 
-	if (device->browse)
-		browse_request_cancel(device->browse);
+	if (device->bredr_state.browse)
+		browse_request_cancel(device->bredr_state.browse);
+	if (device->le_state.browse)
+		browse_request_cancel(device->le_state.browse);
 
 	while (device->services != NULL) {
 		struct btd_service *service = device->services->data;
@@ -6364,7 +6372,7 @@ static void att_disconnected_cb(int err, void *user_data)
 
 	DBG("");
 
-	if (device->browse)
+	if (device->le_state.browse)
 		goto done;
 
 	DBG("%s (%d)", strerror(err), err);
@@ -6392,7 +6400,7 @@ done:
 
 static void register_gatt_services(struct btd_device *device)
 {
-	struct browse_req *req = device->browse;
+	struct browse_req *req = device->le_state.browse;
 	GSList *services = NULL;
 
 	if (!bt_gatt_client_is_ready(device->client))
@@ -6797,8 +6805,8 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 			adapter_connect_list_add(device->adapter, device);
 		}
 
-		if (device->browse)
-			browse_request_complete(device->browse,
+		if (device->le_state.browse)
+			browse_request_complete(device->le_state.browse,
 						BROWSE_GATT,
 						device->bdaddr_type,
 						-ECONNABORTED);
@@ -6924,15 +6932,17 @@ static struct browse_req *browse_request_new(struct btd_device *device,
 							DBusMessage *msg)
 {
 	struct browse_req *req;
+	struct bearer_state *state = type == BROWSE_SDP ?
+				&device->bredr_state : &device->le_state;
 
-	if (device->browse)
+	if (state->browse)
 		return NULL;
 
 	req = g_new0(struct browse_req, 1);
 	req->device = device;
 	req->type = type;
 
-	device->browse = req;
+	state->browse = req;
 
 	if (!msg)
 		return req;
@@ -7051,16 +7061,7 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
 static gboolean device_is_browsing(struct btd_device *device,
 					uint8_t bdaddr_type)
 {
-	if (!device->browse)
-		return FALSE;
-
-	if (bdaddr_type == BDADDR_BREDR && device->browse->type == BROWSE_SDP)
-		return TRUE;
-
-	if (bdaddr_type != BDADDR_BREDR && device->browse->type == BROWSE_GATT)
-		return TRUE;
-
-	return FALSE;
+	return get_state(device, bdaddr_type)->browse != NULL;
 }
 
 void device_cancel_browse(struct btd_device *device, uint8_t bdaddr_type)
@@ -7078,12 +7079,13 @@ void device_cancel_browse(struct btd_device *device, uint8_t bdaddr_type)
 	else
 		attio_cleanup(device);
 
-	browse_request_free(device->browse);
+	browse_request_free(get_state(device, bdaddr_type)->browse);
 }
 
 int device_discover_services(struct btd_device *device,
 				uint8_t bdaddr_type, DBusMessage *msg)
 {
+	struct bearer_state *state = get_state(device, bdaddr_type);
 	int err;
 
 	if (bdaddr_type == BDADDR_BREDR)
@@ -7091,9 +7093,9 @@ int device_discover_services(struct btd_device *device,
 	else
 		err = device_browse_gatt(device, msg);
 
-	if (err == 0 && device->discov_timer) {
-		timeout_remove(device->discov_timer);
-		device->discov_timer = 0;
+	if (err == 0 && state->discov_timer) {
+		timeout_remove(state->discov_timer);
+		state->discov_timer = 0;
 	}
 
 	return err;
@@ -7435,16 +7437,22 @@ bool device_is_connectable(struct btd_device *device)
 	return state->connectable;
 }
 
-static bool start_discovery_cb(gpointer user_data)
+static bool start_sdp_discovery_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
-	if (device->bredr)
-		device_browse_sdp(device, NULL);
-	else
-		device_browse_gatt(device, NULL);
+	device->bredr_state.discov_timer = 0;
+	device_browse_sdp(device, NULL);
+
+	return FALSE;
+}
+
+static bool start_gatt_discovery_cb(gpointer user_data)
+{
+	struct btd_device *device = user_data;
 
-	device->discov_timer = 0;
+	device->le_state.discov_timer = 0;
+	device_browse_gatt(device, NULL);
 
 	return FALSE;
 }
@@ -7618,18 +7626,18 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 						DBUS_TYPE_INVALID);
 		}
 		bonding_request_free(bonding);
-	} else if (!state->svc_resolved) {
-		if (!device->browse && !device->discov_timer &&
-				btd_opts.reverse_discovery) {
-			/* If we are not initiators and there is no currently
-			 * active discovery or discovery timer, set discovery
-			 * timer */
-			DBG("setting timer for reverse service discovery");
-			device->discov_timer = timeout_add_seconds(
-							DISCOVERY_TIMER,
-							start_discovery_cb,
-							device, NULL);
-		}
+	} else if (!state->svc_resolved && !state->browse &&
+			!state->discov_timer && btd_opts.reverse_discovery) {
+		/* If we are not initiators and there is no currently
+		 * active discovery or discovery timer, set discovery
+		 * timer on the bearer that was bonded.
+		 */
+		DBG("setting timer for reverse service discovery");
+		state->discov_timer = timeout_add_seconds(DISCOVERY_TIMER,
+					bdaddr_type == BDADDR_BREDR ?
+					start_sdp_discovery_cb :
+					start_gatt_discovery_cb,
+					device, NULL);
 	}
 }
 
@@ -7667,12 +7675,12 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 	if (state->svc_resolved || !btd_opts.reverse_discovery)
 		cb->idle_id = g_idle_add(svc_idle_cb, cb);
 	else {
-		if (dev->discov_timer > 0)
-			timeout_remove(dev->discov_timer);
+		if (dev->bredr_state.discov_timer > 0)
+			timeout_remove(dev->bredr_state.discov_timer);
 
-		dev->discov_timer = timeout_add_seconds(
+		dev->bredr_state.discov_timer = timeout_add_seconds(
 						0,
-						start_discovery_cb,
+						start_sdp_discovery_cb,
 						dev, NULL);
 	}
 

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

