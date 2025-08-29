Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34130CD84
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432931; cv=none; b=aETs5C/Wck4DYnOYQy3q2u37BkXYtF6jZgjt4BqolmQunPlk37CDblh40ELfd4LxMqWnhJekASECdskwVBRuBx2Lac+OvnVo+xpVNjQYnDV3SIsqs+/Tu+81nfqPTqoD4f2+Dzhc3WU+qAR2arxv1PUtEQi5YANSLuD7D3iqcio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432931; c=relaxed/simple;
	bh=zB3FOolwwNkfLEFGOkbZfKxwGShHO4ICvIjlbAipBP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XqCn58/04iH81QEPsftb7BNwYZ5TotKRVjw+jyCBx1itPKKUzkA/4LbUbCwdapVJSoNdlQGcivyFiVXqEnPTOxdkVEuZwizinicoZ2cDUG9x6wJ2WnFa32G+rf6Bx1TpNbT6WP4Ct4lJPlxerG5kfhHgGmMtVgB/34gerGJ83/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KbgpJBbz; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KbgpJBbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1756432915;
	bh=a27r1iHJuSpU5h231uMVfIxEcKJJhdefbPnWL0bXMTg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=KbgpJBbzjzUoUG2/lVtVLZgktSGS+BHiz3P4IZVF6AmlHAulSiq4eluZTv8gfIT92
	 sJsvqVzNvcR1BpGrE88V74r4f1zNXVlNOVGNOEw14qjCCGZcA2PtzxITDke9dt0bvr
	 pazHoLmKzD6R1vvQdijf7fCe+62hc17nIUhEM8e0=
X-QQ-mid: esmtpgz13t1756432902ta00daaea
X-QQ-Originating-IP: 9JOSBM63nDDZRMFDrB6ng3jLzvKl87vK0ihCrOAiS1Y=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Aug 2025 10:01:36 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13436144907555265226
EX-QQ-RecipientCnt: 2
From: "xinpeng.wang" <wangxinpeng@uniontech.com>
To: linux-bluetooth@vger.kernel.org
Cc: "xinpeng . wang" <wangxinpeng@uniontech.com>
Subject:  
Date: Fri, 29 Aug 2025 10:01:28 +0800
Message-Id: <20250829020128.949863-1-wangxinpeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MACXe2l6e7j9RO+jzluJocS8AUQ+UPgX+E2SkI4fEqEXU9NAbaaMXoee
	g8UbOKzhmpqiBTzJ7LoDWuiNJ5g5PntRVvX3V9Nak5mWEhF+oMMVSFL6eKF4W9c/nE1IkpA
	mvxUMt6u8F25omk6wpCHjTYvuY3YU13DTnOV2rN1SffxuQhghomUJG7WtXnlZ2LweX9C339
	ysV79GTOWcwTprbn4jLhdrCu4QV5Mvs5HIEBsuxFXtiJrsAdW4ZzdggLUMtrISyz9ZjVrvH
	OHXUyjzZd8PkPEYxLxeKZyYFvKihUFJAkFs6Pxgdr8l//fR19aInlAulTFFaNiv44tYRkh1
	KO6MSkCt3Nf3bJogg3Nc9LqD74rY4V9Qi7LZ2uErAuNQsehIBD7VgjOCxd82ebK8V+xiv+O
	sxWauFBXEkd+puirqTbIQKiq1T3nJOE3CYPKGRprXY6wv9CGkvY2B1EHcy9ZWR+78vcsYxc
	WQ+FrZqcEas/TJvpwYAPHnVCtOw4U3Ko8hKnIYRm3t1MML2ENYdpkc81FCD2NkLTH80z9jx
	3h5f841qR4GOH/mKLIDEcwptbIdYM/DV1ca17+6ybFZoL5yYjk0BrK+aB6KpVAgy0txOM+S
	TbOPYkAupCBoTKIO1JRwLt6iRDHITNwmGEJlNvghGc9JAcZ2drFrtnYQDj3LDDwIS0Tbnzg
	D34qLiLSy4gfDWt67tlnoHh7pOwjk31pUll7wpQO/RGG0vrBMlCIrukmm/sMl6Xm72g4qa9
	GHvon032ZnmC7W7d/XYLv/HBONRV/Mz/HDd/zQb7jr2RAFLe8t8PR4Lphn5rkaKF9BBkpeb
	i0QsUk0+Yq3BvSRX962i65PSKI8juYkNF3Kc0fZNId/B+L2iK/Nsl7pfhDa80s10vpTh8AC
	61P5zMq6cuj4MD+NiZgOXCi3ks3pwgxZjvvE92MKEgr7lyeF0ZYeux4uwKk0KnR0Ggb2XPI
	6Xh5pOZMEzPU9kG8aKnAV49k8IAU2F4aYRSzNBF/yCFVVBrNbQ1NmrfOtMhVkKxifPNM=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

