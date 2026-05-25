Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806033839A0
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720631; cv=none; b=In6KYDfsXT6dkejTaXVIZY5bZTwWsA8ScgQay9pKXY5KeC/iXowfoNCPkfqpif7/4/r/6s0MXoOQyMiTS4WLMwDlQ2TqMLb33QQMuC99jCeCVvMg/fD2V4ZMPL4VECSIjFMx3tNL5oFbhaq6YtrTlFoTy2H2fMzVDR5kD/BdQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720631; c=relaxed/simple;
	bh=IbHY2Gu4z8Pzp7PsjWum2vSQFzljEtcKYClaOwidWrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2BxTNCLEyJW+yybz1tDWBBlq9pTidiFhcD9FPnUOF0Gu9DUcHguYxQ2dpyi5AD0MwtPz+jjtSww3OsZ18cL5tyP01CQzCIHd7LM5hu5Zd8n62TAsx1Y678ROMq/22cNrCMN72YfGarBS5TxsVOQ1UolgCuqTV+8Hw1Ufw+24gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6+QrFm6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6+QrFm6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48fde648a71so63005725e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779720628; x=1780325428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQhT5use+6EPS8mVTlg+n6FAxnWapaL0SHSMUx5Ri2o=;
        b=d6+QrFm6/sfINR7jZ/DyAjcNXTLYyBR+foevwuq2V4rI5Eq3nceFPcQZDHp794aBfu
         S5jqBRsalmiXvC5t5/IgRIPlBtcfXBPp+KghHqPnt4NZ1cv1rV1WwGwhBWYA+3DISok2
         VqpWLLJjU7ymprvy4/9SJcf1tAIjGtYnLcR9Rb77nTidf/nUBinAyCqY5bQA2Vb4XX1g
         s30wVXHVn1IvUBuo1ASpd0TZiNG73SPtmIfBKNI+kaqHFYHZocZ/d5f8Jm4ifEvfv0OH
         vkMWCjSg7x1RarWtcVXhfADV7zbLS1RDEolxopQsKEOlLhp/FiqMX439mf4xvMAt9w2m
         kfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779720628; x=1780325428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FQhT5use+6EPS8mVTlg+n6FAxnWapaL0SHSMUx5Ri2o=;
        b=WbzFHZQNqbeAPatPGtwZuG3r3vQEChXrLlmmaK1W4LfeESP7DR90VkfwokkM9pyl9K
         qe/LETCiGtfWhxkNiMZZiGu1qsFMtD8ynkFMM4K7RKaDEuKZmfIsPO/zMk6i7aQYfDsG
         fXJ52mu3aKH8xe5qmnMdt8PfAP4KEhKoBXqMT/BuiKbOWVF7IvVNcBGu58l/g+50VhXa
         LB4Dbd6ZgLXaeOWrjmiIAvULce6VKvkhmvtnXP73lQ+TlfbFbe1AsQ2R8KlidJiijzHL
         v8IxuocDsG2AatGAqrCTkx1JGmbupNIEFrIpxSNwcEaeDlzpNTuXwXY6kh99UP+gyfXl
         AXcQ==
X-Gm-Message-State: AOJu0Yy348GgapvnEeyhKwenWJY1/wOaSzsCladwGZ1uxnA4sUeos9J/
	ng1nyFZk44QAdZqYKcCZqfvZUfXs1RkBUxbED3nvEOXq0/w+uQvhPYEeVY62OBtvVfg=
X-Gm-Gg: Acq92OGIBfYVkQF+dE9gkZsHRncB+iLK5F6VZ/k3ZATl3KC37akEp+yMCvccLTdz3sc
	lvbMgD+4RBLDjlnOdIsh12bfS/Wcm0G1B/JGST0AEPRusCjaW6ZbKuhfdf6mC78eFKmGeRZgiDJ
	Q0AXLvgyTDbOekix9JnEStYDYO9ODG+w4ozvj9Q4AkE+nOv1zXO1fASeazUnfbwg3mylbUZQTAl
	7o/WKqo02YAQ/kiUOi+3EnqFnyXjUqNDF7Dx+XBtTYJbdEgW2V5tHklqpkd4qEHCQdOg4j7/QlU
	dGa4faYXrRvgPXv6en3BdK9IIP5YPwMbMqHwkoFEkLiJDg8t964L5uOYC7BD/U8KSDMMb6dBFMK
	2wCFwxq7Z0+y/SJm9PlnXZts6+54O2wEvH5Hh/p/vM/14O6gT5wB3Q70rwDmc7Acx9YbA2YGYVx
	FIxNrYt6gLfSbj7+DfYlwBcZEZn06cAAWiA48R6U3O8/BMwBWq2jFhvTkSeX/8
X-Received: by 2002:a05:600c:c4a4:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-4904225fbdamr221246605e9.2.1779720627729;
        Mon, 25 May 2026 07:50:27 -0700 (PDT)
Received: from bazzite.. ([141.195.57.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042cebaaasm88589125e9.36.2026.05.25.07.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:50:27 -0700 (PDT)
From: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
Subject: [PATCH BlueZ v4 1/1] adapter: Add configurable default LE PHYs
Date: Mon, 25 May 2026 16:50:10 +0200
Message-ID: <20260525145010.154170-2-tarjeib@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525145010.154170-1-tarjeib@gmail.com>
References: <20260524221421.258593-1-tarjeib@gmail.com>
 <20260525145010.154170-1-tarjeib@gmail.com>
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

v4:
- Replace the hard tabs in the changelog continuation lines with spaces
  to satisfy GitLint.

v3:
- Match the queue header include spelling in main.c with device.h to
  avoid the Sparse redefinition warning seen in CI.

v2:
- Check MGMT_SETTING_PHY_CONFIGURATION before sending PHY
  configuration commands.
---
 src/adapter.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/btd.h     |  2 ++
 src/main.c    | 63 +++++++++++++++++++++++++++++++++++++++-
 src/main.conf |  8 ++++++
 4 files changed, 151 insertions(+), 1 deletion(-)

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
index 8aa19a3e3..83be19be3 100644
--- a/src/main.c
+++ b/src/main.c
@@ -32,6 +32,7 @@
 #include <dbus/dbus.h>
 
 #include "bluetooth/bluetooth.h"
+#include "bluetooth/mgmt.h"
 #include "bluetooth/sdp.h"
 
 #include "gdbus/gdbus.h"
@@ -43,7 +44,7 @@
 #include "shared/att-types.h"
 #include "shared/mainloop.h"
 #include "shared/timeout.h"
-#include "shared/queue.h"
+#include "src/shared/queue.h"
 #include "shared/crypto.h"
 #include "bluetooth/uuid.h"
 #include "shared/util.h"
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

