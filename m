Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794939723;
	b=Egq/b0rwHBDX3n5sKnXEDDZW976ShYVlV8v5RKVgmgE07KqdZskOcPVTJBQN9xgcJL6s
	 GQeMtWHguivlpdKKhAvm6tCZMehhO2ghVjyfY/RCugBxa1IhId/pbfXbgTjSIlsn4jjDL
	 LlrQqrukd7gNj+MrQpsTbbFmgT0p3bqASkqflLOka8dL+UsduiEt4qn+6iNUXsuKSLr6x
	 B7OtDTpGK3vrhQCjgju80p9xlZMY4Aqw/XN4SB4ph4LrgMfqVVCtrEBHjrrSR00YyXIHQ
	 oOg4xLMm5iME8DmBFIgWIMjO7PfqHCaD5oi8Nl7q46hPVtvup4TZO45TkOIaNUIUIQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qGCt/PY2Nl6F3RwzPhzZbXLyfBddPdQN3Jy98m17Bxc=;
	b=BV3zUiJng0HLz0vUeEQVppKEyIprvCu16fcnoMM059jykIcrFOdRSA+jWJEszJtuGeuN
	 DYqz3+gVwxLQbdrfO07BdKT8Q4F9rw0Zcz03GhbavSqMFt70xhhSpAgIjn+fU84q1yAAu
	 j/lWybW02OZK+yDKvlS47hZTfGyyJAI3+FrAmfgzQ9GS9JvOYS0MVmxWJHkhqSqSQKsok
	 1gIQ0p/Ct5/sVGzM06/Pr6dzMY7qioaldgdp3z+LmS3p19u9mFYrYq1qz99TBSYGhEgTM
	 JS/RyoWd5FUh4s4wxI58HA+c0FVXEFwc3uXVot+665CQ/B2+AMwgmuZ5Le6aVgDlgyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=ALbvFOHO;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA0606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7DA0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=ALbvFOHO
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-380b40319bdso301013eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794939722; x=1795544522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGCt/PY2Nl6F3RwzPhzZbXLyfBddPdQN3Jy98m17Bxc=;
        b=ALbvFOHO5oGWPIjz1QX7r1g7/1zCVwiVuIwTLxosBsm4rqD9nGo5EU9CFCoejjJXGw
         zmcBElleHM+MqcYOYFxr+AAOxj2Z37iX9+uM8+j2Q2BvRAM7VHDd9acmXsAabaojtoKE
         Zuvku7FI0vynFXBFOEKnoMIu9Y8Koe88OcLES4HIkHZhBGieMF3wZsFkHeaUxFegAKXM
         ZBfFzIRm9SGDInisR4NM+zMoT4YCUqPQH6+Lzz4AZP1ZcF1XeiIVwLqst6fZD2rl+do6
         Z6GyZ25zSM4W5paY4YwnVnD3DcFoa5BYfj6MvtbDxZGw5McARBx8RNPfU4uSOTCG8cFK
         49vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794939722; x=1795544522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGCt/PY2Nl6F3RwzPhzZbXLyfBddPdQN3Jy98m17Bxc=;
        b=ngyjZugjPwx96sayr5O7HZ+UJGqZhFrBYdstMqfM9Itmm2Se4mz+iovu0ArE0Kh0Y7
         wpeTC1yWpZTvgtvSxm1xkRVECHd3WeVKRlaPD2QQ5weKt3UZgz+7imlOgkTthl5jObKw
         KLI6aFqMyxTuTn5DDNi4hX5aqbuOlzMGha4BCQd4EXHEv30ZMUR5XQwUPDWHjsXE64KT
         kvdB0HL494K3y3xPL3aU1l6fmo61I1feRzo1wvenH/4J1XpKvbW7dyOq1f1BWCjO2Em9
         2G9f0tcLv1x+QovSUAIaIkjsRScV8PPwZMGudwh1X2FYud9bWRQXA+OUXeIVE0SFMZ3w
         tSbw==
X-Gm-Message-State: APuU4Z8vCYCXDSANry19NvpSxdiKRL4Ughhu7C91Z7Ss6a2Id5n2yM8o
	LY4JqOlhwBw9OfkGpvwIK3OcKc0UUSe8XbfjZi/9QsScBo8gMaGGRgh3oEUmKrWUGLq8z3ASMgx
	+FskhzVM=
