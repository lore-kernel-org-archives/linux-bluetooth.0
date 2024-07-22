Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2946C2F26
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721628183; cv=none; b=GK99U5A/KKRi2Z6T2Z22MRMeo+3C9hUIBwnHcikU26OQd0ScFLhPlp5gMx/ItMtYt4PVfRRGBrFx6vxeY5i0jAP8E3PKX6z8F0P+AcN+kd74bv97Dc9lgaJ/r3LxrUXDu6Z9E9OTVE40ijiG7ZRvOmesrlpLeB44XzTf7WXKQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721628183; c=relaxed/simple;
	bh=HE1i9GNH1u3ajl/6QEYIaZx9OJOAl4iyFtXRBT51BEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ln5GWpTcYFawfR0xJI/vxkQ0aeTOn6hXS54P6CM0wK0lAYvoGWfHJKie6KcZi64duGijzd60f4YuA6ESQlI1p7Htc/XBpFG2ka2Q0BqWmwVqDakH3jwCKk9jCtZ87VXz1YlkkdAFfQb4nm2A5rtJ9/s+x7bsSUQtkKzyQuOfe04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I7XuPomV; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I7XuPomV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cYlg4
	eMydBBGoiMcoWjQE12Gx2+djgHNyfP3VLK2FoQ=; b=I7XuPomVP3AkGBVERTX/v
	8C0ft1Rn/Y0xeiDHZtTdIyg/Ll9U3A/tyJHVcQjlFOL29NA9aIa7WI5sp9bD0jGo
	plQKvOlnmQBDGud8oo9G0Me4s17Qxr+S3EcMDnl/MpiegjCCDuRlvmDehILcYgCd
	GvpKFCP3Bv/cmO0D0hcEwY=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wDX30QN9p1mv61+AA--.2467S2;
	Mon, 22 Jul 2024 14:02:54 +0800 (CST)
From: clancy_shang@163.com
To: linux-bluetooth@vger.kernel.org
Cc: Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] [BlueZ] adapter: Fix execute "LE Add Device To Resolving List" command fail
Date: Mon, 22 Jul 2024 14:02:51 +0800
Message-Id: <20240722060251.3042314-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX30QN9p1mv61+AA--.2467S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF48tFy5uF13KrWfGrW7Jwb_yoW5XFW8pr
	Z8GF95Kw4Fqr1Igr43ZF43Xry5Cw4kJry5KFZ3W3srKF47WFWjvayfKryIvFyxGwn5X3sx
	Zan0qa45G3WUGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8sqZUUUUU=
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/1tbisA8kuGV4KqoWHwAAs3

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
index 85ddfc165..7c162c749 100644
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
+			error("Unable to load key file
+				from %s: (%s)", filename, gerr->message);
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

