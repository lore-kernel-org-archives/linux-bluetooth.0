Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2D2FD1C2
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186592; cv=none; b=N006J55+WGozfBEUE28+NgERd0rhdZXCFj+wqplhfTHCiFb891qxAPAZCr8NIiD8WYIEHDNEm20Eu2/2ZUyr1ZcOGEYEs0iptjBu9pPx6BAfGpAk50nmfTcU0iMO4bO2lQOYa4sjHmzSvBXZ1CrPDv71aTNwHj+Dh/kuZqtNoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186592; c=relaxed/simple;
	bh=chONyMzCu/wSMxFL6uCT8YSiY7WaS1xBajIneIszd44=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kqk0x4nnkoERsl8yaLCCJ6wnz8/OFaU2BHUIiMCYuzNUwFYE9U8mwTiDmVyFIXUVb5NJeuHn860Q/gTJpcOuzSO2hzb1tPZ9Ko55ubmwUm8QfxK1XZaq87S9cQPrO82xCska39layFJ3YMeebuFF+7T37+lGo7k5QPFQtnlvvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QdTd5o1n; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QdTd5o1n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769186583;
	bh=chONyMzCu/wSMxFL6uCT8YSiY7WaS1xBajIneIszd44=;
	h=From:To:Subject:Date:From;
	b=QdTd5o1nPKaZqe87oTv8Qh06vyydqk7aurd50y7+4T1J0goSK4mgClrk2p4I3fEZS
	 q5vFltfR7AG270Y0cXpSe+I2mhT05zD6qdrRt4v3FWJIqVrHflZ1Yl4GwEiziStApO
	 sVUhQ4l0UefmwCneq/qo63D/8jPWuhpL3aSjMtoKNM1pSl5nyhJ/ZHNY0qtPlQ4bOw
	 Z3LswhNGy0L61aa9OI+/zbCqFOYeMQJ7043qRQzMJPdjZMJOlD0xEI2YdsCvKNvtPC
	 IYuRNTbnuAmVFDhsDmChqYzaLJQju6Q/6EESEb7027rnrAESTNeHuQaNJ7LuR8Tow4
	 UbLtlhqmX2Q3A==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-0a83-3CB6-e898-A29d.rev.sfr.net [IPv6:2a02:8428:af44:1001:a83:3cb6:e898:a29d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4F17117E0E3D
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 17:43:03 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] plugins/admin: Fix storage file location
Date: Fri, 23 Jan 2026 17:42:57 +0100
Message-ID: <20260123164257.853415-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The admin policy is set per adapter, as stated in
doc/settings-storage.txt and doc/org.bluez.AdminPolicySet.rst but
currently stored directly under STORAGEDIR.
---
 doc/settings-storage.txt |  2 +-
 plugins/admin.c          | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 0a2cc706c..15f55f9ed 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -56,7 +56,7 @@ So the directory structure is:
     /var/lib/bluetooth/<adapter address>/
         ./settings
         ./attributes
-	./admin_policy_settings
+        ./admin_policy_settings
         ./cache/
             ./<remote device address>
             ./<remote device address>
diff --git a/plugins/admin.c b/plugins/admin.c
index 6ab3cba56..76c65d068 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -34,7 +34,6 @@
 
 #define ADMIN_POLICY_SET_INTERFACE	"org.bluez.AdminPolicySet1"
 #define ADMIN_POLICY_STATUS_INTERFACE	"org.bluez.AdminPolicyStatus1"
-#define ADMIN_POLICY_STORAGE		STORAGEDIR "/admin_policy_settings"
 
 #define DBUS_BLUEZ_SERVICE		"org.bluez"
 #define BTD_DEVICE_INTERFACE		"org.bluez.Device1"
@@ -248,7 +247,7 @@ static void store_policy_settings(struct btd_admin_policy *admin_policy)
 {
 	GKeyFile *key_file = NULL;
 	GError *gerr = NULL;
-	char *filename = ADMIN_POLICY_STORAGE;
+	char filename[PATH_MAX];
 	char *key_file_data = NULL;
 	char **uuid_strs = NULL;
 	gsize length, num_uuids;
@@ -268,16 +267,14 @@ static void store_policy_settings(struct btd_admin_policy *admin_policy)
 					(const gchar * const *)uuid_strs,
 					num_uuids);
 
-	if (create_file(ADMIN_POLICY_STORAGE, 0600) < 0) {
-		btd_error(admin_policy->adapter_id, "create %s failed, %s",
-						filename, strerror(errno));
-		goto failed;
-	}
+	create_filename(filename, PATH_MAX, "/%s/admin_policy_settings",
+			btd_adapter_get_storage_dir(admin_policy->adapter));
+	create_file(filename, 0600);
 
 	key_file_data = g_key_file_to_data(key_file, &length, NULL);
-	if (!g_file_set_contents(ADMIN_POLICY_STORAGE, key_file_data, length,
+	if (!g_file_set_contents(filename, key_file_data, length,
 								&gerr)) {
-		error("Unable set contents for %s: (%s)", ADMIN_POLICY_STORAGE,
+		error("Unable set contents for %s: (%s)", filename,
 								gerr->message);
 		g_error_free(gerr);
 	}
@@ -342,9 +339,12 @@ static void load_policy_settings(struct btd_admin_policy *admin_policy)
 {
 	GKeyFile *key_file;
 	GError *gerr = NULL;
-	char *filename = ADMIN_POLICY_STORAGE;
+	char filename[PATH_MAX];
 	struct stat st;
 
+	create_filename(filename, PATH_MAX, "/%s/admin_policy_settings",
+			btd_adapter_get_storage_dir(admin_policy->adapter));
+
 	if (stat(filename, &st) < 0)
 		store_policy_settings(policy_data);
 
-- 
2.43.0

