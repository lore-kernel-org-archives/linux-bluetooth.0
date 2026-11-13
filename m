Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546889;
	b=FBVLUpIWz6/9WYg6eRQhxVzwZ1J3xLFBhlClfUe0To/K0i+DfLLVorF+/VBzQ1+2xC12
	 46fZZACUvma5YPF5pDBHOsCWRcLbWgD7vfjThsp3TT6kUk3GvwpyjYRP3ES1atEWBU2Zz
	 oYuZ2BM+foOdpTcFl1HiC8NU8R7xYwXC4GfwhsJqaPXf3/zdYGCbcyR1rnNQRUiYTFLr+
	 s5MKwV21DCRvTVP/2iKMcHSkSsoXEo+PfZvgsdqR3oid0gfpDmyvzVhN6HL/miYtlMPVY
	 rmLM2K7zR7a9wyzThZL4iR0EL7QHfzz6ESi1YZsGwiEBzO3iACm3QmjicBYX4UMC+xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/RNmK3ONZ7a2UgUSLxXT70l1Ir4lgX9TSPw45HND/f8=;
	b=DiFUpgnHq/8vZ9wVvnEZ/VQeKdFiPrCoPtouTJUOhfQedukIXoabOmpIp2oVkFbR2ftu
	 4S152OPuhZFQzUDivsKaZVpHO70uqMRePG9VQt5oyrb8zSkTkVjtl5HB2ZsiN1tqEG3t8
	 LzA3Tty4EhDq8Q0d+nampa6DRORF16v4KGivzp6h20hGEAWkIXKwTzJzD9+LvnJ67bJdw
	 zuDJ4y6bDaJV0NHKbR5wb9/y/ulxBVgg218fLV+nY0IEqfkUciUdD81pUxlN5g3Aua1YL
	 DB5rQh6H1shE6gCeTHoYIPT5jbRr2+ydmQT29TBEhAmMUz3LTc5m4PToboBdHlbPpfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b="YMBY/3dN";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007A606A334
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 05:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8007A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=YMBY/3dN
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37628596783so1061939eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 21:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794546889; x=1795151689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RNmK3ONZ7a2UgUSLxXT70l1Ir4lgX9TSPw45HND/f8=;
        b=YMBY/3dN/yc1O7cRKCWoGmNw6oGJitd23TBwSroNdCL7wMzoSA9WdQ6YqBelzsIT51
         enkPCBLJwZw0wErMyNHmrYxlZs+vezxWcMeRnJ0++DyG7QcXBQeZv6eDdnH1jBA+CBWt
         mkMaF5NaBRjJ6VO4UpW7cyw/gNZZUZ+lI7QWfKtWVKQ5qLpZRGvQweO+7xXY3bFfzh0a
         ZcCuyVkotWH6WKGXUPVL2hPkal0UXdJ5MzcaXzp+Y11EYqg+RPO6HQNdqmhhRFt9kxvV
         ByYIt9+Dt7ISLGKQ92sMhh31YDtrIbYv4idDmVNpFKVkPWDPjE6eP7XIkeQAkCzhzZUE
         wh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546889; x=1795151689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/RNmK3ONZ7a2UgUSLxXT70l1Ir4lgX9TSPw45HND/f8=;
        b=eATWj6VjNsqnzG2uUmJXrMiwZDSkDDUNNVlIKowQmiMLWbQWWmr4CcQ6Js2OxuPybr
         B/HDUwes0leleRWzsyOqXkFhoTwVGQrytss1OSz0M3xOVOskoAS54erwDJjh3vktq0GQ
         ai3Z50aH8aY22mmSHQaYuhXfNUNc3Ak92rP1OFg/qCuNhTfcyFJO0uuZjuTohUb5sQTF
         YxjVhd9b+pwXNqhp8MIB+0eCg8Vaiw5GjhNQlWwuAFcv1uaIWYZUf0JMWI9xVDnPN1GY
         WK51bwxGJkdaGIdCbEfWt/2BJVo+++TxUDkYuyAON1zF9RP1FVhT5RTAVCuS7fl2cDHw
         Fx5Q==
