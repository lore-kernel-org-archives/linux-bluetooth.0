Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 06 Jul 2018 19:25:28 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH v2 BlueZ 2/3] doc: provide MTU on GATT value reads and writes
Message-ID: <3M-yk1mXlNWN0S0SA86syfphtI0JHi8jHfb4P4X83DcYahByGwAdv0o3Z6ndO8B0XWz2AYsgQw5qdLEUpCauG09OzEPk3hrx4-RDUv0QV9c=@krauser.org>
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
@@ -68,6 +68,7 @@ Methods               array{byte} ReadValue(dict options)
                        operation was successful.
=20
                        Possible options: "offset": uint16 offset
+                                         "mtu": Exchanged MTU (Server only=
)
                                          "device": Object Device (Server o=
nly)
=20
                        Possible Errors: org.bluez.Error.Failed
@@ -83,6 +84,7 @@ Methods               array{byte} ReadValue(dict options)
                        characteristic.
=20
                        Possible options: "offset": Start offset
+                                         "mtu": Exchanged MTU (Server only=
)
                                          "device": Device path (Server onl=
y)
                                          "link": Link type (Server only)
                                          "prepare-authorize": boolean Is p=
repare
@@ -120,7 +122,9 @@ Methods             array{byte} ReadValue(dict options)
                        reconnections as the MTU has to be renegotiated.
=20
                        Possible options: "device": Object Device (Server o=
nly)
-                                         "MTU": Exchanged MTU (Server only=
)
+                                         "mtu": Exchanged MTU (Server only=
)
+                                         "MTU": Exchanged MTU (Deprecated,
+                                                               Server only=
)
                                          "link": Link type (Server only)
=20
                        Possible Errors: org.bluez.Error.Failed
@@ -156,7 +160,9 @@ Methods             array{byte} ReadValue(dict options)
                        reconnections as the MTU has to be renegotiated.
=20
                        Possible options: "device": Object Device (Server o=
nly)
-                                         "MTU": Exchanged MTU (Server only=
)
+                                         "mtu": Exchanged MTU (Server only=
)
+                                         "MTU": Exchanged MTU (Deprecated,
+                                                               Server only=
)
                                          "link": Link type (Server only)
=20
                        Possible Errors: org.bluez.Error.Failed
--
2.18.0

