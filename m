Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032618EFD4
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935001; cv=none; b=KA4aAIZ509n3cj3M9ngKRgpnS3Xy0bGJGV9lhfcyjjAGn3AKYAtK88bJVyJjSVZR/TPLXSELc1tcLaqWk34Aw9X2XADwHCqsfGRttr4ZynFrA7lhglrA/cecZphMoSW9eZ1ricwamvu+NiUj43roGYNdrkDkRcy8Pj3vEQRbiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935001; c=relaxed/simple;
	bh=h6N/ltvzcfj7tRVQG9d80Zlz2oDBAWBGAX5OAPvf3FM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pi0w2Yw98qQmcEUr2vrW25UckPR//+TKVy6RE6OPrLGxFLk6e9/w9+DrhW/V6ZEpykKu8HxTDjTDk4A4RQrOVixGZ99AP4vSut8EMr1cy95uWs6b8jtexkE/+GdwBM+q5hY87RKpBI+D7Rn16MnJhUatlV3TVwxwXeGBlllF4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+veWCJP; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+veWCJP"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52410fb2afeso5398176e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747934998; x=1748539798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4YADi2e17JHtskS5BkrhmLyo+3VegEd3LoVV951SpA=;
        b=i+veWCJP2/g1aexjsjDKmI4BMD00JyW77RSYmi75udWmggEGOQ79uPotuzJYwjgEt+
         8ocLjne9qjjN8aM0loRcds1fhMdia8HIt1M+BDlGW1dAMwvvVfaW0IIJYS8Akg+ZLrbI
         nhJErMGJ57KtDUPKlzSFtg+HlNVbuBdYHpSWn5xGt8zrFY/kRA1SNC8NS0o9aWgGzK+T
         zUG02UbbiEwbvGOdZhvEn2UDElRReWCyFWmhuQTRxdd97EqlZOdmlCbr/8EcnKUE7rOI
         JrhSxTbMPVHpLQ57OJZ8ToEV4XVE/SDXaxscR/Kkf1LPueQRsJSpfV2ymdZ0La5stytQ
         /4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747934998; x=1748539798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4YADi2e17JHtskS5BkrhmLyo+3VegEd3LoVV951SpA=;
        b=XXY1bGB4YasPpoZdMavxRrG1fRL8rQJb4RMw0F36qgvgNBJM0BwSMWNVJa7fJajhcR
         7Wh6HggcYmxj6UMZQJqRhahESEzH6++qeK9c2oBsCiYtaIj1U0cC78OwaZWWv4liv2NB
         l1JyCDN8+1z8h80x5Lv+1JQLONzWB5rQEI9l8QVP6BsansN6Vzgy7MZTQYSU34w+2JH3
         jAX+dcxjCGcOZJeEjGJPAYw9cUEZULsL72cFj/+vKb3583MTpEgGyRt80bQrb0e2VQn3
         qUxuDCD1cdN0RS3LS9UMsR8V2BccWo1/0KhsZkkRq99UQYOxZqowal6FIWUud75jWNua
         Q+LA==
X-Gm-Message-State: AOJu0YxOsGE1Gx3cmo6784LI9ukvhJeXOLPsGxvqUROZxnTyIL0/+R+I
	HlF49HLMDKjEpluL5wKn91S4DTIniUQqOLE0aCau/YnQBaoErrqy+5jWHwgCmsQ5
X-Gm-Gg: ASbGncs4xAzfXj6lsOz7HolwbBTif5VqaQhIp7d3trp38ESebQN30r+82z+JzGZwtuD
	cI00NhGDa0xcq+VZgCDvIoIWJU8ipNGujzvLF9BTGIuChXBJtQ+3DxPhHTAYROBlH84rmLe3yV0
	QYCilgE3oGySUbEy/Bu8BIhzE/eyUzDsGcUzdqUPMkDna0NZY4czhjCbJHBHaOvAGKHi49savBu
	Cj4AQ++Z4/0Kbsm2LXL5oQol9BavKruXwttCBGD4d8Bv8aBNruCD/rX5SqSRJhHHmPQFdI2iMQI
	u7c4wXVOX6vaOmhrmwesKekiT/D0or8qpkk2ADCIIQui8awGGQDhIC9I+ttb91m1aw244sSmhJL
	CbeqSxyR3aPXXIesVRjCB