X-Gm-Message-State: APuU4Z81+BZeLLaz+9QR54sQ2wIoBeTZ57TVYC6OTxUl9csoStudYdph
	Guv5rovaXpd3vjPvSxHICWJt9VOqT3xcj+HpBZ4Rbn/UcHELJXUV3uUPQr03EOaryzDBA0orpnG
	vFkD4tCA=
X-Gm-Gg: AYBFou1VterPtw8ZB1lcdJSVCHGppr2JEm7axMiQ5vsF1e4uqxK5PjFCzYJGt+DNFz7
	tZYUkN/4E6TjBBu8MxPGqH8bmkMcmoVg9u3ie/0nU2mXAUAs89hudSqOL1wtwbosOihhE+MbGQB
	WhfS8S7FW1udllqsTOY7BxqQkf6JqrPWWY91g+aC8Upl0g0mUNTANds2V+QUtxpxB1uVMw3o2Kt
	ZM4wtBF/HDQtotxL3zCM3ZhPgMHlH6TA4T7Je+vIUfA1rHKvF8dTAcheTyFVdVH9zZ635oilyjG
	87IFVI18drDB4grOdyPKLnfBgFsTadWbLY6OCtC21EoadgULkENJmI5BhREPZROfcZ2zlIcwqo3
	VtgKwZ8YLi4NCZoCKc7tqsmhnL02UtJztelYig6SoZ8jiIdb9b25v2nLq8i55ejKYkQiIpPuPht
	vpjdL+u/sk+CUqk7EAb/bFpHbRfW2LFexoOrciV/pftVWOfllhSpETXUlLCOcSEZafdR6gfdygQ
	c2+whJ8NvchakbRsN7XMQAiL60IbouzEy5yS0L8vrSWux24VegFBgaqOx1udzfXwW2RrNT90BAM
	GNBJkMqZVnmMU7npF3LYsgeV9p+Pr8CFpDIuOClmpJGg17URlcboUa1GljWPNzqZ0WUEH22Bg7d
	k5/bL2mwqosYvzFI4aIxHwfZVhsj5ZOznjDP5jxwd4Tat4h7zRhhyjcyl9oEGMofuHxTCR0U=
X-Received: by 2002:a05:7300:f18e:b0:360:b8b4:840a with SMTP id 5a478bee46e88-37967ad9187mr1639509eec.39.1794546888497;
        Thu, 12 Nov 2026 21:14:48 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955a1c5c2sm3597550eec.14.2026.11.12.21.14.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 21:14:48 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 3/4] bearer: Add ReadRSSI method
Date: Thu, 12 Nov 2026 21:14:37 -0800
Message-ID: <20261113051438.75230-4-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113051438.75230-1-kevin@simpleble.org>
References: <20261113051438.75230-1-kevin@simpleble.org>
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

The method is only on Bearer.LE1, as the RSSI of a BR/EDR connection is
relative to the golden receive power range rather than in dBm.

Assisted-by: Claude:claude-opus-5.5
---
 src/bearer.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

diff --git a/src/bearer.c b/src/bearer.c
index ebcdc2b4c..3cbb74bcc 100644
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
@@ -213,10 +217,93 @@ static DBusMessage *bearer_disconnect(DBusConnection *conn, DBusMessage *msg,
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
+	{ GDBUS_TESTING_ASYNC_METHOD("ReadRSSI", NULL,
+					GDBUS_ARGS({ "rssi", "n" }),
+					bearer_read_rssi) },
 	{}
 };
 
@@ -404,6 +491,14 @@ static const char *bearer_interface(uint8_t type)
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
@@ -426,10 +521,11 @@ struct btd_bearer *btd_bearer_new(struct btd_device *device, uint8_t type)
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
@@ -459,6 +555,17 @@ void btd_bearer_destroy(struct btd_bearer *bearer)
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

