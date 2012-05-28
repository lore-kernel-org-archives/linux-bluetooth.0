Return-Path: <cyrus@holtmann.org>
From: Ido Yariv <ido@wizery.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>
Subject: [PATCH] attrib-server: Allow zero length attribute update
Date: Mon, 28 May 2012 21:33:05 +0300
Message-Id: <1338229985-27293-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

attrib_db_update always fails when g_try_realloc returns NULL, not
taking into account that the length passed to g_try_realloc could be
zero. In this case, g_try_realloc frees the currently allocated memory
and returns NULL.
As a result, not only will attrib_db_update fail needlessly, a
use-after-free could occur as the attribute's length will still hold the
length of the freed buffer.

Fix this by only returning an error if the length is non-zero.
---
 src/attrib-server.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 3291e2d..dd1bba4 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1456,7 +1456,7 @@ int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 	a = dl->data;
 
 	a->data = g_try_realloc(a->data, len);
-	if (a->data == NULL)
+	if (len && a->data == NULL)
 		return -ENOMEM;
 
 	a->len = len;
-- 
1.7.7.6

