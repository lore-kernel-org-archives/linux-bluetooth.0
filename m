Received: from relay9-d.mail.gandi.net (relay9.mail.gandi.net [217.70.178.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7613368AA
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014515; cv=none; b=CwtTcfoHvgJ4GKFbbxHsLr3US/Kdi5AKRhN6jq69KzUFI5Vd9BIKnl8G4j9mTRazWFXMD2T+lsM0bgkz6Z3C2dTWQJkUaMZuZpAa1tOzmMRdKEeZvHtJ5UtPEsNqDJvTFLpWPMkc3tE6ogtmITTBmQR60tmtSDTzwnnpeyC577s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014515; c=relaxed/simple;
	bh=qrtegOFJqSK0ctTJgtN1AmKp3eb+rDnF/3vYG3DqmOM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NufVp/3pFLS4/ng66gAOBbNrOOSjEVsLZJIaGZ9Vb2QsewzAzwmhFmYrdmeg/7a6U/6HdOMFAiThn1fEwtlMDRaXU7le/q+EDVaZDa75FlZIRhR/gY/gILH1okoRidIuXWC3OgVp7lA7lmaQucf019as1VTHnyabhSKlNacvJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by relay9-d.mail.gandi.net (Postfix) with ESMTP id 727C944A96
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:58:46 +0200 (CEST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 530113EDD8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:46 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 4/6] main: Use _cleanup_() to simplify configuration parsing
Date: Tue,  9 Jun 2026 15:50:56 +0200
Message-ID: <20260609135837.476561-5-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609135837.476561-1-hadess@hadess.net>
References: <20260609135837.476561-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTFKI0mfyghBjZsB04T/rg312UQ/3CGmYDVwfgqgEUXnru4sXAT5OULp1B9iO9KhGs1DW64EwJ96pAX5kRPCDd4eUBx+UJbv+sU9YVdmOmz3d9TlUoQqxnVSz1IsqlHmVDlEWEZZjbeamJ5j8NXApc/1P2xhgCBFWOL1V4Fw4QJd+Ckztxhnhx8sQymID5HwyFGix7kqYTFe3MYTfM57QPmSXw7ahkPXNUZfX3B8ctsCT4+c26CEIQkGP+XLV4ehTaa1jgze/0L0wg/y2l6CkNPLZixIh/gl2u1Ob/awQxly9bjyp8SoRvtpGEhEc/zv2mQJYZYb+hlAAw6Aqq6gH8StTD7n6AxFrCpSwsrvvHi4hwHk0VPn1gUvjETeeHabH0/YdVZ/zqRDMbPsvU+Zn+uPnElaTIHj9f8lia2ZAYKKN4yoP2iRibnwepeYjVYIaIn+I1zyZDiXiBVUx9qoX/LFtKTVc8sa4CQ1XHqY59r273xjpuZdLbeC21nOP9nfMN3CXF8v/yWHPrpQT8fN2g3eJ7xN7cQutegammQFS820C0qBLCJdFw09GGd3rviUJ/V4WXMft5FH3wOK8yxsc+hBAP4Vt1R1Mo4swxE9EK4MPnXFC2QqygOv1SxRt9MnJj4toQbojug0Xz6TZMgTadvhQwu73d1bPZf/troAcKI7nA

Use helpers to simplify temporary string usage, and cleanup in error
paths.
---
 src/main.c | 108 +++++++++++++++++++----------------------------------
 1 file changed, 38 insertions(+), 70 deletions(-)

diff --git a/src/main.c b/src/main.c
index 8aa19a3e3346..bde295986869 100644
--- a/src/main.c
+++ b/src/main.c
@@ -205,6 +205,16 @@ static const struct group_table {
 	{ }
 };
 
+CLEANUP_FREEFUNC(GError, g_error_free);
+CLEANUP_FREEFUNC(GKeyFile, g_key_file_free);
+
+static inline void cleanup_g_free(void *p)
+{
+	g_free(*(void **) p);
+}
+
+#define _cleanup_g_free_ _cleanup_(cleanup_g_free)
+
 static int8_t check_sirk_alpha_numeric(char *str)
 {
 	int8_t val = 0;
@@ -252,8 +262,8 @@ GKeyFile *btd_get_main_conf(void)
 
 static GKeyFile *load_config(const char *name)
 {
-	GError *err = NULL;
-	GKeyFile *keyfile;
+	_cleanup_type_(GError) GError *err = NULL;
+	_cleanup_type_(GKeyFile) GKeyFile *keyfile = NULL;
 	int len;
 
 	if (name)
@@ -285,12 +295,10 @@ static GKeyFile *load_config(const char *name)
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
@@ -436,14 +444,13 @@ static int get_mode(const char *str)
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
 
@@ -462,7 +469,7 @@ static bool parse_config_int(GKeyFile *config, const char *group,
 					size_t min, size_t max)
 {
 	size_t tmp;
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 	char *endptr = NULL;
 
 	if (!parse_config_string(config, group, key, &str))
@@ -471,25 +478,21 @@ static bool parse_config_int(GKeyFile *config, const char *group,
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
 
@@ -500,10 +503,9 @@ static bool parse_config_signed_int(GKeyFile *config, const char *group,
 					const char *key, int8_t *val,
 					long min, long max)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 	char *endptr = NULL;
 	long tmp;
-	bool result = false;
 
 	str = g_key_file_get_string(config, group, key, NULL);
 	if (!str)
@@ -512,28 +514,24 @@ static bool parse_config_signed_int(GKeyFile *config, const char *group,
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
@@ -894,14 +892,13 @@ static bool parse_config_u8(GKeyFile *config, const char *group,
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
 
@@ -915,7 +912,7 @@ static bool parse_config_bool(GKeyFile *config, const char *group,
 
 static void parse_privacy(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
 	if (!parse_config_string(config, "General", "Privacy", &str)) {
 		btd_opts.privacy = 0x00;
@@ -948,13 +945,11 @@ static void parse_privacy(GKeyFile *config)
 		DBG("Invalid privacy option: %s", str);
 		btd_opts.privacy = 0x00;
 	}
-
-	g_free(str);
 }
 
 static void parse_repairing(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
 	if (!parse_config_string(config, "General", "JustWorksRepairing",
 						&str)) {
@@ -963,13 +958,12 @@ static void parse_repairing(GKeyFile *config)
 	}
 
 	btd_opts.jw_repairing = parse_jw_repairing(str);
-	g_free(str);
 }
 
 static bool parse_config_hex(GKeyFile *config, char *group,
 					const char *key, uint32_t *val)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
 	if (!parse_config_string(config, group, key, &str))
 		return false;
@@ -977,37 +971,34 @@ static bool parse_config_hex(GKeyFile *config, char *group,
 	if (val)
 		*val = strtol(str, NULL, 16);
 
-	g_free(str);
 	return true;
 }
 
 static void parse_device_id(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
 	parse_config_string(config, "General", "DeviceID", &str);
 	if (!str)
 		return;
 
 	parse_did(str);
-	g_free(str);
 }
 
 static void parse_ctrl_mode(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
 	parse_config_string(config, "General", "ControllerMode", &str);
 	if (!str)
 		return;
 
 	btd_opts.mode = get_mode(str);
-	g_free(str);
 }
 
 static void parse_multi_profile(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
 	parse_config_string(config, "General", "MultiProfile", &str);
 	if (!str)
@@ -1019,8 +1010,6 @@ static void parse_multi_profile(GKeyFile *config)
 		btd_opts.mps = MPS_MULTIPLE;
 	else
 		btd_opts.mps = MPS_OFF;
-
-	g_free(str);
 }
 
 static gboolean parse_kernel_experimental(const char *key, const char *value,
@@ -1043,20 +1032,18 @@ static gboolean parse_kernel_experimental(const char *key, const char *value,
 
 static void parse_kernel_exp(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
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
+	_cleanup_g_free_ char *str = NULL;
 
 	if (!parse_config_string(config, "General", "SecureConnections",
 								&str))
@@ -1068,8 +1055,6 @@ static void parse_secure_conns(GKeyFile *config)
 		btd_opts.secure_conn = SC_ON;
 	else if (!strcmp(str, "only"))
 		btd_opts.secure_conn = SC_ONLY;
-
-	g_free(str);
 }
 
 static void parse_general(GKeyFile *config)
@@ -1120,14 +1105,13 @@ static void parse_general(GKeyFile *config)
 
 static void parse_gatt_cache(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
 	parse_config_string(config, "GATT", "Cache", &str);
 	if (!str)
 		return;
 
 	btd_opts.gatt_cache = parse_gatt_cache_str(str);
-	g_free(str);
 }
 
 static enum bt_gatt_export_t parse_gatt_export_str(const char *str)
@@ -1147,14 +1131,13 @@ static enum bt_gatt_export_t parse_gatt_export_str(const char *str)
 
 static void parse_gatt_export(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
 	parse_config_string(config, "GATT", "ExportClaimedServices", &str);
 	if (!str)
 		return;
 
 	btd_opts.gatt_export = parse_gatt_export_str(str);
-	g_free(str);
 }
 
 static uint8_t parse_gatt_seclevel_str(const char *str)
@@ -1176,7 +1159,7 @@ static uint8_t parse_gatt_seclevel_str(const char *str)
 
 static void parse_gatt_seclevel(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
 	if (!btd_opts.testing)
 		return;
@@ -1186,7 +1169,6 @@ static void parse_gatt_seclevel(GKeyFile *config)
 		return;
 
 	btd_opts.gatt_seclevel = parse_gatt_seclevel_str(str);
-	g_free(str);
 }
 
 static void parse_gatt(GKeyFile *config)
@@ -1204,7 +1186,7 @@ static void parse_gatt(GKeyFile *config)
 
 static void parse_csis_sirk(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
 	if (!parse_config_string(config, "CSIS", "SIRK", &str))
 		return;
@@ -1213,8 +1195,6 @@ static void parse_csis_sirk(GKeyFile *config)
 		hex2bin(str, btd_opts.csis.sirk, sizeof(btd_opts.csis.sirk));
 	else if (!gen_sirk(str))
 		DBG("Unable to generate SIRK from string");
-
-	g_free(str);
 }
 
 static void parse_csis(GKeyFile *config)
@@ -1231,8 +1211,8 @@ static void parse_csis(GKeyFile *config)
 static bool parse_cs_role(GKeyFile *config, const char *group,
 					const char *key, uint8_t *val)
 {
-	GError *err = NULL;
-	char *str = NULL;
+	_cleanup_type_(GError) GError *err = NULL;
+	_cleanup_g_free_ char *str = NULL;
 	char *endptr = NULL;
 	int numeric_val;
 
@@ -1241,7 +1221,6 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
 	if (err) {
 		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
 			DBG("%s", err->message);
-		g_error_free(err);
 		return false;
 	}
 
@@ -1251,17 +1230,14 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
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
 
@@ -1272,7 +1248,6 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
 		warn("%s.%s = %s is not a valid value. "
 			"Expected: 1/Initiator, 2/Reflector, or 3/Both",
 			group, key, str);
-		g_free(str);
 		return false;
 	}
 
@@ -1280,14 +1255,12 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
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
 
@@ -1305,7 +1278,7 @@ static void parse_le_cs_config(GKeyFile *config)
 
 static void parse_avdtp_session_mode(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
 	if (!parse_config_string(config, "AVDTP", "SessionMode", &str))
 		return;
@@ -1318,13 +1291,11 @@ static void parse_avdtp_session_mode(GKeyFile *config)
 		DBG("Invalid mode option: %s", str);
 		btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 	}
-
-	g_free(str);
 }
 
 static void parse_avdtp_stream_mode(GKeyFile *config)
 {
-	char *str = NULL;
+	_cleanup_g_free_ char *str = NULL;
 
 	if (!parse_config_string(config, "AVDTP", "StreamMode", &str))
 		return;
@@ -1337,8 +1308,6 @@ static void parse_avdtp_stream_mode(GKeyFile *config)
 		DBG("Invalid mode option: %s", str);
 		btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
 	}
-
-	g_free(str);
 }
 
 static void parse_avdtp(GKeyFile *config)
@@ -1605,7 +1574,7 @@ static GOptionEntry options[] = {
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
-	GError *err = NULL;
+	_cleanup_type_(GError) GError *err = NULL;
 	uint16_t sdp_mtu = 0;
 	uint32_t sdp_flags = 0;
 	int gdbus_flags = 0;
@@ -1618,7 +1587,6 @@ int main(int argc, char *argv[])
 	if (g_option_context_parse(context, &argc, &argv, &err) == FALSE) {
 		if (err != NULL) {
 			g_printerr("%s\n", err->message);
-			g_error_free(err);
 		} else
 			g_printerr("An unknown error occurred\n");
 		exit(1);
-- 
2.54.0

