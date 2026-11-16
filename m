Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813391;
	b=4VNF3+aD2F4K2BRZAunHap0jEmu1hddIDZg/eZkegf1tDH5pjZ6Qk2CvQ+LHgoaqVpUk
	 dc8LPvgaV+e1RNNadqX3PLcovG6olt3XETcBu+/svaE3iUnmLvWR7HlFJ5A9YyWMDxWDt
	 LLDxtY3sUwUD1aFuTTSkR0qC/WC69pAnCdqmAOi7K5mfji8t4pB5F+Wmcz5WYtTwKXExm
	 7m3RNdaD0lI9Pr5p/mtHsJZQboWM3/MkzCddjf8YRyuHCMfrxBBg3RDeo4P3fkBGr6vcB
	 YJUHztyQZegQ310fpUEePZwfYmANqS7xsViJbtkHMM5UJdNgJp8RA7gYwJSkspbnlcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eZPzxNpOcRP3vxiTGjneIkC3zoRbyt56y0di5ytMmbE=;
	b=IKn7cPGpN082r6rpvw9D7/lR6npshacQpZS5l9x9kR+Ll0amK2koAiQYPEaTWym5Ogo+
	 EcpKkJVmrPbF7HSfm6h4tpXG1q0B8TE6YVH7wY9SrIP8mqppWpZl2O2ep5Zh9mL3XOazh
	 Ipb4H9CVXyM34hjqmeqVLmEUWlcqQ/3NNPhP+OQU7HBGOVju07VN9lebjuO+PY5rIFjhf
	 AksoC/w3kAQz7QwYMmsW1zNngmokQYiyq7F9jHLqO/xvd8Bah2AszgsLTH116HY2VaVoy
	 M7pKTIvOGjtRDd6JWt/jsyDrjhE8Oh6l/zJuKgigIH890MCC3nQNA85FT6goK3qGHJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=GLcs6jPv;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DA8606A32C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 07:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50DA8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=GLcs6jPv
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a2af4c8d00so6378185c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 23:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794813390; x=1795418190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZPzxNpOcRP3vxiTGjneIkC3zoRbyt56y0di5ytMmbE=;
        b=GLcs6jPv524KG/sFRhje1bXDaOtmWpoj1SFoKXKdLC8aI7hBtWDX3Zz9mZxpEstagM
         Js+f9IQfQH1irvTKSO+RyxkRC80WE7GqQ2AmaxbkVbCHEa8bWJoBj6YJ8tgRFo5jV9uu
         boo/wI5P3UF1nuE09KzfxWxxPxFJBySEuinhuO13cW/+wq022tl43MsrHnry6THLhpyp
         eQmPQzvtYUkoc2bQ4V9CgEkSvn6CMJusc+oiOK3NR+2Fjq6BH0aG3W/7KEUn7VjmmmTr
         ipwPbm9ymdZoXxZKLOLDNIlVo2NQDypMOAdG/xBMvDgc5+WbPICJIL8QPBx6/NgJS5PM
         ZAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794813390; x=1795418190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eZPzxNpOcRP3vxiTGjneIkC3zoRbyt56y0di5ytMmbE=;
        b=swg2xlC/N6g7sI+JC00cvDyeX3lFYaIOq9XIhuRd6REpSGy9VHUrU3TlAdb1jrUiwC
         sI5oYlko7KyQlJmoqwbLq8/zxwf5VlMr4nMgIFtEYfQw6HLiOu4S57olbB6SMDlcoCKj
         j+srnYuIUUj5HBE9mp/c+ruXq/qOQBKRIfwv+7SX86jrkfX1RxMSDi++DY+jm9Myzwu2
         U38C7YGTqTRvuOSmilaymVH0ZmP82UkWBzt0IxObrzh56ABEriCQbVDcMAKJNGODPW5y
         1IrwyF1O7q+TApsR2+62fcZNdTGM+7wynDuRnxzLQLYuYSTf6sapOQiQNjDWCxjIQkmt
         +U3g==
X-Gm-Message-State: APuU4Z+mKxlbtipa/+aCa3aoT/RxDYfDTnsXqdQ6zWOeAj4nPBV6R/CJ
	FiJMF1u2Q0gsxugkl1yYwKRHenNQL7ydoEB9MGFp9lVwj1OYStEXRg1VDE7YJocXx8sIbfaIWS/
	CXWspCHk=
