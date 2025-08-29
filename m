Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E730497C
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460946; cv=none; b=b8Q0d38nRqzH8pO18tstTH7W0RmopLUr9y/Ml8AoHiMY9Zv/yF6ZJ8HnWEELoBngvQzJwUBmqBBg6VTf51+0OiiQilgWQ/zzHKd50MEwpF0DJgjrycDWO7iiVupa0K4z3DghSYrdIpnnibOncomQcg9pwhPmxJOeqvTxbPG5mRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460946; c=relaxed/simple;
	bh=PHkhAl+U9ZU3qCIFzAJanECDkeX4Kc6ry6V0lAbY2qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OGTJ+BPs0YYADhYOfUxEktYInCfrHAr8JG/Oj8VW67DrmcaE+RqjGNIu0E19X0j+DcYcllO4V0LSsfSP6eTfVIAfM35SySo/kbUAs8RFJzHXjQig2YOVT7LP33K+bSoFOosGt4KAwrk8lP3FiyNyXV5ck/9+BeKH1dlbeyHd1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=m+mPcAYJ; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="m+mPcAYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1756460932;
	bh=Tm3g5Kz5bAQTIkF2jhbPivhv9GJdn/ud90Xo+sjl4BA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=m+mPcAYJjKNJ1AG96AbZ+t52NnoynhDCF5UvIkkU4hfy1ADy/VgzL/QrxTzS8vqUY
	 IHIo15Qp93kKv07ZDeL3F9US1KzjZ7XTTkEznJNHPukXYQqJRGl33zC9SHO8QdhTX+
	 O4b9Vonr3Gzm+WqITRS2yFgahBBoFrQKi+zP/yCY=
X-QQ-mid: esmtpsz20t1756460919t20008cc2
X-QQ-Originating-IP: dKDxA8DxhWYxs4Y0cB53YLNK8UKcBekII8uu8xHn/Ck=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Aug 2025 17:48:31 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 961247839823049025
EX-QQ-RecipientCnt: 2
From: "xinpeng.wang" <wangxinpeng@uniontech.com>
To: linux-bluetooth@vger.kernel.org
Cc: "xinpeng.wang" <wangxinpeng@uniontech.com>
Subject: [PATCH v2 1/1] device: Recreate paired device from storage after failed restore
Date: Fri, 29 Aug 2025 17:48:08 +0800
Message-Id: <20250829094808.32709-2-wangxinpeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250829094808.32709-1-wangxinpeng@uniontech.com>
References: <d364976e93e23f5defbbf711dcda4787bdad3beb>
 <20250829094808.32709-1-wangxinpeng@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: M3ziZXKDk+iOBoBu+R29SOON6Y/rgOrbPWgWHWhpLloaVR64bUqYeiOn
	sKvM0w87h0t+XV/2sIMcqTp9v6QLElIcTUJWQGjfUZBMWv9xSFKAx7NxXzrwycIHHtkWNtZ
	ikNdlL3Ufp+ovKPQ+DPm1dS70bwXrZP+ighTugtR7URwOR7ROXmoQYSujE+eExBwDVD4pBE
	7u6/L1KmgY6xLWUhHVxZ2Sxc2Uvjy1JJbjrdg1Bk0NxWGo1CzqhKT47BAEZMwCB8z8kODNA
	yB42F7EpnWdtzaRgYATXyg9aHka9nQVkEGYaDT0c4KT0q4bouDJmiMWi8JxPszxX2h8OJ1D
	axfKW47lr80kcx1mPWM4CfcaSYj6PQ4GLwpCcaW7vcHtoN97s3eP1sQTjMy3dpzY+bI81Cm
	0ksMABRRswvai0KPT+j6TGTkWxo9khK+HC3VrY4wue6YSddAqwflBv+0QVMumr3jeLNzKQY
	s6f5RiFQHiBxhDptqIlY4XYCObJNW5t3ucV+QIHKf9DPeytoGO1y9ZFJ4Cr0bNoNWB7+VPS
	TQ/ffRAFA9Hrr0pEYSg8NMV/3OSEZ+a053aXzyDO+9G88wxNkjJKjOSo85O/gXRxZ1hhLKf
	o+9gsCLE70g6wEVCPf5h/A5DmIJs1mEFVSIVvJW3VvIc9HmmxsWQyhj7hCYjZuGegBh2o4d
	eHBz7WC9qdPG9HJNIoFEUXT5JFQ8R3q1w2aI4pzWnrJtEiVLLdAeFSlS/u4BDdnnIRX3Jg2
	gxm60vTPfqU0NnFC8GGBFvmUsBSVM0/HC4Snb2677aXlR8rK2wLbgeEbLlry0a8BqFsfHcs
	O3TgwG4fhjYl5jbUWBUi+staYKM006fL/hu4QktEAeqUjKkRl77DZLgBPp0PszbRnV+vC7v
	YGmi3oPHHIda1oGU6iWakC6F1o3AD81lqSzyjH39OJo7XxmXEZKXDO0GnygEvZgUsMFpz0w
	af73HZTlhO6iOQIeqmNUYKnf0A+BqudJaFWaxUjqhfxFl4CPpTM8ePifyWmcD8UT4Ud9Hg1
	sbBc3TD6JKcz4+MN+fnipbIFV/aW2oDb2uap8HUSyAXiiJAe7H9wRpURYoCLkeJsAZMVbXL
	c4/7ZHrFvZS
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

