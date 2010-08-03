Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fix NULL checking for pbap_get
Date: Tue,  3 Aug 2010 12:49:47 +0300
Message-Id: <1280828987-15562-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed NULL checking for name parameter - it shouldn't be there because
handling for NULL name for some cases is already below. Also passing path
which is NULL further makes no sense for PBAP so leaving with -EBADR if
that kind of situation occurs after generating path.
---
 plugins/pbap.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 7422a1e..c008e95 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -555,7 +555,7 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 
 	DBG("name %s type %s pbap %p", name, type, pbap);
 
-	if (type == NULL || name == NULL)
+	if (type == NULL)
 		return -EBADR;
 
 	rsize = obex_aparam_read(os, obj, &buffer);
@@ -594,6 +594,9 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 	} else
 		return -EBADR;
 
+	if (path == NULL)
+		return -EBADR;
+
 	pbap->params = params;
 	ret = obex_get_stream_start(os, path);
 
-- 
1.7.0.4

