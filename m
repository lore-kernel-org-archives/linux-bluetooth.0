Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="HlOGJ+JA"
Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29A5CC2
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 08:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EgMX7
	aJ5wP++AIAgtJNtqNEPrWFEsm33mKMW+rFekDA=; b=HlOGJ+JA2mFqbm4MwDlUO
	yaNFL5LT9l246jhKHC9TkckKaS8sB7ppn3PrUxaWvIoasKtotGaxgaDLB18YFu6e
	JFXb+TabGyTUmp+rOOhoQR+BwNnJV8PBiTa1egtfE4p4+8yyfT6Ohzcon0Buio9c
	MvjbI4JbFyBa+jqp7lGK8I=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wDnT5NyOHdllbAiDw--.21285S2;
	Tue, 12 Dec 2023 00:27:31 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: Xiao Yao <xiaoyao@rock-chips.com>
Subject: [PATCH 1/2] adapter: Fix addr_type for smp_irk/ltk_info/link_key
Date: Tue, 12 Dec 2023 00:27:28 +0800
Message-Id: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT5NyOHdllbAiDw--.21285S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4rGr47uryxWry5Cw4rXwb_yoW5WFykpr
	W3GFy3GrW8Xr1Igr43JrWY93Wavw4vkry2qr92934SkF4UXrWkZr45KrWS9rW5urykXrna
	qF4kXa4UWa17GrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEJKs5UUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbiEBZD1WVLY0IMQQAAsS

From: Xiao Yao <xiaoyao@rock-chips.com>

According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3,
Part H, 2.4.24/2.4.25, The LE LTK and BR/EDR link keys can be
converted between each other, so the addr type can be either
BREDR or LE, so fix it.

Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
---
 src/adapter.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 86fff72bc..ee70b00d2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -170,6 +170,7 @@ static GSList *conn_fail_list = NULL;
 
 struct link_key_info {
 	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
 	unsigned char key[16];
 	uint8_t type;
 	uint8_t pin_len;
@@ -3964,7 +3965,9 @@ static bool is_blocked_key(uint8_t key_type, uint8_t *key_value)
 	return false;
 }
 
-static struct link_key_info *get_key_info(GKeyFile *key_file, const char *peer)
+static struct link_key_info *get_key_info(GKeyFile *key_file, const char *peer,
+					uint8_t bdaddr_type)
+
 {
 	struct link_key_info *info = NULL;
 	char *str;
@@ -3976,6 +3979,7 @@ static struct link_key_info *get_key_info(GKeyFile *key_file, const char *peer)
 	info = g_new0(struct link_key_info, 1);
 
 	str2ba(peer, &info->bdaddr);
+	info->bdaddr_type = bdaddr_type;
 
 	if (!strncmp(str, "0x", 2))
 		str2buf(&str[2], info->key, sizeof(info->key));
@@ -4343,7 +4347,7 @@ static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
 		struct link_key_info *info = l->data;
 
 		bacpy(&key->addr.bdaddr, &info->bdaddr);
-		key->addr.type = BDADDR_BREDR;
+		key->addr.type = info->bdaddr_type;
 		key->type = info->type;
 		memcpy(key->val, info->key, 16);
 		key->pin_len = info->pin_len;
@@ -4598,14 +4602,18 @@ static void load_conn_params(struct btd_adapter *adapter, GSList *params)
 		btd_error(adapter->dev_id, "Load connection parameters failed");
 }
 
-static uint8_t get_le_addr_type(GKeyFile *keyfile)
+static uint8_t get_addr_type(GKeyFile *keyfile)
 {
 	uint8_t addr_type;
 	char *type;
 
+	/* The AddressType is written to file only When dev->le is
+	 * set to true, as referenced in the update_technologies().
+	 * Therefore, When type is NULL, it default to BDADDR_BREDR.
+	 */
 	type = g_key_file_get_string(keyfile, "General", "AddressType", NULL);
 	if (!type)
-		return BDADDR_LE_PUBLIC;
+		return BDADDR_BREDR;
 
 	if (g_str_equal(type, "public"))
 		addr_type = BDADDR_LE_PUBLIC;
@@ -4914,9 +4922,9 @@ static void load_devices(struct btd_adapter *adapter)
 			g_clear_error(&gerr);
 		}
 
-		key_info = get_key_info(key_file, entry->d_name);
+		bdaddr_type = get_addr_type(key_file);
 
-		bdaddr_type = get_le_addr_type(key_file);
+		key_info = get_key_info(key_file, entry->d_name, bdaddr_type);
 
 		ltk_info = get_ltk_info(key_file, entry->d_name, bdaddr_type);
 
-- 
2.34.1

