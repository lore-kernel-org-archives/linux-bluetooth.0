Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590628;
	b=bSCTrRLUAT+b+bNQKddWgqa/t//74EhWN2W1LcoaFGUD07Aqw/buzeEjn2IVfXBc/z8V
	 lWTcLpP/7Hwt8rcJdUnUXMI6mJiOlJECwSxrUrX7Vk9bzlMS5WTVBHgE/Pt+Zp7BEQMHo
	 K/mGceHg7xg1c5hTEfUFBxNsXaWreMb0/TnnhHz673sWazpg1wThSMSeS15YFvcF1jtu3
	 IQIKGJgwbBbSTiTWSxNXZh6Ix9rm8M6oUhAOgf7ZP+ccl5qsVMhYXBRi1ULNKJef/BMyK
	 Vkix+DJ8f5w/x8/heryIeaLcRFw8n2iWmkHrPE2LDvWdU/qo1kI8a7Zq2I7mfNQTUiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/RNmK3ONZ7a2UgUSLxXT70l1Ir4lgX9TSPw45HND/f8=;
	b=s5CkMKOLgU0QpY5A66ZGWVQf02eK/Z+DzHXqTZdw/YRTJ8EcprH9YcSYs+9vcD4ObbQH
	 K2ZBxebj7+ovnbqMtHxgJozwiFbmrWbkD5kThIt/Lb5LkQeUkkg/T1IHblE4MigFHJXSG
	 kRvh/b0YEAm458/wiIdL5sExENcxYwz5OIjlhnUndy7doUD+2VVVWx2oGllEJLRbYkbB4
	 YKsurIBy45W9O7phXeKqR8HKp2P7Zox/m7yr5ZoQ45yRhvElJqzuFzKn/j3AjjUBRsQ5I
	 XT0M8LSaXuVbv8eFJ/YUaSeovuBtHFKw6aD8sbpaHpOyv5F5/ly2zitcVQoyKDnE96A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=I2no4Ktj;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209C6075E34
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 17:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F209C6075E34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=I2no4Ktj
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc758830601so1861350a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794590627; x=1795195427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RNmK3ONZ7a2UgUSLxXT70l1Ir4lgX9TSPw45HND/f8=;
        b=I2no4Ktj7bqWbpO9tlz5Q/pO4ZsFqf8hCHtrbJwJ5DPP34u8n3u5JCdOvGuUyZ0ln8
         kyNhOOh/bX7tkIqTP2e/TyxhCJ+cTG4i9xoMO7YyaWx6ehMYo78TEMospbmXvh+3LZWg
         08Wj1E8Nw9xurYOfcHxiMXA4qLtBH6hql1JWj6avox2t/E4+8+9vJVM90D9u0qJVTzJG
         eGB8lmjLdLi9wyl1cArtkFv7SBWpQke/ayJrALvCzTaqCXB2GAkFVrNgttKxb5aXV7YZ
         qGlQxlC6bZut4dplUtxJHUvMyT29Dbo15FaFmetrIunDR200HrG5wyViiD72+mqFx4XM
         5vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590627; x=1795195427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/RNmK3ONZ7a2UgUSLxXT70l1Ir4lgX9TSPw45HND/f8=;
        b=B6S3l+Z4z4BzBH6t2Impz6jf44JJ9huPtBLpxdJo958WrKuMMTA36omcxd5CyyF//o
         euiqL1oX6ehHUMJkiOSP62SnohUHb3z5GCzsUTeUxzORry7FVILnQCCnZGmlf0QB4RHx
         0l7EUEV8FzTM7bwAZvf8a3960PZx1Y8vUj/m/icTH8xWPCY2sZ8KMrMluiHqvXPVmKOV
         018g0r2pfMW68TbHWxL/ls0XmOnrWQUBU37+Gicbv9c9LibdxCYJuN8wKGxsBx9n58Sy
         aNj6ix4yFADg5q4L4BXl4QlwSFRTCgAc45FH5DZySG07xiyeyK8MdJoDgZjj+AiNDp5n
         AcyA==
X-Gm-Message-State: APuU4Z+FYpnfWjO3wO07l/+sODRDDVxNqri1wiQ40yUMgbtNFRAOdCmO
	uKiDjd33TK/K5bLdexF38aI8gp74nR0Qd6JrKiBVziZYR5ix4dPfbCo6mdau7R1q6e7mmDfC/uY
	iGDvwbh4qnw==
X-Gm-Gg: AYBFou3wA4kpx4XS/sGMsY55yU3YQDTsZRS17J67fcz1YJ1PIhcOMYTqZgkd47F4Tw8
	aq6O04wR1Y7Fef4hhmPi0EfTYHFi0+Bxo4R0BNpISeJOCo7Kx6oizoxmgPIQfyuAkd1814mQGn1
	7Jg6iT0epiYYNoJdsRVzp1tWi7h97KdcHmMikjrU0spojzWC8pxwewXFmolXyeEOcC2HqKT9e1p
	khSEz/qqDK59Nacg2x1GOcGdsa3mr+H91xyb1Ifez9l4cqt6ySZsJzbafi6PoT7NQMRrGcClLL6
	9KKOnLR9ilXYBSwXJS+xu9LGR377SxJ5CBpk02tH6+oNG2S0JXoFmFFkD5sVCkDtYDx+o1Oyw5u
	aaws8I0m9wPaI7LSXDgdxLz5DoLvJb36Qpz4Z4l+lbfJclDTHoyznhcCLXB/SzLreKnfBqqyr7c
	7sOa74Zj0LWEeBb9O4d+oJyWolU/KbdUpe24VBCmHWqkEulFXHMNkvvvh/cbxGcQOHyyA617Zeo
	dBqZmUkEyYsZ5Vn7D/sOQp3RrsbxR2VmaNWk3Cm5eb8V7sj8wjXr/c2C8LeNefeoNTEp8lPPA35
	4P3jcgcaSDGNNTRMxWmG6jn2FyiMDXnBo9WRCAK33nrFu8r99qFDWRVz9iofwCixmppL/EQ7KSp
	XTsgP0te1DGCg6/guL207LGcFtWgHj+yD/e75jFKwKd/qZTNZRp7BezmuM74IgQoLGuR0pYQ=
X-Received: by 2002:a05:701b:230c:b0:1ab:fe29:5081 with SMTP id a92af1059eb24-1b5030fc6e2mr3054278c88.20.1794590626993;
        Fri, 13 Nov 2026 09:23:46 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e008sm8151800c88.6.2026.11.13.09.23.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 09:23:46 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v3 3/4] bearer: Add ReadRSSI method
Date: Fri, 13 Nov 2026 09:23:38 -0800
Message-ID: <20261113172339.54683-4-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113172339.54683-1-kevin@simpleble.org>
References: <20261113172339.54683-1-kevin@simpleble.org>
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

