Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30CF384223
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643461; cv=none; b=IgmdbbK48zVqdUgTl90waGibKGrNXtGGhXi+VBfP7K77/+N8H/q+z976p5+pECPSZ6xDvCekqmkp4GnBEo1y1g3z7aKbb3bjhTNvJ6zN3vooK0TmOm9XtCTKa95cdI3BdNd10ajSBQ1QWfS2oENvvi3/QpAW5rMb1POiffRT7hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643461; c=relaxed/simple;
	bh=cGYcBN8QNwoXcSRwMXFtPvITAaTZhzUGN2w82c4JzpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPcd7qbcwXddzKB1cnwzL3tmyXhvt55wcyIYZtREJsX2vF8OD5PsPEZpyydOz/P53LOJ11Syj6Ey8V10bxSiXQXukhu0nEUoagOv6EwHqu14kvTyHzzimHELqpAMC/qKJXPKFPTRDNqlg1ThpIslLvEkH6F0KXZQdc9oZTmnfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPqfdXDJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPqfdXDJ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f633e6058so3936345f8f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784643458; x=1785248258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qkoxN0znauoPMGiuKdwbQidCINH+qH1aVg+lX9KBYXQ=;
        b=rPqfdXDJMkFI6+W5v8JC5uwOmvC0+dRPmFgW3XlK2ztxEjXiOWOtiTkTTmHWy3EgM6
         i8DKAhz3px3CVWvJGKqeupqW1044sOhjBPdUyMyoFE0dbkjJm6YI2kHH5I9/h09m6VMd
         nClTfb57M3+piqGg+v1wlXk9MPAHnrTGi1NA6WDOlPv+iLdyRh17JOauD8xnUVc7eyC8
         mB4tisydPeyiJWm3wY/ZebWicMm6LIZEch2KKloSohMg/+EkUvbjejjax62d0vTYym9y
         0clSVn92CP4AB8cKIV/0QfpYMW6WirlaCjqcocyRFeLZ+mAGu7YkWv1rs7E9fgrCp8qW
         4w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784643458; x=1785248258;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkoxN0znauoPMGiuKdwbQidCINH+qH1aVg+lX9KBYXQ=;
        b=kPmHZgTfrpts3/pjZjlIcI+t/20W4l/s47wOUBASPJmpB861+ALAB8bu53g6LbplGZ
         z/lfLeDB8HVp3Qn06wF+TvtY/tWheskZnjl7eE/M8QUZ0+/v+mfiwy6VjgX05usO4gPP
         OcZoaOzFDKy6FQJCvXWNHahNMXvrxJFjeRmv3mQdrp9cezxVNt8l1ygasZ/eTjbT3za9
         QjwgcCASCBChBatpPWMRjMoZQYh+tpAiHvP9XCTOg8OCRMtDCLjPzvaehaHdSbXDVIlr
         g5jRQmaBA7wFEOTs8u4EG9y/GrcSiFm0rDjQInKqplR5m0PaPzF6ChzF4p+4mPn2RKsF
         6g4Q==
X-Gm-Message-State: AOJu0YwowQCHag0JLuECvOL/RIoH5g9GbzTUWVnVnOTZw95CQXaNdPvb
	vltJivwAnIigHS4n8zO+/yjXH6Hh8yjZD4TorjUGNFHDEau1ZBKqIJyK2El43WFdrnwDfw==
X-Gm-Gg: AR+sD11XrCasQdQdl1njqqhGXWfpzo9vpfLj7Lsfjnrh/SNxHq9ZPpDnJ/lypadm54E
	ksYI6iOQOILQI3HV4d/7mQxVT7m+8TPB6jGa1nRsh9KWiAlAc59TuU22/tdVrBzjuxLQH5m4psa
	0db4IcZ3PbdevY1++y1SLqsJhCJiUnc/J8Gda/feGP/S7ScT2sUrBVG7q5zrn4c6MrhHXe6BTmZ
	FwLcoOb8n3UqVjgDSY+og7mkHdBKYGM1V2mY6UpoSU9SclYLqIv2W3XPycJeKbg1N3v/VGnZV7z
	YxoWlx5KBUlv+z7SS60ayDQK+e+OKj9DF4yln3I1/wc24CAJLecsdwn+ecjv/NDmdVgZ9zC4qwM
	C+WZGxwglIpu33DdX87i3edPHrTF66bNQNpnv74BRJzOZkAPQnPFjKK4SP4xdwiOOhZy333kOLA
	D3m4iT
