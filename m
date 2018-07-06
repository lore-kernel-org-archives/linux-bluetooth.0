Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 06 Jul 2018 19:27:44 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH v2 BlueZ 3/3] src: make att max le mtu configurable in main.conf
Message-ID: <B79Xs2cdPmQL7qvBHyDWRN6gANE7p-5iiOJb80T_jboNC718mSOqDlCU_oiY9iFnrSlpudEgwF0fkEGXcawdSejgkAQCJVZ9aNq7bguKq7c=@krauser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c  |  2 +-
 src/hcid.h    |  1 +
 src/main.c    | 16 ++++++++++++++++
 src/main.conf |  5 +++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 4f1af7012..75340cabe 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4986,7 +4986,7 @@ bool device_attach_att(struct btd_device *dev, GIOCha=
nnel *io)
 =09=09}
 =09}
=20
-=09dev->att_mtu =3D MIN(mtu, BT_ATT_MAX_LE_MTU);
+=09dev->att_mtu =3D MIN(mtu, main_opts.gatt_max_le_mtu);
 =09attrib =3D g_attrib_new(io,
 =09=09=09cid =3D=3D ATT_CID ? BT_ATT_DEFAULT_LE_MTU : dev->att_mtu,
 =09=09=09false);
diff --git a/src/hcid.h b/src/hcid.h
index 2c2b89d9c..bcb077dde 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -54,6 +54,7 @@ struct main_opts {
=20
 =09bt_mode_t=09mode;
 =09bt_gatt_cache_t gatt_cache;
+=09uint16_t=09gatt_max_le_mtu;
=20
 =09uint8_t=09=09min_enc_key_size;
 };
diff --git a/src/main.c b/src/main.c
index 7e6af42cd..5e19d68b3 100644
--- a/src/main.c
+++ b/src/main.c
@@ -50,6 +50,7 @@
 #include "log.h"
 #include "backtrace.h"
=20
+#include "shared/att-types.h"
 #include "lib/uuid.h"
 #include "hcid.h"
 #include "sdpd.h"
@@ -104,6 +105,7 @@ static const char *policy_options[] =3D {
 static const char *gatt_options[] =3D {
 =09"Cache",
 =09"MinEncKeySize",
+=09"MaxLeMtu",
 =09NULL
 };
=20
@@ -419,6 +421,18 @@ static void parse_config(GKeyFile *config)
 =09=09if (val >=3D7 && val <=3D 16)
 =09=09=09main_opts.min_enc_key_size =3D val;
 =09}
+
+=09val =3D g_key_file_get_integer(config, "GATT",
+=09=09=09=09=09=09"MaxLeMtu", &err);
+=09if (err) {
+=09=09g_clear_error(&err);
+=09} else {
+=09=09/* Ensure the mtu is within a valid range. */
+=09=09val =3D MIN(val, BT_ATT_MAX_LE_MTU);
+=09=09val =3D MAX(val, BT_ATT_DEFAULT_LE_MTU);
+=09=09DBG("gatt_max_le_mtu=3D%d", val);
+=09=09main_opts.gatt_max_le_mtu =3D val;
+=09}
 }
=20
 static void init_defaults(void)
@@ -442,6 +456,8 @@ static void init_defaults(void)
 =09main_opts.did_vendor =3D 0x1d6b;=09=09/* Linux Foundation */
 =09main_opts.did_product =3D 0x0246;=09=09/* BlueZ */
 =09main_opts.did_version =3D (major << 8 | minor);
+
+=09main_opts.gatt_max_le_mtu =3D BT_ATT_MAX_LE_MTU;
 }
=20
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index cbae32ec5..a22d685b2 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -82,6 +82,11 @@
 # Defaults to 0
 # MinEncKeySize =3D 0
=20
+# Maximum MTU size.
+# Possible values: 23-517
+# Defaults to 517
+# MaxLeMtu =3D 517
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
--
2.18.0

