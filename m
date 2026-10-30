Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395789;
	b=K9t3oB2HL0zXFsFuziPHoN3rG1uAZ4En1soBMEViyuuCYJcSGgfn72uNhNVbnmlBBEvl
	 mOiR6F1q3q1m6SDlffsEuy0fbss4G6jl3FqmKMBbR5J6JSJ4O5vzxbadP+1BVu0HUHoWS
	 7POliMJKpa2VUKCapeZyaPJcV/zQW8vRvGL0F65dkjftI1cYZF+cEMZIJcUCdvYbRVIuq
	 zqmRzb1snnObCE3RyIISgoAzU+aqi9j2Tf/JtsDLrmmeM8j+2HnpdVgBEPnOFx1NKcTsZ
	 jXkadrbvFpWBMW6koZgC+H3ms76A8bqT6LdFHzfnRA0jlQ/pppKvu2pCm8yiIfcEM0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s+32EC0Q3eIQ8RNk8qEcewvcxc8zq5Dq9MmfrludphQ=;
	b=eJZb8U6Pp6pK0Bd1417NI0q1Q2K761PEcH/4zrb6dowUoyoZ4ljc+0pQjYC2Qyc+5uz3
	 HeakUuVzsoi/6qxYyfLHaEqG0qEyt28/DmvUNnkece/fg5wkqZRt5uEgdZ+Ca/hNqxDRj
	 dpA+EYvJ+iEhMip1lHazDaPFhthmotHPLwTg2q2meWrgTzUS31kpQLlQWl1ODp1CMX1Nm
	 yPpXAkh5sBJaZ2kCRte8c7qCsHCuKm31pQDgcYu/cj4bmukwyKi6OYhKaTRnJG0O2w23Q
	 1/PDTAPZRV1tsCfAQLz26CbdWFuaWA4uhl6nftt7yB7H3vh4p1dBKGNKMhvF67qBIWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CduIx5eL;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A735F606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 21:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A735F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CduIx5eL
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so316262137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395787; x=1794000587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s+32EC0Q3eIQ8RNk8qEcewvcxc8zq5Dq9MmfrludphQ=;
        b=CduIx5eLyo/B6gRsSm8yxuyJtT3AoaLbQk+3DEeN1kuBzrvUeljwdErh77WZ6bqzGF
         Kv4TPrC5NorsBDd9Hi5S/KC9a0AbEgwhZSUzWWDQrpfYUGDP2n1i8Pv3jYehNwTC7LwI
         IT88h5HzEyqYF4dB+H3FMWviMZnY7PHvyzczMQHU1MPxddC3inIrtHwYZQ+PR5F27gXg
         nZqenMCYw3LjTLZ5aOtFw5/iRA27L5KtRqdH0Lg7jbkBMy8b2zhIMPhnuBJj9/FjwfIz
         N4vjACAqlBD4rtmlTZzAuzCZbOL8quefdYniQCj0yF4GydnI3y2WBZbwhvDlyW6xreka
         kiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395787; x=1794000587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=s+32EC0Q3eIQ8RNk8qEcewvcxc8zq5Dq9MmfrludphQ=;
        b=rzjTgo/yytMOJ6i2DxONTpbIslThMlJ3p9osjW7MYEm7+UX47FtOTFw6VpbDh93JU0
         1l+8kmLm2KhpdnEP2R6ZJaHUAo6EiziquRSeoPod2nsWJW2sylQoq6gA/4j8/fYWjiym
         CFMa9zfimnu93gBi6sFB4E0qXmO1ueqaxfwKt03U+iHJVLU3COSKA8zmqwLfNm89AWaK
         x5fVCgdxKgYEbjeKBGlbzdcXfotVRvADUwX6rcdAP2ZWUQ8NOE880H2GgQlon+Rbgtdd
         7oLEhn/4q5e1TO7EYh0RdWBXqm5jdIfrrGFwg26X6gXYrZxJ+bfHKQxp2mLXKtFAJ5oZ
         M+ww==
X-Gm-Message-State: AFq9FYL3NoGRCpEjIz6cfJhEvY02v7NbcJwDqJrGUk8HLZ4Qq3g4vuAk
	YDXMy8m5VHwtTMtihmwknhxUbBYPc5enpV95QVjzO4mnNx3wpEcC3A5EPy3gYw==
