Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 1/2] Fix Find by Type Response with start == end grp handle
Date: Mon, 21 Feb 2011 10:36:53 -0400
Message-Id: <1298299014-31175-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Find by type value response in attribute server was in loop when the
start/end grp handles from a primary service had same values.

Initializing end grp handle with start handle makes the special check
when end grp handle was zero unnecessary so it was removed.
---
 src/attrib-server.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 4285f6e..2eb800f 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -469,6 +469,9 @@ static int find_by_type(uint16_t start, uint16_t end, uuid_t *uuid,
 
 			range = g_new0(struct att_range, 1);
 			range->start = a->handle;
+			/* It is allowed to have end group handle the same as
+			 * start handle, for groups with only one attribute. */
+			range->end = a->handle;
 
 			matches = g_slist_append(matches, range);
 		} else if (range) {
@@ -487,12 +490,6 @@ static int find_by_type(uint16_t start, uint16_t end, uuid_t *uuid,
 		if (l == NULL) {
 			/* Avoids another iteration */
 			range->end = 0xFFFF;
-		} else if (range->end == 0) {
-			/* Broken requests: requested End Handle is not
-			 * 0xFFFF. Given handle is in the middle of a
-			 * service definition. */
-			matches = g_slist_remove(matches, range);
-			g_free(range);
 		}
 	}
 
-- 
1.7.0.4

