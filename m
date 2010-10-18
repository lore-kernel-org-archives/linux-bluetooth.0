Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Fix possible invalid read
Date: Mon, 18 Oct 2010 17:18:49 +0300
Message-Id: <1287411529-5806-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1287411529-5806-1-git-send-email-luiz.dentz@gmail.com>
References: <1287411529-5806-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

==3229== Invalid read of size 4
==3229==    at 0x1D218: obex_object_set_io_flags (in /usr/lib/obex/obexd)
==3229==  Address 0x4c95e9c is 4 bytes inside a block of size 8 free'd
==3229==    at 0x4833E98: free (vg_replace_malloc.c:366)
==3229==    by 0x4910D23: g_free (gmem.c:191)
==3229==    by 0x492B8EF: g_slist_remove (gslist.c:441)
==3229==    by 0x1D15B: ??? (in /usr/lib/obex/obexd)
---
 src/mimetype.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/mimetype.c b/src/mimetype.c
index 4a30222..078d97c 100644
--- a/src/mimetype.c
+++ b/src/mimetype.c
@@ -50,9 +50,11 @@ void obex_object_set_io_flags(void *object, int flags, int err)
 {
 	GSList *l;
 
-	for (l = watches; l; l = l->next) {
+	for (l = watches; l;) {
 		struct io_watch *watch = l->data;
 
+		l = l->next;
+
 		if (watch->object != object)
 			continue;
 
-- 
1.7.1