X-Gm-Gg: AZFdTZc5A3iGl3/L7+aFrHHMHg5HZAplIwAjON9k4sON2xILgdGP67IlSBRLBHngMVv
	hInyGYNW1VZPSJEUqZSU2uYVuhY14lXG6uR3piJU8Yb1BGQHMldvMY9b1PVKSrbOB8GSTMlgHal
	sVtStpjIyyt1Q2TAuq95rudmL2qx7uxtVEOhqSPcZPP9lPGpXn8IvzgtkOJ5W/Axo1tGl4zNkZH
	q765DY04AS3K1Wjo2zpNVuIYP6LGxELAdGavKnoaKQV1vCQt7A0gwKqwcyC2YS7MUc8U1PVmunP
	axFEC8jQnFfCKXoejKmbAswi706Et8cfxUcsCIcdVChVHNJla2bvCoaAvbYzbjpAvXmssZDEMpy
	T9gxgQZP5PyjCrLzuzOFlN//SXu9ukLAUnS/X1Qro3AbEzKN4I9x+4GsC4ZROMAZHWUfgCa4XuN
	eZ/JZ4sCMRiLBEF0W8t4XSpgKcC2HWJPfwoW83/m15AmdPH95nezD7jlXQN6Yga5qkELzd1rpNS
	pumIy+B7NBlZsYrUrwMNrCoHJnBOrWeHMhLSBpiagsdDhjpRdbHWWVu2zobppkhIlm0svrwVsf5
	ZphR3/nh4aAkUqAVf9/LaNG6k3nHKS69T/Sm9KNxO1NCaE22txmqcmysXTrSDg8CteXnAb9MSoB
	9i97xQC9d9x/Fu6+CDGKEZCDvyCRGKcn5PsTEnG5PRxBSrp9c42Hy6WojRu/o6npqt+Rdyow=
X-Received: by 2002:a05:7301:8613:b0:382:1c72:28cc with SMTP id 5a478bee46e88-3828161cd7fmr196041eec.37.1794939721158;
        Tue, 17 Nov 2026 10:22:01 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380d5135221sm10503213eec.24.2026.11.17.10.22.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 10:22:00 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v5 3/4] bearer: Add ReadRSSI method
Date: Tue, 17 Nov 2026 10:21:50 -0800
Message-ID: <20261117182151.73722-4-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261117182151.73722-1-kevin@simpleble.org>
References: <20261117182151.73722-1-kevin@simpleble.org>
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

Implement Bearer.LE1.ReadRSSI with Get Connection Information, as a
testing method. The kernel reads the RSSI from the controller, or
returns the value it read last if that is recent enough
(conn_info_min_age and conn_info_max_age, 1 to 3 seconds by default).

The kernel reports a connection as soon as it is established but only
answers Get Connection Information once it has set it up, so a call made
right after Connect returns fails with NotReady rather than NotConnected.

Calls made while a request is pending get its result rather than sending
another one, as the kernel would answer that with its cached value,
which a new connection does not have yet.

A request still pending when the bearer is destroyed is left to complete
rather than cancelled, as the kernel replies to it anyway and the reply
would be taken for the reply to the next request. The calls waiting for
it fail with NotConnected right away.

The method is only on Bearer.LE1, as the RSSI of a BR/EDR connection is
relative to the golden receive power range rather than in dBm.

Assisted-by: Claude:claude-opus-5.5
---
 src/bearer.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 2 deletions(-)

diff --git a/src/bearer.c b/src/bearer.c
index e5fc2ee3a..154e132ae 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -44,6 +44,12 @@
 
 #define DISCONNECT_TIMER	2
 
