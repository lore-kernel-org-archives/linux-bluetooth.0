Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA6135A5F
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142497; cv=none; b=ruHdRgkLju+pBHH2pJNs2fTAVFuQLeOdVLDQsdlwP9QhO3RPITFM9OafCPyuKULwZQf9pp3bllal9624cFKDb3s4UYXzMLJZVfdbhsSktgJx5RCDKDbEnCHeiskaozFLuEKxj92fCKVGPBlyCyF2jAoxRgRrzqIT+lMhgT3zGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142497; c=relaxed/simple;
	bh=uJoDIqrrobnXry5Q1/FbtDdWifcTcjSiuEF9jU4na60=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=noAF91YHKPtxBR67UE5GrglBCnJnBGGox/V8kJN72dDkB5eg3gjUA0g2q6QbUYluZzOR7Y1N96SiS6aDJ4WM49UrNvZrDNR0hdOz3NzI6u2gwoDiS316ibntHzx8Yg2LDIUuc78RntZ+4qOeT6Z/8eC7z50MKVlCCVF4eelJgao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tKDDYCjD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tKDDYCjD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712142493;
	bh=uJoDIqrrobnXry5Q1/FbtDdWifcTcjSiuEF9jU4na60=;
	h=From:To:Subject:Date:From;
	b=tKDDYCjDSjvi5+4O/O8wtIRQWXMPrA3w4RmhQ3V4G4KZEQiyqy7xc+OoxlohNYCS0
	 EtsIPDg8xJSheiWa14e0q7lstGsHR9z3L1qNnX3cQGotXdXWjB4QxjEdOtRjK2WQDx
	 SlzJBxch8QJBO5HnwqEfiNQ2Zqn1klWAReuy7RTTTjvfFYM1WE8mNqIEI/sWOr0kM4
	 Aw3sgX9fVaTQtP+xcRhXG0J2XGhagM5/A8FeQPlKzaSEX7u4Avm9cEfLIz4tmrLFp/
	 XcknclGTC+0AIicp2KPvlY1TYyRXDJA3A+x82bAq1JwhPagRlqHpQGiXr9JDjoaN2U
	 ZwlsJESVzw/Ag==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8FF4837820CD
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 11:08:13 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] plugins: Add new plugin to fix airpods pairing
Date: Wed,  3 Apr 2024 13:08:08 +0200
Message-Id: <20240403110808.805771-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Apple Airpods are discoverable and pairable in BREDR mode, but also
advertise in unconnectable mode in LE with the same Public address, at the
same time. As the pairing process uses the latest seen address, sometimes
it uses the LE Public address to pair, which fails.

This commit adds a new adapter driver plugin which force the BREDR last
seen time on LE Public address device found event related to an Apple
device, allowing pairing process to always use the BREDR.

This commit is based on proposal
https://lore.kernel.org/all/20240103101328.1812899-1-clancy_shang@163.com/
---
 Makefile.plugins  |   3 ++
 plugins/airpods.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100644 plugins/airpods.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 4aa2c9c92..2ebd8aaf6 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -11,6 +11,9 @@ builtin_sources += plugins/autopair.c
 builtin_modules += policy
 builtin_sources += plugins/policy.c
 
+builtin_modules += airpods
+builtin_sources += plugins/airpods.c
+
 if ADMIN
 builtin_modules += admin
 builtin_sources += plugins/admin.c
diff --git a/plugins/airpods.c b/plugins/airpods.c
new file mode 100644
index 000000000..5043f0cca
--- /dev/null
+++ b/plugins/airpods.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024 Frédéric Danis <frederic.danis@collabora.com>
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+
+#include <glib.h>
+
+#include "bluetooth/bluetooth.h"
+
+#include "lib/mgmt.h"
+#include "src/plugin.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/eir.h"
+#include "src/log.h"
+#include "src/shared/mgmt.h"
+#include "src/shared/util.h"
+
+#define APPLE_INC_VENDOR_ID 0x004c
+
+static struct mgmt *mgmt;
+
+static bool eir_msd_is_apple_inc(GSList *msd_list)
+{
+	GSList *msd_l, *msd_next;
+
+	for (msd_l = msd_list; msd_l != NULL; msd_l = msd_next) {
+		const struct eir_msd *msd = msd_l->data;
+
+		msd_next = g_slist_next(msd_l);
+
+		if (msd->company == APPLE_INC_VENDOR_ID)
+			return true;
+	}
+
+	return false;
+}
+
+static void airpods_device_found_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_device *dev;
+	const struct mgmt_ev_device_found *ev = param;
+	struct btd_adapter *adapter = user_data;
+	uint16_t eir_len;
+	uint32_t flags = le32_to_cpu(ev->flags);
+	struct eir_data eir_data;
+
+	dev = btd_adapter_find_device(adapter,  &ev->addr.bdaddr,
+					ev->addr.type);
+	if (!dev)
+		return;
+
+	if (length < sizeof(*ev)) {
+		warn("Too short device found event (%u bytes)", length);
+		return;
+	}
+
+	eir_len = btohs(ev->eir_len);
+	if (length != sizeof(*ev) + eir_len) {
+		warn("Device found event size mismatch (%u != %zu)",
+					length, sizeof(*ev) + eir_len);
+		return;
+	}
+
+	if (eir_len == 0)
+		return;
+
+	memset(&eir_data, 0, sizeof(eir_data));
+	eir_parse(&eir_data, ev->eir, eir_len);
+
+	if (eir_msd_is_apple_inc(eir_data.msd_list) &&
+				(flags & MGMT_DEV_FOUND_NOT_CONNECTABLE) &&
+				(ev->addr.type == BDADDR_LE_PUBLIC)) {
+		DBG("Force BREDR last seen");
+		device_set_bredr_support(dev);
+		device_update_last_seen(dev, BDADDR_BREDR, true);
+	}
+}
+
+static int airpods_probe(struct btd_adapter *adapter)
+{
+	if (!mgmt)
+		mgmt = mgmt_new_default();
+
+	if (!mgmt) {
+		fprintf(stderr, "Failed to open management socket\n");
+		return 0;
+	}
+
+	mgmt_register(mgmt, MGMT_EV_DEVICE_FOUND,
+					btd_adapter_get_index(adapter),
+					airpods_device_found_callback,
+					adapter, NULL);
+
+	return 0;
+}
+
+static void airpods_remove(struct btd_adapter *adapter)
+{
+	mgmt_unregister_index(mgmt, btd_adapter_get_index(adapter));
+}
+
+static struct btd_adapter_driver airpods_driver = {
+	.name	= "airpods",
+	.probe	= airpods_probe,
+	.remove	= airpods_remove,
+};
+
+static int airpods_init(void)
+{
+	return btd_register_adapter_driver(&airpods_driver);
+}
+
+static void airpods_exit(void)
+{
+	btd_unregister_adapter_driver(&airpods_driver);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(airpods, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_LOW, airpods_init, airpods_exit)
-- 
2.34.1

