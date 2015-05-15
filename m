Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] adapter: Fix memory leak
Date: Fri, 15 May 2015 17:27:44 +0300
Message-Id: <1431700064-21419-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In case of error with dbus stuff free allocated memory and set filter
to NULL.
---
 src/adapter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8ee5b5b..7035a69 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2219,8 +2219,11 @@ static bool parse_discovery_filter_dict(struct discovery_filter **filter,
 
 	dbus_message_iter_init(msg, &iter);
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
-	    dbus_message_iter_get_element_type(&iter) != DBUS_TYPE_DICT_ENTRY)
+	    dbus_message_iter_get_element_type(&iter) != DBUS_TYPE_DICT_ENTRY) {
+		g_free(*filter);
+		*filter = NULL;
 		return false;
+	}
 
 	dbus_message_iter_recurse(&iter, &subiter);
 	do {
-- 
2.1.4

