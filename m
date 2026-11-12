Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453779;
	b=nxuX1iD4Wa8yftElpTLAU3d3IDcHzF3pLDtbcYw2RVSkKnBhJYmRoj/ONuR/hZngP55x
	 5uIW5FcNtVWyFML9g4Y8ncqpOXqOeFvz2MzSGczZChHDG344AGT+VQ6CZg8T+qDS9XMZY
	 c2+RYkYFlZyRE6C9GYXvpzg3SBAX/O4kYncZvGBcVevrREG5d1tbCswie80b1z5/46naj
	 aOha8f7tArCP0OYYGIUV5xEIwMBuED5rfxRdPBFpH6pTegrQai8x+JIlnH28UIj0gH9eA
	 XDRaE7DT892+0JGUSFgH6xDxUNKvSz5+WuMxPYc4WkYz2o7WcBF2OLi7Pf/p+eF8KJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xKFH2c9ha1IXosXThW46urXyv/aHJadMhEm9XnYA6B8=;
	b=x4RmH3FJS3x5xjvJuIoGZ8Tg4z77TcSve2QY7axZXoaqrovkkDWQg95dILDnN4WlkPN5
	 S82NnOFNXwjmI08Y7dwGKG3wuZ0adZJRFS13ryUSI+iqlHR///N+Fs89YQux86uLOcpVM
	 8IcwCPztEWMemqdkh9j5ozo0/SQ9igGSInUOeAoSwjJMKNbXMTxpHX/1kBQbFUGYbxAEc
	 TDcjPru8KRbf4iK7uFSc2vw/IuLGr2qC/+qd4ThofOjICSAlQ8ONzXBt4vvP6GYGXwdJB
	 4ER3RemKvz192w3WmL6sChly0+wzDdXVbJyyGYq/nB/+nVoS+PwBVdCPBWAhmf5yd6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=Gy2Fjz9x;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096C4606A32D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 03:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 096C4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=Gy2Fjz9x
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36f8cdd30beso7024214eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 19:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794453778; x=1795058578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKFH2c9ha1IXosXThW46urXyv/aHJadMhEm9XnYA6B8=;
        b=Gy2Fjz9xlNOcz0cl+RESjIsXzYQ3evSreXi7o4xt1tht5IX+PxzGMV11kVetOIWhDM
         FuaEBQHBzyDXyAG+4F0+fTdLE4voc7bNyELmh9fr+lguVcP4sjldsBo5844gbTHvhdKk
         POU+4twH5ODjpCmrBjPsFNHOyb2o7pZQpCHn3sAKCISOoMaOghIyTUpB3yCC3d1ZoRoF
         bljuVEa0fJOS1It6JDCSryq1yq+Kj0FyZrUjg9XGqkWhUIpSBl5LOtvJvJFKb3xmEgub
         084dsNwea2vsX1DY6anUZS1WSNpDy28VOmF8TxFUYqsclm6hJZ5hyPiV4mAf8b/hviZy
         u+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453778; x=1795058578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xKFH2c9ha1IXosXThW46urXyv/aHJadMhEm9XnYA6B8=;
        b=F5bFny3pTQvZDEJNB8Nv74/3XntSwJ9IzjwzSIdctCVb5a/FNQIdt48h/rnYdOSexO
         XFH4fyiT7O8jRzk6ir2Ays8uD19q+RlwSVZPz3Ai2hBCmt2T4zlwueI3MnFncUCUsI8B
         2ulwUCrJe2ClS4ZtHktxMutECXc7A2TVumiiVhtu2lDe25+ODySbsFtVfQe2woHjIrYY
         iIiG1M4DMW0QOeSnIUHslEwP6p0F406OagO4AtfVCsbXXobvgVxfT9Fx237pDyj3kucq
         vfnacU5GzS0SH61L0jUTY9tR7P0MbsLUc19Zyon+X2+IcsC7Vnz6zy7idQdTkE8p9wOp
         QvZA==
X-Gm-Message-State: APuU4Z/0PvjwOLu5hvYNm41PA416KIF19lwduHUjJHR6SKPu698nZq1b
	yJgiX7IGBT2kHOehJfbsB8YA6nNpV2Aauf3HFO82FJQaDzuXwKOjekovjdz1dCArZ/91IMo4fer
	lbxMiXV0=
X-Gm-Gg: AYBFou0tgVIObu9RzGFqa2PFzZIHBjy/2m+m/wIAAbZQqB8qNyrywVfqFDcb0dbCcFY
	OujX8k4iNT4ktKsbcN0HLIL4kSX+W1H6e9zGZQhLQ6Nb4OHnMo9+wp0c+jpsR6oDXqkn3wzvxBn
	VyXo70kc6ITTtwpZxIrk9DRE8/4fdgzGPnOzKln4MgIaaU5QYOUkrwlcu+9uVrjGEUZGMiGz5Hd
	LK4KorN5G3RtLnh3ko9JD5iuaPyORv7ybwFvgpYKM/11PF1ulXKz+uf4uZoBA82GRkWKQi0wUYr
	y6aF1IaREZoxgbrfaWtIe29CSOl5T3zBt9HabJCxhP1q2ScLcpyJMq7kvazNzntNQG+o0jm6zW6
	eOvWKRsfAu7cUqkOiv6DIZPnZ+MJSv+eyou4OriG1PaJrEYz/FiNfPeepwS1TDNZOFcRDYHn0kb
	jwX/rRzlqumSAyf8cjQEaMPCUk0rOru1DPVuO9KDEfOgB8GvAogA7GyzLq5Tek8XL7nZN4InsaM
	oJzRjJWI7yTapf6/6CV4nhlz9csPx/uk0dVoo6IICLth5pUS3b8YQBykmkR/S9U2jJQl1njVItm
	s71hK9BbSHttHaFDTLI4zSFm4vVPXpaC6Q7vpjny62G20i5mYzArZV0vMn81nuQiR58FpjA1z2p
	LAqZqEkJTdfgf+E/yCdsVoE8pHH1Yue6TLHJ+05wXbjOUhs6viIhLv84vt2QEHYVRS5F3wzs=
