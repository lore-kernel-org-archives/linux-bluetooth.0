Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625942;
	b=iP/0T4gP+q+chfmDZ7gdib8Kqn0FwEYudIDPMBPQ9oHTB50O4Q0+Ho1WrBIKHI9oo2jA
	 XZ87+X7TB8jDuyvzxNYJ7PvFb590n87Arpd3vz4AZH29oifPS+yjHTnEbbfin0QaBw6Jo
	 +aEPf2NZcvLNupDUQOH/D5liB4y11mQTIq9vuzhD2hwY0ON+3icQSXbGm9nD+XAIcD2sv
	 neS8xY4ZJ3+mtRyw5zvfROZnKVAKbuTGeyIeDtMCAzwo+V/Fh81w88DyIlIKUXJ06jp1i
	 Vw5ZwV1FI0euq675w0tXo7HxPD75yQWg2Q1caKI31qR8zPffhK6ZPBT3AjhMlCZmJ6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vpBsyyAfndaNrYNzTSiaTaSPI3qkgjSpoUzojPGf7PE=;
	b=OB4p/xYI9w8kWZsa0i9VfQmCpaUGdzRMrglQtGn/x4WiE/z2Jc6pYi8v4gyLpUxvtkF+
	 XhnLxzdKSCmoXph/BG1p5FCwVPzHblxr9kjSDgaBsPVgMjSRovsU4x0QHypCOV63jdtcT
	 TlPdT5qPOHFeUWjxL+Jw20UmfWxV5c5gCzO870Kov464ZL7vCaxZI124RALcx+aqcXhbX
	 DPe6UCH4UtViNgjeWeVPc26K6qsVV1cILAgaXDnrnxp5viunEVXLPaEKwSeD92/q2BChP
	 j73UOTIFqjqTB3ff0CRATxPo14bRVlTPk2vAb+nNR/s3Bi8uwp2hxezZoL+XmpAl5RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=kCY78Zjg;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9315606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9315606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=kCY78Zjg
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so77876835e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795625940; x=1796230740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpBsyyAfndaNrYNzTSiaTaSPI3qkgjSpoUzojPGf7PE=;
        b=kCY78ZjgmnLVMLJPEOXn3rc/4Dj83oPx9iv6IoeLdbckuS1R0SGdij4y6eAGUNPbez
         U40tTnx71WydqmX52yf0//EyhWG2+OpPdDi9KM2wVZ80H2SdXsXsyc3ntEcAlpLHJjtK
         4FhPiClNTxPXiiP423pAuvtZO7oJrWM7bPfp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625940; x=1796230740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpBsyyAfndaNrYNzTSiaTaSPI3qkgjSpoUzojPGf7PE=;
        b=IqNdAbD/Ip++d4SQTSHTWLnUZE2i72Bv+f+DZ/taIfhEx/6xTTU/6qtW2zKBD+dTIi
         p6fUUVZ6d9eRleA8eSUJkuJIAXN4kictYCFmG4fsDlpAV2Qhe3FJw/0hAS4dbyR596hV
         2ZkO2c1zIlmP/ftgaNYlWuMoWhbtsK3S2VrQgh9r8KsgBG4lSpOadtVzMDJJQvy8o2gW
         ltYmjWi4/yFJguPafp8LgXJgkB4/8h4DIQjHyKTVrh9z5vLHkqEPe2NOD/OgjZlkWeSm
         fDxfLedtotf+beCKfBnx4V3hpQTkWVgU/JClm3TBuyl3OTEL5DxqirJcFN3hyhH0n9Np
         NYhA==
X-Gm-Message-State: APuU4Z/tzEAhSIyQOsxr308makBz7fUEE9LZwNfszev3zXwVbaKOPLfb
	vcCm6E1lRxUEWnPy1OOskdMYVHGY2iyzvRC4WouQhjBWzejRIaaoy9Lg/NNa0RMmSvhcg2MlOzR
	glspY