From d364976e93e23f5defbbf711dcda4787bdad3beb Mon Sep 17 00:00:00 2001
From: xinpeng wang <wangxinpeng@uniontech.com>
Date: Thu, 28 Aug 2025 21:31:31 +0800
Subject: [PATCH] device: Recreate paired device from storage if previous
 restoration failed

When a USB Bluetooth adapter is resumed from S4 suspend, the kernel may trigger
an "index remove" followed by an "index add". BlueZ responds by removing all
devices and attempting to recreate them from stored configuration (storage).

However, if a connected A2DP device disconnects just before suspend, BlueZ may
have started a disconnect timer (via set_disconnect_timer) but not yet freed
the session. During this period:
- The session pointer is set to NULL and becomes inaccessible.
- The session still holds a reference to the device, preventing it from being freed.
- As a result, the "index add" event fails to recreate the device from storage (due to
  D-Bus path conflict or incomplete cleanup).
- Later, when the timer expires, a new device is created from discovery data, bypassing
  storage and causing it to appear as unpaired.

This leads to loss of pairing information and confuses desktop applications that
rely on paired/unpaired state.

This patch improves the device creation logic during discovery: when creating a
device from scan data, it checks whether the remote address corresponds to a
known paired device in storage. If so, and if no valid device instance exists,
it forces recreation from storage to restore the correct paired state.

This ensures that devices are properly restored after suspend/resume cycles,
even in race conditions involving delayed session cleanup.

Signed-off-by: xinpeng.wang <wangxinpeng@uniontech.com>
---
 src/adapter.c | 111 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 99 insertions(+), 12 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 549a6c0b8..c2ac19f32 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -342,6 +342,8 @@ struct btd_adapter {
 
 	struct queue *exp_pending;
 	struct queue *exps;
+
+	GSList *pending_restore_device_addrs;
 };
 
 static char *adapter_power_state_str(uint32_t power_state)
@@ -1400,17 +1402,7 @@ static void adapter_add_device(struct btd_adapter *adapter,
 
 static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
 						const bdaddr_t *bdaddr,
-						uint8_t bdaddr_type)
-{
-	struct btd_device *device;
-
-	device = device_create(adapter, bdaddr, bdaddr_type);
-	if (!device)
-		return NULL;
-
-	adapter_add_device(adapter, device);
-	return device;
-}
+						uint8_t bdaddr_type);
 
 static void service_auth_cancel(struct service_auth *auth)
 {
@@ -4969,6 +4961,95 @@ done:
 	mgmt_tlv_list_free(list);
 }
 
