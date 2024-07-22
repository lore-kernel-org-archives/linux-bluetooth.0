Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656CC381BA
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634999; cv=none; b=NQ9rR+o9w7nV/tD2T0j6R20LXbAkF+8moz22y8CJvAUyLyXOWT3vZVCghXfry9aw1uG6jlsgYd68MUsaFOr5dJU1lfjpc39C/zHdYRCtq4o8tW1LeBkvAEb/zD34VnEv69ctjbxfnM8Npfwl8elU0LbbrOVly5ejJZjRxLy5YzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634999; c=relaxed/simple;
	bh=5omwLNF6CNM3jpGQV/7ArJjHjmVsDwxI8uq/1hN1VJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=REYKl/AU5Dmxonkbjrax9CDYSufwuRf6IeVv379OIMQMSzuxxHYqaBGOm4/DTzRFp5sy4gUaVCy5Xv6fHzI6UdOiynxTJt/Vd/CcUIwt1QUyZJueOVPKuh35LoB5zzCRaqIA4CnaQfGOghoB8zSAwsjH4ZtM2XomyxvDC2IzABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AyhT3K+z; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AyhT3K+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xz1GZ
	BWNALHmxdiLUBRrciUNjKfrHTujMG9QSP4QaM8=; b=AyhT3K+zGb6jm9jVGGbQ+
	Z6oUZp6mjLWllc/gAc4GPcYPTKn8IGFAOgk7e3OFg4WEMl/uUiRmaJFO2IEuDqzo
	sXgempaXPt5As1j8coRwSPwMjVSNNtjww3SDc0IjByeonO4CAcp23gHvag6mN78s
	eZOqKy4t0xxY4uLgWRZDP8=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wDXP1KrEJ5mhn7MCA--.6434S2;
	Mon, 22 Jul 2024 15:56:29 +0800 (CST)
From: clancy_shang@163.com
To: linux-bluetooth@vger.kernel.org
Cc: Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] [BlueZ] adapter: Fix execute "LE Add Device To Resolving List" command fail
Date: Mon, 22 Jul 2024 15:56:26 +0800
Message-Id: <20240722075626.3050334-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXP1KrEJ5mhn7MCA--.6434S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF48tFy5uF13KrWfGrW7Jwb_yoW5XFW8pr
	Z8GF95Kw4Fqr1xKr4fZF43XryYkw4kJry5KFZxW3srKF47WFWjvayfKryIvFyxGwn5X3sx
	Zan0qas8G3WUGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8sqZUUUUU=
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/1tbisBEkuGV4Kqz7QAAAsd

From: Clancy Shang <clancy.shang@quectel.com>

According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E,
7.8.38, If there is an existing entry in the resolving list with the same
non-zero Peer_IRK, the Controller should return the error code Invalid
HCI Command Parameters (0x12), so fix it.

Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
---
 src/adapter.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 85ddfc165..495c9f631 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8901,6 +8901,76 @@ static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
 	g_key_file_free(key_file);
 }
 
+static void delete_exist_irk_from_directory(
+						struct btd_adapter *adapter,
+						const unsigned char *key)
+{
+	char dirname[PATH_MAX];
+	GError *gerr = NULL;
+	DIR *dir;
+	struct dirent *entry;
+
+	create_filename(dirname, PATH_MAX, "/%s",
+				btd_adapter_get_storage_dir(adapter));
+
+	dir = opendir(dirname);
+	if (!dir) {
+		btd_error(adapter->dev_id,
+				"Unable to open adapter storage directory: %s",
+								dirname);
+		return;
+	}
+
+	while ((entry = readdir(dir)) != NULL) {
+		struct btd_device *device;
+		char filename[PATH_MAX];
+		GKeyFile *key_file;
+		struct irk_info *irk_info;
+		uint8_t bdaddr_type;
+
+		if (entry->d_type == DT_UNKNOWN)
+			entry->d_type = util_get_dt(dirname, entry->d_name);
+
+		if (entry->d_type != DT_DIR || bachk(entry->d_name) < 0)
+			continue;
+
+		create_filename(filename, PATH_MAX, "/%s/%s/info",
+					btd_adapter_get_storage_dir(adapter),
+					entry->d_name);
+
+		key_file = g_key_file_new();
+		if (!g_key_file_load_from_file(
+								key_file,
+								filename,
+								0,
+								&gerr)) {
+			error("Unable to load key file from %s: (%s)",
+					filename, gerr->message);
+			g_clear_error(&gerr);
+		}
+
+		bdaddr_type = get_le_addr_type(key_file);
+
+		irk_info = get_irk_info(key_file, entry->d_name, bdaddr_type);
+
+		if (irk_info) {
+			if (!memcmp(irk_info->val, key, 16)) {
+				DBG("Has same irk,delete it");
+				device = btd_adapter_find_device(adapter,
+							&irk_info->bdaddr,
+							irk_info->bdaddr_type);
+				if (device)
+					btd_adapter_remove_device(adapter,
+									device);
+			}
+		}
+		g_key_file_free(key_file);
+	}
+
+	closedir(dir);
+
+}
+
 static void new_irk_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -8950,6 +9020,8 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 	if (!persistent)
 		return;
 
+	delete_exist_irk_from_directory(adapter, irk->val);
+
 	store_irk(adapter, &addr->bdaddr, addr->type, irk->val);
 
 	btd_device_set_temporary(device, false);
-- 
2.25.1

