Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B93AA514
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691905; cv=none; b=k0VtqVyQ3aQBRaG9p8oDlWzryesa1jIOMAH7CREbY0aIrN+3zaE5JZVDSUqMVjv+fWEN5V7vjXHfS8qBPW4mKkldrlBKOcM2CRLUwH95uNrIPu/TWBYTzro1YKpz6aSxqezjRhPoQ6idMMLjY6+iPQvWTPa3CpBVpvCareHrehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691905; c=relaxed/simple;
	bh=maAyXrl/b8Dp9bhL7tM3V74txFup3AHVVLUO0b0lsUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pct9EidFoogSj+zaibJlfWjhEUWE3oBCKUAiEJoZmgf4uCbmHtXeRoRroRXII/+GXcULMxjw7mplDmX3YsAuCbrlo5QffgwSIK8oVDxXJDGPzhAXV8UMvdTKxsGMfNFfDiT2Zjt6D28MRjCLp2xmwRcyqRO0kr7/Q12JCTe2ZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fALEELUY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fALEELUY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso17890865e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 23:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779691898; x=1780296698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bplQjJxh/YWvxtio9sWQrxXHGrvSC78dfZ+nvg9bCKM=;
        b=fALEELUYFEnwJqVkW4mdPY2+0fMxrxQ9MkhRuTf4Lr5auQkDhWguGCpK2pao343bFS
         uvABIJQozLZy11dgjplRql4CuLhXESA/nyW+rFpW9jn10kQX3v3WNRqJ5FQxT+7Vew65
         PK/rSn4tDnQhv71lB/ZC2+W01TVE3GyX60SGowlJsf5wLU1ie51BENF4I72oPr3O/FJA
         OPBMdu3yYvvaTtlfOtvvLe4f7E1h7+vniUCqF/A8+Cyb8Wdssm2EfVexo/Dz8YYNQsRN
         6xHMyKxmOT+Pa2VcTgafelBwHvrZV2RWmpFEZZXet1gNlP5laNuaFD4fQcWGDXo3rbxx
         FrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779691898; x=1780296698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bplQjJxh/YWvxtio9sWQrxXHGrvSC78dfZ+nvg9bCKM=;
        b=ka4A3nM0T8SLEq4v1U/Qgda8mCh3GiFzHU3KYZFzgpHUNH69JHc+dDv/gfgFerZG9Y
         TQPwWx0HvyGluT+K7TeoO1fytjy6GMzH9lfcs6dPQS2KWddUiP+MO5g8RNoECQ4wpynt
         OZ4hdy981Vn8q5LMe2DAQO2GBnzsB5N5T4kRNx+XQNdw+w0JKzvBYXzFXnD6NRI/rei/
         49FayQnttKp6YKuI/57ylBz8F4C55/M/Gvbhj2zBk/af4BZV0E4KZtHpXPLnbKKmzfxx
         9kz22iRHecnErC5FmL/vAuCiq5JW818z4aMe0rIHbSp6i1UILBKZZNQvQ6dpaXugdxdr
         pjOA==
X-Gm-Message-State: AOJu0Yw9au5lqZjZ8J/uf4+7TWOEF8nsLTqPEouYEellGuqtgiB53IV/
	X5oC0mj7qCzNiezHzmTMGxAQjJ6/sc5zKkEKBhIJUfNbOX1Xmsif38HeuXOnvkx6FFQ=
X-Gm-Gg: Acq92OEFVhd/bhSGFOo782wHaXEyO5VnxEDgFEbn1zs6bCZheO2X8g/J6aY8PgfAbTi
	C/Su92IK90mOmNQndqI0QrOlbnuIVjMaVg0mK633QtLYB+oBGpkAfkWhBSDGuJIQ/Pe9wDubttS
	YJyDT66HaVRUhu+rXSsBT8QewT3uRXvU+p8MEhEaSkxYwCg+bM3QR11Vb84XKuiA4mpdH8ApxQD
	iS1U2TerMLppLd6QCv2Id4YUyLyLTTicEUveNw5VocyKANDI0cBU2b3ho4UHp+itkdaYjO6Bx+G
	dge48m/FMEr2/LUj70TW02YGt/J5jbHs6Oxn2W6sDHdsE3V87S+iElgUpwcVseTHBDAHHZ5y2/q
	O3PMQmPj/ZQ7ZY15439MtUHlcPNzz4I+5/BD35uhVfJS1D7fYel3K2l25gln2Jd0/pxFssC566+
	EQQ3XRs1dJ5CSVO6yzPp/wP6ktnoWGCnZam8pNwGSmp3RaSXYG1w==
X-Received: by 2002:a05:600c:698d:b0:490:601f:d77b with SMTP id 5b1f17b1804b1-490601fd94amr85319645e9.0.1779691897684;
        Sun, 24 May 2026 23:51:37 -0700 (PDT)
Received: from bazzite.. ([141.195.57.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042ce8722sm77507645e9.34.2026.05.24.23.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 23:51:36 -0700 (PDT)
From: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
Subject: [PATCH BlueZ v2 1/1] adapter: Add configurable default LE PHYs
Date: Mon, 25 May 2026 08:50:44 +0200
Message-ID: <20260525065045.27375-2-tarjeib@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525065045.27375-1-tarjeib@gmail.com>
References: <20260524221421.258593-1-tarjeib@gmail.com>
 <20260525065045.27375-1-tarjeib@gmail.com>
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

v2:
- Check MGMT_SETTING_PHY_CONFIGURATION before sending PHY
  configuration commands.
---
 src/adapter.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/btd.h     |  2 ++
 src/main.c    | 61 +++++++++++++++++++++++++++++++++++++++
 src/main.conf |  8 ++++++
 4 files changed, 150 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 20f7c3e03..46df362c5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4972,6 +4972,84 @@ done:
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
+	if (!(adapter->supported_settings & MGMT_SETTING_PHY_CONFIGURATION))
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
@@ -9455,6 +9533,7 @@ load:
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