X-Gm-Gg: AZFdTZdUb5024DaNRhrb4pHo9TsoyNRig7MURtlzUUCr8C7TLBg/95lWzEzIL98ZBST
	RkAYY9Z2FN8IJ0cHfvkE3IwdzeCyWEXrnuetGcnHxGc3cFsT+5+wBcXwfA8rFCTuJoSTMq38jRP
	xcioLQiln/2gLzscKVjHssNJ8dX5IKHT7WaZ3XmUgUT9RlRGmlO4CEHDRLV0O6j9l7CiZwHpVtJ
	R/GOaBRdnIw8zAbLiVOMPGm9w/DZ92u8Cy3Jwz1kGVCzl6JGw3QtAbsqRun6ztI16m7oocd4laQ
	HplzO7mHtE8aZOa/zCt3x7Cv4ReVQcZzWfLs6Izh8hGtD5IPifboBO5KEeMponxCVD1zjrUV+NQ
	THwYqr2PIewu0Rl4W6G5axQoR5dUvl1YG+6P4u14Nu5tOd48cQvQBuvsgYwGNAOEmO1GNDMJuGs
	1bqk+bSXz2cT0iHFcm0yWoTu6uMg0/OKLRn6WMLH2VU4FIVOdiv34xr+piclWkCPFKOVsaxPmvE
	ojktyU96Ejg47s0DVfRPkL9RQJJz6OSP6lRAeN0PfO3WOAcgGmhbAWf0eAHmygPm878Y6rJUE42
	SfD8NEfTZpyHpFLuV0JLOt3QInEu/SfSOcVW8g2AiYh/E/gE3w==
X-Received: by 2002:a05:600c:154c:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb887c3428mr377469705e9.1.1795625940195;
        Wed, 25 Nov 2026 08:59:00 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm758650455e9.11.2026.11.25.08.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:59:00 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 2/2] main.conf: Add 'paired' to ReverseServiceDiscovery
Date: Wed, 25 Nov 2026 17:58:57 +0100
Message-ID: <20261125165857.1645242-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125165857.1645242-1-simon.mikuda@streamunlimited.com>
References: <20261125165857.1645242-1-simon.mikuda@streamunlimited.com>
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

When a device that is not paired connects to us over LE, its GATT
client is created and the profiles are accepted on its services. Their
attach reads characteristic values right away, e.g. BAP the PAC records
or CSIP the SIRK. When the remote protects them it answers Insufficient
Authentication (0x05) or Insufficient Encryption (0x0f), bt_att raises
the security level to retry the read, and the device is asked to pair
although nobody requested it.

ReverseServiceDiscovery = false avoids this for LE by not creating the
GATT client of such a link at all. Add 'paired' in addition to true
and false: with it, the GATT client of a device that connected to us,
and with it the profiles' accept, is started only once the device is
paired, and reverse SDP of a BR/EDR device likewise waits for pairing.
The default stays true.

Assisted-by: Claude:claude-opus-5-5
---
 src/btd.h     |  8 +++++++-
 src/device.c  | 25 ++++++++++++++++++++++---
 src/main.c    | 29 ++++++++++++++++++++++++++---
 src/main.conf |  3 +++
 4 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/src/btd.h b/src/btd.h
index 9bf310271..2c897756c 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -48,6 +48,12 @@ enum bt_gatt_export_t {
 	BT_GATT_EXPORT_READ_WRITE,
 };
 