X-Gm-Gg: AYBFou3JkO0h0vEacRPBhmays6fPIBIYigYXS45aKBYPV6y+zKs9QzDmHuqNOBh1iOq
	YHXrTL1uC5UVw6tVHLkLbKqlDJbkl0HL8dI0jioMTiaQA2vAatzhip/LSqM9dLlEyL84axFYB1e
	JKiFoOUqOs5S/om+VmG3KGPj0dkS4OPcswQIIrOJgJrn5LfUqh2Y63q6b/tfK0Qm8kfw+C4ijZA
	NZoJ/F2X0J9nGuXTu/YY0ma8gsg2Bzb0I5LEloCisg0ri3ectiItMMoNdJzfWGUUTvIvlmOFBz3
	FdjXH0A9tPntclvGIbPFF0HIp+T29nbAt7UMmh00HosD6h3QCAx9LSOQzvc/HCGGqCAtO2fgAcl
	CojjwrUwZOhvN5cm3FSEOJD32+kbLLSbiq4OMM/t4CvRNcoyAbzIzM79kOkwTcrOtxShZwX0rqT
	R6PBlq0hmcAV9bHtIFjMhLPx8fW8x7JPFFWlj2IBVv8GJ5bIyZovPnU659rAXKBTqSHtYnEPb80
	jBHSdWuBVF5ndq1hC8hG7IXxfooUBUmLtZn61/PJSk1uXIA15D72rovbmgAycZFWzGeRyorA+kb
	+gPBVARwTYQaiK2FdExWLu4Ry8O0Xoj0BQSl01SkFxFXzMSTTW3EHhj3SLKGBrUWiO5smNdU7v3
	+dLC+VW96IXDCud0u8zoxMKZrWiAV40bpigO/WNXP4ugFDOOzM5AzRiRNv9NhA5QRl3XFEpXfLU
	c2eRLRzSvBurl6w6Omm6W4djQo
X-Received: by 2002:a05:6102:8092:b0:7cc:9d82:61e2 with SMTP id ada2fe7eead31-7d0725cfd86mr1756135137.13.1793395787474;
        Fri, 30 Oct 2026 14:29:47 -0700 (PDT)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c9c554sm3696412e0c.14.2026.10.30.14.29.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:29:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 04/10] adapter: Don't return Busy when a pending change sets the same value
Date: Fri, 30 Oct 2026 17:29:33 -0400
Message-ID: <20261030212940.753771-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030212940.753771-1-luiz.dentz@gmail.com>
References: <20261030212940.753771-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Registering an agent sets the adapter bondable, so setting Pairable
right after, e.g. with "pairable on" in bluetoothctl as soon as it
registered its default agent, fails with Busy although the pending
change already does what was requested.

Track the value of pending changes, and when a request sets the same
value, reply to it once the pending change completed with its result,
without sending the command again. Opposing requests still fail with
Busy.

Fixes: 348feb005a12 ("adapter: Return Busy error when setting is pending")
Assisted-by: Claude:claude-opus-5-5
---
 src/adapter.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index edd2fdaf4db9..3c0895d1e241 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -280,6 +280,8 @@ struct btd_adapter {
 	char *short_name;		/* controller short name */
 	uint32_t supported_settings;	/* controller supported settings */
 	uint32_t pending_settings;	/* pending controller settings */
+	uint32_t pending_values;	/* values of pending settings */
+	struct queue *pending_props;	/* requests waiting a pending setting */
 	uint32_t power_state;		/* the power state */
 	uint32_t current_settings;	/* current controller settings */
 
@@ -745,6 +747,44 @@ struct set_mode_data {
 	uint8_t value;
 };
 
+struct pending_prop {
+	uint32_t setting;
+	GDBusPendingPropertySet id;
+	uint8_t status;
+};
+
+static bool reply_pending_prop(const void *data, const void *match_data)
+{
+	const struct pending_prop *prop = data;
+	const struct pending_prop *done = match_data;
+
+	if (!(prop->setting & done->setting))
+		return false;
+
+	if (done->status == MGMT_STATUS_SUCCESS)
+		g_dbus_pending_property_success(prop->id);
+	else if (done->status == MGMT_STATUS_RFKILLED)
+		g_dbus_pending_property_error(prop->id,
+					ERROR_INTERFACE ".Blocked",
+					mgmt_errstr(done->status));
+	else
+		g_dbus_pending_property_error(prop->id,
+					ERROR_INTERFACE ".Failed",
+					mgmt_errstr(done->status));
+
+	return true;
+}
+
+/* Reply to the requests that waited for a pending setting change */
+static void reply_pending_props(struct btd_adapter *adapter,
+					uint32_t setting, uint8_t status)
+{
+	struct pending_prop done = { .setting = setting, .status = status };
+
+	queue_remove_all(adapter->pending_props, reply_pending_prop, &done,
+									free);
+}
+
 static void set_mode_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -761,6 +801,7 @@ static void set_mode_complete(uint8_t status, uint16_t length,
 		if (status != MGMT_STATUS_RFKILLED &&
 		    data->setting & MGMT_SETTING_POWERED)
 			reset_power_state_target(adapter, data->value);
+		reply_pending_props(adapter, data->setting, status);
 		return;
 	}
 
@@ -770,6 +811,7 @@ static void set_mode_complete(uint8_t status, uint16_t length,
 	 * event handling functions here.
 	 */
 	new_settings_callback(adapter->dev_id, length, param, adapter);
+	reply_pending_props(adapter, data->setting, status);
 }
 
 static void remove_temporary_devices(struct btd_adapter *adapter)
@@ -785,6 +827,17 @@ static void remove_temporary_devices(struct btd_adapter *adapter)
 	}
 }
 