X-Gm-Gg: AYBFou1NJrx7+/g/dlHaUoyWwRx7NSX5fLJf+UOWsVvpBEHUSIpdJfHuw9xpOAFmCRI
	2Eml+78GCDNvCK8XAXW1FOGiInc9w4DZOUx9uqvjqXfIec/A90IKzN6+cVcy1JckwkbmK/M7iaf
	cDMAqnhvdaVrc8M5HfUivjHk/DPAcYgNR3NAd9hAOtCVvJSHDXrVnRonGkpAg0O9/5nLhSs/kF2
	HoW16PjWHFK8+uG8KMI+RmAr4Y2hvShNgCZ/cni6r8JWXpMfwTSXVNS/xJAMuNOXfeMUql7Vty8
	9J9fOlYXI+Y0gDESlpZeEmcheb3Ab/2/A1Sst7+ibXb9UVoCg3PbIp0rC5aoxlXOrFejav8ldor
	AHODDZ08ZCNn4MLbL1N+pW+jOlLA35wCsGNWfyg6igTv4ZbtvxkGjzMmxHU+6hSaZFU07yDKMLC
	HB84rxPzGUu6MLb3uMsgJaI7dCjN+kKOL9/0DyCleuFe1es8sglZvyndu7fiBAuyfSBXlQ1QPuH
	OD7YTfF4Kzzpv8iXJ7KNRoJcjI8r6TH6zEzAu/7YOieqyNARd/SR3TzTXXbq8tKmC0Sw6vr5DDJ
	b/CJ2PrxBFCjW5JPe/BSjjR/S8yl+/XBs1x7SUcNO20PyKMnGbDTxIj4DpNLqdKr7L35/LM8T54
	GZshSx9aqG6Dtcl5pG55eHwujvcisbmRnTm0us3xWnuWR1kqMk+9cHJTBboHEQQy6PSMRVOw=
X-Received: by 2002:a05:701a:8148:10b0:1b5:1a6e:1bec with SMTP id a92af1059eb24-1b51a6e1f70mr6293257c88.10.1794813390146;
        Sun, 15 Nov 2026 23:16:30 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm40571430c88.9.2026.11.15.23.16.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 23:16:29 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v4 3/4] bearer: Add ReadRSSI method
Date: Sun, 15 Nov 2026 23:16:20 -0800
Message-ID: <20261116071622.35355-4-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116071622.35355-1-kevin@simpleble.org>
References: <20261116071622.35355-1-kevin@simpleble.org>
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
would be taken for the reply to the next request.

The method is only on Bearer.LE1, as the RSSI of a BR/EDR connection is
relative to the golden receive power range rather than in dBm.

Assisted-by: Claude:claude-opus-5.5
---
 src/bearer.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 2 deletions(-)

diff --git a/src/bearer.c b/src/bearer.c
index ebcdc2b4c..779f6ea3c 100644
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
@@ -213,13 +221,117 @@ static DBusMessage *bearer_disconnect(DBusConnection *conn, DBusMessage *msg,
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
@@ -404,6 +516,14 @@ static const char *bearer_interface(uint8_t type)
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
@@ -429,7 +549,7 @@ struct btd_bearer *btd_bearer_new(struct btd_device *device, uint8_t type)
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					bearer->path, bearer_interface(type),
-					bearer_methods, bearer_signals,
+					bearer_methods(type), bearer_signals,
 					bearer_properties,
 					bearer, bearer_free)) {
 		error("Unable to register BREDR interface");
@@ -459,6 +579,14 @@ void btd_bearer_destroy(struct btd_bearer *bearer)
 		bearer->connect = NULL;
 	}
 
+	/* Let a pending request complete rather than cancel it, as the kernel
+	 * replies to it anyway and the reply would complete the next request.
+	 */
+	if (bearer->rssi_req) {
+		bearer->rssi_req->bearer = NULL;
+		bearer->rssi_req = NULL;
+	}
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(), bearer->path,
 					bearer_interface(bearer->type));
 }
-- 
2.54.0 (Apple Git-157)

