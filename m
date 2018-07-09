Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 09 Jul 2018 12:27:20 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH v4 BlueZ 3/3] src: make att le mtu configurable in main.conf
Message-ID: <brQFElXZS0skXCwDtFDXietQhkFG8rnpXN6MFsU7YAKgqROusMEWuDgJbMdHqbMYsYWFwWMO3d5BXyl_JvYZEkIRJ6oypwkLZKZxaDd7wvU=@krauser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c  |  2 +-
 src/hcid.h    |  1 +
 src/main.c    | 22 +++++++++++++++++++---
 src/main.conf |  9 +++++++--
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index 4f1af7012..839223a35 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4986,7 +4986,7 @@ bool device_attach_att(struct btd_device *dev, GIOCha=
nnel *io)
 =09=09}
 =09}
=20
-=09dev->att_mtu =3D MIN(mtu, BT_ATT_MAX_LE_MTU);
+=09dev->att_mtu =3D MIN(mtu, main_opts.gatt_default_le_mtu);
 =09attrib =3D g_attrib_new(io,
 =09=09=09cid =3D=3D ATT_CID ? BT_ATT_DEFAULT_LE_MTU : dev->att_mtu,
 =09=09=09false);
diff --git a/src/hcid.h b/src/hcid.h
index 2c2b89d9c..780cec0b4 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -54,6 +54,7 @@ struct main_opts {
=20
 =09bt_mode_t=09mode;
 =09bt_gatt_cache_t gatt_cache;
+=09uint16_t=09gatt_default_le_mtu;
=20
 =09uint8_t=09=09min_enc_key_size;
 };
diff --git a/src/main.c b/src/main.c
index 7e6af42cd..81a880da9 100644
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
@@ -103,7 +104,8 @@ static const char *policy_options[] =3D {
=20
 static const char *gatt_options[] =3D {
 =09"Cache",
-=09"MinEncKeySize",
+=09"MinEncryptionKeySize",
+=09"DefaultLeMtu",
 =09NULL
 };
=20
@@ -409,16 +411,28 @@ static void parse_config(GKeyFile *config)
 =09}
=20
 =09val =3D g_key_file_get_integer(config, "GATT",
-=09=09=09=09=09=09"MinEncKeySize", &err);
+=09=09=09=09=09=09"MinEncryptionKeySize", &err);
 =09if (err) {
 =09=09DBG("%s", err->message);
 =09=09g_clear_error(&err);
 =09} else {
-=09=09DBG("MinEncKeySize=3D%d", val);
+=09=09DBG("MinEncryptionKeySize=3D%d", val);
=20
 =09=09if (val >=3D7 && val <=3D 16)
 =09=09=09main_opts.min_enc_key_size =3D val;
 =09}
+
+=09val =3D g_key_file_get_integer(config, "GATT",
+=09=09=09=09=09=09"DefaultLeMtu", &err);
+=09if (err) {
+=09=09g_clear_error(&err);
+=09} else {
+=09=09/* Ensure the mtu is within a valid range. */
+=09=09val =3D MIN(val, BT_ATT_MAX_LE_MTU);
+=09=09val =3D MAX(val, BT_ATT_DEFAULT_LE_MTU);
+=09=09DBG("gatt_default_le_mtu=3D%d", val);
+=09=09main_opts.gatt_default_le_mtu =3D val;
+=09}
 }
=20
 static void init_defaults(void)
@@ -442,6 +456,8 @@ static void init_defaults(void)
 =09main_opts.did_vendor =3D 0x1d6b;=09=09/* Linux Foundation */
 =09main_opts.did_product =3D 0x0246;=09=09/* BlueZ */
 =09main_opts.did_version =3D (major << 8 | minor);
+
+=09main_opts.gatt_default_le_mtu =3D BT_ATT_MAX_LE_MTU;
 }
=20
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index cbae32ec5..4b0ae757b 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -63,7 +63,7 @@
 # Possible values: "off", "device", "network"
 # "network" option not supported currently
 # Defaults to "off"
-# Privacy =3D off
+#Privacy =3D off
=20
 [GATT]
 # GATT attribute cache.
@@ -80,7 +80,12 @@
 # Minimum required Encryption Key Size for accessing secured characteristi=
cs.
 # Possible values: 0 and 7-16. 0 means don't care.
 # Defaults to 0
-# MinEncKeySize =3D 0
+#MinEncryptionKeySize =3D 0
+
+# Default LE MTU size.
+# Possible values: 23-517
+# Defaults to 517
+#DefaultLeMtu =3D 517
=20
 [Policy]
 #
--=20
2.18.0

