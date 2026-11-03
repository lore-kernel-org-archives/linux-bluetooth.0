Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690878;
	b=34uAge1p9QjPgTSk55+LoGbddatE6ow5mRX71ip/GO/Z4YlzpfD8mpjj/llTfnT5ZBRg
	 aVXi2sYm2XbWZYJ8m1VW3eKrwEPDA4agGJJSrG1m/0JJ/HAfQkFcvhSKBbwNH1EXwJm62
	 iXRCDQzOBU4tQZPJUGU9CsLpIz047WJp1Xytu44+wKpaidHFO2sBHYcDoRLengTQi4NMj
	 PciAm1EmDO0ZGdSK/6fuYzCOHPBpQ9fn/ABCNsZYLpP7QMr/Oo5mQiX3HGAbC0lpm3KSo
	 fQF/YxJuSG7Omv93E53xH1xAGdizEXK7nOmkwOb8V4zIOnMav5KqgcqMhYhnDYUwvxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ge3acH+yi7jj/2VZ8oPBGEaqzVMx6RDgsI+gwHw3LnU=;
	b=RAwMG7NE9lYTvfnNXhV9m9NJrUk+O2eYW17P5x7Khjj/4Jvq4msdXmvxtLuHRAGb8aLh
	 yfIFg+tVN6z0M1bROfa566i+eSZQYB/v4eJXR+0UKqXpMheVDSJu5FZPqVOxQeu1rGABc
	 PCUKRv9UPxVaX5QEwJau84b4jt/L4wvQCL/46774OOvcNpox9tlxSRu2GdYRmUVTNNYzB
	 PVyn5QCroOXwwxXg4zFjjwnGHqJfg5+iF/nNMCnpP62DH+5APLv5bcah6/PKzj3Cffkth
	 ptwmJPQaQ7OhWJpr4Qx0TES1rCzL/7VVbG7apguuiawStpmR+awvFyCHnVjRW9S2Q8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b="Mnrm/0me";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A35606A32E
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 07:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1A35606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=Mnrm/0me
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-369f33df08eso7468081eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 23:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793690877; x=1794295677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ge3acH+yi7jj/2VZ8oPBGEaqzVMx6RDgsI+gwHw3LnU=;
        b=Mnrm/0mexulM7WC1uybFKIZN5sTkhTA/B+84pbImMgpvazA5yEK9F0VjKDsJPJOIk6
         wE9fyWmKN84bo0nNaZGo1Az4Xkhs+kX5su2Biy3r/A7N7oN0kSe8LqPCX1OlMQKWTBMl
         EJbkbrR2TNfbI+B/VU4v7Wh9MFIvPyX36iLQ6We2tyo1nFay9CWvu5G9+69HKo+MTxJk
         CJNMUqxBp1yJsH1ZxkRqqpIywAMsbSEv1oIVAQu56l0p3GbPLEXiHTD5Uxe72BpSy7zD
         LR6Hclf0M4V3HIio41jdAGYctLw68C2rdTbh0SkXGW6grQ6n18c+Q3hdj7juG/NSoVDJ
         5jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690877; x=1794295677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ge3acH+yi7jj/2VZ8oPBGEaqzVMx6RDgsI+gwHw3LnU=;
        b=YQEWILAQKqvDiufr8JIW7tryJLtpURPiw/dWgU7D8a1gl2o0GJlbPOAkuFbLFL4+A2
         IcKCa9NtN+gv6QpfniCMYiqdxcLPM/QNYjEyuOIbqDJ7V517dCBJ0HK2slPU6OwkRhDO
         k2ShnPJUf6f7iUJ6fO33e66S8TC/DX6FXwVxzGUY0/OLFhGGnYqy0kZnW2bJ3lflfVha
         VEo65ZMg5TYJqybc2r5sX7ElNAnIoLuVulGTySy/uuEO+1ZdSP8ccf+UnCdhjkb5deHt
         gpGwgBT1sFgOu3RIYdEIy9tHYWjVhGCNKrjLQK2Iia6qP7WrpTOqz1r4E4JS46tMSx+t
         1s8Q==
X-Gm-Message-State: APuU4Z8g5OlAhd7A7m9i+JTZ8oTH99PbuLGZyH/8YNLDrnPe5VvO7lRc
	Jr2SlbQxzdq5S6SGP3K5rQLyuBSP2uif58r+4m/6fQ9Cg62MiJsLJHbaupqtAfyZkPO4KRUYnPx
	ryfY+ODc=
