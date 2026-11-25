Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625942;
	b=en6t9GOI8vZmecKZiPzO5C9gwcw7dmHpYom81+Rajbc7LvtQOs+Sal6JXsgM5O0bVjIo
	 n6+kyOk+Jne/vREQS6Wrnt0zPc8X1ZjFermxIMX2MFvsjp0Cb4Gdh+Gavdg35DgqBunc2
	 o5QU0rMN72eP+rNlVlY00JOiaTpIA8Sx7TisOdTZfSLHpuZGLP0331HvQ+VjHEzCZwsQr
	 1cVAm4p5ZaLDJBibzhBK5SvkYm+3OC2+Np3LpaE0UMXnmBrx82VHcBzl9PzJaKJFOSAor
	 ZE/OCMiIjrGAbx03GpQe+lAyDNVg2HDcnKB2YWJAwwNEmpiBcKI0VUc2/J9PTU5IHDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mGh4+wHOSnk/4DqBFJKevKT779nJGBV2z80CdPrDs6M=;
	b=crEdeDpLzJGsi6N8zdbMD7f0m0WQeWonJLCDtV/DIVdNir+Xwz1GClM3y9Ri4XR61kZj
	 mVQn2APhYeM3Pmlc73YtvhEp/VbGtX1e4Crtcq4NCWrAzGyYIF9Wzo/Z84utNP6kWiF/Z
	 s49cMYfLn8Pvuis3IIpofiTDzql7clDtopjuWopxXDbyImgHWPIQYR06icrinnqrl2uE5
	 dt08jjkwfLmJPCMZj7BiRBoChrp1j1zosXUYFmGzWGGQLM1AFekcXlPgezAhvkomf0d1J
	 4N8hPA2VqvtOdFEF0wiu0iXhLaX5Mb+DEaDmet06/qBD72SFcv46sCuMjy6R09jGRvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=HuffhTIl;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99281606A330
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99281606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=HuffhTIl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so56437395e9.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795625940; x=1796230740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mGh4+wHOSnk/4DqBFJKevKT779nJGBV2z80CdPrDs6M=;
        b=HuffhTIluCPdIESbkpcl8HCBofxaaidSKxWNNrivp3FKHYZqJGnw8INO1b/XAfHbeo
         +0uTlraOJAR0LfZzLLbOb5dvzXltnk/biD2wjes1mVdn+wTA9juNIROTIWYgMYHIBJM6
         +ILdj3TDmyTXod8nb+8fvc26QBZc2NfSaWpU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625940; x=1796230740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mGh4+wHOSnk/4DqBFJKevKT779nJGBV2z80CdPrDs6M=;
        b=XopyYZ+wMgKlOnKGuZIhj08BIAeKok7iIY+7k+kEP8g7y9Z+dGpRLBwjeus+K3qnmh
         EhgWId1jo13Ip0t7a2M2qYU3O0UZ091Z+qc7u6pVO0ffvIexfGgfptEHHu/nlJer7oth
         b3FbX2nh25lbzR2zCT4pOdLjFXqQCQFIfysS+0lMKI+sFxR4gbL9nlvju+T4ciESTgOb
         MEO9qjaweEOlGv3Bvd8rXmFqATYXWuY+FhSXpYmpYEuODL3CUEqBB1lLx77Gm5kwO1fR
         z42GMz/8z8YkifCB1WwBaf7mtCnRYWH0DOF6zXLYOmwPVxAOkghsFi3hwNKgFfjK4ufc
         3H4Q==
X-Gm-Message-State: APuU4Z9CHhjPkoDDMi3iRkWHFL6OIw1XemgiNaYS7KbqQPgRwQ8njX2F
	c6sTd390SltZYbkqQ5yoADLW9IghorAResAYNGJw0ks481Jx3hdcgoPrXX025WzY6d6LeMbB8p3
	+I3ja
