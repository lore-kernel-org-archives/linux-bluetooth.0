Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH] Fix invalid read after list concatenation
Date: Thu,  3 Feb 2011 14:43:48 -0400
Message-Id: <1296758628-15202-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_slist_concat uses the items from second list directly so they should
not be freed.
---
 attrib/gatt.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index f3b513e..20bb96f 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -121,7 +121,6 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 	dp->primaries = g_slist_concat(dp->primaries, ranges);
 
 	last = g_slist_last(ranges);
-	g_slist_free(ranges);
 	range = last->data;
 
 	if (range->end == 0xffff)
-- 
1.7.0.4

