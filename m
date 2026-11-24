Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526312;
	b=dgBUo2nsdJrYxGvzatY7bSOzdpeTfYwXQJz6ntT0sgRMxQhyxbTYqJLHM9oiEiGhenhI
	 Juy43ZRlSEytx5J2hdxyqObfEEy08X3ds0lmw/3dQj41PAVnKyhfaai1h7BHmqTuYgOjg
	 PqOMQF79q1RF9hL9cXccFcXr073fgVq+Rn0MR3ThR51Olq9RkzHXr90IWQ7Kknitb8w+Q
	 3xvNaWRbOvFh7RZzWat6dSopJ3GL1eirhZx+9dWs66Vky7O/cdTwOkk+U6WXizerIbx3C
	 GvRUFmTf3SrI717bJ5y0pBVi4roqkekaVPxTM9proYD00UtuW1ufEKvdUaOmrY4KkEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=63YwZufJQRNDP1mIkSHRpcMydUBe/WznTqjOhbI+CHg=;
	b=dC/88POkYUnwuSpNvEBw0GzQsAcfj2EjeQstLs9eGxvn5wo7NThDR9S1ITvQReqlOpws
	 iJwgCD4D5m/1jJ6vP3BUSKTgudik1DOjx70n2VdY1cPJVJQIIR2DBYxZSY1zeU/TFUTrL
	 wUNylyCqhWXtTgxg8vJQho5aslfxvuK/YjbKkyfJLLhmwMzPpAudwBmTUKnC3u/gFqD/J
	 sncMStkpibd8KoTkL8Kf8fZ0Pf3VliiGQvVsmUAfTrZxSfxA4jOMAH0DCoqVGzKQDSa6o
	 s9AhnF+vFGAjuKygZhQ9ZFB1qo/LoZlGVe1ZEJJQTTYLsZxqPbqUSKYCC0WNGKJV31Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=NO1ScJR4;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ABC606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3ABC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=NO1ScJR4
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so46052595e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795526310; x=1796131110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=63YwZufJQRNDP1mIkSHRpcMydUBe/WznTqjOhbI+CHg=;
        b=NO1ScJR4K7jNC6hn3WLyQ9pCHnYty9INdasOpcxjgByVHcfJ9jgYcAdlyGMBbNOA5t
         NXU6IGo2MHcslDl4s/WMOi76Y59N/VKiHWr67SwwjiUujpTtCIzuGrLLBEh7ST0woqKS
         r7hq0Bw5bjsYqzxYN4tK4x/C2zKesEsvTI9Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526310; x=1796131110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=63YwZufJQRNDP1mIkSHRpcMydUBe/WznTqjOhbI+CHg=;
        b=iFD482ZT7fyBUFkdjgskWMY7ApsfS8GQ1HfAwg0Z04lvKbAWMPqjrGh+qJuexPt0dU
         GtT/GYsPRMAlTtzVrZLfU5dVdIDglOsAmgXZ9/lvxvX4sE355wpcJmEE/1oCtD7W07fk
         oF2AQv4QnLPiJVPE3RR4Fruh55k9jcj1bLErSyX71vmmcLrENaDpPXwpWOsTxNWaYzZn
         U0ulUpS5L8FP7GcLq5okVV6npD99aOVMguolDIKeipYzfaUDU8EZncdf8PsObTy96iNb
         kn8A8KdL0Y4VOy5tTFepBreEC/MmG455vsQfaioA40+03MGs92oh96yaHBsosmVvCRLp
         k93g==
X-Gm-Message-State: APuU4Z8pgBzFRy7ky1a4XkLmW4dGf9WIaSNw55fzIN2FCLbxrYv5OAh9
	qdV3reNa6cXPxM0aAnlMwQZ9llvvoglBF4WzkbMu23HTso2ra5KP4qeJL0pLSbkTAB0v0dVIoIN
	ATC/M
X-Gm-Gg: AZFdTZdXs11gGy16OT0OWA8Gq/OzS8hiRQFZhoQwIrXC+yp5Ssh37NCnVLyJv9+WF6V
	5SUZDuJI7dp55ABwM+Tdo5xBqSsL3uKeT8yfBaY5y1qL18hMSWrVZEJMxx03/Z2E0CglZLLWbou
	SM2ox6lV/mHycnRL9eIigKjhrWkQi/ABv5P3orMHfvUAHkQpK1zZo6JVXmsKXsBMGAHVE7I/kGO
	3gDGN2vrz/rKN/yrKYGuh/H9wRTQDyPB/rVUCTU+bnm0Prza0EZjfqvugvKemzjEmDFGcJp+pGG
	6RyIxo5Fw6YcwsnG83uxpceLZz0nuu8iPmI2w5xJl+RFrR6/ePpYTIFLxEYxbr1JuT3kpXfHa+d
	jCvJp1n9xdK010nHBXcMli8m1yzkPLoCs194tXieZgn2kHzIrfMjC7oD0p9UgMipB1lUluwIrnx
	+jzagfpg7wlxew8zE1Un4ZMLA3VUIr5PlFHQ+wMsN2oYyaHo1lj/8rDrzJEJCCKOGWOfn+l2dfY
	ItSWVgC4b61okrAoS8z9WIYn+1a1h6WYfNQ75GHZ0cmRxZJwNcAPI/velpNiQcMJRrSYC8wMAaC
	Ds6fOy4J/Dki9vqj8KwOSHpo5ItAtv24G0SMBWmhjf8sps7UKQ==
