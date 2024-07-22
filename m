Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B8ACA64
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721615255; cv=none; b=j69OtUKgR/Q7VoEKqhIhovkPOk9vFS3HNKiyS9uHAUf0BDwwluOq9TP0eabPHqaJL9vMbW65i2e2hKOt6dUAUrlMH1eXcEUorhItMZ4atvEcyfw1znGUJNghJK5AqkgWtnX4T3M/NhCxB+RWKefuVius0ZkqftlDDOBJZ5Uc8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721615255; c=relaxed/simple;
	bh=EqdJPry8OSI6t8RaI8QhxKN82Heiev3VyJ0RtlvCs/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j0fsCJdknrj48E4ESS1pt5jaqyP/nfA2gRSbtfUgK7HmhphxK8hh0N1rjI7/SwcML5dfj15fNxufkIb0E71zQHcogDYSSWiDmVybjOybfkIj/gRlL1K2kyDcgYuIx7NGdo3rr2iV7QgBDF0pu4zlgMYD3Gb1TBroYFipfJ1rjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GelxWa5h; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GelxWa5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Ls2mA
	9zP2dk/pcwsrgQ2WhB2A/gZv5H5q9GA9kd4XSE=; b=GelxWa5hkIPMyvdrU1mcg
	Xi8VoH0ah64oFHVaXt5sH57ktE579tNOi71BkXmBilyoqRh1p03nIHxL3dZN3WsR
	Bu86yn9wZO0NoTe0UQb3SCbHzxtbWlswk/km9QxIVcrHIZJURtUXCoyqevO4BJnI
	t4nxRyOie+DrZs9bRHxTGg=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wCnr82Mw51mf9bFCQ--.21520S2;
	Mon, 22 Jul 2024 10:27:26 +0800 (CST)
From: clancy_shang@163.com
To: linux-bluetooth@vger.kernel.org
Cc: zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] [BlueZ] adapter: Fix execute "LE Add Device To Resolving List" command fail
Date: Mon, 22 Jul 2024 10:27:22 +0800
Message-Id: <20240722022722.2973007-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnr82Mw51mf9bFCQ--.21520S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF48tF4kuw4xtw4UtF43KFg_yoW5XFyfpr
	Z5GF95Kw4rXr1Igr4fJF43XryYkw4kJryrKFZ3u3srKF47WFWjv3yfKryIvFyxGwn5X3sx
	Zan0qa45G3WUGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8sqZUUUUU=
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/1tbiUBEkuGXAmA90mQAAsC

From: Clancy Shang <clancy.shang@quectel.com>

According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E, 7.8.38,
If there is an existing entry in the resolving list with the same non-zero
Peer_IRK, the Controller should return the error code Invalid HCI Command
Parameters (0x12), so fix it.

Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
---
 src/adapter.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index cf29fe9ba..e3b4993e8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8926,6 +8926,72 @@ static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
 	g_key_file_free(key_file);
 }
 
+static void delete_exist_irk_from_directory(struct btd_adapter *adapter,
+										const unsigned char *key)
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
+		if (!g_key_file_load_from_file(key_file, filename,
+									0, &gerr)) {
+			error("Unable to load key file from %s: (%s)",
+								filename, gerr->message);
+			g_clear_error(&gerr);
+		}
+
+		bdaddr_type = get_le_addr_type(key_file);
+
+		irk_info = get_irk_info(key_file, entry->d_name, bdaddr_type);
+
+		if(irk_info)
+		{
+			if(!memcmp(irk_info->val, key, 16))
+			{
+				DBG("Has same irk,delete it");
+				device = btd_adapter_find_device(adapter,&irk_info->bdaddr,
+											irk_info->bdaddr_type);
+				if(device)
+					btd_adapter_remove_device(adapter,device);
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
@@ -8975,6 +9041,8 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 	if (!persistent)
 		return;
 
+	delete_exist_irk_from_directory(adapter,irk->val);
+
 	store_irk(adapter, &addr->bdaddr, addr->type, irk->val);
 
 	btd_device_set_temporary(device, false);
-- 
2.25.1

