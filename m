Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 07 Jul 2018 22:11:31 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH v3 BlueZ 4/4] src: rename MinEncKeySize
Message-ID: <7IJfxPVAI3OFibEao3WDjPS2j0dCVLH6IigW0Q6Xob_jViEwzBNQts9kf3ekqRt_Q6cTloeu6C8GLSuwBnGiRfGIoXmSKj5IEAEt1PTAMpM=@krauser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/main.c    | 16 +++++++++++++---
 src/main.conf |  4 ++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/src/main.c b/src/main.c
index b70e6044b..060c2cc33 100644
--- a/src/main.c
+++ b/src/main.c
@@ -104,7 +104,8 @@ static const char *policy_options[] =3D {
=20
 static const char *gatt_options[] =3D {
 =09"Cache",
-=09"MinEncKeySize",
+=09"MinEncKeySize", /* deprecated */
+=09"MinEncryptionKeySize",
 =09"DefaultLeMtu",
 =09NULL
 };
@@ -411,12 +412,21 @@ static void parse_config(GKeyFile *config)
 =09}
=20
 =09val =3D g_key_file_get_integer(config, "GATT",
-=09=09=09=09=09=09"MinEncKeySize", &err);
+=09=09=09=09=09=09"MinEncryptionKeySize", &err);
+
+=09/* Retry with deprecated option on error. */
+=09if (err) {
+=09=09DBG("%s", err->message);
+=09=09g_clear_error(&err);
+=09=09val =3D g_key_file_get_integer(config, "GATT",
+=09=09=09=09=09=09=09"MinEncKeySize", &err);
+=09}
+
 =09if (err) {
 =09=09DBG("%s", err->message);
 =09=09g_clear_error(&err);
 =09} else {
-=09=09DBG("MinEncKeySize=3D%d", val);
+=09=09DBG("MinEncryptionKeySize=3D%d", val);
=20
 =09=09if (val >=3D7 && val <=3D 16)
 =09=09=09main_opts.min_enc_key_size =3D val;
diff --git a/src/main.conf b/src/main.conf
index c503040a5..4b0ae757b 100644
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
@@ -80,7 +80,7 @@
 # Minimum required Encryption Key Size for accessing secured characteristi=
cs.
 # Possible values: 0 and 7-16. 0 means don't care.
 # Defaults to 0
-# MinEncKeySize =3D 0
+#MinEncryptionKeySize =3D 0
=20
 # Default LE MTU size.
 # Possible values: 23-517
--=20
2.18.0

