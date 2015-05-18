Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATHv2] adapter: Fix memory leak
Date: Mon, 18 May 2015 10:13:12 +0300
Message-Id: <1431933192-18203-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20150517073124.GA27593@t440s.P-661HNU-F1>
References: <20150517073124.GA27593@t440s.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In case of error with dbus stuff free allocated memory and set filter
to NULL.
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8ee5b5b..95b5349 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2220,7 +2220,7 @@ static bool parse_discovery_filter_dict(struct discovery_filter **filter,
 	dbus_message_iter_init(msg, &iter);
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
 	    dbus_message_iter_get_element_type(&iter) != DBUS_TYPE_DICT_ENTRY)
-		return false;
+		goto invalid_args;
 
 	dbus_message_iter_recurse(&iter, &subiter);
 	do {
-- 
2.1.4

