Received: from relay9-d.mail.gandi.net (relay9.mail.gandi.net [217.70.178.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54F35A38C
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060088; cv=none; b=urtxZtU86ZVLVZK6rFrAexFpq1mDFV4Sb1EmQ3VKqbS7mg9CBuZGO8/NwuDF6qN9dqcS/co5mIq7F92f/ZBJJ3LrqQcfWNUroxruThViWR15DsX+qj39WpvN343LHdIYbSR2L0072AR+ckmZslKni4RcRn/uKZSdS06LQQ0Iz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060088; c=relaxed/simple;
	bh=VuSI6Bf6burj7UgsReQqfhPutji+StL38TKb9QF/ciU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvW1kqEGElTbHemfe2oaoZoO+QE5T2PuKO8SI06H/xUMdimw+/wZUyeeUsethKDB953d8upcsizRpykDAJEYUy+yLcIdj/XyKcM3hWFx5xBeUQB7UOxZZ/i7uluVSpxFvecEExqDyhaF0mbQm3qQVwXJ8soirUfuuIW+BFL7/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by relay9-d.mail.gandi.net (Postfix) with ESMTP id 25E5545C3C
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 11:18:34 +0200 (CEST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F06F53EBD2
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 09:18:33 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 4/5] main: Use _cleanup_() to simplify configuration parsing
Date: Wed,  6 May 2026 11:14:25 +0200
Message-ID: <20260506091824.2920716-5-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506091824.2920716-1-hadess@hadess.net>
References: <20260506091824.2920716-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTEhrS5CevKfea6c0gYz1xqPoe5WgaprRaljhhda6y1tTAjQvY4W850UJSa/N3qAB60atETHsWsQ8s1ozOJt86GwG1eHxHAo/cp75xPzNrbbdLAIAddLibkwJZFaBn118YDZWPFcRrOUfZZWULOxIQRJiVJk5siLOjMUeG0Hz8ioAIOWz8lxSiwQSU3ek4hPLBg6rWxgfSbnWCUwLmi5fOvMoOdFfxO0DsqjRrB6zBFa2Hpgu1XS0w/Rnuhso2GNWPROYpM3+KAbDp5aZhjuog3nb9dgQdeQidiO0DYhnkpes5Ai+rNejAT7In3wtjMm5dWcKeqNl8JxiddbyYMpu+8vUx+vTNtuGED7LkhSTk5xLac6SG+1QZ5lwWNf335inA9DolTjfl48sml+8wg12DG8stU7Zq70bOo3zHQMxGlkKwN1YMM5KB32tQ13lnXrU3nwuxFLGrlOhkT9571H0vOSmtFrZ+UwYa6MCeIexIE1ATGyHk5Nnifon04VzEy9cZU8LkD0PTwxiO1t8Fzne6k2LMRgl72EH04/Nmt9kiUeWGON43V4CCtGGoPcIlILj7Z6Q55s0vXAYsDnk6Ag51oD8DEqfg4ot3ac5HCU64tXPmPdltsXXfybFzQD5Odxo3jVsQXfGeTltplbgMFkrm2OAPHnd4liPYmE3mgt21U2jA

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

