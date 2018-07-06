Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 05 Jul 2018 20:47:11 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH BlueZ 2/3] doc: provide MTU on GATT value reads and writes
Message-ID: <DPjXL5C3tu6S98WA8uatqt7v726_ta8fWa-wht2od_WDSGC3Hu6wJNmySi_ulNnayk8Zr4m-zWHKJpF0FOZbDoM_buXnnen_H6hbiGeqPY0=@krauser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/gatt-api.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 2a8da75b0..a0db65383 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -68,6 +68,7 @@ Methods=09=09array{byte} ReadValue(dict options)
 =09=09=09operation was successful.
=20
 =09=09=09Possible options: "offset": uint16 offset
+=09=09=09=09=09  "MTU": Exchanged MTU (Server only)
 =09=09=09=09=09  "device": Object Device (Server only)
=20
 =09=09=09Possible Errors: org.bluez.Error.Failed
@@ -83,6 +84,7 @@ Methods=09=09array{byte} ReadValue(dict options)
 =09=09=09characteristic.
=20
 =09=09=09Possible options: "offset": Start offset
+=09=09=09=09=09  "MTU": Exchanged MTU (Server only)
 =09=09=09=09=09  "device": Device path (Server only)
 =09=09=09=09=09  "link": Link type (Server only)
 =09=09=09=09=09  "prepare-authorize": boolean Is prepare
--=20
2.18.0

