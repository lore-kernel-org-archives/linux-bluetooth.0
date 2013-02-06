Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5 v2] media-api: Fix referencing to MediaLibrary instead of MediaFolder
Date: Wed,  6 Feb 2013 11:14:58 +0200
Message-Id: <1360142100-5141-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1360142100-5141-1-git-send-email-luiz.dentz@gmail.com>
References: <1360142100-5141-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

MediaLibrary was replaced by MediaFolder so doesn't exist anymore.
---
 doc/media-api.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index db1575f..2656a9e 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -233,7 +233,7 @@ Properties	string Equalizer [readwrite]
 		boolean Browsable [readonly]
 
 			If present indicates the player can be browsed using
-			MediaLibrary interface.
+			MediaFolder interface.
 
 			Possible values:
 
@@ -248,7 +248,7 @@ Properties	string Equalizer [readwrite]
 		boolean Searchable [readonly]
 
 			If present indicates the player can be searched using
-			MediaLibrary interface.
+			MediaFolder interface.
 
 			Possible values:
 
-- 
1.8.1

