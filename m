Return-Path: <cyrus@holtmann.org>
Message-id: <50868762.4010501@samsung.com>
Date: Tue, 23 Oct 2012 14:02:42 +0200
From: Michael Knudsen <m.knudsen@samsung.com>
MIME-version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc:  media API doco proofraeding.
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


---
 doc/media-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index b9802d9..d15d22a 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -48,7 +48,7 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 								dict metadata)
 
 			Register a media player object to sender, the sender
-			can register as many objets as it likes.
+			can register as many objects as it likes.
 
 			Note: If the sender disconnects its objects are
 			automatically unregistered.
-- 
1.7.0.4
