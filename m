Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/2] Fix MediaPlayer documentation
Date: Tue, 18 Oct 2011 21:24:38 -0200
Message-Id: <1318980279-2331-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/media-api.txt |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index b8dcdbd..e061f38 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -180,12 +180,6 @@ Signals		PropertyChanged(string setting, variant value)
 
 					Track duration in milliseconds
 
-		StatusChanged(string status, uint32 position)
-
-			Possible status: "playing", "stopped", "paused",
-					"forward-seek", "reverse-seek" or
-					"error"
-
 Properties	string Equalizer [readwrite]
 
 			Possible values: "off" or "on"
@@ -203,13 +197,13 @@ Properties	string Equalizer [readwrite]
 
 			Possible values: "off", "alltracks" or "group"
 
-		string Status [readonly]
+		string Status [readwrite]
 
 			Possible status: "playing", "stopped", "paused",
 					"forward-seek", "reverse-seek" or
 					"error"
 
-		uint32 Position [readonly]
+		uint32 Position [readwrite]
 
 			Playback position in milliseconds
 
-- 
1.7.7

