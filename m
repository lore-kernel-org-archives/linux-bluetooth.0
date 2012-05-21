Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 08/12] client-doc: Move GetCapabilities to session API
Date: Mon, 21 May 2012 11:07:10 +0200
Message-Id: <1337591234-24919-9-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
 doc/client-api.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index de726a8..a467d40 100644
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
1.7.7.6

