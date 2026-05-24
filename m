Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511DA41C71
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779660874; cv=none; b=XPxwt2TfMAP48iwKAQccAlu10qTgr5flfRs+KVtmXEH8XPHLhJ+FHXXiiIfR5jrLApsRYwFtlaokiQZy+QFX3n43oP9YMMMm0K1z+IzjJh0mK2JFFT/wkzMQRCcM3FZvYfKYxiZ1tMFfOaWmB15sO2DvmcCT7nfiuh/QU0U7m7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779660874; c=relaxed/simple;
	bh=L8IhFqhnKn01w0EXWwX0+y6X3hnJlCuzlXE43DxDzt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0yzWni36c7RIdkC/8tzIwrgNAJ9SFY1cVt/K1zqmaY26DjomeKGTb2kPJqxyvt2rOlJsuaIk4vX+5XDCUSKH2yDH+4h7LBRdKCL7rLNuNUzHc71jns8RG1DXFi5Uyi+2LQ0UAAnc4I601Bcv2MkE8t6EX8dUbXxeOsVSJ+IO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JstW/3KS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JstW/3KS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490686877a1so220795e9.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779660872; x=1780265672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5mRbi7ODYWEtP7OAqayc5G6WwXUEyj4I9onT0sHNSU=;
        b=JstW/3KS5YWHUz0SXp7gwMroeOC4gte9xFxMKOm5ifqkQ6LjxuOOD7Z+IlUhLf2D6n
         1IH+qL6XayUJUfNdU1cO3kcAGG723EkCJov5h1jZNIWpLlowA4+z5muFnm/D34NXD2kO
         YT2QeOraqi5rpuyW9r7l2V+hzp37OSzHg+imCrQAm+F2xGSgj9zGki7RgCgeHa/t09xd
         4rw5kuy+oKYfHrYoEp7i+bpYwIF42fK41B4irGW0taAQy3C+OptplXmxNedzEPkUujVX
         3k+n4zfbEfZelfKCtQsbQqf9W1GWBnRYijQYNDRBs5t4n5PBtBUmPa8PgvYlQZflb65+
         eY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779660872; x=1780265672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W5mRbi7ODYWEtP7OAqayc5G6WwXUEyj4I9onT0sHNSU=;
        b=Vlxe1i4BE4++4YinsAFa0xwOh6ao70Lq9sa9XvoUPYalcfg3qGJcl9ivzO8JSkeJon
         /OVKS5gHT1haF1pLnEeAZTa+A0Hpr3AQTNrV6KDIiE5biCQpf05GCex/Q/8yiRApKKn8
         alivSct5oW2qJ5alfBUPZuxPa2HAl/5QQcsHix9ceGKUj+aWWJIa6aEMuJe1PLMkctZX
         m0GuKlI5zCFXd5fesHBOssqVNy8IvcrgZPrEgSc5DzesbX0vDVQjIBl6cb81YgJudQsw
         Rkp2iRDIs1xS3+YWOu1uzq8VB36EfFEj3Ud8sc+0/I6z/xzcYnv8b49jbtBy0+keNqIw
         /Pww==
X-Gm-Message-State: AOJu0Yw/azVznEauW453azHhaIJdX9IFfypaoFDsxqBIfShWS6Q5Yt69
	4V60+EHA5vE/pob8G73DUScrLILgH82POa5yww9iaEeezhnl2bQdk70smsMwTzJr+4U=
X-Gm-Gg: Acq92OGXQHPX+44IfBCbZCkUJsDw/sDvvStRWbyRSVhAJAcwhT/0KxhqzTX40t+geup
	/UGW20lapfGvX9zt3oyXbDHFFSNHacFB/mwbtFMDjEg7KR4rgmpnaBce1jiVjVLDwx+36scgEPv
	SYK26wdHzvlg9STvCnmoDaQFWrquJhy6x5qc3aH964RZvC8vkxFKTEasikyBq3HVHy4Ta1ixB5w
	g7Out25ZsLaFA61LZ/q97WzuFfeGhUbbcLVVaurgvAb7fR1e6qnuZXEmJhXmJRkvWe89sNC7382
	HZizlsNvSYbVFKU2fabBTL8GqwYc7zAdiHH2tbiIx05SNp8NQOsseuTU5TZkZx0hoPfckzc/GJ7
	dOUQ9UaEEs/hz9QGsyEiiK1LXNwnzZpcx9gQIhF+X+6TIE38Ej0hhNYf2A9/JHYgK6gS43aK0Ue
	jDHPvT0KLNsQzgefASlFCM0jyab4CmeM88ogiXLNeUlh+c/KPDJA==