When a USB Bluetooth adapter is resumed from S4 suspend, the kernel
may trigger an "index remove" followed by an "index add". BlueZ
responds by removing all devices and attempting to recreate them
from stored configuration (storage).

However, if a connected A2DP device disconnects just before suspend,
BlueZ may have started a disconnect timer (via set_disconnect_timer)
but not yet freed the session. During this period:
- The session pointer is set to NULL and becomes inaccessible.
- The session still holds a reference to the device, preventing it
  from being freed.
- As a result, the "index add" event fails to recreate the device from
  storage (due to D-Bus path conflict or incomplete cleanup).
- Later, when the timer expires, a new device is created from discovery
  data, bypassing storage and causing it to appear as unpaired.

This leads to loss of pairing information and confuses desktop applications
that rely on paired/unpaired state.

This patch enhances the device creation logic: if loading a paired device
from storage previously failed (e.g., due to pending session cleanup), its
address is recorded in the adapter's pending list. Later, when creating a
device from scan data, BlueZ checks this list and re-attempts creation from
storage if matched, ensuring the correct paired state is restored.

This ensures that devices are properly restored after suspend/resume
cycles, even in race conditions involving delayed session cleanup.

Signed-off-by: xinpeng.wang <wangxinpeng@uniontech.com>
---
 src/adapter.c | 113 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 101 insertions(+), 12 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 549a6c0b8..16163d1f5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -342,6 +342,8 @@ struct btd_adapter {
 
 	struct queue *exp_pending;
 	struct queue *exps;
+
+	GSList *restore_dev_addrs;
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
@@ -4969,6 +4961,93 @@ done:
 	mgmt_tlv_list_free(list);
 }
 
+static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
+						const bdaddr_t *bdaddr,
+						uint8_t bdaddr_type)
+{
+	struct btd_device *device;
+	char addr[18];
+	GSList *match = NULL;
+	char *match_addr = NULL;
+	GKeyFile *key_file = NULL;
+
+	ba2str(bdaddr, addr);
+
+	match = g_slist_find_custom(adapter->restore_dev_addrs, addr,
+					(GCompareFunc)strcasecmp);
+	if (match) {
+		char filename[PATH_MAX];
+		GError *gerr = NULL;
+		struct link_key_info *key_info;
+		struct smp_ltk_info *ltk_info;
+		struct smp_ltk_info *peripheral_ltk_info;
+		struct irk_info *irk_info;
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
+		}
+
+		DBG("Found device %s but restoring from storage", addr);
+		device = device_create_from_storage(adapter, addr, key_file);
+		if (!device) {
+			g_key_file_free(key_file);
+			return NULL;
+		}
+		match_addr = match->data;
+		adapter->restore_dev_addrs =
+			g_slist_delete_link(adapter->restore_dev_addrs, match);
+		g_free(match_addr);
+
+		if (bdaddr_type == BDADDR_BREDR)
+			device_set_bredr_support(device);
+		else
+			device_set_le_support(device, bdaddr_type);
+
+		key_info = get_key_info(key_file, addr, bdaddr_type);
+		ltk_info = get_ltk_info(key_file, addr, bdaddr_type);
+		peripheral_ltk_info =
+			get_peripheral_ltk_info(key_file, addr, bdaddr_type);
+		irk_info = get_irk_info(key_file, addr, bdaddr_type);
+		if (key_info) {
+			device_set_paired(device, BDADDR_BREDR);
+			device_set_bonded(device, BDADDR_BREDR);
+		}
+		if (ltk_info || peripheral_ltk_info) {
+			struct smp_ltk_info *info;
+
+			info = ltk_info ? ltk_info : peripheral_ltk_info;
+			device_set_paired(device, info->bdaddr_type);
+			device_set_bonded(device, info->bdaddr_type);
+
+			device_set_ltk(device, info->val, info->central,
+					info->enc_size);
+		}
+		if (irk_info)
+			device_set_rpa(device, true);
+
+		btd_device_set_temporary(device, false);
+		g_free(key_info);
+		g_free(ltk_info);
+		g_free(peripheral_ltk_info);
+		g_free(irk_info);
+		g_key_file_free(key_file);
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
@@ -5087,8 +5166,15 @@ static void load_devices(struct btd_adapter *adapter)
 
 		device = device_create_from_storage(adapter, entry->d_name,
 							key_file);
-		if (!device)
+		if (!device) {
+			char *addr_copy;
+
+			addr_copy = g_strdup(entry->d_name);
+			adapter->restore_dev_addrs =
+				g_slist_append(adapter->restore_dev_addrs,
+						addr_copy);
 			goto free;
+		}
 
 		if (irk_info)
 			device_set_rpa(device, true);
@@ -7085,6 +7171,9 @@ static void adapter_remove(struct btd_adapter *adapter)
 	adapter->msd_callbacks = NULL;
 
 	queue_remove_all(adapter->exp_pending, NULL, NULL, cancel_exp_pending);
+
+	g_slist_free_full(adapter->restore_dev_addrs, g_free);
+	adapter->restore_dev_addrs = NULL;
 }
 
 const char *adapter_get_path(struct btd_adapter *adapter)
-- 
2.20.1