+static void set_pending(struct btd_adapter *adapter, uint32_t setting,
+							uint8_t value)
+{
+	adapter->pending_settings |= setting;
+
+	if (value)
+		adapter->pending_values |= setting;
+	else
+		adapter->pending_values &= ~setting;
+}
+
 static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 							uint8_t mode)
 {
@@ -828,7 +881,7 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 	if (mgmt_send(adapter->mgmt, opcode,
 				adapter->dev_id, sizeof(cp), &cp,
 				set_mode_complete, data, g_free) > 0) {
-		adapter->pending_settings |= setting;
+		set_pending(adapter, setting, mode);
 		return true;
 	}
 	g_free(data);
@@ -3149,6 +3202,7 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
 		if (status != MGMT_STATUS_RFKILLED &&
 		    data->setting & MGMT_SETTING_POWERED)
 			reset_power_state_target(adapter, data->value);
+		reply_pending_props(adapter, data->setting, status);
 		return;
 	}
 
@@ -3160,6 +3214,7 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
 	 * event handling functions here.
 	 */
 	new_settings_callback(adapter->dev_id, length, param, adapter);
+	reply_pending_props(adapter, data->setting, status);
 }
 
 static void clear_discoverable(struct btd_adapter *adapter)
@@ -3199,9 +3254,23 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 
 	dbus_message_iter_get_basic(value, &enable);
 
+	/* A pending change, e.g. bondable set when an agent registers,
+	 * already does what is requested if it sets the same value: reply
+	 * once it completed instead of sending the command again.
+	 */
 	if (adapter->pending_settings & setting) {
-		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Busy",
-						NULL);
+		struct pending_prop *prop;
+
+		if (!!(adapter->pending_values & setting) != !!enable) {
+			g_dbus_pending_property_error(id,
+						ERROR_INTERFACE ".Busy", NULL);
+			return;
+		}
+
+		prop = new0(struct pending_prop, 1);
+		prop->setting = setting;
+		prop->id = id;
+		queue_push_tail(adapter->pending_props, prop);
 		return;
 	}
 
@@ -3289,7 +3358,7 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 
 	if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
 			property_set_mode_complete, data, g_free) > 0) {
-		adapter->pending_settings |= setting;
+		set_pending(adapter, setting, mode);
 		return;
 	}
 
@@ -6244,6 +6313,9 @@ static void adapter_free(gpointer user_data)
 
 	queue_destroy(adapter->exp_pending, cancel_exp_pending);
 
+	reply_pending_props(adapter, UINT32_MAX, MGMT_STATUS_FAILED);
+	queue_destroy(adapter->pending_props, NULL);
+
 	/*
 	 * Unregister all handlers for this specific index since
 	 * the adapter bound to them is no longer valid.
@@ -7311,6 +7383,7 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 	adapter->auths = g_queue_new();
 	adapter->exps = queue_new();
 	adapter->exp_pending = queue_new();
+	adapter->pending_props = queue_new();
 
 	return btd_adapter_ref(adapter);
 }
-- 
2.56.0