X-Received: by 2002:a05:693c:8959:20b0:378:314:4033 with SMTP id 5a478bee46e88-37803144bb2mr1006609eec.32.1794453777853;
        Wed, 11 Nov 2026 19:22:57 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm21340765eec.5.2026.11.11.19.22.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 19:22:57 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [RFC PATCH BlueZ 3/4] bearer: Add ReadRSSI method
Date: Wed, 11 Nov 2026 19:22:49 -0800
Message-ID: <20261112032250.37687-4-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112032250.37687-1-kevin@simpleble.org>
References: <20261112032250.37687-1-kevin@simpleble.org>
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

Implement Bearer.LE1.ReadRSSI with Get Connection Information. The
kernel reads the RSSI from the controller, or returns the value it read
last if that is recent enough (conn_info_min_age and conn_info_max_age,
1 to 3 seconds by default).

The kernel reports a connection as soon as it is established but only
answers Get Connection Information once it has set it up, so a call made
right after Connect returns fails with NotReady rather than NotConnected.

Calls made while a request is pending get its result rather than sending
another one, as the kernel would answer that with its cached value,
which a new connection does not have yet.

The method is only on Bearer.LE1, as the RSSI of a BR/EDR connection is
relative to the golden receive power range rather than in dBm.

Assisted-by: Claude:claude-opus-5.5
---
 src/bearer.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/src/bearer.c b/src/bearer.c
index ebcdc2b4c..51075cdb7 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -57,6 +57,10 @@ struct btd_bearer {
 	 */
 	DBusMessage *connect; /* connect message */
 
+	/* ReadRSSI calls waiting for the Get Connection Information reply */
+	unsigned int conn_info_id;
+	struct queue *rssi_reads;
+
 	/* LE connection parameters, only valid while connected */
 	bool conn_params;
 	uint32_t interval; /* in microseconds */
@@ -213,10 +217,92 @@ static DBusMessage *bearer_disconnect(DBusConnection *conn, DBusMessage *msg,
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
+static void conn_info_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_bearer *bearer = user_data;
+	DBusMessage *msg;
+
+	bearer->conn_info_id = 0;
+
+	while ((msg = queue_pop_head(bearer->rssi_reads))) {
+		g_dbus_send_message(btd_get_dbus_connection(),
+				rssi_reply(bearer, msg, status, length, param));
+		dbus_message_unref(msg);
+	}
+}
+
+static DBusMessage *bearer_read_rssi(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct btd_bearer *bearer = user_data;
+	struct btd_device *device = bearer->device;
+
+	if (!btd_device_bdaddr_type_connected(device, bearer->type))
+		return btd_error_not_connected(msg);
+
+	/* Calls made while a read is pending get the same result */
+	if (!bearer->conn_info_id) {
+		bearer->conn_info_id = btd_adapter_get_conn_info(
+					device_get_adapter(device),
+					device_get_address(device),
+					device_get_le_address_type(device),
+					conn_info_complete, bearer);
+		if (!bearer->conn_info_id)
+			return btd_error_failed(msg, "Unable to read RSSI");
+	}
+
+	queue_push_tail(bearer->rssi_reads, dbus_message_ref(msg));
+
+	return NULL;
+}
+
+static const GDBusMethodTable bearer_bredr_methods[] = {
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, bearer_connect) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL,
+						bearer_disconnect) },
+	{}
+};
+
+static const GDBusMethodTable bearer_le_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, bearer_connect) },
 	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL,
 						bearer_disconnect) },
+	{ GDBUS_ASYNC_METHOD("ReadRSSI", NULL, GDBUS_ARGS({ "rssi", "n" }),
+						bearer_read_rssi) },
 	{}
 };
 
@@ -404,6 +490,14 @@ static const char *bearer_interface(uint8_t type)
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
@@ -426,10 +520,11 @@ struct btd_bearer *btd_bearer_new(struct btd_device *device, uint8_t type)
 	bearer->type = type;
 	bearer->path = device_get_path(device);
 	bearer->disconnects = queue_new();
+	bearer->rssi_reads = queue_new();
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					bearer->path, bearer_interface(type),
-					bearer_methods, bearer_signals,
+					bearer_methods(type), bearer_signals,
 					bearer_properties,
 					bearer, bearer_free)) {
 		error("Unable to register BREDR interface");
@@ -459,6 +554,17 @@ void btd_bearer_destroy(struct btd_bearer *bearer)
 		bearer->connect = NULL;
 	}
 
+	if (bearer->conn_info_id) {
+		btd_adapter_cancel_request(device_get_adapter(bearer->device),
+							bearer->conn_info_id);
+		bearer->conn_info_id = 0;
+	}
+
+	if (bearer->rssi_reads) {
+		queue_destroy(bearer->rssi_reads, bearer_free_dbus_message);
+		bearer->rssi_reads = NULL;
+	}
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(), bearer->path,
 					bearer_interface(bearer->type));
 }
-- 
2.54.0 (Apple Git-157)