X-Gm-Gg: AZFdTZdar4cb7KDq59S1pdv55axfKuWcI4EMvDpAlRjj+lrbxjzQYudPTaiDtg0/n6Y
	QUe0CY3Zqwe4ubK5vHVAm937+EIVQsWKu93NHJzZDHDYeGUwJyp4IqilyLlzZDqvyO4K5fmvtCU
	bdTtAxozirFgWt/KjGmy5HrX+KGKVhd5zOxqL+20y6zpSEAxyjI+RX2NPs66Lfa7g9hIYHzOEZO
	n7LPaBDOOQ3EkLaDfw1TrOJnx9KLLUSQ1n5KYGYmLaQP1Z50soOQJuO6qZWXDC24+6OZcRnpZgJ
	a7OHvIweR4JRZA1ecMfg9q3TRQcqvfGDDFLfteMf9i/W2ZSUfft4JdR8TmoiC+wQ3w4tuPHyfou
	bW8w45Zyo2xwJmsZHBF7QF3aLKf+f92V/wuNxr9+ozLjgWIZdcFcw9pfhMDO5jWBLcCJFAPkeNp
	iv1SLnzp3dMW8bh1vvIIQPlnHc8A7ObFxb5RaZ5iJCLLLwn+q8Mfrpfm8hQoqjXm70iwp3DTnfu
	rNMJx/eKZHZtjaCep38MGdlDDa/G3vhj2fObeYiAH2Ysa0Xd12LC9jzznGdWlOlhzU2pf14n2Pi
	X0q66s1LUQTaU8lLJ7rB7bA/v6YammD0nE4tlzvEwcZtyC6iLJcs08QntiwcgO0KdEVbphM=
X-Received: by 2002:a05:600c:8906:b0:4bb:a60e:a316 with SMTP id 5b1f17b1804b1-4bba60ea355mr41664055e9.12.1795625939721;
        Wed, 25 Nov 2026 08:58:59 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm758650455e9.11.2026.11.25.08.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:58:59 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 1/2] device: Run reverse service discovery on the bonded bearer
Date: Wed, 25 Nov 2026 17:58:56 +0100
Message-ID: <20261125165857.1645242-1-simon.mikuda@streamunlimited.com>
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
discover SDP on BR/EDR and GATT on LE. Skip a bearer that is not
connected while the other one is: a BR/EDR link key derived from LE
pairing also completes bonding on BR/EDR. Cancelling a request now
stops only its own discovery, and the callbacks waiting for services
run once SDP completes.

Assisted-by: Claude:claude-opus-5-5
---
Changes in v3:
- skip reverse discovery on a bearer that is not connected while the
  other one is: a BR/EDR key derived from LE pairing (CTKD) paged the
  device for SDP (CI TestFunctional test_bap)
- cancel only the request's own SDP or GATT discovery in
  browse_request_cancel()
- run the svc_callbacks only once BR/EDR services are resolved, not on
  GATT completion
- main.conf: reword the commit message and the option's comment: the
  profiles' accept, not discovery, reads the protected characteristics

 src/device.c | 142 +++++++++++++++++++++++++++++----------------------
 1 file changed, 81 insertions(+), 61 deletions(-)

diff --git a/src/device.c b/src/device.c
index 36a980d1e..6aefc8a8e 100644
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
@@ -882,9 +884,11 @@ static void browse_request_cancel(struct browse_req *req)
 
 	DBG("");
 
-	bt_cancel_discovery(btd_adapter_get_address(adapter), &device->bdaddr);
-
-	attio_cleanup(device);
+	if (req->type == BROWSE_SDP)
+		bt_cancel_discovery(btd_adapter_get_address(adapter),
+							&device->bdaddr);
+	else
+		attio_cleanup(device);
 
 	browse_request_free(req);
 }
@@ -928,8 +932,10 @@ static void device_free(gpointer user_data)
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
@@ -2076,8 +2082,10 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
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
@@ -2660,7 +2668,7 @@ void btd_device_update_allowed_services(struct btd_device *dev)
 	/* If service discovery is ongoing, let the service discovery complete
 	 * callback call this function.
 	 */
