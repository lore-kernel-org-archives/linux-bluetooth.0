Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE7A387352
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779231; cv=none; b=IlR5CtheEhCc+9nmBGPHslYYlV3kOOBAyNpizTBRBPKr4MjWnbrD/B5P3JZBYuYngDfm88uuwAFZOxL3lK8svYH3imTYzEmI8kvUoY1fnnIPpOEabTDCm8bOFv9aMc58VtuvLaAb+4unUEKWeuwHHcmppf5L7RQyK7Vha6MP/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779231; c=relaxed/simple;
	bh=GfDUfUI8ulB1rZKB1W64TPfDMwd6Q1AZO9h0UXx+OFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlfsLk17qlbHSl/wH3+m9CzBSOkv8AXamu+G0C2WnVNP85QiCflvfx7uDxGvcDcrK6J5079mPUrKiISojKpicCizgZTOjmNsB8OAiGqlNrah7giizEkp9z1b+Bzm7KK+2NyTC5DcQcvvPsl5pBUJw+PFcbLW/uZu00TxJC7dIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=gk8v6tPm; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="gk8v6tPm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773779227; x=1774384027; i=martinbts@gmx.net;
	bh=7EA2SvQROB4T6xx4PBf8NyBtL5uJdhfBwzxfv90HyyE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gk8v6tPmcOYp1DqCGYN8OENhpgo3LExATWm18J8HzWWKuh1sSQVb9pdTxGreqii9
	 pb60DiEYlxO4QyPtEh51AbB2MUrKklrsDZAAf1WQxJegjzp94gaOEKYV/uKWFQ3ow
	 HPj71GUayqUIV9oeNIbAE2se7rU74BtdPudn6qucH04xDIEd0qGm0NG64eDnA0DCD
	 Pe9t9Psk3qgy3/t9qt3MJYeASokBEfaH+h0VYdS3xUqTuNpGLL2BcOof8vsiq0t7C
	 Tmz645KjAbNZZBarrppa3VJktg3bX8A7HccgQldXgZ2folOOcDDNv7UICKaegzKnq
	 tuVzwQbt962668NZbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1vm27q1i0S-0158Pk; Tue, 17
 Mar 2026 21:27:06 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v3 6/6] plugins/switch2: Add Nintendo Switch 2 Controller plugin
Date: Tue, 17 Mar 2026 21:26:32 +0100
Message-ID: <20260317202637.158997-7-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317202637.158997-1-martinbts@gmx.net>
References: <20260317202637.158997-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lM68IfJGZehucYFLuDKF7hcYBnE+Jbv6jKkqGNzNllEcLMsp//x
 IP5LLAWOZH9WS33P6BBIrE1V5Jf7gs0VX0lkceLh9Hp7huNnDT/vPN2ABmvn3NXx2G77wS6
 roVOIlZn4ezp1Yk0gx0qkwjwKER6pid4iCNb5OqU0OmrCW77MRtRUCUmNDQgR9bcQZwEMk9
 tLQolK5IBMEvGSYDuY9EQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3nm/Tc+rgL0=;Pmtcvzt6eEwotIZiFZLvuTGHWpI
 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
 rv9uTx3fddA9BEn/W1n/2enKkDR2/xQ5Q==

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

