Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 6/7] Handle arrays in device properties dictionary.
Date: Wed,  4 Aug 2010 16:00:30 -0700
Message-Id: <1280962831-18147-7-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280962831-18147-1-git-send-email-ingas@codeaurora.org>
References: <1280962831-18147-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b735bdd..c142a4a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2700,6 +2700,7 @@ static void append_dict_valist(DBusMessageIter *iter,
 	DBusMessageIter dict;
 	const char *key;
 	int type;
+	int n_elements;
 	void *val;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
@@ -2711,7 +2712,13 @@ static void append_dict_valist(DBusMessageIter *iter,
 	while (key) {
 		type = va_arg(var_args, int);
 		val = va_arg(var_args, void *);
-		dict_append_entry(&dict, key, type, val);
+		if (type == DBUS_TYPE_ARRAY) {
+			n_elements = va_arg(var_args, int);
+			if (n_elements > 0)
+				dict_append_array(&dict, key, DBUS_TYPE_STRING,
+						val, n_elements);
+		} else
+			dict_append_entry(&dict, key, type, val);
 		key = va_arg(var_args, char *);
 	}
 
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
