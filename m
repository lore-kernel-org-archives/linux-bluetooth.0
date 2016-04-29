Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 BlueZ 3/3] doc/gatt-api: Add secure flags
Date: Fri, 29 Apr 2016 13:38:33 +0300
Message-Id: <1461926313-5629-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1461926313-5629-1-git-send-email-luiz.dentz@gmail.com>
References: <1461926313-5629-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add secure-{read,write} which shall be used by servers that want
to restrict attribute access to secure connection only (BT_SECURITY_FIPS)
---
 doc/gatt-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 9404986..cb4e196 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -150,6 +150,8 @@ Properties	string UUID [read-only]
 				"encrypt-write"
 				"encrypt-authenticated-read"
 				"encrypt-authenticated-write"
+				"secure-read" (Server only)
+				"secure-write" (Server only)
 
 Characteristic Descriptors hierarchy
 ====================================
@@ -217,6 +219,8 @@ Properties	string UUID [read-only]
 				"encrypt-write"
 				"encrypt-authenticated-read"
 				"encrypt-authenticated-write"
+				"secure-read" (Server Only)
+				"secure-write" (Server Only)
 
 GATT Profile hierarcy
 =====================
-- 
2.5.5