+enum reverse_discovery_t {
+	REVERSE_DISCOVERY_NEVER,
+	REVERSE_DISCOVERY_ALWAYS,
+	REVERSE_DISCOVERY_PAIRED,
+};
+
 struct btd_br_defaults {
 	uint16_t	page_scan_type;
 	uint16_t	page_scan_interval;
@@ -144,7 +150,7 @@ struct btd_opts {
 
 	struct btd_defaults defaults;
 
-	bool		reverse_discovery;
+	uint8_t		reverse_discovery;
 	bool		name_resolv;
 	bool		debug_keys;
 	bool		fast_conn;
diff --git a/src/device.c b/src/device.c
index 6aefc8a8e..38f2a94d1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -350,6 +350,18 @@ bool btd_device_is_initiator(struct btd_device *dev)
 	return dev->att_io ? true : false;
 }
 
+static bool reverse_discovery(struct btd_device *dev, uint8_t bdaddr_type)
+{
+	switch (btd_opts.reverse_discovery) {
+	case REVERSE_DISCOVERY_ALWAYS:
+		return true;
+	case REVERSE_DISCOVERY_PAIRED:
+		return device_is_paired(dev, bdaddr_type);
+	default:
+		return false;
+	}
+}
+
 static GSList *find_service_with_profile(GSList *list, struct btd_profile *p)
 {
 	GSList *l;
@@ -6476,7 +6488,8 @@ static void gatt_client_init(struct btd_device *device)
 
 	gatt_client_cleanup(device);
 
-	if (!btd_device_is_initiator(device) && !btd_opts.reverse_discovery) {
+	if (!btd_device_is_initiator(device) &&
+			!reverse_discovery(device, device->bdaddr_type)) {
 		DBG("Reverse service discovery disabled: skipping GATT client");
 		return;
 	}
@@ -6975,6 +6988,12 @@ static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
 	if (!req)
 		return -EBUSY;
 
+	/* Connected without a client, as reverse discovery waited for the
+	 * device to be paired: start it on the existing link.
+	 */
+	if (!device->client && device->att)
+		gatt_client_init(device);
+
 	if (device->client) {
 		/*
 		 * If discovery has not yet completed, then wait for gatt-client
@@ -7636,7 +7655,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 	} else if (!state->svc_resolved && !state->browse &&
 			!state->discov_timer &&
 			(state->connected || !other->connected) &&
-			btd_opts.reverse_discovery) {
+			reverse_discovery(device, bdaddr_type)) {
 		/* If we are not initiators and there is no currently
 		 * active discovery or discovery timer, set discovery
 		 * timer on the bearer that was bonded. A bearer bonded
@@ -7684,7 +7703,7 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 
 	dev->svc_callbacks = g_slist_prepend(dev->svc_callbacks, cb);
 
-	if (state->svc_resolved || !btd_opts.reverse_discovery)
+	if (state->svc_resolved || !reverse_discovery(dev, BDADDR_BREDR))
 		cb->idle_id = g_idle_add(svc_idle_cb, cb);
 	else {
 		if (dev->bredr_state.discov_timer > 0)
diff --git a/src/main.c b/src/main.c
index 3a051c5a4..3672bb707 100644
--- a/src/main.c
+++ b/src/main.c
@@ -924,6 +924,30 @@ static bool parse_config_bool(GKeyFile *config, const char *group,
 	return true;
 }
 
+static void parse_reverse_discovery(GKeyFile *config)
+{
+	char *str = NULL;
+	bool val;
+
+	if (parse_config_bool(config, "General", "ReverseServiceDiscovery",
+								&val)) {
+		btd_opts.reverse_discovery = val ? REVERSE_DISCOVERY_ALWAYS :
+						REVERSE_DISCOVERY_NEVER;
+		return;
+	}
+
+	if (!parse_config_string(config, "General", "ReverseServiceDiscovery",
+								&str))
+		return;
+
+	if (!strcmp(str, "paired"))
+		btd_opts.reverse_discovery = REVERSE_DISCOVERY_PAIRED;
+	else
+		warn("Invalid value for ReverseServiceDiscovery: %s", str);
+
+	g_free(str);
+}
+
 static void parse_privacy(GKeyFile *config)
 {
 	char *str = NULL;
@@ -1096,8 +1120,7 @@ static void parse_general(GKeyFile *config)
 						&btd_opts.pairto,
 						0, UINT32_MAX);
 	parse_device_id(config);
-	parse_config_bool(config, "General", "ReverseServiceDiscovery",
-						&btd_opts.reverse_discovery);
+	parse_reverse_discovery(config);
 	parse_config_bool(config, "General", "NameResolving",
 						&btd_opts.name_resolv);
 	parse_config_bool(config, "General", "DebugKeys",
@@ -1473,7 +1496,7 @@ static void init_defaults(void)
 	btd_opts.pairto = DEFAULT_PAIRABLE_TIMEOUT;
 	btd_opts.discovto = DEFAULT_DISCOVERABLE_TIMEOUT;
 	btd_opts.tmpto = DEFAULT_TEMPORARY_TIMEOUT;
-	btd_opts.reverse_discovery = TRUE;
+	btd_opts.reverse_discovery = REVERSE_DISCOVERY_ALWAYS;
 	btd_opts.name_resolv = TRUE;
 	btd_opts.debug_keys = FALSE;
 	btd_opts.refresh_discovery = TRUE;
diff --git a/src/main.conf b/src/main.conf
index c9906148d..3ee6897c1 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -34,6 +34,9 @@
 # BITE tester doesn't like us doing reverse SDP for some test cases, for LE
 # this disables the GATT client functionally so it can be used in system which
 # can only operate as peripheral (see also GATT Client option).
+# Possible values: 'true', 'false' or 'paired'. With 'paired' it is done only
+# once the device is paired, so that the profiles do not start pairing with a
+# device that connected to us by reading characteristics that need encryption.
 # Defaults to 'true'.
 #ReverseServiceDiscovery = true
 
-- 
2.43.0

