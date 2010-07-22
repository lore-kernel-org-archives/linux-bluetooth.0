Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 4/5] Handle arrays in device properties dictionary
Date: Thu, 22 Jul 2010 09:06:19 -0700
Message-Id: <1279814780-29673-5-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
References: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c1e1768..b22b086 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2715,6 +2715,7 @@ static void append_dict_valist(DBusMessageIter *iter,
 	DBusMessageIter dict;
 	const char *key;
 	int type;
+	int n_elements;
 	void *val;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
@@ -2726,7 +2727,12 @@ static void append_dict_valist(DBusMessageIter *iter,
 	while (key) {
 		type = va_arg(var_args, int);
 		val = va_arg(var_args, void *);
-		dict_append_entry(&dict, key, type, val);
+		if (type == DBUS_TYPE_ARRAY) {
+			n_elements = va_arg(var_args, int);
+			if (n_elements > 0)
+				dict_append_array(&dict, key, DBUS_TYPE_STRING, val, n_elements);
+		} else
+			dict_append_entry(&dict, key, type, val);
 		key = va_arg(var_args, char *);
 	}
 
-- 
1.7.1

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