X-Google-Smtp-Source: AGHT+IHEj1i2F3o4LLb7qa00axciBQ8f5T6bKroiUfqnceB/JviEGkOKypIYF8IIfdhI7KLUAjQwVA==
X-Received: by 2002:a05:6122:221d:b0:520:6773:e5ba with SMTP id 71dfb90a1353d-52dba803151mr25679744e0c.2.1747934997625;
        Thu, 22 May 2025 10:29:57 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dba91076esm12220321e0c.3.2025.05.22.10.29.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 10:29:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/4] client: Add scan.auto-connect command
Date: Thu, 22 May 2025 13:29:51 -0400
Message-ID: <20250522172952.3312270-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522172952.3312270-1-luiz.dentz@gmail.com>
References: <20250522172952.3312270-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[bluetoothctl]> scan.auto-connect --help
Set/Get auto-connect filter
Usage:
	 auto-connect [on/off]
---
 client/main.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 5d53a7be11e4..5c31cd8763e2 100644
--- a/client/main.c
+++ b/client/main.c
@@ -161,6 +161,7 @@ static struct set_discovery_filter_args {
 	size_t uuids_len;
 	dbus_bool_t duplicate;
 	dbus_bool_t discoverable;
+	dbus_bool_t auto_connect;
 	bool set;
 	bool active;
 	unsigned int timeout;
@@ -1253,9 +1254,14 @@ static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 						DBUS_TYPE_BOOLEAN,
 						&args->discoverable);
 
-	if (args->pattern != NULL)
+	if (args->pattern != NULL) {
 		g_dbus_dict_append_entry(&dict, "Pattern", DBUS_TYPE_STRING,
 						&args->pattern);
+		if (args->auto_connect)
+			g_dbus_dict_append_entry(&dict, "Pattern",
+						DBUS_TYPE_BOOLEAN,
+						&args->auto_connect);
+	}
 
 	dbus_message_iter_close_container(iter, &dict);
 }
@@ -1492,6 +1498,29 @@ static void cmd_scan_filter_pattern(int argc, char *argv[])
 		set_discovery_filter(false);
 }
 
+static void cmd_scan_filter_auto_connect(int argc, char *argv[])
+{
+	if (argc < 2 || !strlen(argv[1])) {
+		bt_shell_printf("AutoConnect: %s\n",
+				filter.auto_connect ? "on" : "off");
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (!strcmp(argv[1], "on"))
+		filter.auto_connect = true;
+	else if (!strcmp(argv[1], "off"))
+		filter.auto_connect = false;
+	else {
+		bt_shell_printf("Invalid option: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	filter.set = false;
+
+	if (filter.active)
+		set_discovery_filter(false);
+}
+
 static void filter_clear_uuids(void)
 {
 	g_strfreev(filter.uuids);
@@ -1531,6 +1560,11 @@ static void filter_clear_pattern(void)
 	filter.pattern = NULL;
 }
 
+static void filter_auto_connect(void)
+{
+	filter.auto_connect = false;
+}
+
 struct clear_entry {
 	const char *name;
 	void (*clear) (void);
@@ -1544,6 +1578,7 @@ static const struct clear_entry filter_clear[] = {
 	{ "duplicate-data", filter_clear_duplicate },
 	{ "discoverable", filter_clear_discoverable },
 	{ "pattern", filter_clear_pattern },
+	{ "auto-connect", filter_auto_connect },
 	{}
 };
 
@@ -3219,6 +3254,9 @@ static const struct bt_shell_menu scan_menu = {
 	{ "pattern", "[value]", cmd_scan_filter_pattern,
 				"Set/Get pattern filter",
 				NULL },
+	{ "auto-connect", "[on/off]", cmd_scan_filter_auto_connect,
+				"Set/Get auto-connect filter",
+				NULL },
 	{ "clear",
 	"[uuids/rssi/pathloss/transport/duplicate-data/discoverable/pattern]",
 				cmd_scan_filter_clear,
-- 
2.49.0

