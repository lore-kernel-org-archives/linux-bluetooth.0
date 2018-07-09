Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 09 Jul 2018 12:26:08 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH BlueZ 2/3] doc: provide MTU on GATT value reads and writes
Message-ID: <zHLAnvtzV-cTdPzv2Z8O_R4BJu1_gxF4GdYvx4sZpDpVdw0iywvZQiHeE3SMwV-Flwi9XFm5oONYnbJc0qhPdSKwaBm77qFAWS4w4L9uqsA=@krauser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/gatt-api.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 2a8da75b0..7cb7c0d80 100644
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
@@ -120,7 +122,7 @@ Methods=09=09array{byte} ReadValue(dict options)
 =09=09=09reconnections as the MTU has to be renegotiated.
=20
 =09=09=09Possible options: "device": Object Device (Server only)
-=09=09=09=09=09  "MTU": Exchanged MTU (Server only)
+=09=09=09=09=09  "mtu": Exchanged MTU (Server only)
 =09=09=09=09=09  "link": Link type (Server only)
=20
 =09=09=09Possible Errors: org.bluez.Error.Failed
@@ -156,7 +158,7 @@ Methods=09=09array{byte} ReadValue(dict options)
 =09=09=09reconnections as the MTU has to be renegotiated.
=20
 =09=09=09Possible options: "device": Object Device (Server only)
-=09=09=09=09=09  "MTU": Exchanged MTU (Server only)
+=09=09=09=09=09  "mtu": Exchanged MTU (Server only)
 =09=09=09=09=09  "link": Link type (Server only)
=20
 =09=09=09Possible Errors: org.bluez.Error.Failed
--=20
2.18.0

