Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8C382398
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206602; cv=none; b=RQnDSoLKF0K8Zoj/tKUQk7Rbco29EtCeQN2hmFVlYFzMQc3QGF3sumEvJQK4Sol9c+03Zha34e0g3Hpd+7UGZCtBloYi3pZX+j2FCTz9p0qO3smFb9j1ANs8mKm+8j33ikLPfsXm3qlHCLzjtnXvxzwq/bp3Z9KZNt20vkf7JJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206602; c=relaxed/simple;
	bh=GfDUfUI8ulB1rZKB1W64TPfDMwd6Q1AZO9h0UXx+OFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpbBriikbUaiH83Sf4nv5wO5J7ELEvhmZlioRFC3K5J8BMzv8/8HyjREo8iMOgOEnBjh0my+s1UsU2m65GRrsV33tz6Qt9pIk7JHQ1nz3QgAevIIujw2VSHiwnJSopkZVmBbGP5fYIy4Qtam6yfhcvQY3ifpwmvM0kcYWJw7f00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=pITLbT45; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="pITLbT45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1775206595; x=1775811395; i=martinbts@gmx.net;
	bh=7EA2SvQROB4T6xx4PBf8NyBtL5uJdhfBwzxfv90HyyE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pITLbT45B+ZH7d7s3XSku/7wzAqOiykl5j9vYprPvgD6v1OIkqhwywnyq96e4aLw
	 vM2oIUq+Cx8Qf4azy2py0IfNlOgJMCwYey4+WjYtVI96gPBi6UVz1w2rCH4g2w4zt
	 p4cS+h1rEVD1s4gGKsGZYob4Dtq0AvwXWl/vf0x6+f+6C0D+HbOifkwFGweiHfYls
	 CnzV0WZCgP6S7N/UqfU4qOlON3QXEyPMufu1dvL01TJ/20eukiJY4GABqWdZPDnIi
	 vu21RIq47shQ0tyF6OBgaHgwXZOyNXmfb1fGEeil/uF/ecxhQpq7nX1UYnPYfrgyG
	 LdjgXkyouRlgbz4q0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1vTsFr1SVA-010c5g; Fri, 03
 Apr 2026 10:56:35 +0200
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v3 6/6] plugins/switch2: Add Nintendo Switch 2 Controller plugin
Date: Fri,  3 Apr 2026 10:55:53 +0200
Message-ID: <20260403085555.23871-7-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403085555.23871-1-martinbts@gmx.net>
References: <20260403085555.23871-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UoNs9OK8qH3Ve+6NLsgY2zVTy5A8NUrVgYR9I3M9kFJSi7S8wfV
 EtwI5MqZsSAA+4As449PMjz8mSl7tCcswuIFxHoGIi2EMS2nKBQkLkAmsns409UV0eEdvH0
 4B5K/NUoeh0MmPfZk1ntu+xddRFSW5Tgtsk1aANN2MaX3oMn2uM3th+5yxIn4m6UnuWuzqB
 UDOV/UqA52N5KBoFTLHrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fd3UAthf+64=;WOLkesyAxu/tZ3ysSoPNRABNbO/
 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
 Ab01RGodaL3H5N6Ziqgm2iEg==

Thin device-specific wrapper around the generic GATT-UHID bridge for
Nintendo Switch 2 controllers (Pro Controller 2, Joy-Con 2 L/R,
GameCube Controller).

The plugin handles:
- Profile registration with the Switch 2 GATT service UUID
- Dynamic GATT characteristic discovery (all notify handles)
- Controller type detection from product ID
- Vendor/product IDs and payload sizes for uhid device creation
- Low-latency connection parameters and BT_SECURITY_LOW
- Skip secondary service discovery (controller rejects it)

All protocol knowledge (init handshake, calibration, stick normalization,
button mapping, rumble) is delegated to a matched kernel HID driver.
The plugin itself contains no Nintendo protocol logic.
=2D--
 Makefile.plugins  |   5 +
 plugins/switch2.c | 255 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 260 insertions(+)
 create mode 100644 plugins/switch2.c

