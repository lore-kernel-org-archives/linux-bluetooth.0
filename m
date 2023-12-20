Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BB247A45
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="oZfsizxo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3ne3M
	lB8AxgUDbSmFlHr1ZUkufhwv3zNGVAaXN8ZJkE=; b=oZfsizxoSGhbwzF2XIwV7
	kE3x5avmtT7ydXE/uf/D5EIT9MdrGntwPIhb3ohOo2M6H99M2eoXiWtyV08xSmKY
	T6e/lfbL5zuvdjSFHzL2a4DEsdQk87o+zhJr6UQKKHAY/xQjklx+Gbi93wgwCA5w
	iexXADPDO/FbL9CBXE7MSo=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3vwrOJINl1X8ZEQ--.12935S2;
	Thu, 21 Dec 2023 01:30:56 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: antiz@archlinux.org,
	Xiao Yao <xiaoyao@rock-chips.com>
Subject: [PATCH v2] adapter: Fix link key address type for old kernels
Date: Thu, 21 Dec 2023 01:30:52 +0800
Message-Id: <20231220173052.1617172-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vwrOJINl1X8ZEQ--.12935S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFykAF48Cw1DJF4UtrWkJFb_yoWrWF4Dp3
	y7GF15JF4UXF1Iqa97CryUuF1a9a95KFyUtFy2k3sxuFn8XrW0yFWxtFW29ry3Kr4kXwn7
	AF1kWw15Wr47KrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRP5rsUUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi6AZK1WVLY5t15QABs2

From: Xiao Yao <xiaoyao@rock-chips.com>

According to the Bluetooth specification, the address
type of the link key is not fixed. However, the
load_link_keys function in the old kernel code requires
that the address type must be BDADDR_BREDR, so attempt
it when the first load fails.

Fixes: https://github.com/bluez/bluez/issues/686

Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
---
v1 -> v2
Prioritize loading keys with standard address types,
and switch to BREDR address types upon failure, as
suggested by the maintainer.
---
 src/adapter.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ee70b00d2..e1b704ecc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -168,6 +168,9 @@ static GSList *adapter_drivers = NULL;
 static GSList *disconnect_list = NULL;
 static GSList *conn_fail_list = NULL;
 
+static GSList *link_keys = NULL;
+static bool link_keys_brder = false;
+
 struct link_key_info {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
@@ -4284,23 +4287,45 @@ static int set_privacy(struct btd_adapter *adapter, uint8_t privacy)
 	return -1;
 }
 
+static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
+			   bool debug_keys, bool link_key_bredr);
+
 static void load_link_keys_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
 
 	if (status != MGMT_STATUS_SUCCESS) {
+		/*
+		 * According to the Bluetooth specification, the address
+		 * type of the link key is not fixed. However, the
+		 * load_link_keys function in the old kernel code requires
+		 * that the address type must be BDADDR_BREDR, so attempt it.
+		 */
+		if (link_keys_brder == false && status == 0x0d) {
+			link_keys_brder = true;
+			load_link_keys(adapter, link_keys, btd_opts.debug_keys,
+				       link_keys_brder);
+			return;
+		}
+
 		btd_error(adapter->dev_id,
 			"Failed to load link keys for hci%u: %s (0x%02x)",
 				adapter->dev_id, mgmt_errstr(status), status);
-		return;
+
+		goto free;
 	}
 
 	DBG("link keys loaded for hci%u", adapter->dev_id);
+
+free:
+	g_slist_free_full(link_keys, g_free);
+	link_keys = NULL;
+	link_keys_brder = false;
 }
 
 static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
-							bool debug_keys)
+			   bool debug_keys, bool link_key_bredr)
 {
 	struct mgmt_cp_load_link_keys *cp;
 	struct mgmt_link_key_info *key;
@@ -4320,8 +4345,8 @@ static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
 
 	key_count = g_slist_length(keys);
 
-	DBG("hci%u keys %zu debug_keys %d", adapter->dev_id, key_count,
-								debug_keys);
+	DBG("hci%u keys %zu debug_keys %d (%s)", adapter->dev_id, key_count,
+			debug_keys, link_key_bredr ? "force bredr" : "normal");
 
 	cp_size = sizeof(*cp) + (key_count * sizeof(*key));
 
@@ -4347,7 +4372,10 @@ static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
 		struct link_key_info *info = l->data;
 
 		bacpy(&key->addr.bdaddr, &info->bdaddr);
-		key->addr.type = info->bdaddr_type;
+		if (link_key_bredr)
+			key->addr.type = BDADDR_BREDR;
+		else
+			key->addr.type = info->bdaddr_type;
 		key->type = info->type;
 		memcpy(key->val, info->key, 16);
 		key->pin_len = info->pin_len;
@@ -4873,7 +4901,6 @@ done:
 static void load_devices(struct btd_adapter *adapter)
 {
 	char dirname[PATH_MAX];
-	GSList *keys = NULL;
 	GSList *ltks = NULL;
 	GSList *irks = NULL;
 	GSList *params = NULL;
@@ -4964,7 +4991,7 @@ static void load_devices(struct btd_adapter *adapter)
 		}
 
 		if (key_info)
-			keys = g_slist_append(keys, key_info);
+			link_keys = g_slist_append(link_keys, key_info);
 
 		if (ltk_info)
 			ltks = g_slist_append(ltks, ltk_info);
@@ -5013,8 +5040,8 @@ free:
 
 	closedir(dir);
 
-	load_link_keys(adapter, keys, btd_opts.debug_keys);
-	g_slist_free_full(keys, g_free);
+	load_link_keys(adapter, link_keys, btd_opts.debug_keys,
+			link_keys_brder);
 
 	load_ltks(adapter, ltks);
 	g_slist_free_full(ltks, g_free);
-- 
2.34.1

