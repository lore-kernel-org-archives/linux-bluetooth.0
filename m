Received: from relay9-d.mail.gandi.net (relay9.mail.gandi.net [217.70.178.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758563F0ABA
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077954; cv=none; b=nXq2cp2NnKVNQ81XRvyWbxpcJA/V1R/iooc82HgOBtonaIy/Qja5ykBEug3IFSx9DlsJ6UkLeqXBo3Wk6LVAF5Y5lcTtBHzEcDYBWyhYBoSpCaqmxyzjuVI+jUF+N2T/Xb2vG9mesuSQmxGsfInZGiVZGsUmPNPLou6uKdiZ/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077954; c=relaxed/simple;
	bh=VuSI6Bf6burj7UgsReQqfhPutji+StL38TKb9QF/ciU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRAG/IpENdwA66SBOsxXSkqhItQ/s8kk96fbVglCQcUXh4Jzm6Lz+h0w91snLjugQRx1rz5GgJZeuqMXyQoXc1e+oTBuAajfCb9z3AR34ya4ICnboYUP4DG/DJnzMjvvvTbmVNtJHlq7YKMsmYVaXzL7HIvMNinzx2zKq6F0cvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by relay9-d.mail.gandi.net (Postfix) with ESMTP id BAE8B45C72
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 16:32:29 +0200 (CEST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 953E43EC0D
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:32:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 4/5] main: Use _cleanup_() to simplify configuration parsing
Date: Wed,  6 May 2026 16:30:58 +0200
Message-ID: <20260506143220.3076135-5-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506143220.3076135-1-hadess@hadess.net>
References: <20260506143220.3076135-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: spam:medium
X-GND-Score: 300
X-GND-Cause: dmFkZTFMSSW1lr7tk8HaYW3dj8hrSjp845JyjsB0fZqGwO1ZNOdR92YbpZy3k7VXRk7vKU22LIMwCEODW9ihvJglV/N5i93H1v7VCmh8PZYIN+0oWOF89u7cuOu/QqFMhgBoCck7plJ+tcxZu3wS8fEt15m1k+s6qSqLJA719/E/M65t1aKb74rQkj/CIBSh9c3/W2e724JFabaDywgg1Ii8eYWHxo3zqikohWwom0ULXxSLswBuTQ2i48WWBOldZTTkqfYHb/ia/GhV7fQoSYqKla69KegtQPa2Yj3Qt+B4mXajTTX3TwdMFtbgZOf3OfVIbd/J+ziZSfZ9onhHeh6WIoQmqvWYMexDmGjsZjYsUyxf/nS60jhra0N1fyzAA4OA/6oD9mybtGVmT50ZF4g7C1ns9FW7FnBp6zMVrTCr1eO/jYwLXij4lB7Itk/t13eFeG0zUov4w7J1Gxd1dWrMP3jN+ODPeezC6zSbngwbiOPCMB5RjLQcikQ1PEVLfcFWh4M7nESTkmiplGrAHhozyXuKiUn+gmsc7RJMQogaCJ7HjRqJpo5E0k5L0VPMSNqIq0WxiabRPHYrwCGbsdynnWNcMLq5d0F9LHmCjPMWHqH3FJJnAKyiYx7j9wXSgwfQpSrzEJMGZvvgpYNpu21rmO8okJWmYgKlxwQcc80fKJTZlA

Makes dealing with the error path easier.
---
 src/main.c | 70 ++++++++++++++++--------------------------------------
 1 file changed, 20 insertions(+), 50 deletions(-)

diff --git a/src/main.c b/src/main.c
index 8aa19a3e3346..3a2c3e645a74 100644
--- a/src/main.c
+++ b/src/main.c
@@ -462,7 +462,7 @@ static bool parse_config_int(GKeyFile *config, const char *group,
 					size_t min, size_t max)
 {
 	size_t tmp;
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 	char *endptr = NULL;
 
 	if (!parse_config_string(config, group, key, &str))
@@ -471,25 +471,21 @@ static bool parse_config_int(GKeyFile *config, const char *group,
 	tmp = strtol(str, &endptr, 0);
 	if (!endptr || *endptr != '\0') {
 		error("%s.%s = %s is not integer", group, key, str);
-		g_free(str);
 		return false;
 	}
 
 	if (tmp < min) {
-		g_free(str);
 		warn("%s.%s = %zu is out of range (< %zu)", group, key, tmp,
 									min);
 		return false;
 	}
 
 	if (tmp > max) {
-		g_free(str);
 		warn("%s.%s = %zu is out of range (> %zu)", group, key, tmp,
 									max);
 		return false;
 	}
 
-	g_free(str);
 	if (val)
 		*val = tmp;
 
@@ -500,10 +496,9 @@ static bool parse_config_signed_int(GKeyFile *config, const char *group,
 					const char *key, int8_t *val,
 					long min, long max)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 	char *endptr = NULL;
 	long tmp;
-	bool result = false;
 
 	str = g_key_file_get_string(config, group, key, NULL);
 	if (!str)
@@ -512,28 +507,24 @@ static bool parse_config_signed_int(GKeyFile *config, const char *group,
 	tmp = strtol(str, &endptr, 0);
 	if (!endptr || *endptr != '\0') {
 		warn("%s.%s = %s is not integer", group, key, str);
-		goto cleanup;
+		return false;
 	}
 
 	if (tmp < min) {
 		warn("%s.%s = %ld is out of range (< %ld)", group, key, tmp,
 			min);
-		goto cleanup;
+		return false;
 	}
 
 	if (tmp > max) {
 		warn("%s.%s = %ld is out of range (> %ld)", group, key, tmp,
 									max);
-		goto cleanup;
+		return false;
 	}
 
 	if (val)
 		*val = (int8_t) tmp;
-	result = true;
-
-cleanup:
-	g_free(str);
-	return result;
+	return true;
 }
 
 struct config_param {
@@ -915,7 +906,7 @@ static bool parse_config_bool(GKeyFile *config, const char *group,
 
 static void parse_privacy(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!parse_config_string(config, "General", "Privacy", &str)) {
 		btd_opts.privacy = 0x00;
@@ -948,13 +939,11 @@ static void parse_privacy(GKeyFile *config)
 		DBG("Invalid privacy option: %s", str);
 		btd_opts.privacy = 0x00;
 	}
-
-	g_free(str);
 }
 
 static void parse_repairing(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!parse_config_string(config, "General", "JustWorksRepairing",
 						&str)) {
@@ -963,13 +952,12 @@ static void parse_repairing(GKeyFile *config)
 	}
 
 	btd_opts.jw_repairing = parse_jw_repairing(str);
-	g_free(str);
 }
 
 static bool parse_config_hex(GKeyFile *config, char *group,
 					const char *key, uint32_t *val)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!parse_config_string(config, group, key, &str))
 		return false;
@@ -977,37 +965,34 @@ static bool parse_config_hex(GKeyFile *config, char *group,
 	if (val)
 		*val = strtol(str, NULL, 16);
 
-	g_free(str);
 	return true;
 }
 
 static void parse_device_id(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	parse_config_string(config, "General", "DeviceID", &str);
 	if (!str)
 		return;
 
 	parse_did(str);
-	g_free(str);
 }
 
 static void parse_ctrl_mode(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	parse_config_string(config, "General", "ControllerMode", &str);
 	if (!str)
 		return;
 
 	btd_opts.mode = get_mode(str);
-	g_free(str);
 }
 
 static void parse_multi_profile(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	parse_config_string(config, "General", "MultiProfile", &str);
 	if (!str)
@@ -1019,8 +1004,6 @@ static void parse_multi_profile(GKeyFile *config)
 		btd_opts.mps = MPS_MULTIPLE;
 	else
 		btd_opts.mps = MPS_OFF;
-
-	g_free(str);
 }
 
 static gboolean parse_kernel_experimental(const char *key, const char *value,
@@ -1043,20 +1026,18 @@ static gboolean parse_kernel_experimental(const char *key, const char *value,
 
 static void parse_kernel_exp(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!parse_config_string(config, "General", "KernelExperimental",
 						&str))
 		return;
 
 	parse_kernel_experimental(NULL, str, NULL, NULL);
-
-	g_free(str);
 }
 
 static void parse_secure_conns(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!parse_config_string(config, "General", "SecureConnections",
 								&str))
@@ -1068,8 +1049,6 @@ static void parse_secure_conns(GKeyFile *config)
 		btd_opts.secure_conn = SC_ON;
 	else if (!strcmp(str, "only"))
 		btd_opts.secure_conn = SC_ONLY;
-
-	g_free(str);
 }
 
 static void parse_general(GKeyFile *config)
@@ -1120,14 +1099,13 @@ static void parse_general(GKeyFile *config)
 
 static void parse_gatt_cache(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	parse_config_string(config, "GATT", "Cache", &str);
 	if (!str)
 		return;
 
 	btd_opts.gatt_cache = parse_gatt_cache_str(str);
-	g_free(str);
 }
 
 static enum bt_gatt_export_t parse_gatt_export_str(const char *str)
@@ -1147,14 +1125,13 @@ static enum bt_gatt_export_t parse_gatt_export_str(const char *str)
 
 static void parse_gatt_export(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	parse_config_string(config, "GATT", "ExportClaimedServices", &str);
 	if (!str)
 		return;
 
 	btd_opts.gatt_export = parse_gatt_export_str(str);
-	g_free(str);
 }
 
 static uint8_t parse_gatt_seclevel_str(const char *str)
@@ -1176,7 +1153,7 @@ static uint8_t parse_gatt_seclevel_str(const char *str)
 
 static void parse_gatt_seclevel(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!btd_opts.testing)
 		return;
@@ -1186,7 +1163,6 @@ static void parse_gatt_seclevel(GKeyFile *config)
 		return;
 
 	btd_opts.gatt_seclevel = parse_gatt_seclevel_str(str);
-	g_free(str);
 }
 
 static void parse_gatt(GKeyFile *config)
@@ -1204,7 +1180,7 @@ static void parse_gatt(GKeyFile *config)
 
 static void parse_csis_sirk(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!parse_config_string(config, "CSIS", "SIRK", &str))
 		return;
@@ -1213,8 +1189,6 @@ static void parse_csis_sirk(GKeyFile *config)
 		hex2bin(str, btd_opts.csis.sirk, sizeof(btd_opts.csis.sirk));
 	else if (!gen_sirk(str))
 		DBG("Unable to generate SIRK from string");
-
-	g_free(str);
 }
 
 static void parse_csis(GKeyFile *config)
@@ -1305,7 +1279,7 @@ static void parse_le_cs_config(GKeyFile *config)
 
 static void parse_avdtp_session_mode(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!parse_config_string(config, "AVDTP", "SessionMode", &str))
 		return;
@@ -1318,13 +1292,11 @@ static void parse_avdtp_session_mode(GKeyFile *config)
 		DBG("Invalid mode option: %s", str);
 		btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 	}
-
-	g_free(str);
 }
 
 static void parse_avdtp_stream_mode(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!parse_config_string(config, "AVDTP", "StreamMode", &str))
 		return;
@@ -1337,8 +1309,6 @@ static void parse_avdtp_stream_mode(GKeyFile *config)
 		DBG("Invalid mode option: %s", str);
 		btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
 	}
-
-	g_free(str);
 }
 
 static void parse_avdtp(GKeyFile *config)
-- 
2.54.0