diff --git a/Makefile.plugins b/Makefile.plugins
index c9efadb45..4c5d10a90 100644
=2D-- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -1,4 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
+builtin_sources +=3D plugins/gatt-uhid.h plugins/gatt-uhid.c
+
+builtin_modules +=3D switch2
+builtin_sources +=3D plugins/switch2.c
+
 builtin_modules +=3D hostname
 builtin_sources +=3D plugins/hostname.c
=20
diff --git a/plugins/switch2.c b/plugins/switch2.c
new file mode 100644
index 000000000..0e389cab1
=2D-- /dev/null
+++ b/plugins/switch2.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Nintendo Switch 2 controller BLE plugin
+ *
+ *  Thin device-specific wrapper around the generic GATT-UHID bridge.
+ *  Provides the GATT service UUID, characteristic discovery, and
+ *  vendor/product IDs for uhid device matching.
+ *
+ *  This wires the BLE device(s) so that HID drivers can take over.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/plugin.h"
+#include "src/log.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/gatt-db.h"
+
+#include "plugins/gatt-uhid.h"
+
+/*
+ * Hard facts about Nintendo and the Switch 2 controllers
+ */
+
+#define SWITCH2_SERVICE_UUID "ab7de9be-89fe-49ad-828f-118f09df7fd0"
+
+#define NS2_VID           0x057e /* Nintendo Vendor ID */
+#define NS2_PID_JOYCON_R  0x2066
+#define NS2_PID_JOYCON_L  0x2067
+#define NS2_PID_PROCON    0x2069
+#define NS2_PID_GCCON        0x2073
+
+#define NS2_INPUT_SIZE    63 /* Max observed on Procon2 in bytes */
+#define NS2_OUTPUT_SIZE   64 /* Max observed on Procon2; no off by one */
+
+#define NS2_MAX_NOTIFY    8 /* Max |notify characteristics in the service=
| */
+
+struct switch2_ctlr_info {
+	uint16_t    pid;
+	const char *alias;
+};
+
+static const struct switch2_ctlr_info ctlr_table[] =3D {
+	{ NS2_PID_PROCON,   "Nintendo Switch 2 Pro Controller" },
+	{ NS2_PID_JOYCON_L, "Nintendo Switch 2 Joy-Con (L)" },
+	{ NS2_PID_JOYCON_R, "Nintendo Switch 2 Joy-Con (R)" },
+	{ NS2_PID_GCCON,    "Nintendo Switch 2 GameCube Controller" },
+};
+
+/* Struct representing a controller */
+struct switch2_device {
+	struct btd_device    *device;
+	struct gatt_uhid     *bridge;
+	const struct switch2_ctlr_info *info;
+};
+
+/*
+ * GATT characteristic discovery
+ */
+
+/* We iterate gatt_db_foreach_service->gatt_db_service_foreach_char->insp=
ect.
+ * Collect progress in char_walk_state */
+struct char_walk_state {
+	uint16_t   notify_handles[NS2_MAX_NOTIFY];
+	unsigned int notify_count;
+};
+
+static void inspect_char(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct char_walk_state *state =3D user_data;
+	uint16_t handle, value_handle;
+	uint8_t properties;
+
+	if (!gatt_db_attribute_get_char_data(attr, &handle, &value_handle,
+						&properties, NULL, NULL))
+		return;
+
+	/* Collect every characteristic that supports notification */
+	if ((properties & 0x10) &&
+			state->notify_count < NS2_MAX_NOTIFY) {
+		state->notify_handles[state->notify_count++] =3D value_handle;
+	}
+}
+
+static void find_chars_in_service(struct gatt_db_attribute *service,
+							void *user_data)
+{
+	gatt_db_service_foreach_char(service, inspect_char, user_data);
+}
+
+/*
+ * Plugin functions
+ */
+
+static int switch2_probe(struct btd_service *service)
+{
+	struct btd_device *device =3D btd_service_get_device(service);
+	uint16_t pid =3D btd_device_get_product(device);
+	struct switch2_device *dev;
+	unsigned int c;
+
+	DBG("switch2: probe %s", device_get_path(device));
+
+	dev =3D g_new0(struct switch2_device, 1);
+	dev->device =3D btd_device_ref(device);
+	dev->info =3D &ctlr_table[0]; /* default to Procon 2 */
+
+	for (c =3D 0; c < G_N_ELEMENTS(ctlr_table); c++) {
+		if (ctlr_table[c].pid =3D=3D pid) {
+			dev->info =3D &ctlr_table[c];
+			break;
+		}
+	}
+
+	DBG("switch2: detected %s (pid=3D0x%04x)", dev->info->alias, pid);
+
+	btd_device_set_alias(device, dev->info->alias);
+	btd_device_set_skip_secondary(device, true);
+
+	btd_service_set_user_data(service, dev);
+
+	return 0;
+}
+
+static void switch2_remove(struct btd_service *service)
+{
+	struct switch2_device *dev =3D btd_service_get_user_data(service);
+
+	DBG("switch2: remove %s", device_get_path(dev->device));
+
+	btd_device_unref(dev->device);
+	g_free(dev);
+}
+
+static int switch2_accept(struct btd_service *service)
+{
+	struct switch2_device *dev =3D btd_service_get_user_data(service);
+	struct btd_device *device  =3D btd_service_get_device(service);
+	struct bt_gatt_client *client;
+	struct gatt_db *db;
+	struct char_walk_state state;
+	bt_uuid_t service_uuid;
+	struct gatt_uhid_params params;
+
+	DBG("switch2: accept %s", device_get_path(device));
+
+	client =3D btd_device_get_gatt_client(device);
+	if (!client) {
+		error("switch2: no GATT client");
+		return -EINVAL;
+	}
+
+	/* NS2 controllers reject pairing; avoid pairing */
+	bt_gatt_client_set_security(client, BT_SECURITY_LOW);
+
+	/* Low-latency connection, otherwise unplayable */
+	btd_device_set_conn_param(device, 6, 6, 0, 200);
+
+	/* Discover GATT characteristics */
+	memset(&state, 0, sizeof(state));
+
+	db =3D btd_device_get_gatt_db(device);
+	bt_string_to_uuid(&service_uuid, SWITCH2_SERVICE_UUID);
+	gatt_db_foreach_service(db, &service_uuid,
+					find_chars_in_service, &state);
+
+	if (!state.notify_count) {
+		error("switch2: no notify characteristics found");
+		return -ENOENT;
+	}
+
+	/* Set up the GATT-UHID bridge */
+	memset(&params, 0, sizeof(params));
+	/* Static info */
+	params.version =3D 0x0001;
+	params.vendor =3D NS2_VID;
+	params.input_size =3D NS2_INPUT_SIZE;
+	params.output_size =3D NS2_OUTPUT_SIZE;
+	/* Our dev->info override in _probe() */
+	params.name =3D dev->info->alias;
+	params.product =3D dev->info->pid;
+	/* Discovered handles at runtime */
+	params.notify_handles =3D state.notify_handles;
+	params.notify_count =3D state.notify_count;
+
+	dev->bridge =3D gatt_uhid_new(client, &params);
+	if (!dev->bridge) {
+		error("switch2: failed to create GATT-UHID bridge");
+		return -EIO;
+	}
+
+	btd_service_connecting_complete(service, 0);
+	return 0;
+}
+
+static int switch2_disconnect(struct btd_service *service)
+{
+	struct switch2_device *dev =3D btd_service_get_user_data(service);
+
+	DBG("switch2: disconnect %s", device_get_path(dev->device));
+
+	gatt_uhid_free(dev->bridge);
+	dev->bridge =3D NULL;
+
+	btd_service_disconnecting_complete(service, 0);
+	return 0;
+}
+
+/*
+ * Plug in the plugin
+ */
+
+static struct btd_profile switch2_profile =3D {
+	.name =3D "switch2",
+	.bearer =3D BTD_PROFILE_BEARER_LE,
+	.remote_uuid =3D SWITCH2_SERVICE_UUID,
+	.device_probe =3D switch2_probe,
+	.device_remove =3D switch2_remove,
+	.accept =3D switch2_accept,
+	.disconnect =3D switch2_disconnect,
+	.auto_connect =3D true,
+};
+
+static int switch2_init(void)
+{
+	return btd_profile_register(&switch2_profile);
+}
+
+static void switch2_exit(void)
+{
+	btd_profile_unregister(&switch2_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(switch2, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAU=
LT,
+						switch2_init, switch2_exit)
=2D-=20
2.47.3

