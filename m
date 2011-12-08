Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v2 06/21] client-doc: GetCapabilities moved to session API
Date: Thu, 8 Dec 2011 16:27:40 +0100
Message-ID: <1323358075-27857-7-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/client-api.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 43521ff..65de1f1 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -20,10 +20,6 @@ Methods		object CreateSession(dict device)
 
 			Unregister session and abort pending transfers.
 
-		string GetCapabilities(dict device)
-
-			Get remote device capabilities.
-
 Properties	string Target
 
 		string Source
@@ -52,6 +48,10 @@ Methods		dict GetProperties()
 
 			Release a previously assigned OBEX agent.
 
+		string GetCapabilities()
+
+			Get remote device capabilities.
+
 Properties	string Source [readonly]
 
 		string Destination [readonly]
-- 
1.7.6.4

