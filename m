Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18733DCDBE
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059122; cv=none; b=uMmLDLcQvjvLk11ugksjfSzBwKvdqnnq4rqRKEKTU3ylSCJLehxNEBp3y3INgK2XBgMooZmmmxdK2vxw/jpiKyghI5VnKuZudYAz23g6dfd/7hPARW9nSaNz5ehNemKu4z/WSJktF9cvupXJ8E0eokbOc3rzoNCMeExPVq8bUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059122; c=relaxed/simple;
	bh=uqGN1Nmgrry+SIQl2sLGwMDv/Xo1O9c1P2F8GqTGrsY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nckj+EXDP4FMUbH+T5chYQkWXnNNk3ItAcaaV+tEeMt0IYzE3Q4fN1MxgyMd/dSl2uIUe8SjHfu65ZBFaAz6B4d3SzSn7D3era5aakDrCFZaBQOV+Xc5rb5/YoKgJaufXMEku0gboBoWHiVpm0wR6jijkNzHy+eyQ8gGubVF+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 434FC3E95D
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 09:18:34 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 5/5] main: Use _cleanup_() to simplify GError-handling
Date: Wed,  6 May 2026 11:14:26 +0200
Message-ID: <20260506091824.2920716-6-hadess@hadess.net>
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
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTGW+5oYUz6IkFrcqLOmL5gVyzcxCcduo1OVNcG2/zCqO+ChB82V5yLRe6VDdwZdV4JyggnOX5OsGNefTaSo4HPar9h9espE02B+Y20GeUMtxudums1t94KA3KB1tok41dYIlzWnc8xGas8gOIvWbYNG2+XxBMyRxKbrHWNjWwVlBzMAC4kgcjg/TPW8pHjA7NKksY01g/ZFuBQHxDkL8m1q11p22eiUIoxr2egp4G2kWBdZLCURnohf9mPPRefyjpe7FXyP7KLrF4uHpA4e/cCVnpBTi5kH4FPjWPj4Z7wKUd8k29A1UVay8fqAqekgTe4F86btiQsnM29LsA4R3OiyKHJ6FdSl/h5F75/ia8OHPqv4zFcu3Qq34kzB3w5yNdBmJQFNyZmvqWGxvDxDF0bmyNWNgw1hBrFfYf2k4HOH8bEfUfusR/2laAqRTFfANfEE/04xzE/gH9kMcD+PS7w3GGhUGMTcy64NBRFCFLwGlkajXDQFZhEQkYGDhCoRMnQh3UpsC06IEDKZwZreKmfNhezsdBspXX/J65ElToMdcQJcBd0awi+xM5+wtRC7D92zTArun0LNd4QDL12GIhUCL22harmDUu/fvGJOXJtX/5CXWUlq9X020gQTQAbjaU4loQO9l4Wc1fM+2WNzvCBW97kT8+/U0Z55c6NQKmhI0Q

Use _cleanup_() to simplify GError-handling in the error paths.
---
 src/main.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/src/main.c b/src/main.c
index 3a2c3e645a74..a2fe3ffdc914 100644
--- a/src/main.c
+++ b/src/main.c
@@ -205,6 +205,12 @@ static const struct group_table {
 	{ }
 };
 
+static inline void free_error(void *err) {
+        g_error_free(*(void**) err);
+}
+
+#define _cleanup_error_ _cleanup_(free_error)
+
 static int8_t check_sirk_alpha_numeric(char *str)
 {
 	int8_t val = 0;
@@ -252,7 +258,7 @@ GKeyFile *btd_get_main_conf(void)
 
 static GKeyFile *load_config(const char *name)
 {
-	GError *err = NULL;
+	_cleanup_error_ GError *err = NULL;
 	GKeyFile *keyfile;
 	int len;
 
@@ -285,7 +291,6 @@ static GKeyFile *load_config(const char *name)
 		if (!g_error_matches(err, G_FILE_ERROR, G_FILE_ERROR_NOENT))
 			error("Parsing %s failed: %s", main_conf_file_path,
 				err->message);
-		g_error_free(err);
 		g_key_file_free(keyfile);
 		return NULL;
 	}
@@ -436,14 +441,13 @@ static int get_mode(const char *str)
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
 
@@ -885,14 +889,13 @@ static bool parse_config_u8(GKeyFile *config, const char *group,
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
 
@@ -1205,8 +1208,8 @@ static void parse_csis(GKeyFile *config)
 static bool parse_cs_role(GKeyFile *config, const char *group,
 					const char *key, uint8_t *val)
 {
-	GError *err = NULL;
-	char *str = NULL;
+	_cleanup_error_ GError *err = NULL;
+	_cleanup_(g_free) char *str = NULL;
 	char *endptr = NULL;
 	int numeric_val;
 
@@ -1215,7 +1218,6 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
 	if (err) {
 		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
 			DBG("%s", err->message);
-		g_error_free(err);
 		return false;
 	}
 
@@ -1225,17 +1227,14 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
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
 
@@ -1246,7 +1245,6 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
 		warn("%s.%s = %s is not a valid value. "
 			"Expected: 1/Initiator, 2/Reflector, or 3/Both",
 			group, key, str);
-		g_free(str);
 		return false;
 	}
 
@@ -1254,14 +1252,12 @@ static bool parse_cs_role(GKeyFile *config, const char *group,
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
 
@@ -1575,7 +1571,7 @@ static GOptionEntry options[] = {
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
-	GError *err = NULL;
+	_cleanup_error_ GError *err = NULL;
 	uint16_t sdp_mtu = 0;
 	uint32_t sdp_flags = 0;
 	int gdbus_flags = 0;
@@ -1588,7 +1584,6 @@ int main(int argc, char *argv[])
 	if (g_option_context_parse(context, &argc, &argv, &err) == FALSE) {
 		if (err != NULL) {
 			g_printerr("%s\n", err->message);
-			g_error_free(err);
 		} else
 			g_printerr("An unknown error occurred\n");
 		exit(1);
-- 
2.54.0