-	if (dev->browse) {
+	if (dev->bredr_state.browse || dev->le_state.browse) {
 		ba2str(&dev->bdaddr, addr);
 		DBG("service discovery of %s is ongoing. Skip updating allowed "
 							"services", addr);
@@ -2801,7 +2809,7 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
 	GSList *l;
 	uint8_t bdaddr_type;
 
-	if (dev->pending || dev->connect || dev->browse)
+	if (dev->pending || dev->connect || dev->bredr_state.browse)
 		return -EBUSY;
 
 	if (!btd_adapter_get_powered(dev->adapter))
@@ -2852,7 +2860,7 @@ DBusMessage *device_connect_profiles(struct btd_device *dev,
 	DBG("%s %s, client %s", dev->path, uuid ? uuid : "(all)",
 						dbus_message_get_sender(msg));
 
-	if (dev->pending || dev->connect || dev->browse)
+	if (dev->pending || dev->connect || dev->bredr_state.browse)
 		return btd_error_in_progress_str(msg, ERR_BREDR_CONN_BUSY);
 
 	if (!btd_adapter_get_powered(dev->adapter)) {
@@ -3206,7 +3214,7 @@ static void browse_request_complete(struct browse_req *req, uint8_t type,
 
 	/* if successfully resolved services we need to free browsing request
 	 * before passing message back to connect functions, otherwise
-	 * device->browse is set and "InProgress" error is returned instead
+	 * the bearer's browse is set and "InProgress" error is returned instead
 	 * of actually connecting services
 	 */
 	msg = dbus_message_ref(req->msg);
@@ -3251,7 +3259,7 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 						uint8_t bdaddr_type, int err)
 {
 	struct bearer_state *state = get_state(dev, bdaddr_type);
-	struct browse_req *req = dev->browse;
+	struct browse_req *req = state->browse;
 
 	DBG("%s err %d", dev->path, err);
 
@@ -3288,7 +3296,10 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 	if (req)
 		browse_request_complete(req, browse_type, bdaddr_type, err);
 
-	while (dev->svc_callbacks) {
+	/* The callbacks wait for BR/EDR services, see
+	 * device_wait_for_svc_complete().
+	 */
+	while (bdaddr_type == BDADDR_BREDR && dev->svc_callbacks) {
 		struct svc_callback *cb = dev->svc_callbacks->data;
 
 		if (cb->idle_id > 0)
@@ -5658,8 +5669,10 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
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
@@ -6364,7 +6377,7 @@ static void att_disconnected_cb(int err, void *user_data)
 
 	DBG("");
 
-	if (device->browse)
+	if (device->le_state.browse)
 		goto done;
 
 	DBG("%s (%d)", strerror(err), err);
@@ -6392,7 +6405,7 @@ done:
 
 static void register_gatt_services(struct btd_device *device)
 {
-	struct browse_req *req = device->browse;
+	struct browse_req *req = device->le_state.browse;
 	GSList *services = NULL;
 
 	if (!bt_gatt_client_is_ready(device->client))
@@ -6797,8 +6810,8 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 			adapter_connect_list_add(device->adapter, device);
 		}
 
-		if (device->browse)
-			browse_request_complete(device->browse,
+		if (device->le_state.browse)
+			browse_request_complete(device->le_state.browse,
 						BROWSE_GATT,
 						device->bdaddr_type,
 						-ECONNABORTED);
@@ -6924,15 +6937,17 @@ static struct browse_req *browse_request_new(struct btd_device *device,
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
@@ -7051,16 +7066,7 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
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
@@ -7078,12 +7084,13 @@ void device_cancel_browse(struct btd_device *device, uint8_t bdaddr_type)
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
@@ -7091,9 +7098,9 @@ int device_discover_services(struct btd_device *device,
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
@@ -7435,16 +7442,22 @@ bool device_is_connectable(struct btd_device *device)
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
 
-	device->discov_timer = 0;
+	return FALSE;
+}
+
+static bool start_gatt_discovery_cb(gpointer user_data)
+{
+	struct btd_device *device = user_data;
+
+	device->le_state.discov_timer = 0;
+	device_browse_gatt(device, NULL);
 
 	return FALSE;
 }
@@ -7544,6 +7557,8 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 	struct bonding_req *bonding = device->bonding;
 	struct authentication_req *auth = device->authr;
 	struct bearer_state *state = get_state(device, bdaddr_type);
+	struct bearer_state *other = bdaddr_type == BDADDR_BREDR ?
+				&device->le_state : &device->bredr_state;
 	int err;
 
 	DBG("bonding %p status 0x%02x", bonding, status);
@@ -7618,18 +7633,23 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
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
+			!state->discov_timer &&
+			(state->connected || !other->connected) &&
+			btd_opts.reverse_discovery) {
+		/* If we are not initiators and there is no currently
+		 * active discovery or discovery timer, set discovery
+		 * timer on the bearer that was bonded. A bearer bonded
+		 * with a key derived over the other one (CTKD) is not
+		 * connected while the other one is, so it is not
+		 * discovered.
+		 */
+		DBG("setting timer for reverse service discovery");
+		state->discov_timer = timeout_add_seconds(DISCOVERY_TIMER,
+					bdaddr_type == BDADDR_BREDR ?
+					start_sdp_discovery_cb :
+					start_gatt_discovery_cb,
+					device, NULL);
 	}
 }
 
@@ -7667,12 +7687,12 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
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

