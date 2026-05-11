Received: from relay9-d.mail.gandi.net (relay9.mail.gandi.net [217.70.178.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F23E8C5C
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505711; cv=none; b=Sx8zRae3ss78Qhc9ijDA9KZAO2pKVSOVScuDj/YXWjXaaV7e+398auk19jOXgpFbxe3uOcV/eICMnGGBRIq5BlGsdStmTOirAPRRHQAOI9TvBBOaRs/1wDnfTlqbnc3L33Qf11EMh7RKtdd53U0b70FrDkdEVSkxow9gRJ+piOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505711; c=relaxed/simple;
	bh=6BhJZFqWX5rb+jdRx2NAxxCggHGTpI8zr7i7HaPgwQY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxftq1+XIoL1fTq5imrwugku55VaTEItb2teAKlcv8Psj8IrVIZdZuyelz6ChmJ3GmszuDa5yNIWlAjl6qJx7C90qz4nbnAJ39b0S/a4IYQIITJ9ypz+McaMRTmeGtpSkDtQO+7WpsObNr52uhs8S+Hp7lwTKHgTkG1caYGDjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by relay9-d.mail.gandi.net (Postfix) with ESMTP id 476A544AAF
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 15:21:41 +0200 (CEST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26D783EC42
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3 4/6] main: Use _cleanup_() to simplify configuration parsing
Date: Mon, 11 May 2026 15:18:07 +0200
Message-ID: <20260511132131.1283892-5-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511132131.1283892-1-hadess@hadess.net>
References: <20260511132131.1283892-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFw/dM7eU0nUH1eh0jc2zzq4vnb8lF0Wgq2WuCaiyraLD5KP322b5seTCtoDzOoYkoiDoof5acpdHk1L7SKNxvIPefZbHqvOzWFF85EDW3cEO6+VcHk3VbHoaORZM65+kDMU+Hz/DoDZqliRZDXRFvZwvDxpz1PkvGOB6qfpz+OryAiJfdwzDIcpa2zkRXncHzwB7wAjS8imPmWqYj2gZvYluySo1ALo3eN9rSfQi6oeAF7rmlRzFyZH+xVeZASgsdLO/BX7lqO1gmeX+swDZ/vI98N35QKActA3BGIfPTysiX+4qjf7ED4GZOd+QLNa2TVG498Sm5xC1WLCS7IMc64jqPsFk/E0QS6bss7lw7O7ofEw2tVernTl1kuQBJGHO8/cPbAH/W7Rvv1uN1UQWJiio2PRu52OCVZfXsB6qsTmIIBqsViNte1jKX/9nqHqi1m7ka/ZmmmfHE3PNi91ucsGCoHyBWyombWbk3hx/6Qf4enONmajYn2qCSU+p7MjhlV1sUtH9m3MGi78T/dlPQbBXAws3tQiM9sl5/U0cgMJk89Wyg44ENGRBWIrr6QnSlJzyqHhu2cy3UBLrB7z4BbtzAifGfeh1hJ9cY2eDRhoP6KXg9/jEYcTaa4R9wtxl8EW8zgVQ851/Bwg1BJSPuAwvIN3RuRB4cWsxIZbBC2OA
X-GND-State: spam:medium
X-GND-Score: 300

Use helpers to simplify temporary string usage, and cleanup in error
paths.
---
 src/main.c | 101 ++++++++++++++++-------------------------------------
 1 file changed, 31 insertions(+), 70 deletions(-)

diff --git a/src/main.c b/src/main.c
index 8aa19a3e3346..9053e74aaf75 100644
--- a/src/main.c
+++ b/src/main.c
@@ -205,6 +205,9 @@ static const struct group_table {
 	{ }
 };
 
+CLEANUP_FREEFUNC(GError, g_error_free);
+CLEANUP_FREEFUNC(GKeyFile, g_key_file_free);
+
 static int8_t check_sirk_alpha_numeric(char *str)
 {
 	int8_t val = 0;
@@ -252,8 +255,8 @@ GKeyFile *btd_get_main_conf(void)
 
 static GKeyFile *load_config(const char *name)
 {
-	GError *err = NULL;
-	GKeyFile *keyfile;
+	_cleanup_type_(GError) GError *err = NULL;
+	_cleanup_type_(GKeyFile) GKeyFile *keyfile = NULL;
 	int len;
 
 	if (name)
@@ -285,12 +288,10 @@ static GKeyFile *load_config(const char *name)
 		if (!g_error_matches(err, G_FILE_ERROR, G_FILE_ERROR_NOENT))
 			error("Parsing %s failed: %s", main_conf_file_path,
 				err->message);
-		g_error_free(err);
-		g_key_file_free(keyfile);
 		return NULL;
 	}
 
-	return keyfile;
+	return _steal_(keyfile);
 }
 
 static void parse_did(const char *did)
@@ -436,14 +437,13 @@ static int get_mode(const char *str)
 static bool parse_config_string(GKeyFile *config, const char *group,
 					const char *key, char **val)
 {
-	GError *err = NULL;
+	_cleanup_type_(GError) GError *err = NULL;
 	char *tmp;
 
 	tmp = g_key_file_get_string(config, group, key, &err);
 	if (err) {
 		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
 			DBG("%s", err->message);
-		g_error_free(err);
 		return false;
 	}
 
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
@@ -894,14 +885,13 @@ static bool parse_config_u8(GKeyFile *config, const char *group,
 static bool parse_config_bool(GKeyFile *config, const char *group,
 					const char *key, bool *val)
 {
-	GError *err = NULL;
+	_cleanup_type_(GError) GError *err = NULL;
 	gboolean tmp;
 
 	tmp = g_key_file_get_boolean(config, group, key, &err);
 	if (err) {
 		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
 			DBG("%s", err->message);
-		g_error_free(err);
 		return false;
 	}
 
@@ -915,7 +905,7 @@ static bool parse_config_bool(GKeyFile *config, const char *group,
 
 static void parse_privacy(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!parse_config_string(config, "General", "Privacy", &str)) {
 		btd_opts.privacy = 0x00;
@@ -948,13 +938,11 @@ static void parse_privacy(GKeyFile *config)
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
@@ -963,13 +951,12 @@ static void parse_repairing(GKeyFile *config)
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
@@ -977,37 +964,34 @@ static bool parse_config_hex(GKeyFile *config, char *group,
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
@@ -1019,8 +1003,6 @@ static void parse_multi_profile(GKeyFile *config)
 		btd_opts.mps = MPS_MULTIPLE;
 	else
 		btd_opts.mps = MPS_OFF;
-
-	g_free(str);
 }
 
 static gboolean parse_kernel_experimental(const char *key, const char *value,
@@ -1043,20 +1025,18 @@ static gboolean parse_kernel_experimental(const char *key, const char *value,
 
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
@@ -1068,8 +1048,6 @@ static void parse_secure_conns(GKeyFile *config)
 		btd_opts.secure_conn = SC_ON;
 	else if (!strcmp(str, "only"))
 		btd_opts.secure_conn = SC_ONLY;
-
-	g_free(str);
 }
 
 static void parse_general(GKeyFile *config)
@@ -1120,14 +1098,13 @@ static void parse_general(GKeyFile *config)
 
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
@@ -1147,14 +1124,13 @@ static enum bt_gatt_export_t parse_gatt_export_str(const char *str)
 
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
@@ -1176,7 +1152,7 @@ static uint8_t parse_gatt_seclevel_str(const char *str)
 
 static void parse_gatt_seclevel(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!btd_opts.testing)
 		return;
@@ -1186,7 +1162,6 @@ static void parse_gatt_seclevel(GKeyFile *config)
 		return;
 
 	btd_opts.gatt_seclevel = parse_gatt_seclevel_str(str);
-	g_free(str);
 }
 
 static void parse_gatt(GKeyFile *config)
@@ -1204,7 +1179,7 @@ static void parse_gatt(GKeyFile *config)
 
 static void parse_csis_sirk(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!parse_config_string(config, "CSIS", "SIRK", &str))
 		return;
@@ -1213,8 +1188,6 @@ static void parse_csis_sirk(GKeyFile *config)
 		hex2bin(str, btd_opts.csis.sirk, sizeof(btd_opts.csis.sirk));
 	else if (!gen_sirk(str))
 		DBG("Unable to generate SIRK from string");
-
-	g_free(str);
 }
 
 static void parse_csis(GKeyFile *config)
@@ -1231,8 +1204,8 @@ static void parse_csis(GKeyFile *config)
 static bool parse_cs_role(GKeyFile *config, const char *group,
 					const char *key, uint8_t *val)
 {
-	GError *err = NULL;
-	char *str = NULL;
+	_cleanup_type_(GError) GError *err = NULL;
+	_cleanup_(g_free) char *str = NULL;
 	char *endptr = NULL;
 	int numeric_val;
 
@@ -1241,7 +1214,6 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
 	if (err) {
 		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
 			DBG("%s", err->message);
-		g_error_free(err);
 		return false;
 	}
 
@@ -1251,17 +1223,14 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
 	if (!strcmp(str, "Initiator") || !strcmp(str, "initiator")) {
 		if (val)
 			*val = 1;
-		g_free(str);
 		return true;
 	} else if (!strcmp(str, "Reflector") || !strcmp(str, "reflector")) {
 		if (val)
 			*val = 2;
-		g_free(str);
 		return true;
 	} else if (!strcmp(str, "Both") || !strcmp(str, "both")) {
 		if (val)
 			*val = 3;
-		g_free(str);
 		return true;
 	}
 
@@ -1272,7 +1241,6 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
 		warn("%s.%s = %s is not a valid value. "
 			"Expected: 1/Initiator, 2/Reflector, or 3/Both",
 			group, key, str);
-		g_free(str);
 		return false;
 	}
 
@@ -1280,14 +1248,12 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
 		warn("%s.%s = %d is out of range. "
 			"Valid values: 1 (Initiator), 2 (Reflector), 3 (Both)",
 			group, key, numeric_val);
-		g_free(str);
 		return false;
 	}
 
 	if (val)
 		*val = numeric_val;
 
-	g_free(str);
 	return true;
 }
 
@@ -1305,7 +1271,7 @@ static void parse_le_cs_config(GKeyFile *config)
 
 static void parse_avdtp_session_mode(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_(g_free) char *str = NULL;
 
 	if (!parse_config_string(config, "AVDTP", "SessionMode", &str))
 		return;
@@ -1318,13 +1284,11 @@ static void parse_avdtp_session_mode(GKeyFile *config)
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
@@ -1337,8 +1301,6 @@ static void parse_avdtp_stream_mode(GKeyFile *config)
 		DBG("Invalid mode option: %s", str);
 		btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
 	}
-
-	g_free(str);
 }
 
 static void parse_avdtp(GKeyFile *config)
@@ -1605,7 +1567,7 @@ static GOptionEntry options[] = {
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
-	GError *err = NULL;
+	_cleanup_type_(GError) GError *err = NULL;
 	uint16_t sdp_mtu = 0;
 	uint32_t sdp_flags = 0;
 	int gdbus_flags = 0;
@@ -1618,7 +1580,6 @@ int main(int argc, char *argv[])
 	if (g_option_context_parse(context, &argc, &argv, &err) == FALSE) {
 		if (err != NULL) {
 			g_printerr("%s\n", err->message);
-			g_error_free(err);
 		} else
 			g_printerr("An unknown error occurred\n");
 		exit(1);
-- 
2.54.0

