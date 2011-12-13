Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 06/20] client-doc: move GetCapabilities to session API
Date: Tue, 13 Dec 2011 17:44:09 +0100
Message-ID: <1323794663-2711-7-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/client-api.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index f5d31a0..7a47d78 100644
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