X-Received: by 2002:a5d:5d0e:0:b0:46e:8226:96ba with SMTP id ffacd0b85a97d-47f623036aamr23657067f8f.13.1784643457542;
        Tue, 21 Jul 2026 07:17:37 -0700 (PDT)
Received: from pakrohk.localdoman ([89.34.36.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49acesm37898270f8f.6.2026.07.21.07.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:17:37 -0700 (PDT)
From: Pakrohk <rhpcir@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Pakrohk <Pakrohk@users.noreply.github.com>
Subject: [PATCH BlueZ v2 2/3] input: add HID gamepad quirk fallback for broken SDP records
Date: Tue, 21 Jul 2026 17:47:17 +0330
Message-ID: <patch.1753084802.git.Pakrohk@users.noreply.github.com>
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

Add a modular gamepad quirk system to profiles/input/ that provides HID
report descriptor fallbacks when BlueZ's SDP parser fails.

When extract_hid_record() returns -ENOENT for a known gamepad, the quirk
system checks registered quirks and injects a fallback HID descriptor so
the kernel's HID driver can create an input device.

Two tiers of quirk support:

Built-in quirks:
  Hardcoded C entries for known broken controllers. Currently supports
  DualShock 4 v2 / TG170W (054c:09cc) with a minimal BT HID descriptor
  matching report ID 0x11 (78 bytes, as expected by hid-playstation).

External quirk profiles:
  JSON files in /var/lib/bluez/quirks/ with HMAC-SHA256 signatures.
  Loaded at bluetoothd startup. Enables community-maintained support
  without BlueZ source modifications.

Architecture:
  quirk.h     - quirk struct definition and dispatch API
  quirk.c     - quirk registry and dispatch logic
  quirk-profile.h/c - external JSON profile loader with HMAC verification
  quirks/tg170w.c - built-in quirk for DualShock 4 v2

The quirk only activates when SDP parsing fails AND the device matches
a registered quirk. This does not globally weaken HID parsing.

Multi-factor matching avoids false positives:
  match = (vendor_id == 0x054c && product_id == 0x09cc)
       || (device_name == "Wireless Controller"
           && SDP provider contains "Sony")

Signed-off-by: Pakrohk <Pakrohk@users.noreply.github.com>
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 8017e07..0089c3d 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1089,11 +1089,8 @@ static int hidp_add_connection(struct input_device *idev)
 
 	err = extract_hid_record(idev, req);
 	if (err < 0) {
-		/* Try gamepad quirk fallback for known broken devices */
-		if (gamepad_quirk_match(idev)) {
-			DBG("HID SDP failed, trying gamepad quirk");
-			err = gamepad_quirk_apply(idev, req);
-		}
+		DBG("HID SDP failed, trying gamepad quirk");
+		err = gamepad_quirk_apply(idev, req);
 	}
 
 	if (err < 0) {
diff --git a/profiles/input/quirk-profile.c b/profiles/input/quirk-profile.c
index 8ec3835..4240154 100644
--- a/profiles/input/quirk-profile.c
+++ b/profiles/input/quirk-profile.c
@@ -28,22 +28,20 @@
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hidp.h"
+#include "bluetooth/sdp.h"
+#include "bluetooth/sdp_lib.h"
 
 #include "src/log.h"
 
 #include "quirk.h"
 #include "quirk-profile.h"
 
-/* Accessors from src/device.h and src/service.h */
-extern struct btd_service *input_device_get_service(
-					struct input_device *idev);
-extern struct btd_device *btd_service_get_device(
-					const struct btd_service *service);
-extern uint16_t btd_device_get_vendor(struct btd_device *device);
-extern uint16_t btd_device_get_product(struct btd_device *device);
-extern bool device_name_known(struct btd_device *device);
-extern void device_get_name(struct btd_device *device,
-					char *name, size_t len);
+#include "gdbus/gdbus.h"
+
+#include "src/device.h"
+#include "src/service.h"
+#include "src/shared/crypto.h"
+#include "device.h"
 
 #define MAX_EXTERNAL_QUIRKS 32
 #define HMAC_KEY_PATH QUIRK_PROFILE_DIR "/.hmac_key"
@@ -67,6 +65,7 @@ struct external_quirk {
 
 static struct external_quirk *ext_quirks[MAX_EXTERNAL_QUIRKS + 1];
 static int num_ext_quirks;
+static struct bt_crypto *crypto;
 
 /*
  * Parse a hex string like "0501 0905" into a byte buffer.
@@ -139,77 +138,23 @@ static char *read_file(const char *path, size_t *out_len)
 }
 
 /*
- * Compute HMAC-SHA256 using openssl CLI.
- */
-static char *hmac_sha256(const uint8_t *key, int key_len,
-			 const void *data, size_t data_len)
-{
-	char key_hex[HMAC_KEY_SIZE * 2 + 1];
-	char *cmd;
-	char *result = NULL;
-	FILE *p, *tmpf;
-	int i;
-	const char *tmpfile = "/tmp/.bluez_quirk_hmac_input";
-	char line[256];
-	char *eq, *end;
-
-	for (i = 0; i < key_len; i++)
-		snprintf(key_hex + i * 2, 3, "%02x", key[i]);
-	key_hex[key_len * 2] = '\0';
-
-	tmpf = fopen(tmpfile, "we");
-	if (!tmpf)
-		return NULL;
-
-	fwrite(data, 1, data_len, tmpf);
-	fclose(tmpf);
-
-	cmd = malloc(strlen(key_hex) + 128);
-	if (!cmd) {
-		unlink(tmpfile);
-		return NULL;
-	}
-
-	snprintf(cmd, strlen(key_hex) + 128,
-		"openssl dgst -sha256 -hmac '%s' -hex < %s 2>/dev/null",
-		key_hex, tmpfile);
-
-	p = popen(cmd, "re");
-	free(cmd);
-	unlink(tmpfile);
-
-	if (!p)
-		return NULL;
-
-	while (fgets(line, sizeof(line), p)) {
-		eq = strstr(line, "= ");
-		if (eq) {
-			eq += 2;
-			end = eq + strlen(eq) - 1;
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
-/*
- * Verify HMAC signature.
+ * Verify HMAC-SHA256 signature using bt_crypto (kernel AF_ALG).
  */
 static bool verify_signature(const char *json_path,
 			     const uint8_t *hmac_key, int key_len)
 {
 	char sig_path[1024];
 	size_t sig_len, json_len;
-	char *sig_hex, *json_data, *expected_sig;
+	char *sig_hex, *json_data;
 	char *end;
+	uint8_t computed[32];
+	char computed_hex[65];
+	int i;
 	bool valid;
 
+	if (!crypto)
+		return false;
+
 	snprintf(sig_path, sizeof(sig_path), "%s" SIG_EXT, json_path);
 
 	sig_hex = read_file(sig_path, &sig_len);
@@ -228,21 +173,25 @@ static bool verify_signature(const char *json_path,
 		return false;
 	}
 
-	expected_sig = hmac_sha256(hmac_key, key_len, json_data, json_len);
-	free(json_data);
-
-	if (!expected_sig) {
+	if (!bt_crypto_hmac_sha256(crypto, hmac_key, key_len,
+				(const uint8_t *) json_data, json_len,
+				computed)) {
+		free(json_data);
 		free(sig_hex);
 		return false;
 	}
+	free(json_data);
+
+	for (i = 0; i < 32; i++)
+		snprintf(computed_hex + i * 2, 3, "%02x", computed[i]);
+	computed_hex[64] = '\0';
 
-	valid = (strcmp(sig_hex, expected_sig) == 0);
+	valid = (strcmp(sig_hex, computed_hex) == 0);
 
 	if (!valid)
 		DBG("Signature mismatch for %s", json_path);
 
 	free(sig_hex);
-	free(expected_sig);
 	return valid;
 }
 
@@ -516,6 +465,12 @@ int load_external_quirks(const char *dir)
 	if (!dir)
 		dir = QUIRK_PROFILE_DIR;
 
+	if (!crypto) {
+		crypto = bt_crypto_new();
+		if (!crypto)
+			DBG("quirk-profile: failed to init crypto");
+	}
+
 	d = opendir(dir);
 	if (!d) {
 		DBG("quirk-profile: cannot open %s: %s", dir, strerror(errno));
@@ -586,4 +541,9 @@ void free_external_quirks(void)
 		ext_quirks[i] = NULL;
 	}
 	num_ext_quirks = 0;
+
+	if (crypto) {
+		bt_crypto_unref(crypto);
+		crypto = NULL;
+	}
 }
diff --git a/profiles/input/quirk.c b/profiles/input/quirk.c
index 053f45b..fa5e7e6 100644
--- a/profiles/input/quirk.c
+++ b/profiles/input/quirk.c
@@ -36,23 +36,6 @@ static struct gamepad_quirk *quirks[] = {
 	NULL
 };
 
-bool gamepad_quirk_match(struct input_device *idev)
-{
-	int i;
-
-	/* Check built-in quirks first */
-	for (i = 0; quirks[i]; i++) {
-		if (quirks[i]->match(idev))
-			return true;
-	}
-
-	/* Then check external (file-based) quirks */
-	if (external_quirk_match(idev))
-		return true;
-
-	return false;
-}
-
 int gamepad_quirk_apply(struct input_device *idev,
 			struct hidp_connadd_req *req)
 {
@@ -69,9 +52,5 @@ int gamepad_quirk_apply(struct input_device *idev,
 	}
 
 	/* Try external quirks */
-	if (external_quirk_match(idev)) {
-		return external_quirk_apply(idev, req);
-	}
-
-	return -1;
+	return external_quirk_apply(idev, req);
 }
diff --git a/profiles/input/quirk.h b/profiles/input/quirk.h
index 08e0bce..f2fc81b 100644
--- a/profiles/input/quirk.h
+++ b/profiles/input/quirk.h
@@ -24,13 +24,10 @@ struct gamepad_quirk {
 			struct hidp_connadd_req *req);
 };
 
-bool gamepad_quirk_match(struct input_device *idev);
-
 int gamepad_quirk_apply(struct input_device *idev,
 			struct hidp_connadd_req *req);
 
 /* External quirk support (quirk-profile.c) */
-bool external_quirk_match(struct input_device *idev);
 int external_quirk_apply(struct input_device *idev,
 			struct hidp_connadd_req *req);
 
diff --git a/profiles/input/quirks/tg170w.c b/profiles/input/quirks/tg170w.c
index d3f37a8..d82c3fa 100644
--- a/profiles/input/quirks/tg170w.c
+++ b/profiles/input/quirks/tg170w.c
@@ -38,9 +38,14 @@
 #include "bluetooth/sdp.h"
 #include "bluetooth/sdp_lib.h"
 
+#include "gdbus/gdbus.h"
+
 #include "src/log.h"
+#include "src/device.h"
+#include "src/service.h"
 
 #include "../quirk.h"
+#include "../device.h"
 
 /*
  * DualShock 4 Bluetooth HID Report Descriptor.
@@ -124,25 +129,6 @@ static const uint8_t tg170w_hid_report_descriptor[] = {
 #define TG170W_VID  0x054c  /* Sony */
 #define TG170W_PID  0x09cc  /* DualShock 4 v2 */
 
-/* Opaque structs - we don't pull in heavy headers */
-struct input_device;
-struct btd_device;
-struct btd_service;
-
-/* Declarations from src/device.h and src/service.h */
-extern struct btd_service *input_device_get_service(
-					struct input_device *idev);
-extern struct btd_device *btd_service_get_device(
-					const struct btd_service *service);
-extern uint16_t btd_device_get_vendor(struct btd_device *device);
-extern uint16_t btd_device_get_product(struct btd_device *device);
-extern const sdp_record_t *btd_device_get_record(
-					struct btd_device *device,
-					const char *uuid);
-extern bool device_name_known(struct btd_device *device);
-extern void device_get_name(struct btd_device *device,
-					char *name, size_t len);
-
 static bool tg170w_match(struct input_device *idev)
 {
 	struct btd_service *service;

