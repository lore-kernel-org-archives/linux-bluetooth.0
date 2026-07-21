Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B422C21DD
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643465; cv=none; b=NPXxlCXYCd1mjQxHRUSI7qDnsGCilHylYpNlB3vSUEDqwlHII3AtWoighGAVuLMC/eXw9hVOTlNK/vHWBuQjjKQHgOVjLghHoK8n3No9UiavDArwci1J813leMARQC6/Lh5nbINuNJoGMdycBVGG9OZgLmeOUvKt0olosElmNFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643465; c=relaxed/simple;
	bh=/b5udHkisZ2TmsXtdiMxGURlg8rmryFUbvdeg/84nAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XABw/mJ4C4focrzrt5gIB8/qOI0ZFtOImy9Qfu4fEtchzADd8CIDvx4sctNKg1I49wfSQpoBW+H2GfPUXnONoObVxJJuvdwhJ6MTn8YmyiZM3hyp27BB3Mxdxfw20lWF14ddfB6uMpEpIaHsUzj6LQwgt7oTGcP26R+SrJRSrzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+EtOkkE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+EtOkkE"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f81a3ccf9so475245f8f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784643462; x=1785248262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kWUzRK6FxN5Gqef01dVdaBoEHOZA4ReC+nBZ8gqoA5Q=;
        b=m+EtOkkE3JRyhhbTshEszX+9tuICfYWQQMn4WCoqM7WZuBrkVIwxXahUllnZXLWOcb
         SvAqxbpJdx1GbaboPOIjOmqa4S4tH8qoModPc72MpSqCaovVqefZweMsSXBM8rGJwetc
         V7OfctxbxxGCwrKLbZRqhvqtosDtJQs5anSAw28WCuyPKyjWNIlqATMZKCK8l66DBirU
         YgDIN5V9MeOXnCE2Cav8N6/WjoJc1704wpFFFpQ0qHSmVa6yHbBmo2fRHtJzy7DiaWhD
         Mn9wkY5CaD6Kdn2spiZ77zYVUNitSpu3R/iwPo5MtXpPe6awDPL81eagya92Gj1Yjb4j
         9DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784643462; x=1785248262;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kWUzRK6FxN5Gqef01dVdaBoEHOZA4ReC+nBZ8gqoA5Q=;
        b=oQ6P6XIVOgb+QdE77eQOAsxn/ji25pgP1ZNkMkwCx83rZIsLMjTul1mvSZlDFREUux
         ep8wuLSr1bZqC5bBpvSNZUEypQvULElnuHupFDr5xNCsHimS6DJh7jlpC8G3VmnFOAPD
         zWiBlQOVrLueXnwoQQNMoElOPkfJa278Ecn093D7ege1zxT4FwgsTikD/F557cKSeho6
         8t1RAsPJ/CkhPmyqlUGTIo6iTumxcGrzyJjSC4sLSVBgqNZGss89Gn+YXTc8J/7qoEoX
         jA4aBsHfULRU1MeIxsP0DxduBBm/tTmWGK/qmyDqWWBBPgmG+3HNoG+g1Bn600Hj/Fhi
         5djw==
X-Gm-Message-State: AOJu0Yw+j8pyjw1rpo3LRPliQegIVKM8+jLoBarv3QyIBDe5s8PtkwVc
	6SQ7YoslW1Wc2cUxQDpRMTb/tsuAvSEGdGpBRjAAMAcqgcirERCyUXbhRYm2cTZB1Hr2Dg==
X-Gm-Gg: AR+sD12f23kGZ9kfg7TCxJZQNKw+jydUG0uL0StBtxzItfhvIzjsoTzp3OiS41hjQFN
	n/5gLPURrgBQiKivXvn4FwmA1LiVAVTUp70iIYfhbmIZTOsmMHhs5I+Z4pDkq2bIxU04UFYaW41
	YeDyoC4lVp5ewrv00Bcba7DIqx1nmscydkKYZnwJRfWPVkog3me2eevfutsW60sJ/YH7ijmlm0g
	/k0z5dATjnJTyUIBYAE8XE1Pm4wuuD1dcnmoshH7nMx/YJzbFZE6qg4rPNOY7oRXVFr1649+H2/
	+vgOUDYzj3f2THBpgebXrqUnQr7mNhsgulfb89nNvYH8zJIxeKgpDbBf06gmyz2U+LkGofe1Ick
	Zq+aU18Vfz1XNPcWwdS3bUtcOxmB2Gp3G6Wk0DGMpdvO7VQ40jWH6LheuvNCMFL/7NFH3bc8pFZ
	9A80+o
X-Received: by 2002:a05:6000:2907:b0:47f:83cb:ace9 with SMTP id ffacd0b85a97d-47f83cbae07mr561440f8f.22.1784643461920;
        Tue, 21 Jul 2026 07:17:41 -0700 (PDT)
