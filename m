Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Barry Byford <31baz66@gmail.com>
Date: Mon, 26 Sep 2016 22:09:22 +0100
Message-ID: <CAAu3APYm1n2YV060CnDFE+aACoCAuhKyDyrYQFy3wW7ZnAx35g@mail.gmail.com>
Subject: [PATCH 1/1] doc/gatt-api.txt: Correct spelling mistakes
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Correct small spelling errors

---

 doc/gatt-api.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index fd4bdd5..1864391 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -115,7 +115,7 @@ Properties string UUID [read-only]

  object Service [read-only]

- Object path of the GATT service the characteristc
+ Object path of the GATT service the characteristic
  belongs to.

  array{byte} Value [read-only, optional]
@@ -198,7 +198,7 @@ Properties string UUID [read-only]

  object Characteristic [read-only]

- Object path of the GATT characteristc the descriptor
+ Object path of the GATT characteristic the descriptor
  belongs to.

  array{byte} Value [read-only, optional]
@@ -222,7 +222,7 @@ Properties string UUID [read-only]
  "secure-read" (Server Only)
  "secure-write" (Server Only)

-GATT Profile hierarcy
+GATT Profile hierarhcy
 =====================

 Local profile (GATT client) instance. By registering this type of object
-- 
2.5.4