X-Gm-Gg: AYBFou0caxiQ19HWGVh4/yLkjAjez7NWU6jEJXIE/rShuO8lcpaoL9UXlf1LCqWoCUX
	/Nqnlqn2AAv4y7T76CcWGVBOzAzuc3BmvheJX6+Fnv/QnbaUQ/ClLhi9QHbjiIQ72Op+iKIS26e
	5OzIc5PNZSHFq2gPycqFqklk0SmCs0ZatmDwlkevcexSiAKFVlHVBvi32UKtInUy9pfj+KsfFZQ
	uxqdfuvXZs2Y6XGAmO8cQsu26azQftEH8aFLP2ulZp4+BzQuX3ii058Q0njlnu/l7pQL3QX05EU
	Cq8Ds/ZUXfbHBlpJRpZll4yZUUh2rwfAOZE0E87LSz6Bnw+gMLmn/Tq+VsWbwrWNanuGMvMy/r/
	h1aDsUb8ROeF+xwHz0IOFKJF4WezfkXUIMZ10DzjTCn9NMN+9ZMWfbzQ+0ZhqYabCDJ8hVZfV4r
	6hVfjtAXHWpma5oFxumexXM9phFnDBSusElraYGpQWgstE7DXDMcwGIKDWOQkN/w5tRsAYzIEgh
	5LLH7acJo6tqBMnQvOQPTC9lbOn/a4N4CgxHE8Gb/b1l9SZRUyF8575sLCUqhrHhripGXd9TRNM
	Cv6Q5G/mIf+2HJzIGB2hBdbGVDRB6rTylpVBMMaiI8yN8d+3ol5kPUoVkiF7EIygzt6uSa7mRwc
	ith4ti4+nMhdt5Wxl1LOb/WEg8uiAnZ/FLJEMeflWvwYrhhC6xRH/GnGa/PtAbcCpKmgqAqo=
X-Received: by 2002:a05:701b:455a:10b0:1b2:42e3:e5f0 with SMTP id a92af1059eb24-1b242e3e78bmr141160c88.12.1793690877017;
        Mon, 02 Nov 2026 23:27:57 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm42437988c88.12.2026.11.02.23.27.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 23:27:56 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 3/5] bearer: Add connection parameter properties
Date: Mon,  2 Nov 2026 23:27:47 -0800
Message-ID: <20261103072749.50979-4-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103072749.50979-1-kevin@simpleble.org>
References: <20261103072749.50979-1-kevin@simpleble.org>
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

This implements the Interval, Latency, SupervisionTimeout and Subrate
properties of org.bluez.Bearer.LE1 with the values of the MGMT
Connection Subrate event, which the kernel sends when an LE connection
is established and whenever its parameters change.

Assisted-by: Claude:claude-opus-5.5
---
 src/adapter.c |  12 +++++
 src/bearer.c  | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/bearer.h  |   3 ++
 src/device.c  |   8 ++++
 src/device.h  |   3 ++
 5 files changed, 148 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index edd2fdaf4..5ecb3c784 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9506,6 +9506,7 @@ static void conn_subrate_evt(uint16_t index, uint16_t length,
 	const struct mgmt_ev_conn_subrate *ev = param;
 	struct btd_adapter *adapter = user_data;
 	uint16_t interval, subrate, latency, cont_num, supv_timeout;
+	struct btd_device *device;
 	char dst[18];
 
 	if (length < sizeof(*ev)) {
@@ -9532,6 +9533,17 @@ static void conn_subrate_evt(uint16_t index, uint16_t length,
 		"cont_num 0x%04x timeout 0x%04x", adapter->dev_id, dst,
 		ev->addr.type, interval, subrate, latency, cont_num,
 		supv_timeout);
+
+	device = btd_adapter_find_device(adapter, &ev->addr.bdaddr,
+							ev->addr.type);
+	if (!device)
+		return;
+
+	/* The interval is in units of 0.125 ms and the supervision timeout
+	 * in units of 10 ms.
+	 */
+	device_set_le_conn_params(device, interval * 125, latency,
+					supv_timeout * 10, subrate);
 }
 
 int adapter_set_io_capability(struct btd_adapter *adapter,
diff --git a/src/bearer.c b/src/bearer.c
index 51dd789f1..5285e0274 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -56,6 +56,13 @@ struct btd_bearer {
 	 * additional connect messages.
 	 */
 	DBusMessage *connect; /* connect message */
+
+	/* LE connection parameters, only valid while connected */
+	bool conn_params;
+	uint32_t interval; /* in microseconds */
+	uint16_t latency;
+	uint16_t supv_timeout; /* in milliseconds */
+	uint16_t subrate;
 };
 
 static void bearer_free_dbus_message(void *data)
@@ -304,6 +311,58 @@ static gboolean bearer_role_exists(const GDBusPropertyTable *property,
 	return btd_device_bdaddr_type_connected(bearer->device, bearer->type);
 }
 
+static gboolean bearer_get_interval(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_bearer *bearer = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+							&bearer->interval);
+
+	return TRUE;
+}
+
+static gboolean bearer_get_latency(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_bearer *bearer = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&bearer->latency);
+
+	return TRUE;
+}
+
+static gboolean bearer_get_supv_timeout(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_bearer *bearer = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&bearer->supv_timeout);
+
+	return TRUE;
+}
+
+static gboolean bearer_get_subrate(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_bearer *bearer = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&bearer->subrate);
+
+	return TRUE;
+}
+
+static gboolean bearer_conn_params_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_bearer *bearer = data;
+
+	return bearer->conn_params;
+}
+
 static const GDBusSignalTable bearer_signals[] = {
 	{ GDBUS_SIGNAL("Disconnected",
 			GDBUS_ARGS({ "name", "s" }, { "message", "s" })) },
@@ -318,6 +377,14 @@ static const GDBusPropertyTable bearer_properties[] = {
 	{ "Connectable", "b", bearer_get_connectable, NULL,
 					bearer_connectable_exists },
 	{ "Role", "s", bearer_get_role, NULL, bearer_role_exists },
+	{ "Interval", "u", bearer_get_interval, NULL,
+					bearer_conn_params_exists },
+	{ "Latency", "q", bearer_get_latency, NULL,
+					bearer_conn_params_exists },
+	{ "SupervisionTimeout", "q", bearer_get_supv_timeout, NULL,
+					bearer_conn_params_exists },
+	{ "Subrate", "q", bearer_get_subrate, NULL,
+					bearer_conn_params_exists },
 	{}
 };
 
@@ -418,6 +485,59 @@ void btd_bearer_connectable(struct btd_bearer *bearer)
 					"Connectable");
 }
 
