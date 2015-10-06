Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
Subject: [PATCH] core/advertising: Fix string match in le adv search
Message-ID: <5613B4A7.7030901@ubnt.com>
Date: Tue, 6 Oct 2015 14:46:47 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of searching for matched entry in the list, the function match_advertisement
was searching for the first non-matched entry. As a result, it wasn't possible to
unregister existing advertisement from LE Adv manager.

Signed-off-by: Andrejs Hanins <andrejs.hanins@ubnt.com>
---
 src/advertising.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index d56b7a2..a148625 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -77,10 +77,10 @@ static bool match_advertisement(const void *a, const void *b)
 	const struct advertisement *ad = a;
 	const struct dbus_obj_match *match = b;
 
-	if (match->owner && !g_strcmp0(ad->owner, match->owner))
+	if (match->owner && g_strcmp0(ad->owner, match->owner))
 		return false;
 
-	if (match->path && !g_strcmp0(ad->path, match->path))
+	if (match->path && g_strcmp0(ad->path, match->path))
 		return false;
 
 	return true;
-- 
1.9.1

