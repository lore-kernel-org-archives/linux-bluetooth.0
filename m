Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 4/6] Extend bt_string2uuid to convert hex strings to UUID16
Date: Wed, 17 Nov 2010 16:09:44 -0200
Message-Id: <1290017386-23969-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1290017386-23969-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1290017386-23969-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Convert four or six(0x) digits length hexadecimal strings to UUID16.
---
 src/glib-helper.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/glib-helper.c b/src/glib-helper.c
index 9d76626..232fc71 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -466,6 +466,24 @@ static inline gboolean is_uuid128(const char *string)
 			string[23] == '-');
 }
 
+static int string2uuid16(uuid_t *uuid, const char *string)
+{
+	int length = strlen(string);
+	char *endptr = NULL;
+	uint16_t u16;
+
+	if (length != 4 && length != 6)
+		return -EINVAL;
+
+	u16 = strtol(string, &endptr, 16);
+	if (endptr && *endptr == '\0') {
+		sdp_uuid16_create(uuid, u16);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 char *bt_name2string(const char *pattern)
 {
 	uuid_t uuid;
@@ -529,9 +547,9 @@ int bt_string2uuid(uuid_t *uuid, const char *string)
 			sdp_uuid16_create(uuid, class);
 			return 0;
 		}
-	}
 
-	return -1;
+		return string2uuid16(uuid, string);
+	}
 }
 
 gchar *bt_list2string(GSList *list)
-- 
1.7.3.2

