Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/7] Fix typo on doc
Date: Mon, 10 Oct 2011 09:37:06 -0300
Message-Id: <1318250231-14001-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/media-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index af4cfa0..7dc7661 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -133,7 +133,7 @@ Object path	freely definable
 Methods		void SetProperty(string property, variant value)
 
 			Changes the value of the specified property. Only
-			properties that are listed a read-write can be changed.
+			properties that are listed as read-write can be changed.
 
 			On success this will emit a PropertyChanged signal.
 
-- 
1.7.7

