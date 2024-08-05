Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1184EDC
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722823306; cv=none; b=JEz09zMaXoe1r+byYHEjffBcjF1cTbbTbBSiaD2mMpyIro4MS7Ef5OotRMxKEUQnAbjIog4vJSoRMjSY8lS6qRxASqAbIZ36IRUFoWbYUXV8Hgn7av4iatFccWBthK98rnKfbUgcJW+/1+Zmo9oZmpLmcijnwDw/B7VLoKrvuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722823306; c=relaxed/simple;
	bh=d+kavo78siIMbP12vIvXEJr2o35clAf0q9h9eJ6eAJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AR4kqVwPPJwLfhJ+NPq1U6clJ2Pc3QddfSsulTfobyD/wOJTyShBZDqaOedv1sbFcaTeY4BZV/mzFgPj7pfQACdDNqaR0G7wTA3wejidKZxi0ctiqK9RcShlD5ah983hR6uQZV6bI4Et1piGVEWvOS9lKCn24w2GWIJx0jPTCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W6vmzM0t; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W6vmzM0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iuYfQ
	DQidliFTg8Yx/y0H/5iECtXEzZaNmvD8MSEKPM=; b=W6vmzM0t55b610BCq1fZo
	NjlcA38Ji+PBWH3146+PO7MOQwkoKy0nzqdp4Dgwissao2eC0SDZ++LFmboQOewy
	eJVj8L4NI1J1FzKPhs0GpHcuhYNYyoUQzcJ6Ku1BEAHZEttEQml1ilZqR/oZKWys
	AUUiJOkByelEisSg1pc8mQ=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wAXm893MrBmc8ftCw--.51888S2;
	Mon, 05 Aug 2024 10:01:28 +0800 (CST)
From: clancy_shang@163.com
To: linux-bluetooth@vger.kernel.org
Cc: zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] [BlueZ] adapter: Fix execute "LE Add Device To Resolving List" command fail
Date: Mon,  5 Aug 2024 10:01:26 +0800
Message-Id: <20240805020126.903959-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXm893MrBmc8ftCw--.51888S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF48tF4DWF45tF47uF4Uurg_yoW5try8pr
	Z8JF9Yqws5tr17Kr4fuF4xWry5ur4kJ345KFZ3W3srKF17WFyUZFWSkryfta4xGwn5W3ZI
	van0qa4DGa1UGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U00PDUUUUU=
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/1tbiLBwyuGXAnfXDXQAAsp

From: Clancy Shang <clancy.shang@quectel.com>

According to Bluetooth Core Specification Version 5.4 | Vol 4, Part E,
7.8.38, if there is an existing entry in the resolving list with the same
non-zero Peer_IRK, the Controller should return the error code Invalid
HCI Command Parameters (0x12), so fix it.

Test environment:
I tested with the game controller device, and the steps are as follows:
1. The game controller device enters advertising pairing mode and then
   connects.
2. Disconnect.
3. Make the hand shank enter advertising pairing mode again and then
   reconnect.
4. Reproduce.
The step one and step four, the game controller device is the same device
but with a different privacy static address, causing the same IRK.

There could be some trouble if it is fixed in the kernel.
Firstly, there would be two devices in the paired list, but only the latest
device can be conneted. Actually they are the same device.
Secondly, the display will show two devices too.

Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
---
 src/adapter.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 85ddfc165..c6021f173 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8901,6 +8901,73 @@ static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
 	g_key_file_free(key_file);
 }
 
+static void delete_existing_irk_from_directory(
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
+		if (!g_key_file_load_from_file(key_file, filename,
+								0, &gerr)) {
+			error("Unable to load key file from %s: (%s)",
+					filename, gerr->message);
+			g_clear_error(&gerr);
+		}
+
+		bdaddr_type = get_addr_type(key_file);
+
+		irk_info = get_irk_info(key_file, entry->d_name, bdaddr_type);
+
+		if (irk_info) {
+			if (!memcmp(irk_info->val, key, 16)) {
+				DBG("Has same irk, delete it");
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
@@ -8950,6 +9017,8 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 	if (!persistent)
 		return;
 
+	delete_existing_irk_from_directory(adapter, irk->val);
+
 	store_irk(adapter, &addr->bdaddr, addr->type, irk->val);
 
 	btd_device_set_temporary(device, false);
-- 
2.25.1