+static void bearer_conn_param_changed(struct btd_bearer *bearer,
+							const char *name)
+{
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
+					bearer_interface(bearer->type), name);
+}
+
+void btd_bearer_conn_params(struct btd_bearer *bearer, uint32_t interval,
+				uint16_t latency, uint16_t supv_timeout,
+				uint16_t subrate)
+{
+	bool added;
+
+	if (!bearer || !bearer->path)
+		return;
+
+	added = !bearer->conn_params;
+	bearer->conn_params = true;
+
+	if (added || bearer->interval != interval) {
+		bearer->interval = interval;
+		bearer_conn_param_changed(bearer, "Interval");
+	}
+
+	if (added || bearer->latency != latency) {
+		bearer->latency = latency;
+		bearer_conn_param_changed(bearer, "Latency");
+	}
+
+	if (added || bearer->supv_timeout != supv_timeout) {
+		bearer->supv_timeout = supv_timeout;
+		bearer_conn_param_changed(bearer, "SupervisionTimeout");
+	}
+
+	if (added || bearer->subrate != subrate) {
+		bearer->subrate = subrate;
+		bearer_conn_param_changed(bearer, "Subrate");
+	}
+}
+
+static void bearer_clear_conn_params(struct btd_bearer *bearer)
+{
+	if (!bearer->conn_params)
+		return;
+
+	bearer->conn_params = false;
+
+	bearer_conn_param_changed(bearer, "Interval");
+	bearer_conn_param_changed(bearer, "Latency");
+	bearer_conn_param_changed(bearer, "SupervisionTimeout");
+	bearer_conn_param_changed(bearer, "Subrate");
+}
+
 void btd_bearer_connected(struct btd_bearer *bearer, int err)
 {
 	DBusMessage *reply;
@@ -488,6 +608,8 @@ void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason)
 					bearer_interface(bearer->type),
 					"Role");
 
+	bearer_clear_conn_params(bearer);
+
 	switch (reason) {
 	case MGMT_DEV_DISCONN_UNKNOWN:
 		name = "org.bluez.Reason.Unknown";
diff --git a/src/bearer.h b/src/bearer.h
index 238d0a17c..26530c11a 100644
--- a/src/bearer.h
+++ b/src/bearer.h
@@ -19,5 +19,8 @@ void btd_bearer_destroy(struct btd_bearer *bearer);
 void btd_bearer_paired(struct btd_bearer *bearer);
 void btd_bearer_bonded(struct btd_bearer *bearer);
 void btd_bearer_connectable(struct btd_bearer *bearer);
+void btd_bearer_conn_params(struct btd_bearer *bearer, uint32_t interval,
+				uint16_t latency, uint16_t supv_timeout,
+				uint16_t subrate);
 void btd_bearer_connected(struct btd_bearer *bearer, int err);
 void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason);
diff --git a/src/device.c b/src/device.c
index 4567188d6..137970637 100644
--- a/src/device.c
+++ b/src/device.c
@@ -8523,6 +8523,14 @@ void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
 					timeout);
 }
 
+void device_set_le_conn_params(struct btd_device *device, uint32_t interval,
+				uint16_t latency, uint16_t supv_timeout,
+				uint16_t subrate)
+{
+	btd_bearer_conn_params(device->le, interval, latency, supv_timeout,
+								subrate);
+}
+
 void btd_device_foreach_service_data(struct btd_device *dev, bt_ad_func_t func,
 							void *data)
 {
diff --git a/src/device.h b/src/device.h
index 5ead73958..6756cb3ab 100644
--- a/src/device.h
+++ b/src/device.h
@@ -249,6 +249,9 @@ void btd_device_foreach_ad(struct btd_device *dev, bt_device_ad_func_t func,
 void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
 					uint16_t max_interval, uint16_t latency,
 					uint16_t timeout);
+void device_set_le_conn_params(struct btd_device *device, uint32_t interval,
+				uint16_t latency, uint16_t supv_timeout,
+				uint16_t subrate);
 void btd_device_foreach_service_data(struct btd_device *dev,
 					bt_device_ad_func_t func,
 					void *data);
-- 
2.54.0 (Apple Git-157)