+static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
+						const bdaddr_t *bdaddr,
+						uint8_t bdaddr_type)
+{
+	struct btd_device *device;
+	char addr[18];
+	GSList *l;
+	GKeyFile *key_file = NULL;
+
+	ba2str(bdaddr, addr);
+
+	l = g_slist_find_custom(adapter->pending_restore_device_addrs, addr,
+		(GCompareFunc)strcasecmp);
+	if (l != NULL) {
+		char filename[PATH_MAX];
+    		GError *gerr = NULL;
+
+		create_filename(filename, PATH_MAX, "/%s/%s/info",
+					btd_adapter_get_storage_dir(adapter),
+					addr);
+
+		key_file = g_key_file_new();
+		if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+			error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+			g_clear_error(&gerr);
+			adapter->pending_restore_device_addrs =
+				g_slist_delete_link(adapter->pending_restore_device_addrs, l);
+        		g_free(l->data);
+			key_file = NULL;
+		}
+	}
+
+	if (key_file != NULL) {
+		struct link_key_info *key_info;
+		struct smp_ltk_info *ltk_info;
+		struct smp_ltk_info *peripheral_ltk_info;
+		struct irk_info *irk_info;
+		
+		DBG("Found device %s but restoring from storage", addr);
+        	device = device_create_from_storage(adapter, addr, key_file);
+		if (!device) {
+			g_key_file_free(key_file);
+            		return NULL;
+		}
+		adapter->pending_restore_device_addrs = 
+			g_slist_delete_link(adapter->pending_restore_device_addrs, l);
+        	g_free(l->data);
+
+		if (bdaddr_type == BDADDR_BREDR)
+			device_set_bredr_support(device);
+		else
+			device_set_le_support(device, bdaddr_type);
+
+		key_info = get_key_info(key_file, addr, bdaddr_type);
+		ltk_info = get_ltk_info(key_file, addr, bdaddr_type);
+		peripheral_ltk_info = get_peripheral_ltk_info(key_file,
+						addr, bdaddr_type);
+		irk_info = get_irk_info(key_file, addr, bdaddr_type);
+		if (key_info) {
+			device_set_paired(device, BDADDR_BREDR);
+			device_set_bonded(device, BDADDR_BREDR);
+		}
+		if (ltk_info || peripheral_ltk_info) {
+			struct smp_ltk_info *info = ltk_info ? ltk_info : peripheral_ltk_info;
+			device_set_paired(device, ltk_info->bdaddr_type);
+			device_set_bonded(device, ltk_info->bdaddr_type);
+			
+			device_set_ltk(device, info->val, info->central,
+						info->enc_size);
+		}
+		if (irk_info)
+			device_set_rpa(device, true);
+
+		btd_device_set_temporary(device, false);
+		g_free(key_info);
+		g_free(ltk_info);
+		g_free(peripheral_ltk_info);
+		g_free(irk_info);
+	} else {
+		device = device_create(adapter, bdaddr, bdaddr_type);
+		if (!device)
+			return NULL;
+	}
+
+	adapter_add_device(adapter, device);
+	return device;
+}
+
 static void load_devices(struct btd_adapter *adapter)
 {
 	char dirname[PATH_MAX];
@@ -5087,8 +5168,11 @@ static void load_devices(struct btd_adapter *adapter)
 
 		device = device_create_from_storage(adapter, entry->d_name,
 							key_file);
-		if (!device)
+		if (!device) {
+			char *addr_copy = g_strdup(entry->d_name);
+    			adapter->pending_restore_device_addrs = g_slist_append(adapter->pending_restore_device_addrs,addr_copy);
 			goto free;
+		}
 
 		if (irk_info)
 			device_set_rpa(device, true);
@@ -7085,6 +7169,9 @@ static void adapter_remove(struct btd_adapter *adapter)
 	adapter->msd_callbacks = NULL;
 
 	queue_remove_all(adapter->exp_pending, NULL, NULL, cancel_exp_pending);
+
+	g_slist_free_full(adapter->pending_restore_device_addrs,g_free);
+	adapter->pending_restore_device_addrs = NULL;
 }
 
 const char *adapter_get_path(struct btd_adapter *adapter)
-- 
2.20.1