X-Received: by 2002:a05:600c:4514:b0:4bb:6823:3d3c with SMTP id 5b1f17b1804b1-4bb888169d0mr315280605e9.20.1795526310468;
        Tue, 24 Nov 2026 05:18:30 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2e6dsm28007691f8f.6.2026.11.24.05.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:18:30 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] main.conf: Add 'paired' to ReverseServiceDiscovery
Date: Tue, 24 Nov 2026 14:18:23 +0100
Message-ID: <20261124131823.3848364-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124131823.3848364-1-simon.mikuda@streamunlimited.com>
References: <20261124131823.3848364-1-simon.mikuda@streamunlimited.com>
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

Reverse GATT discovery on a device that connected to us but is not
paired reads characteristics that may need encryption. The remote
answers those with ATT error Insufficient Authentication (0x05) or
Insufficient Encryption (0x0f), and bt_att then raises the link's
security level to retry the read, which sends a pairing request to the
device although nobody asked for pairing.

Add 'paired' in addition to true and false to reverse discovery conf
it waits until the device is paired, and the GATT client of an LE link
that connected without one is started once it is.

Set the default ReverseServiceDiscovery to new 'paired' option.

Assisted-by: Claude:claude-opus-5-5
---
 src/btd.h     |  8 +++++++-
 src/device.c  | 26 +++++++++++++++++++++++---
 src/main.c    | 29 ++++++++++++++++++++++++++---
 src/main.conf |  7 +++++--
 4 files changed, 61 insertions(+), 9 deletions(-)

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
index 40d17bae4..3ece82c8d 100644
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
@@ -6471,7 +6483,8 @@ static void gatt_client_init(struct btd_device *device)
 
 	gatt_client_cleanup(device);
 
-	if (!btd_device_is_initiator(device) && !btd_opts.reverse_discovery) {
+	if (!btd_device_is_initiator(device) &&
+			!reverse_discovery(device, device->bdaddr_type)) {
 		DBG("Reverse service discovery disabled: skipping GATT client");
 		return;
 	}
@@ -6970,6 +6983,12 @@ static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
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
@@ -7627,7 +7646,8 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		}
 		bonding_request_free(bonding);
 	} else if (!state->svc_resolved && !state->browse &&
-			!state->discov_timer && btd_opts.reverse_discovery) {
+			!state->discov_timer &&
+			reverse_discovery(device, bdaddr_type)) {
 		/* If we are not initiators and there is no currently
 		 * active discovery or discovery timer, set discovery
 		 * timer on the bearer that was bonded.
@@ -7672,7 +7692,7 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 
 	dev->svc_callbacks = g_slist_prepend(dev->svc_callbacks, cb);
 
-	if (state->svc_resolved || !btd_opts.reverse_discovery)
+	if (state->svc_resolved || !reverse_discovery(dev, BDADDR_BREDR))
 		cb->idle_id = g_idle_add(svc_idle_cb, cb);
 	else {
 		if (dev->bredr_state.discov_timer > 0)
diff --git a/src/main.c b/src/main.c
index 3a051c5a4..4003a9627 100644
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
+	btd_opts.reverse_discovery = REVERSE_DISCOVERY_PAIRED;
 	btd_opts.name_resolv = TRUE;
 	btd_opts.debug_keys = FALSE;
 	btd_opts.refresh_discovery = TRUE;
diff --git a/src/main.conf b/src/main.conf
index c9906148d..b2c834244 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -34,8 +34,11 @@
 # BITE tester doesn't like us doing reverse SDP for some test cases, for LE
 # this disables the GATT client functionally so it can be used in system which
 # can only operate as peripheral (see also GATT Client option).
-# Defaults to 'true'.
-#ReverseServiceDiscovery = true
+# Possible values: 'true', 'false' or 'paired'. With 'paired' it is done only
+# once the device is paired, so that reading the services of a device that
+# connected to us does not start pairing when they need encryption.
+# Defaults to 'paired'.
+#ReverseServiceDiscovery = paired
 
 # Enable name resolving after inquiry. Set it to 'false' if you don't need
 # remote devices name and want shorter discovery cycle. Defaults to 'true'.
-- 
2.43.0

