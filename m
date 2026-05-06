Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF5480320
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077958; cv=none; b=KXD8m/kOzXEbkb4x0edqaAI2PmMTfEommMLhiSo0pfdpQWvJ815CcOTsqnfLc2ZCHD94YaMokVQNa8poQIBqeL9CD8t1VqPeI2eV2RygurdyBBFxv9woTxTb6uupT/lcbcwTMT9Authfvch1l3rtSGSiRqB0vYCSCixADVtXaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077958; c=relaxed/simple;
	bh=/vJPHRT+dj9ZeTVZM6iavIjmPN+Csy5rLXy/6wjqAC0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nj4I+qopZi2jua9CX7nE8sDUDNWgsbEo1Pfjs+IoQy00T62wlc3k5nh0IGv54kApeAFinSiDuYn300zoZ8bivEJi2B+9RlLXkBTVSCRmfQvQnsNqF5/Jfh2Y3hcywMUabaCP/GhaO/oVoJLJ/tjm4MRNVkfdkuOq8WYPlnntwwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D71523EC0D
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:32:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 5/5] main: Use _cleanup_() to simplify GError-handling
Date: Wed,  6 May 2026 16:30:59 +0200
Message-ID: <20260506143220.3076135-6-hadess@hadess.net>
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
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTEI3AiONlbGM76ajCdWYrpcp9I6rJ9J97keVCFlxgrQebY1wUG8XyLcf9m53KsqlN5m87sMS30eaRzKqJAt4LdVXCXXRWGjxi8Ua3NsWXct4eL71mbffWBBLR8onzmsb6rHZSotDsEnliEkVA0ER3FYUKGLqHvB9V5uo0cgN5cengH7nPlqwfvRZtX4BXHGQvPpLYOaq9i4gwULKQPJYYzKNHfIJFdRnT03n2O24fCkSrCFbXus8J5aNRLoMa5WSnLr0YvzkOZaMHPwCLPAmjH9KkEuOKIoOA2HbpxtmAt3Ds4WXFGndtL4bgW+YTwIFkXPdeLQWMFXljLbwr5JBkV1tvdAImsJfybc1Z8Y8s1UgkNt0oK9vPXex2/Rg5yJM/i5nsKG/0Nb8TZgwoi8IMMheFN7of6HRZkSP2x/TDex9bOcsTUNEH7QGoQv+EpW6DrW90s86tZ0dIeajED2qcLeqXz+4UqK/0xwzSgYQatL3J6yBtC1t6oEyqSBMcfqgbA3H5uA/MvcJU6W+uHQFsOI3NcyXBSKCKe4pA3wBEAba5LwkDAm8MJaYwNK6LwxAqN++X3woqKMcnXs4sI9Qx4vaonEUckPle2PZBplqYXdBG6gSSxYPbOs6W0uTtpZs8hOjGrm6sWLqLB+uGlpMNS90ANjjs2Qq5Vt6SV1ZtLROQ

Use _cleanup_() to simplify GError-handling in the error paths.
---
 src/main.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/src/main.c b/src/main.c
index 3a2c3e645a74..ef11b07d7a9a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -205,6 +205,13 @@ static const struct group_table {
 	{ }
 };
 
+static inline void free_error(void *err)
+{
+	g_error_free(*(void **) err);
+}
+
+#define _cleanup_error_ _cleanup_(free_error)
+
 static int8_t check_sirk_alpha_numeric(char *str)
 {
 	int8_t val = 0;
@@ -252,7 +259,7 @@ GKeyFile *btd_get_main_conf(void)
 
 static GKeyFile *load_config(const char *name)
 {
-	GError *err = NULL;
+	_cleanup_error_ GError *err = NULL;
 	GKeyFile *keyfile;
 	int len;
 
@@ -285,7 +292,6 @@ static GKeyFile *load_config(const char *name)
 		if (!g_error_matches(err, G_FILE_ERROR, G_FILE_ERROR_NOENT))
 			error("Parsing %s failed: %s", main_conf_file_path,
 				err->message);
-		g_error_free(err);
 		g_key_file_free(keyfile);
 		return NULL;
 	}
@@ -436,14 +442,13 @@ static int get_mode(const char *str)
 static bool parse_config_string(GKeyFile *config, const char *group,
 					const char *key, char **val)
 {
-	GError *err = NULL;
+	_cleanup_error_ GError *err = NULL;
 	char *tmp;
 
 	tmp = g_key_file_get_string(config, group, key, &err);
 	if (err) {
 		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
 			DBG("%s", err->message);
-		g_error_free(err);
 		return false;
 	}
 
@@ -885,14 +890,13 @@ static bool parse_config_u8(GKeyFile *config, const char *group,
 static bool parse_config_bool(GKeyFile *config, const char *group,
 					const char *key, bool *val)
 {
-	GError *err = NULL;
+	_cleanup_error_ GError *err = NULL;
 	gboolean tmp;
 
 	tmp = g_key_file_get_boolean(config, group, key, &err);
 	if (err) {
 		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
 			DBG("%s", err->message);
-		g_error_free(err);
 		return false;
 	}
 
@@ -1205,8 +1209,8 @@ static void parse_csis(GKeyFile *config)
 static bool parse_cs_role(GKeyFile *config, const char *group,
 					const char *key, uint8_t *val)
 {
-	GError *err = NULL;
-	char *str = NULL;
+	_cleanup_error_ GError *err = NULL;
+	_cleanup_(g_free) char *str = NULL;
 	char *endptr = NULL;
 	int numeric_val;
 
@@ -1215,7 +1219,6 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
 	if (err) {
 		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
 			DBG("%s", err->message);
-		g_error_free(err);
 		return false;
 	}
 
@@ -1225,17 +1228,14 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
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
 
@@ -1246,7 +1246,6 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
 		warn("%s.%s = %s is not a valid value. "
 			"Expected: 1/Initiator, 2/Reflector, or 3/Both",
 			group, key, str);
-		g_free(str);
 		return false;
 	}
 
@@ -1254,14 +1253,12 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
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
 
@@ -1575,7 +1572,7 @@ static GOptionEntry options[] = {
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
-	GError *err = NULL;
+	_cleanup_error_ GError *err = NULL;
 	uint16_t sdp_mtu = 0;
 	uint32_t sdp_flags = 0;
 	int gdbus_flags = 0;
@@ -1588,7 +1585,6 @@ int main(int argc, char *argv[])
 	if (g_option_context_parse(context, &argc, &argv, &err) == FALSE) {
 		if (err != NULL) {
 			g_printerr("%s\n", err->message);
-			g_error_free(err);
 		} else
 			g_printerr("An unknown error occurred\n");
 		exit(1);
-- 
2.54.0

