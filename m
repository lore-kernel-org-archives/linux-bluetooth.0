Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543908;
	b=E7NfJJxkjK1hnHQOBRCtjaP9CHmqA/6uKcHOjhh92psftpNI66bjEKOzbbDaUfBnQtei
	 zVBQ4D0z4Agov0DpihoOtvNVAQ2kTv6p8QMTekD2H+mHj3Vb1u5P3MS52Uf9ga1AD45bF
	 +ZIVSJmXosrvVWDN4j1LyG9WEttjw0KapLzj1ITc6WrUCXGLztEZ9AYwEZIy970Ak9Rlt
	 YUazmZX9vgefl5mIJxh9L4RXFFmvl+zX3iKjMX/4xszxPHX1yuK3v3NfqhR/KIItjuqPI
	 TG7HChORFSwR4mieD+JPCnXXClTYIbHwnqiwsYhOrkk110Nr54C4nrCkL+XlaEnxQVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rfehQqWRi78qTtUq/SljPaUIatfcNY11Qa3i9Eh7byg=;
	b=YYz+SB3bnas3A4JDy2F0ux3WLAUF3lF8kE63UtVGkT/oW6toIJK+tnAVGOAaPSlVAWMa
	 h4fIHDv8EEbP15OFD1QbKeyeGuN5xVfxYWk7vZkHjXnYMl/qO2pNouV8KAd4aySOkn6r0
	 P6kiFfO+z2VpdwvXaF38auOTZhtIQO6dD3VFs7SSYrAkdFrsxNvbTBuwUcZFB8egJTgMe
	 xFDlgddroggT/E2Zo/IBhtVaN/+ZhNA5ddnsJrlRW/j4Iht7JcdXZ4LtcS6zhTlXE7z26
	 HR4UMuX867fr81yt1fVNJyDJcDeBoDXVRQvFlXkQyWYFMcFxuhjd8XpoBLvcZWFObCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=0K2uGg9M;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDD606A335
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 18:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52BDD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=0K2uGg9M
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so31630765e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795543907; x=1796148707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rfehQqWRi78qTtUq/SljPaUIatfcNY11Qa3i9Eh7byg=;
        b=0K2uGg9MEnNCG4L0oKyQZ/pLGdSnT6qBw+Otkj+1XPJuVmMFa4vtDagmSzAL9VmynY
         bI0n16V+cyS4SssIgCWgZWQ8N2jRqQyZ/wyHxJ2VoYepIoXktmBQPZsIqKC76EkFN+Ks
         PwEypA4WA9ISr0oK1jA7kSP7LJQhyCq+RBy1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543907; x=1796148707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rfehQqWRi78qTtUq/SljPaUIatfcNY11Qa3i9Eh7byg=;
        b=JN6o0qDlzS8z+ytt850YAc/BLsTF5R/BwN6BD0izEYacAf2OPpKeHKDI1QgSADscIc
         f9T2rhI2L36mtliK5ftigGmXzX+Q/0iPPM/yqtCo4UZ03vk07kyI7Z8r92ZLd4dRIvuL
         fAE8urRCjJzrrJX4OqP/Qd1fgmNlcwP0Q7rpAkWHXoPLt8ccSK0pGKxYRKp3IeZNncr0
         HrViR3lQVTdh1mz+VKm4WK0qNfSsyUBu66/54qoWszUtIn/joHxzl5NHn3Pms2dOP94M
         xUHhHda3HpenCNE34EDsNxmDe+R99JnJzYBbbjhMVX8l/uXSb8WQ2qYdtcPs+uevdK8z
         K+Ug==
X-Gm-Message-State: APuU4Z82gn62PAb8/ojS7RJdH+NvGr82C0+6p618rUtnQI3+Il4Xp1cU
	8NrT9ZD5jnW4PRHtEJ3hQ7pReYwSGl2D2QoT2RShTmKX+jz/Kja2e6iXblQ/glvN8nuIitUVVx6
	/Qpym
X-Gm-Gg: AZFdTZfOTGYqzeJNyrU9Si24g5NtNCqid7a80ohL/CT2L9ENkIAMJyiJVc1QCLvavsA
	L3zpwe7tkw3JYvIRS6DGBZeSJ485lEVE3vPkyELzX1Fw4dJNaPHE4U9etr2peVxs20aItCzaUYp
	4ZcjHfFdagBf+28L5BBlqeDHjj31xJDPgC95it+JsS5rSZJAaz7AwATcrxWDQ9Im7+5pdpGa1jC
	9kal/djY43AtugwOtjnIGxNBlwfaHMkcZCbtc4QNgV+4kSb597kSJirCvXFb3ifD2Gm+1HIyrNW
	SeQF2tCTrZpdL59iNq88/meNPXmilJToC0s20H94/Z8RKNGoRo9Jhv9OehAxBRrVIoxsyVCuCBZ
	mjmtPsatiUjlUHRxy411SnshBrvhqjxjoJ3TiW5V0oeJ7qgFmnHjEuHcQhT0I9prlE4cBbsUTv2
	soEFmMzERKW35kRLECYSPvCJJz0tblg+G0b88/fivkSaQz0bLc9ZrHbhaWeJ3JpplCVD8ApOOCu
	TPvnoPUPJ9NrncilVtpqMvWmzy051VZig/CzTPD7Aw3a6S3GQm5DW3l4bXlSRTmloXDNSyXqRYt
	MNzIIAUFkx2HxNGqksPYuyGb3ucvnABlpMwrGdPIraoKZPqynA==
X-Received: by 2002:a05:600c:8210:b0:4a2:1a:a116 with SMTP id 5b1f17b1804b1-4bb887865b5mr310617645e9.0.1795543906662;
        Tue, 24 Nov 2026 10:11:46 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm593980055e9.0.2026.11.24.10.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:11:46 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/2] main.conf: Add 'paired' to ReverseServiceDiscovery
Date: Tue, 24 Nov 2026 19:11:33 +0100
Message-ID: <20261124181134.481760-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124181134.481760-1-simon.mikuda@streamunlimited.com>
References: <20261124181134.481760-1-simon.mikuda@streamunlimited.com>
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

Add 'paired' in addition to true and false to ReverseServiceDiscovery:
with it, reverse discovery waits until the device is paired, and the
GATT client of an LE link that connected without one is started once
it is. The default stays true.

Assisted-by: Claude:claude-opus-5-5
---
 src/btd.h     |  8 +++++++-
 src/device.c  | 26 +++++++++++++++++++++++---
 src/main.c    | 29 ++++++++++++++++++++++++++---
 src/main.conf |  3 +++
 4 files changed, 59 insertions(+), 7 deletions(-)

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
index c9906148d..6e9a974f7 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -34,6 +34,9 @@
 # BITE tester doesn't like us doing reverse SDP for some test cases, for LE
 # this disables the GATT client functionally so it can be used in system which
 # can only operate as peripheral (see also GATT Client option).
+# Possible values: 'true', 'false' or 'paired'. With 'paired' it is done only
+# once the device is paired, so that reading the services of a device that
+# connected to us does not start pairing when they need encryption.
 # Defaults to 'true'.
 #ReverseServiceDiscovery = true
 
-- 
2.43.0

