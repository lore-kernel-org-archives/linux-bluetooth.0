Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] Fix MediaPlayer documentation
Date: Wed, 19 Oct 2011 10:05:00 -0200
Message-Id: <1319025900-1437-1-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <CAMOw1v6OwkwFfqeZmNSOGCXp+W1_yEpsM-+8XyeF9NW1CR_f-w@mail.gmail.com>
References: <CAMOw1v6OwkwFfqeZmNSOGCXp+W1_yEpsM-+8XyeF9NW1CR_f-w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/media-api.txt |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index b8dcdbd..c748e50 100644
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
-- 
1.7.7