X-Received: by 2002:a05:600c:8599:b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490426ade02mr124279285e9.15.1779660871661;
        Sun, 24 May 2026 15:14:31 -0700 (PDT)
Received: from bazzite.. ([141.195.57.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454b1ab3sm232036415e9.14.2026.05.24.15.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 15:14:31 -0700 (PDT)
From: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
Subject: [PATCH BlueZ 1/1] adapter: Add configurable default LE PHYs
Date: Mon, 25 May 2026 00:14:21 +0200
Message-ID: <20260524221421.258593-2-tarjeib@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524221421.258593-1-tarjeib@gmail.com>
References: <20260524221421.258593-1-tarjeib@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some controllers mis-handle LE procedures on specific PHYs with
certain peers. On an Intel AX210-class controller, connecting to a
Frostbay BLE device can fail during early ATT/GATT setup unless the
adapter is limited to LE 1M TX/RX.

Add an opt-in [LE] DefaultPHYs setting to bluetoothd and apply it at
adapter startup using MGMT_OP_GET/SET_PHY_CONFIGURATION while
preserving non-configurable PHY bits.

This provides a generic, adapter-wide workaround for controller-
specific LE PHY interoperability problems affecting scanning and
connection establishment, without adding device-specific quirks.
---
 src/adapter.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/btd.h     |  2 ++
 src/main.c    | 61 +++++++++++++++++++++++++++++++++++++++++
 src/main.conf |  8 ++++++
 4 files changed, 147 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 20f7c3e03..fcbb65e38 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4972,6 +4972,81 @@ done:
 	mgmt_tlv_list_free(list);
 }
 
+static void set_default_le_phys_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	if (status != MGMT_STATUS_SUCCESS)
+		btd_error(adapter->dev_id,
+				"Failed to set default LE PHYs for hci%u: %s (0x%02x)",
+				adapter->dev_id, mgmt_errstr(status), status);
+}
+
+static void get_default_le_phys_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	const struct mgmt_rp_get_phy_confguration *rp = param;
+	struct mgmt_cp_set_phy_confguration cp;
+	uint32_t configurable_phys;
+	uint32_t selected_phys;
+	uint32_t next_phys;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		btd_error(adapter->dev_id,
+				"Failed to read PHY configuration for hci%u: %s (0x%02x)",
+				adapter->dev_id, mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		btd_error(adapter->dev_id,
+				"Too small get PHY configuration response for hci%u",
+				adapter->dev_id);
+		return;
+	}
+
+	configurable_phys = btohl(rp->configurable_phys);
+	selected_phys = btohl(rp->selected_phys);
+
+	configurable_phys &= MGMT_PHY_LE_TX_MASK | MGMT_PHY_LE_RX_MASK;
+	next_phys = selected_phys & ~configurable_phys;
+	next_phys |= btd_opts.default_le_phys & configurable_phys;
+
+	if (next_phys == selected_phys)
+		return;
+
+	cp.selected_phys = cpu_to_le32(next_phys);
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_PHY_CONFIGURATION,
+			adapter->dev_id, sizeof(cp), &cp,
+			set_default_le_phys_complete, adapter, NULL) > 0)
+		return;
+
+	btd_error(adapter->dev_id,
+			"Failed to set default LE PHYs for hci%u",
+			adapter->dev_id);
+}
+
+static void load_default_le_phys(struct btd_adapter *adapter)
+{
+	if (!btd_opts.default_le_phys_configured)
+		return;
+
+	if (!(adapter->supported_settings & MGMT_SETTING_LE))
+		return;
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_GET_PHY_CONFIGURATION,
+			adapter->dev_id, 0, NULL,
+			get_default_le_phys_complete, adapter, NULL) > 0)
+		return;
+
+	btd_error(adapter->dev_id,
+			"Failed to read PHY configuration for hci%u",
+			adapter->dev_id);
+}
+
 static void load_devices(struct btd_adapter *adapter)
 {
 	char dirname[PATH_MAX];
@@ -9455,6 +9530,7 @@ load:
 	btd_profile_foreach(probe_profile, adapter);
 	clear_blocked(adapter);
 	load_defaults(adapter);
+	load_default_le_phys(adapter);
 	load_devices(adapter);
 
 	/* restore Service Changed CCC value for bonded devices */
diff --git a/src/btd.h b/src/btd.h
index db2e81239..59f44dc8c 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -140,6 +140,8 @@ struct btd_opts {
 	bool		device_privacy;
 	uint32_t	name_request_retry_delay;
 	uint8_t		secure_conn;
+	uint32_t	default_le_phys;
+	bool		default_le_phys_configured;
 
 	struct btd_defaults defaults;
 
diff --git a/src/main.c b/src/main.c
index 8aa19a3e3..97c64845b 100644
--- a/src/main.c
+++ b/src/main.c
@@ -32,6 +32,7 @@
 #include <dbus/dbus.h>
 
 #include "bluetooth/bluetooth.h"
+#include "bluetooth/mgmt.h"
 #include "bluetooth/sdp.h"
 
 #include "gdbus/gdbus.h"
@@ -132,6 +133,7 @@ static const char *le_options[] = {
 	"Autoconnecttimeout",
 	"AdvMonAllowlistScanDuration",
 	"AdvMonNoFilterScanDuration",
+	"DefaultPHYs",
 	"EnableAdvMonInterleaveScan",
 	NULL
 };
@@ -145,6 +147,8 @@ static const char *policy_options[] = {
 	NULL
 };
 
+static void parse_default_le_phys(GKeyFile *config);
+
 static const char *gatt_options[] = {
 	"Cache",
 	"KeySize",
@@ -751,6 +755,7 @@ static void parse_le_config(GKeyFile *config)
 		return;
 
 	parse_mode_config(config, "LE", params, ARRAY_SIZE(params));
+	parse_default_le_phys(config);
 }
 
 static bool match_experimental(const void *data, const void *match_data)
@@ -966,6 +971,62 @@ static void parse_repairing(GKeyFile *config)
 	g_free(str);
 }
 
+struct phy_config_entry {
+	const char *name;
+	uint32_t bit;
+};
+
+static const struct phy_config_entry le_phy_configs[] = {
+	{ "LE1MTX", MGMT_PHY_LE_1M_TX },
+	{ "LE1MRX", MGMT_PHY_LE_1M_RX },
+	{ "LE2MTX", MGMT_PHY_LE_2M_TX },
+	{ "LE2MRX", MGMT_PHY_LE_2M_RX },
+	{ "LECODEDTX", MGMT_PHY_LE_CODED_TX },
+	{ "LECODEDRX", MGMT_PHY_LE_CODED_RX },
+};
+
+static void parse_default_le_phys(GKeyFile *config)
+{
+	char *str = NULL;
+	char **tokens;
+	uint32_t phys = 0;
+	bool valid = false;
+	int i;
+
+	if (!parse_config_string(config, "LE", "DefaultPHYs", &str))
+		return;
+
+	tokens = g_strsplit_set(str, ", \t", -1);
+
+	for (i = 0; tokens[i]; i++) {
+		const char *token = tokens[i];
+		size_t j;
+
+		if (!token[0])
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(le_phy_configs); j++) {
+			if (strcasecmp(le_phy_configs[j].name, token) != 0)
+				continue;
+
+			phys |= le_phy_configs[j].bit;
+			valid = true;
+			break;
+		}
+
+		if (j == ARRAY_SIZE(le_phy_configs))
+			warn("Invalid DefaultPHYs token: %s", token);
+	}
+
+	if (valid) {
+		btd_opts.default_le_phys = phys;
+		btd_opts.default_le_phys_configured = true;
+	}
+
+	g_strfreev(tokens);
+	g_free(str);
+}
+
 static bool parse_config_hex(GKeyFile *config, char *group,
 					const char *key, uint32_t *val)
 {
diff --git a/src/main.conf b/src/main.conf
index 5846ef92d..ed955897e 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -247,6 +247,14 @@
 # Default: 500
 #AdvMonNoFilterScanDuration=
 
+# Configure the controller's default LE PHY policy used for scanning and
+# connection establishment. Only configurable LE PHYs are changed; mandatory
+# PHYs remain selected automatically.
+# Possible values: comma or space separated list of LE1MTX, LE1MRX, LE2MTX,
+# LE2MRX, LECODEDTX, LECODEDRX.
+# Example: keep LE on 1M only.
+#DefaultPHYs = LE1MTX LE1MRX
+
 # Enable/Disable Advertisement Monitor interleave scan for power saving.
 # 0: disable
 # 1: enable
-- 
2.43.0

