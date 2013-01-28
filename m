Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] attrib: Don't attempt to unregister event id 0
Date: Mon, 28 Jan 2013 15:30:30 -0600
Message-Id: <1359408630-20210-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359408630-20210-1-git-send-email-luiz.dentz@gmail.com>
References: <1359408630-20210-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Id 0 is considered invalid so the code should not even try to lookup for
it in the event list.
---
 attrib/gattrib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 58f19d0..ca73491 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -719,6 +719,9 @@ gboolean g_attrib_unregister(GAttrib *attrib, guint id)
 	struct event *evt;
 	GSList *l;
 
+	if (id == 0)
+		return FALSE;
+
 	l = g_slist_find_custom(attrib->events, GUINT_TO_POINTER(id),
 							event_cmp_by_id);
 	if (l == NULL)
-- 
1.8.1