+/* Get Connection Information request of ReadRSSI */
+struct rssi_req {
+	struct btd_bearer *bearer; /* NULL once the bearer is destroyed */
+	struct queue *msgs; /* ReadRSSI calls waiting for the reply */
+};
+
 struct btd_bearer {
 	struct btd_device *device;
 	uint8_t type;
@@ -57,6 +63,8 @@ struct btd_bearer {
 	 */
 	DBusMessage *connect; /* connect message */
 
+	struct rssi_req *rssi_req;
+
 	/* LE connection parameters, only valid while connected */
 	bool conn_params;
 	uint32_t interval; /* in microseconds */
@@ -217,13 +225,117 @@ static DBusMessage *bearer_disconnect(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static const GDBusMethodTable bearer_methods[] = {
+static DBusMessage *rssi_reply(struct btd_bearer *bearer, DBusMessage *msg,
+					uint8_t status, uint16_t length,
+					const struct mgmt_rp_get_conn_info *rp)
+{
+	dbus_int16_t rssi;
+
+	/* The kernel reports the connection as soon as it is established, but
+	 * only answers once it has set it up, e.g. read the remote features.
+	 */
+	if (status == MGMT_STATUS_NOT_CONNECTED) {
+		if (btd_device_bdaddr_type_connected(bearer->device,
+							bearer->type))
+			return btd_error_not_ready(msg);
+
+		return btd_error_not_connected(msg);
+	}
+
+	if (status != MGMT_STATUS_SUCCESS)
+		return btd_error_failed(msg, mgmt_errstr(status));
+
+	if (length < sizeof(*rp))
+		return btd_error_failed(msg, "Invalid response");
+
+	/* 127 means the controller has no RSSI for the connection */
+	if (rp->rssi == 127)
+		return btd_error_not_available(msg);
+
+	rssi = rp->rssi;
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INT16, &rssi,
+							DBUS_TYPE_INVALID);
+}
+
+static void rssi_req_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct rssi_req *req = user_data;
+	struct btd_bearer *bearer = req->bearer;
+	DBusMessage *msg;
+
+	if (!bearer)
+		return;
+
+	while ((msg = queue_pop_head(req->msgs))) {
+		g_dbus_send_message(btd_get_dbus_connection(),
+				rssi_reply(bearer, msg, status, length, param));
+		dbus_message_unref(msg);
+	}
+}
+
+static void rssi_req_free(void *data)
+{
+	struct rssi_req *req = data;
+
+	if (req->bearer)
+		req->bearer->rssi_req = NULL;
+
+	queue_destroy(req->msgs, bearer_free_dbus_message);
+	free(req);
+}
+
+static DBusMessage *bearer_read_rssi(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct btd_bearer *bearer = user_data;
+	struct btd_device *device = bearer->device;
+	struct rssi_req *req;
+
+	if (!btd_device_bdaddr_type_connected(device, bearer->type))
+		return btd_error_not_connected(msg);
+
+	/* Calls made while a read is pending get the same result */
+	if (!bearer->rssi_req) {
+		req = new0(struct rssi_req, 1);
+		req->bearer = bearer;
+		req->msgs = queue_new();
+
+		if (!btd_adapter_get_conn_info(device_get_adapter(device),
+					device_get_address(device),
+					device_get_le_address_type(device),
+					rssi_req_complete, req,
+					rssi_req_free)) {
+			rssi_req_free(req);
+			return btd_error_failed(msg, "Unable to read RSSI");
+		}
+
+		bearer->rssi_req = req;
+	}
+
+	queue_push_tail(bearer->rssi_req->msgs, dbus_message_ref(msg));
+
+	return NULL;
+}
+
+static const GDBusMethodTable bearer_bredr_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, bearer_connect) },
 	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL,
 						bearer_disconnect) },
 	{}
 };
 
+static const GDBusMethodTable bearer_le_methods[] = {
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, bearer_connect) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL,
+						bearer_disconnect) },
+	{ GDBUS_TESTING_ASYNC_METHOD("ReadRSSI", NULL,
+					GDBUS_ARGS({ "rssi", "n" }),
+					bearer_read_rssi) },
+	{}
+};
+
 static gboolean bearer_get_adapter(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -408,6 +520,14 @@ static const char *bearer_interface(uint8_t type)
 		return BTD_BEARER_LE_INTERFACE;
 }
 
+static const GDBusMethodTable *bearer_methods(uint8_t type)
+{
+	if (type == BDADDR_BREDR)
+		return bearer_bredr_methods;
+	else
+		return bearer_le_methods;
+}
+
 struct btd_bearer *btd_bearer_new(struct btd_device *device, uint8_t type)
 {
 	struct btd_bearer *bearer;
@@ -433,7 +553,7 @@ struct btd_bearer *btd_bearer_new(struct btd_device *device, uint8_t type)
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					bearer->path, bearer_interface(type),
-					bearer_methods, bearer_signals,
+					bearer_methods(type), bearer_signals,
 					bearer_properties,
 					bearer, bearer_free)) {
 		error("Unable to register BREDR interface");
@@ -463,6 +583,24 @@ void btd_bearer_destroy(struct btd_bearer *bearer)
 		bearer->connect = NULL;
 	}
 
+	/* Answer the calls waiting for a pending request, but let the request
+	 * complete rather than cancel it, as the kernel replies to it anyway
+	 * and the reply would complete the next request.
+	 */
+	if (bearer->rssi_req) {
+		struct rssi_req *req = bearer->rssi_req;
+		DBusMessage *msg;
+
+		while ((msg = queue_pop_head(req->msgs))) {
+			g_dbus_send_message(btd_get_dbus_connection(),
+						btd_error_not_connected(msg));
+			dbus_message_unref(msg);
+		}
+
+		req->bearer = NULL;
+		bearer->rssi_req = NULL;
+	}
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(), bearer->path,
 					bearer_interface(bearer->type));
 }
-- 
2.54.0 (Apple Git-157)

