Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Aug 2009 17:46:25 +0200
From: Vladimir Botka <vbotka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] fix missing call to closedir
Message-ID: <20090825174625.49cbf150@vlado.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 29e477a29519c4a232ba02b6878beeeaa6d57da6 Mon Sep 17 00:00:00 2001
From: Vladimir Botka <vbotka@gmail.com>
Date: Tue, 25 Aug 2009 13:23:29 +0200
Subject: [PATCH] fix missing call to closedir

---
 compat/dun.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/compat/dun.c b/compat/dun.c
index c74e5ee..7140bac 100644
--- a/compat/dun.c
+++ b/compat/dun.c
@@ -106,8 +106,10 @@ static int uses_rfcomm(char *path, char *dev)
 		int  len = readlink(de->d_name, link, sizeof(link));
 		if (len > 0) {
 			link[len] = 0;
-			if (strstr(link, dev))
+			if (strstr(link, dev)) {
+				closedir(dir);
 				return 1;
+			}
 		}
 	}
 
-- 
1.6.0.2


Marcel, thank you for the hint. Sorry for the inconveniences.
Cheers,
-- 
	-vlado
	Vladimir Botka

