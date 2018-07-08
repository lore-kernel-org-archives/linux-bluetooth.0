Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 07 Jul 2018 22:09:18 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH v3 BlueZ 2/4] doc: provide MTU on GATT value reads and writes
Message-ID: <zwvZX5AOgP4GvmJFQHUWMoqsFDMz7RVyW7rbyd54IxZ88ITxAgI3nIei-QvtRsT6AafMiNl9JbKgdYxftG_TY4hns3GEhmvhQXXWMK3ZFUE=@krauser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/gatt-api.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 2a8da75b0..ff4bc333a 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -68,6 +68,7 @@ Methods=09=09array{byte} ReadValue(dict options)
 =09=09=09operation was successful.
=20
 =09=09=09Possible options: "offset": uint16 offset
+=09=09=09=09=09  "mtu": Exchanged MTU (Server only)
 =09=09=09=09=09  "device": Object Device (Server only)
=20
 =09=09=09Possible Errors: org.bluez.Error.Failed
@@ -83,6 +84,7 @@ Methods=09=09array{byte} ReadValue(dict options)
 =09=09=09characteristic.
=20
 =09=09=09Possible options: "offset": Start offset
+=09=09=09=09=09  "mtu": Exchanged MTU (Server only)
 =09=09=09=09=09  "device": Device path (Server only)
 =09=09=09=09=09  "link": Link type (Server only)
 =09=09=09=09=09  "prepare-authorize": boolean Is prepare
@@ -120,7 +122,9 @@ Methods=09=09array{byte} ReadValue(dict options)
 =09=09=09reconnections as the MTU has to be renegotiated.
=20
 =09=09=09Possible options: "device": Object Device (Server only)
-=09=09=09=09=09  "MTU": Exchanged MTU (Server only)
+=09=09=09=09=09  "mtu": Exchanged MTU (Server only)
+=09=09=09=09=09  "MTU": Exchanged MTU (Deprecated,
+=09=09=09=09=09=09=09=09Server only)
 =09=09=09=09=09  "link": Link type (Server only)
=20
 =09=09=09Possible Errors: org.bluez.Error.Failed
@@ -156,7 +160,9 @@ Methods=09=09array{byte} ReadValue(dict options)
 =09=09=09reconnections as the MTU has to be renegotiated.
=20
 =09=09=09Possible options: "device": Object Device (Server only)
-=09=09=09=09=09  "MTU": Exchanged MTU (Server only)
+=09=09=09=09=09  "mtu": Exchanged MTU (Server only)
+=09=09=09=09=09  "MTU": Exchanged MTU (Deprecated,
+=09=09=09=09=09=09=09=09Server only)
 =09=09=09=09=09  "link": Link type (Server only)
=20
 =09=09=09Possible Errors: org.bluez.Error.Failed
--=20
2.18.0