Received: from pakrohk.localdoman ([89.34.36.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49acesm37898270f8f.6.2026.07.21.07.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:17:41 -0700 (PDT)
From: Pakrohk <rhpcir@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Pakrohk <Pakrohk@users.noreply.github.com>
Subject: [PATCH BlueZ v2 3/3] tools: add bluez-quirkctl for managing quirk profiles
Date: Tue, 21 Jul 2026 17:47:18 +0330
Message-ID: <patch.1753084803.git.Pakrohk@users.noreply.github.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1753084800.git.Pakrohk@users.noreply.github.com>
References: <cover.1753084800.git.Pakrohk@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pakrohk <Pakrohk@users.noreply.github.com>

Add bluez-quirkctl, a CLI tool for managing external gamepad quirk
profiles. This tool validates JSON profiles, manages HMAC-SHA256 keys,
and installs/removes signed profiles to the system directory.

Usage:
  bluez-quirkctl install <file.json>   - validate, sign, install
  bluez-quirkctl remove <name>         - uninstall a profile
  bluez-quirkctl list                  - list installed profiles
  bluez-quirkctl validate <file.json>  - check without installing

Security model:
  - Install/remove requires root (checked via getuid())
  - HMAC key auto-generated in /var/lib/bluez/quirks/.hmac_key (0600)
  - Profiles installed to /var/lib/bluez/quirks/ (0644)
  - HMAC-SHA256 computed using bt_crypto (kernel AF_ALG)
  - Symlinks rejected during loading
  - Descriptor size capped at 2048 bytes

The tool links against libbluetooth-internal and libshared-mainloop
for access to bt_crypto_hmac_sha256().

Signed-off-by: Pakrohk <Pakrohk@users.noreply.github.com>
diff --git a/Makefile.tools b/Makefile.tools
index 44da0ce..ecce5b4 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -581,5 +581,6 @@ bin_PROGRAMS += tools/bluez-quirkctl
 
 tools_bluez_quirkctl_SOURCES = tools/quirkctl.c
 tools_bluez_quirkctl_CFLAGS = $(JSONC_CFLAGS)
-tools_bluez_quirkctl_LDADD = $(JSONC_LIBS)
+tools_bluez_quirkctl_LDADD = lib/libbluetooth-internal.la \
+				src/libshared-mainloop.la $(JSONC_LIBS)
 endif
diff --git a/tools/quirkctl.c b/tools/quirkctl.c
index 5c35e97..93f3207 100644
--- a/tools/quirkctl.c
+++ b/tools/quirkctl.c
@@ -30,10 +30,16 @@
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/sendfile.h>
 #include <pwd.h>
 
 #include <json-c/json.h>
 
+#include "src/shared/crypto.h"
+
+static const char *prog;
+static struct bt_crypto *crypto;
+
 #define QUIRK_DIR "/var/lib/bluez/quirks"
 #define USER_QUIRK_DIR "/.config/bluez/quirks"
 #define HMAC_KEY_PATH QUIRK_DIR "/.hmac_key"
@@ -42,7 +48,166 @@
 #define JSON_EXT ".json"
 #define SIG_EXT ".sig"
 
-static const char *prog;
+/*
+ * Copy file using sendfile(2).
+ */
+static int copy_file(const char *src, const char *dst)
+{
+	int fd_in, fd_out;
+	struct stat st;
+	ssize_t sent;
+
+	fd_in = open(src, O_RDONLY);
+	if (fd_in < 0)
+		return -1;
+
+	if (fstat(fd_in, &st) < 0) {
+		close(fd_in);
+		return -1;
+	}
+
+	fd_out = open(dst, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd_out < 0) {
+		close(fd_in);
+		return -1;
+	}
+
+	sent = sendfile(fd_out, fd_in, NULL, st.st_size);
+	close(fd_in);
+	close(fd_out);
+
+	return (sent == st.st_size) ? 0 : -1;
+}
+
+/*
+ * Load HMAC key from disk. Returns key length or -1 on failure.
+ */
+static int load_hmac_key(uint8_t *key, int max_len)
+{
+	FILE *f;
+	long fsize;
+	char *hex;
+	int key_len, i;
+	char *end;
+
+	f = fopen(HMAC_KEY_PATH, "re");
+	if (!f)
+		return -1;
+
+	fseek(f, 0, SEEK_END);
+	fsize = ftell(f);
+	if (fsize < 0 || fsize > 1024) {
+		fclose(f);
+		return -1;
+	}
+	rewind(f);
+
+	hex = malloc(fsize + 1);
+	if (!hex) {
+		fclose(f);
+		return -1;
+	}
+
+	if (fread(hex, 1, fsize, f) != (size_t)fsize) {
+		free(hex);
+		fclose(f);
+		return -1;
+	}
+	fclose(f);
+	hex[fsize] = '\0';
+
+	end = hex + strlen(hex) - 1;
+	while (end > hex && (*end == '\n' || *end == '\r' || *end == ' '))
+		*end-- = '\0';
+
+	key_len = strlen(hex) / 2;
+	if (key_len > max_len)
+		key_len = max_len;
+
+	for (i = 0; i < key_len; i++) {
+		unsigned int byte;
+		char buf[3];
+
+		buf[0] = hex[i * 2];
+		buf[1] = hex[i * 2 + 1];
+		buf[2] = '\0';
+		if (sscanf(buf, "%2x", &byte) != 1) {
+			free(hex);
+			return -1;
+		}
+		key[i] = (uint8_t)byte;
+	}
+
+	free(hex);
+	return key_len;
+}
+
+/*
+ * Compute HMAC-SHA256 using bt_crypto (kernel AF_ALG).
+ * Returns hex string of 32-byte digest, or NULL on failure.
+ */
+static char *compute_hmac(const char *file_path)
+{
+	FILE *f;
+	long fsize;
+	uint8_t *data;
+	uint8_t key[HMAC_KEY_SIZE];
+	uint8_t digest[32];
+	char hex[HMAC_KEY_SIZE * 2 + 1];
+	char *result;
+	int key_len, i;
+
+	if (!crypto)
+		return NULL;
+
+	/* Read the file */
+	f = fopen(file_path, "re");
+	if (!f)
+		return NULL;
+
+	fseek(f, 0, SEEK_END);
+	fsize = ftell(f);
+	if (fsize < 0 || fsize > 1024 * 1024) {
+		fclose(f);
+		return NULL;
+	}
+	rewind(f);
+
+	data = malloc(fsize);
+	if (!data) {
+		fclose(f);
+		return NULL;
+	}
+
+	if (fread(data, 1, fsize, f) != (size_t)fsize) {
+		free(data);
+		fclose(f);
+		return NULL;
+	}
+	fclose(f);
+
+	/* Load the HMAC key */
+	key_len = load_hmac_key(key, HMAC_KEY_SIZE);
+	if (key_len <= 0) {
+		free(data);
+		return NULL;
+	}
+
+	/* Compute HMAC-SHA256 */
+	if (!bt_crypto_hmac_sha256(crypto, key, key_len, data, fsize, digest)) {
+		free(data);
+		return NULL;
+	}
+	free(data);
+
+	/* Convert to hex string */
+	for (i = 0; i < 32; i++)
+		snprintf(hex + i * 2, 3, "%02x", digest[i]);
+	hex[64] = '\0';
+
+	result = strdup(hex);
+	return result;
+}
 
 static void usage(void)
 {
@@ -139,43 +304,6 @@ static int ensure_hmac_key(void)
 	return 0;
 }
 
-/*
- * Compute HMAC-SHA256 via openssl CLI.
- */
-static char *compute_hmac(const char *file_path)
-{
-	char cmd[1024];
-	char line[256];
-	char *result = NULL;
-	FILE *p;
-	char *eq;
-
-	snprintf(cmd, sizeof(cmd),
-		"openssl dgst -sha256 -hmac \"$(cat " HMAC_KEY_PATH ")\" "
-		"-hex < '%s' 2>/dev/null", file_path);
-
-	p = popen(cmd, "r");
-	if (!p)
-		return NULL;
-
-	while (fgets(line, sizeof(line), p)) {
-		eq = strstr(line, "= ");
-		if (eq) {
-			eq += 2;
-			/* trim */
-			char *end = eq + strlen(eq) - 1;
-			while (end > eq && (*end == '\n' || *end == '\r'
-						|| *end == ' '))
-				*end-- = '\0';
-			result = strdup(eq);
-			break;
-		}
-	}
-
-	pclose(p);
-	return result;
-}
-
 /*
  * Validate JSON profile structure.
  */
@@ -390,14 +518,10 @@ static int cmd_install(const char *path)
 		return 1;
 	}
 
-	{
-		char cmd[1024];
-		snprintf(cmd, sizeof(cmd), "cp '%s' '%s'", path, dest);
-		if (system(cmd) != 0) {
-			fprintf(stderr, "Failed to copy profile\n");
-			free(name);
-			return 1;
-		}
+	if (copy_file(path, dest) < 0) {
+		fprintf(stderr, "Failed to copy profile\n");
+		free(name);
+		return 1;
 	}
 
 	if (chmod(dest, 0644) < 0) {
@@ -510,6 +634,8 @@ static int cmd_list(void)
 
 int main(int argc, char *argv[])
 {
+	int ret;
+
 	prog = argv[0];
 
 	if (argc < 2) {
@@ -522,7 +648,14 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "Usage: %s install <file.json>\n", prog);
 			return 1;
 		}
-		return cmd_install(argv[2]);
+		crypto = bt_crypto_new();
+		if (!crypto) {
+			fprintf(stderr, "Failed to init crypto\n");
+			return 1;
+		}
+		ret = cmd_install(argv[2]);
+		bt_crypto_unref(crypto);
+		return ret;
 	}
 
 	if (strcmp(argv[1], "remove") == 0) {
@@ -533,9 +666,8 @@ int main(int argc, char *argv[])
 		return cmd_remove(argv[2]);
 	}
 
-	if (strcmp(argv[1], "list") == 0) {
+	if (strcmp(argv[1], "list") == 0)
 		return cmd_list();
-	}
 
 	if (strcmp(argv[1], "validate") == 0) {
 		if (argc < 3) {

